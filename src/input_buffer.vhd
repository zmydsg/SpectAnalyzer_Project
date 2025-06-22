library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity input_buffer is
    port (
        clk, rst_n : in  std_logic;
        ----------------------------------------------------------------
        -- 与 ADC 侧握手
        ----------------------------------------------------------------
        din        : in  signed(DATA_WIDTH-1 downto 0);
        din_valid  : in  std_logic;
        din_ready  : out std_logic;
        ----------------------------------------------------------------
        -- 与 FFT 侧握手
        ----------------------------------------------------------------
        start_fft  : out std_logic;   -- 单拍脉冲
        fft_done   : in  std_logic;
        ----------------------------------------------------------------
        -- 单端口 RAM 总线（多模块共享）
        ----------------------------------------------------------------
        ram_addr   : out addr_t;
        ram_dout   : out signed(DATA_WIDTH-1 downto 0);
        ram_we     : out std_logic
    );
end entity;

------------------------------------------------------------------------
architecture rtl of input_buffer is
------------------------------------------------------------------------
    --------------------------------------------------------------------
    -- 寄存器 / 状态机
    --------------------------------------------------------------------
    signal wr_ptr : integer range 0 to DEPTH-1 := 0;

    type s_t is (IDLE, WRITE, WAIT_1, WAIT_FFT);
    signal st : s_t := IDLE;

    --------------------------------------------------------------------
    -- 内部 RAM 信号 + 伪三态控制
    --------------------------------------------------------------------
    signal addr_int : addr_t                          := (others=>'0');
    signal dout_int : signed(DATA_WIDTH-1 downto 0)   := (others=>'0');
    signal we_int   : std_logic                       := '0';
    signal drive_en : std_logic                       := '0';   -- =1 表示本模块驱动总线

    --------------------------------------------------------------------
    -- 工具函数
    --------------------------------------------------------------------
    -- bit_reverse：wr_ptr/2 取 3 位 ? 8 点 FFT
    function bit_reverse(x: natural; bits: natural) return natural is
        variable r    : natural := 0;
        variable temp : natural := x;
    begin
        for i in 0 to bits-1 loop
            r    := r * 2 + (temp mod 2);
            temp := temp / 2;
        end loop;
        return r;
    end;

    -- 复数索引 → RAM 地址（偶实、奇虚）
    function cpx_to_addr(idx : integer; is_im : boolean) return addr_t is
        variable a : integer := idx*2;
    begin
        if is_im then
            a := a + 1;
        end if;
        return to_unsigned(a, ADDR_WIDTH);
    end;
begin
    --------------------------------------------------------------------
    -- 伪三态总线：非 drive_en 时输出 'Z'
    --------------------------------------------------------------------
    ram_addr <= addr_int                when drive_en='1' else (others=>'Z');
    ram_dout <= dout_int                when drive_en='1' else (others=>'Z');
    ram_we   <= we_int                  when drive_en='1' else 'Z'; -- 'Z'≈0

    --------------------------------------------------------------------
    -- 主时序进程
    --------------------------------------------------------------------
    process(clk, rst_n)
        variable bit_rev_idx : integer;
    begin
        if rst_n='0' then
            st        <= IDLE;
            wr_ptr    <= 0;
            din_ready <= '0';
            start_fft <= '0';

            drive_en  <= '0';
            we_int    <= '0';
        elsif rising_edge(clk) then
            ----------------------------------------------------------------
            -- 每拍默认值
            ----------------------------------------------------------------
            drive_en  <= '0';       -- 若本拍不重新赋 1，则输出 'Z'
            we_int    <= '0';
            start_fft <= '0';
            -- din_ready 缺省保持上一次的值（只在需要时修改）

            case st is
            ----------------------------------------------------------------
            when IDLE =>
                din_ready <= '1';

                if din_valid='1' then
                    -- 计算地址 & 写 RAM
                    bit_rev_idx := bit_reverse(wr_ptr/2, 3);

                    addr_int  <= cpx_to_addr(bit_rev_idx, (wr_ptr mod 2)=1);
                    dout_int  <= din;
                    we_int    <= '1';
                    drive_en  <= '1';

                    wr_ptr    <= wr_ptr + 1;
                    st        <= WRITE;
                end if;

            ----------------------------------------------------------------
            when WRITE =>
                if din_valid='1' then
                    bit_rev_idx := bit_reverse(wr_ptr/2, 3);

                    addr_int  <= cpx_to_addr(bit_rev_idx, (wr_ptr mod 2)=1);
                    dout_int  <= din;
                    we_int    <= '1';
                    drive_en  <= '1';

                    wr_ptr    <= wr_ptr + 1;
                end if;

                if wr_ptr = DEPTH-1 then      -- 最后一个采样已写入
                    din_ready <= '0';         -- 暂停 ADC
                    st        <= WAIT_1;      -- 先松总线，再发脉冲
                end if;

            ----------------------------------------------------------------
            when WAIT_1 =>
                -- 本拍已不再驱动 RAM（drive_en 默认 0）
                start_fft <= '1';             -- 单拍脉冲
                st        <= WAIT_FFT;

            ----------------------------------------------------------------
            when WAIT_FFT =>
                if fft_done='1' then
                    wr_ptr    <= 0;
                    din_ready <= '1';
                    st        <= IDLE;
                end if;

            end case;
        end if;
    end process;

end architecture;
