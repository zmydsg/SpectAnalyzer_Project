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
        start_fft    : out std_logic;   -- 新：告诉 FFT “缓存好了”
        fft_done     : in  std_logic;    -- 来自 FFT
        -- 与缓存的 **唯一** 端口
        ram_addr     : out addr_t;
        ram_dout     : out signed(DATA_WIDTH-1 downto 0);
        ram_we       : out std_logic
    );
end;

architecture rtl of input_buffer is
    signal wr_ptr : integer range 0 to DEPTH-1 := 0;
    type s_t is (IDLE, WRITE, WAIT_FFT);
    signal st : s_t := IDLE;
begin
    process(clk, rst_n)
    begin
        if rst_n='0' then
            st <= IDLE;
            wr_ptr <= 0;
        elsif rising_edge(clk) then
            case st is
            when IDLE =>
                din_ready <= '1';
                if din_valid='1' then
                    ram_addr <= to_unsigned(wr_ptr, ADDR_WIDTH);
                    ram_dout <= din;
                    ram_we   <= '1';
                    wr_ptr   <= wr_ptr + 1;
                    st <= WRITE;
                end if;

            when WRITE =>
                ram_we <= '0';
                if din_valid='1' then
                    ram_addr <= to_unsigned(wr_ptr, ADDR_WIDTH);
                    ram_dout <= din;
                    ram_we   <= '1';
                    wr_ptr   <= wr_ptr + 1;
                end if;
                if wr_ptr = DEPTH-1 then          -- 写满一帧
                    din_ready <= '0';
                    start_fft <= '1';             -- 拉高 1 拍
                    st <= WAIT_FFT;
                end if;

            when WAIT_FFT =>
                start_fft <= '0';
                if fft_done='1' then              -- FFT 完成
                    wr_ptr <= 0;
                    din_ready <= '1';
                    st <= IDLE;
                end if;
            end case;
        end if;
    end process;
end;
