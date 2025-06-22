library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

--------------------------------------------------------------------
-- 顶层实体：根据实际板卡 IO 自行增删端口
--------------------------------------------------------------------
entity SpectAnalyzer_top is
    port (
        clk        : in  std_logic;
        rst_n      : in  std_logic;

        adc_sample : in  signed(DATA_WIDTH-1 downto 0);
        adc_valid  : in  std_logic;
        adc_ready  : out std_logic;

        dout       : out signed(DATA_WIDTH-1 downto 0);
        dout_valid : out std_logic
    );
end entity;

--------------------------------------------------------------------
architecture rtl of SpectAnalyzer_top is
--------------------------------------------------------------------
    ----------------------------------------------------------------
    -- 1) 各阶段“私有” RAM 信号
    ----------------------------------------------------------------
    -- INPUT 写阶段
    signal ram_addr_in  : addr_t;
    signal ram_dout_in  : signed(DATA_WIDTH-1 downto 0);
    signal ram_we_in    : std_logic;

    -- FFT 计算阶段
    signal ram_addr_fft : addr_t;
    signal ram_dout_fft : signed(DATA_WIDTH-1 downto 0);
    signal ram_we_fft   : std_logic;

    -- OUTPUT 读阶段（只读地址）
    signal ram_addr_out : addr_t;

    ----------------------------------------------------------------
    -- 2) 公共 RAM 总线
    ----------------------------------------------------------------
    signal ram_addr  : addr_t;
    signal ram_dout  : signed(DATA_WIDTH-1 downto 0);
    signal ram_we    : std_logic;
    signal ram_din   : signed(DATA_WIDTH-1 downto 0);      -- RAM 读数据

    ----------------------------------------------------------------
    -- 3) 模块间握手
    ----------------------------------------------------------------
    signal start_sig  : std_logic;  -- input_buffer → FFT
    signal done_sig   : std_logic;  -- FFT → input/output
    signal done_out   : std_logic;  -- output_buffer → phase FSM

    ----------------------------------------------------------------
    -- 4) 相位 FSM（PH_IN→PH_FFT→PH_OUT）
    ----------------------------------------------------------------
    type phase_t is (PH_IN, PH_FFT, PH_OUT);
    signal phase : phase_t := PH_IN;
begin
    --------------------------------------------------------------
    -- 4-1 相位切换
    --------------------------------------------------------------
    process(clk, rst_n)
    begin
        if rst_n = '0' then
            phase <= PH_IN;
        elsif rising_edge(clk) then
            case phase is
                when PH_IN  =>
                    if start_sig = '1' then
                        phase <= PH_FFT;
                    end if;
                when PH_FFT =>
                    if done_sig = '1' then
                        phase <= PH_OUT;
                    end if;
                when PH_OUT =>
                    if done_out = '1' then
                        phase <= PH_IN;
                    end if;
            end case;
        end if;
    end process;

    --------------------------------------------------------------
    -- 4-2 总线三选一 MUX
    --------------------------------------------------------------
    ram_addr <= ram_addr_in  when phase = PH_IN  else
                ram_addr_fft when phase = PH_FFT else
                ram_addr_out;                     -- 读阶段

    ram_dout <= ram_dout_in  when phase = PH_IN  else
                ram_dout_fft when phase = PH_FFT else
                (others => '0');                  -- 读阶段不写

    ram_we   <= ram_we_in    when phase = PH_IN  else
                ram_we_fft   when phase = PH_FFT else
                '0';

    --------------------------------------------------------------
    -- 5) 单端口同步 RAM（推断或自己替换 IP）
    --------------------------------------------------------------
    ram_inst : entity work.ram_sp
        port map (
            clk  => clk,
            addr => ram_addr,
            din  => ram_dout,
            we   => ram_we,
            dout => ram_din
        );

    --------------------------------------------------------------
    -- 6) INPUT 缓冲
    --------------------------------------------------------------
    u_in : entity work.input_buffer
        port map (
            clk        => clk,
            rst_n      => rst_n,
            din        => adc_sample,
            din_valid  => adc_valid,
            din_ready  => adc_ready,

            start_fft  => start_sig,
            fft_done   => done_sig,

            ram_addr   => ram_addr_in,
            ram_dout   => ram_dout_in,
            ram_we     => ram_we_in
        );

    --------------------------------------------------------------
    -- 7) FFT + |X|2
    --------------------------------------------------------------
    u_fft : entity work.mag_sqr_fft
        port map (
            clk      => clk,
            rst_n    => rst_n,
            start    => start_sig,
            done     => done_sig,

            ram_addr => ram_addr_fft,
            ram_din  => ram_din,
            ram_dout => ram_dout_fft,
            ram_we   => ram_we_fft
        );

    --------------------------------------------------------------
    -- 8) OUTPUT
    --------------------------------------------------------------
    u_out : entity work.output_buffer
        port map (
            clk        => clk,
            rst_n      => rst_n,
            start_in   => done_sig,   -- 开始输出
            done_out   => done_out,   -- 通知相位 FSM

            ram_addr   => ram_addr_out,
            ram_din    => ram_din,
            ram_we     => open,       -- 只读

            dout       => dout,
            dout_valid => dout_valid
        );
end architecture;
