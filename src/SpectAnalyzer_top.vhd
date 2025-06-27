library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

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

architecture rtl of SpectAnalyzer_top is
    ----------------------------------------------------------------
    -- 各阶段RAM接口信号
    ----------------------------------------------------------------
    -- INPUT阶段
    signal ram_addr_in  : addr_t;
    signal ram_dout_in  : signed(DATA_WIDTH-1 downto 0);
    signal ram_we_in    : std_logic;

    -- FFT阶段
    signal ram_addr_fft : addr_t;
    signal ram_dout_fft : signed(DATA_WIDTH-1 downto 0);
    signal ram_we_fft   : std_logic;

    -- OUTPUT阶段
    signal ram_addr_out : addr_t;
    signal ram_we_out   : std_logic;  -- 添加缺失的信号

    ----------------------------------------------------------------
    -- 统一RAM控制信号
    ----------------------------------------------------------------
    signal ram_addr     : addr_t;
    signal ram_din      : signed(DATA_WIDTH-1 downto 0);  -- RAM写入数据
    signal ram_dout     : signed(DATA_WIDTH-1 downto 0);  -- RAM读出数据
    signal ram_we       : std_logic;

    ----------------------------------------------------------------
    -- 模块间控制信号
    ----------------------------------------------------------------
    signal start_sig    : std_logic;
    signal done_sig     : std_logic;
    signal done_out     : std_logic;

    ----------------------------------------------------------------
    -- 阶段状态机
    ----------------------------------------------------------------
    type phase_t is (PH_IN, PH_FFT, PH_OUT);
    signal phase : phase_t := PH_IN;

begin
    --------------------------------------------------------------
    -- 阶段状态机
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
    -- RAM接口MUX（修正版）
    --------------------------------------------------------------
    ram_addr <= ram_addr_in  when phase = PH_IN  else
                ram_addr_fft when phase = PH_FFT else
                ram_addr_out;

    ram_din  <= ram_dout_in  when phase = PH_IN  else
                ram_dout_fft when phase = PH_FFT else
                (others => '0');  -- 输出阶段不写

    ram_we   <= ram_we_in    when phase = PH_IN  else
                ram_we_fft   when phase = PH_FFT else
                ram_we_out;   -- 修正：连接输出阶段写使能

    --------------------------------------------------------------
    -- RAM实例
    --------------------------------------------------------------
    ram_inst : entity work.ram_sp
        port map (
            clk  => clk,
            addr => ram_addr,
            din  => ram_din,   -- 修正：写入数据
            we   => ram_we,
            dout => ram_dout   -- 修正：读出数据
        );

    --------------------------------------------------------------
    -- INPUT BUFFER模块
    --------------------------------------------------------------
    u_in : entity work.input_buffer
        port map (
            clk        => clk,
            rst_n      => rst_n,
            din        => adc_sample,
            din_valid  => adc_valid,
            din_ready  => adc_ready,
            start_fft  => start_sig,
            fft_done   => done_sig,    -- 修正：添加缺失连接
            ram_addr   => ram_addr_in,
            ram_dout   => ram_dout_in,
            ram_we     => ram_we_in
        );

    --------------------------------------------------------------
    -- FFT模块
    --------------------------------------------------------------
    u_fft : entity work.mag_sqr_fft
        port map (
            clk      => clk,
            rst_n    => rst_n,
            start    => start_sig,
            done     => done_sig,
            ram_addr => ram_addr_fft,
            ram_din  => ram_dout,      -- 修正：连接RAM读出数据
            ram_dout => ram_dout_fft,
            ram_we   => ram_we_fft
        );

    --------------------------------------------------------------
    -- OUTPUT BUFFER模块
    --------------------------------------------------------------
    u_out : entity work.output_buffer
        port map (
            clk        => clk,
            rst_n      => rst_n,
            start_in   => done_sig,
            done_out   => done_out,
            ram_addr   => ram_addr_out,
            ram_din    => ram_dout,    -- 修正：连接RAM读出数据
            ram_we     => ram_we_out,  -- 修正：连接到信号而非open
            dout       => dout,
            dout_valid => dout_valid
        );

end architecture;
