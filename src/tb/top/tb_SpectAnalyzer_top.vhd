library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;             -- WIDTH/N_POINTS/addr_t…

entity tb_SpectAnalyzer_top is
end;

architecture behav of tb_SpectAnalyzer_top is
    -- 1) 基本时钟/复位
    constant CLK_PER : time := 10 ns;          -- 100 MHz
    signal clk     : std_logic := '0';
    signal rst_n   : std_logic := '0';

    -- 2) 顶层端口信号
    signal adc_sample : signed(DATA_WIDTH-1 downto 0);
    signal adc_valid  : std_logic;
    signal adc_ready  : std_logic;
    signal dout       : signed(DATA_WIDTH-1 downto 0);
    signal dout_valid : std_logic;

    -- 3) 简易刺激向量
    type vec_t is array(natural range <>) of signed(DATA_WIDTH-1 downto 0);
    constant N    : natural := N_POINTS;
    constant IN_LEN : natural := 3*N;          -- 至少 3 帧
    constant sine_vec : vec_t :=
        (0 => to_signed(0  , DATA_WIDTH),
         1 => to_signed(8191, DATA_WIDTH),     -- 简单半波
         2 => to_signed(16384,DATA_WIDTH),
         3 => to_signed(8191, DATA_WIDTH),
         4 => to_signed(0,   DATA_WIDTH),
         5 => to_signed(-8191,DATA_WIDTH),
         6 => to_signed(-16384,DATA_WIDTH),
         7 => to_signed(-8191,DATA_WIDTH));
    -- 上面 8 个样本循环使用

begin
    ----------------------------------------------------------------
    -- 时钟过程
    clk <= not clk after CLK_PER/2;

    ----------------------------------------------------------------
    -- 复位：保持 3 个时钟周期
    process
    begin
        rst_n <= '0';
        wait for 3*CLK_PER;
        rst_n <= '1';
        wait;
    end process;

    ----------------------------------------------------------------
    -- 输入激励：遵守 adc_ready，产生 IN_LEN 个采样
    stim_proc: process
        variable idx : natural := 0;
    begin
        adc_valid  <= '0';
        wait until rst_n = '1';
        wait for CLK_PER;                  -- 等待一个时钟
        while idx < IN_LEN loop
            wait until rising_edge(clk);
            if adc_ready = '1' then
                adc_sample <= sine_vec(idx mod N);
                adc_valid  <= '1';
                idx := idx + 1;
            else
                adc_valid  <= '0';         -- 上游暂停
            end if;
        end loop;
        adc_valid <= '0';                  -- 输入结束
        wait;
    end process;

    ----------------------------------------------------------------
    -- DUT 实例
    u_dut: entity work.SpectAnalyzer_top
        port map (
            clk        => clk,
            rst_n      => rst_n,
            adc_sample => adc_sample,
            adc_valid  => adc_valid,
            adc_ready  => adc_ready,
            dout       => dout,
            dout_valid => dout_valid
        );

    ----------------------------------------------------------------
    -- 结果监视（纯时序，无数值判断）
    monitor: process
        variable frame_cnt : natural := 0;
        variable sample_cnt: natural := 0;
    begin
        wait until rst_n = '1';
        loop
            wait until rising_edge(clk);
            if dout_valid = '1' then
                sample_cnt := sample_cnt + 1;
                if sample_cnt = N then
                    frame_cnt := frame_cnt + 1;
                    report "Frame " & integer'image(frame_cnt) & " completed"
                           severity note;
                    sample_cnt := 0;
                end if;
            end if;
            if frame_cnt = 3 then          -- Stop after 3 frames
                report "Top-level timing PASS!" severity note;
                wait;                      -- Stop monitor
            end if;
        end loop;
    end process;
end;
