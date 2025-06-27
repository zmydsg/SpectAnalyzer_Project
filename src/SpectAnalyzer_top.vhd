library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

--------------------------------------------------------------------
-- ����ʵ�壺����ʵ�ʰ忨 IO ������ɾ�˿�
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
-- 修正信号名称和连接逻辑
architecture rtl of SpectAnalyzer_top is
--------------------------------------------------------------------
    ----------------------------------------------------------------
    -- 1) ���׶Ρ�˽�С� RAM �ź�
    ----------------------------------------------------------------
    -- INPUT д�׶�
    signal ram_addr_in  : addr_t;
    signal ram_dout_in  : signed(DATA_WIDTH-1 downto 0);
    signal ram_we_in    : std_logic;

    -- FFT ����׶�
    signal ram_addr_fft : addr_t;
    signal ram_dout_fft : signed(DATA_WIDTH-1 downto 0);
    signal ram_we_fft   : std_logic;

    -- OUTPUT ���׶Σ�ֻ����ַ��
    signal ram_addr_out : addr_t;

    ----------------------------------------------------------------
    -- 2) ���� RAM ����
    ----------------------------------------------------------------
    signal ram_addr  : addr_t;
    signal ram_dout  : signed(DATA_WIDTH-1 downto 0);
    signal ram_we    : std_logic;
    signal ram_din   : signed(DATA_WIDTH-1 downto 0);      -- RAM ������

    ----------------------------------------------------------------
    -- 3) ģ�������
    ----------------------------------------------------------------
    signal start_sig  : std_logic;  -- input_buffer �� FFT
    signal done_sig   : std_logic;  -- FFT �� input/output
    signal done_out   : std_logic;  -- output_buffer �� phase FSM

    ----------------------------------------------------------------
    -- 4) ��λ FSM��PH_IN��PH_FFT��PH_OUT��
    ----------------------------------------------------------------
    type phase_t is (PH_IN, PH_FFT, PH_OUT);
    signal phase : phase_t := PH_IN;
begin
    --------------------------------------------------------------
    -- 4-1 ��λ�л�
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
    -- 4-2 ������ѡһ MUX
    --------------------------------------------------------------
    ram_addr <= ram_addr_in  when phase = PH_IN  else
                ram_addr_fft when phase = PH_FFT else
                ram_addr_out;                     -- ���׶�

    -- 修正：RAM写入数据信号
    signal ram_din_mux : signed(DATA_WIDTH-1 downto 0);
    
begin
    ram_dout <= ram_dout_in  when phase = PH_IN  else
                ram_dout_fft when phase = PH_FFT else
                (others => '0');                  -- ���׶β�д

    ram_we   <= ram_we_in    when phase = PH_IN  else
                ram_we_fft   when phase = PH_FFT else
                '0';

    --------------------------------------------------------------
    -- 5) 修正RAM实例化
    --------------------------------------------------------------
    ram_inst : entity work.ram_sp
        port map (
            clk  => clk,
            addr => ram_addr,
            din  => ram_din_mux,  -- 修正：使用正确的写入信号
            we   => ram_we,
            dout => ram_din       -- 修正：这是RAM的读出数据
        );

    --------------------------------------------------------------
    -- 6) INPUT ����
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
            start_in   => done_sig,   -- ��ʼ���
            done_out   => done_out,   -- ֪ͨ��λ FSM

            ram_addr   => ram_addr_out,
            ram_din    => ram_din,
            ram_we     => open,       -- ֻ��

            dout       => dout,
            dout_valid => dout_valid
        );
end architecture;
