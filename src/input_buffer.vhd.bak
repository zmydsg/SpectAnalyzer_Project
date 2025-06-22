library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity input_buffer is
    port (
        clk, rst_n   : in  std_logic;
        din          : in  signed(DATA_WIDTH-1 downto 0);
        din_valid    : in  std_logic;
        din_ready    : out std_logic;
        start_fft    : out std_logic;   -- 启动 FFT 处理信号
        fft_done     : in  std_logic;    -- FFT 完成信号
        -- 输入缓冲区 **唯一** 接口
        ram_addr     : out addr_t;
        ram_dout     : out signed(DATA_WIDTH-1 downto 0);
        ram_we       : out std_logic
    );
end;

architecture rtl of input_buffer is
    signal wr_ptr : integer range 0 to DEPTH-1 := 0;
    type s_t is (IDLE, WRITE, WAIT_FFT);
    signal st : s_t := IDLE;
    
    -- bit-reverse函数用于倒位序
    function bit_reverse(x: natural; bits: natural) return natural is
        variable r : natural := 0;
        variable temp : natural := x;
    begin
        for i in 0 to bits-1 loop
            r := r * 2 + (temp mod 2);
            temp := temp / 2;
        end loop;
        return r;
    end;
    
    -- 复数到地址转换函数
    function cpx_to_addr(idx : integer; is_im : boolean) return addr_t is
        variable a : integer := idx*2;
    begin
        if is_im then a := a + 1; end if;
        return to_unsigned(a, ADDR_WIDTH);
    end;
    
begin
    process(clk, rst_n)
        variable bit_rev_idx : integer;
    begin
        if rst_n='0' then
            st <= IDLE;
            wr_ptr <= 0;
            ram_we <= '0';
            din_ready <= '0';
            start_fft <= '0';
        elsif rising_edge(clk) then
            -- 默认值
            ram_we <= '0';
            start_fft <= '0';
            
            case st is
            when IDLE =>
                din_ready <= '1';
                if din_valid='1' then
                    -- 使用倒位序地址存储数据
                    bit_rev_idx := bit_reverse(wr_ptr/2, 3);  -- 对复数索引进行倒位序
                    if (wr_ptr mod 2) = 0 then
                        -- 实部
                        ram_addr <= cpx_to_addr(bit_rev_idx, false);
                    else
                        -- 虚部
                        ram_addr <= cpx_to_addr(bit_rev_idx, true);
                    end if;
                    ram_dout <= din;
                    ram_we   <= '1';
                    wr_ptr   <= wr_ptr + 1;
                    st <= WRITE;
                end if;

            when WRITE =>
                if din_valid='1' then
                    -- 使用倒位序地址存储数据
                    bit_rev_idx := bit_reverse(wr_ptr/2, 3);  -- 对复数索引进行倒位序
                    if (wr_ptr mod 2) = 0 then
                        -- 实部
                        ram_addr <= cpx_to_addr(bit_rev_idx, false);
                    else
                        -- 虚部
                        ram_addr <= cpx_to_addr(bit_rev_idx, true);
                    end if;
                    ram_dout <= din;
                    ram_we   <= '1';
                    wr_ptr   <= wr_ptr + 1;
                end if;
                
                if wr_ptr = DEPTH-1 then          -- 写满一帧
                    din_ready <= '0';
                    start_fft <= '1';             -- 持续 1 周期
                    st <= WAIT_FFT;
                end if;

            when WAIT_FFT =>
                if fft_done='1' then              -- FFT 完成
                    wr_ptr <= 0;
                    din_ready <= '1';
                    st <= IDLE;
                end if;
            end case;
        end if;
    end process;
end;
