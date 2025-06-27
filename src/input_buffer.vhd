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

    signal wr_ptr : integer range 0 to DEPTH-1 := 0;   -- 写指针
    type   s_t is (IDLE, WRITE, WAIT_FFT);
    signal st : s_t := IDLE;

    -- bit-reverse
    function bit_reverse(x : natural; bits : natural) return natural is
        variable r,t : natural := x;
    begin
        r := 0;
        for i in 0 to bits-1 loop
            r := r*2 + (t mod 2);
            t := t/2;
        end loop;
        return r;
    end;

    function cpx_to_addr(idx : integer; is_im : boolean) return addr_t is
        variable a : integer := idx*2;
    begin
        if is_im then a := a + 1; end if;
        return to_unsigned(a, ADDR_WIDTH);
    end;

begin
    ----------------------------------------------------------------------------
    process(clk, rst_n)
        variable bit_rev_idx : integer;
        variable next_ptr    : integer;
    begin
        if rst_n = '0' then
            st        <= IDLE;
            wr_ptr    <= 0;
            din_ready <= '0';
            ram_we    <= '0';
            start_fft <= '0';
        elsif rising_edge(clk) then
            -- 默认值
            ram_we    <= '0';
            start_fft <= '0';

            case st is
            ----------------------------------------------------------------------------
            when IDLE =>
                din_ready <= '1';
                if din_valid = '1' then
                    -- 写一个采样
                    bit_rev_idx := bit_reverse(wr_ptr/2, 3);
                    ram_addr    <= cpx_to_addr(bit_rev_idx, (wr_ptr mod 2) = 1);
                    ram_dout    <= din;
                    ram_we      <= '1';

                    -- 计算下一指针 & 状态
                    next_ptr := wr_ptr + 1;
                    if next_ptr = DEPTH then         -- 刚好写完一帧
                        wr_ptr    <= 0;
                        din_ready <= '0';
                        start_fft <= '1';
                        st        <= WAIT_FFT;
                    else
                        wr_ptr <= next_ptr;
                        st     <= WRITE;
                    end if;
                end if;

            ----------------------------------------------------------------------------
            when WRITE =>
                if din_valid = '1' then
                    bit_rev_idx := bit_reverse(wr_ptr/2, 3);
                    ram_addr    <= cpx_to_addr(bit_rev_idx, (wr_ptr mod 2) = 1);
                    ram_dout    <= din;
                    ram_we      <= '1';

                    next_ptr := wr_ptr + 1;
                    if next_ptr = DEPTH then
                        wr_ptr    <= 0;
                        din_ready <= '0';
                        start_fft <= '1';
                        st        <= WAIT_FFT;
                    else
                        wr_ptr <= next_ptr;
                    end if;
                end if;

            ----------------------------------------------------------------------------
            when WAIT_FFT =>
                if fft_done = '1' then
                    din_ready <= '1';
                    st        <= IDLE;
                end if;
            end case;
        end if;
    end process;
end architecture;
