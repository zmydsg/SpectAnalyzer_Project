-- File    : tb_SpectAnalyzer_top_dp.vhd
-- Purpose : 双端口RAM优化版本的完整系统测试
-- Target  : ModelSim
-- ============================================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;
library std;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb_SpectAnalyzer_top_dp is
end entity;

architecture sim of tb_SpectAnalyzer_top_dp is
    -- ======== 配置参数 =======================================================
    constant CLKPER : time := 20 ns; -- 50 MHz
    
    -- 激励文件路径
    constant STIM_FILE : string :=
        "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/tb/system/sig_C.hex";
    
    -- 仿真结果输出文件
    constant OUT_FILE : string :=
        "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/tb/double/sim_out_dp.hex";
    
    -- ======== 信号声明 =======================================================
    signal clk         : std_logic := '0';
    signal rst_n       : std_logic := '0';
    signal adc_sample  : signed(DATA_WIDTH-1 downto 0);
    signal adc_valid   : std_logic := '0';
    signal adc_ready   : std_logic;
    signal dout        : signed(DATA_WIDTH-1 downto 0);
    signal dout_valid  : std_logic;
    
    -- 性能监控信号
    signal sample_count : integer := 0;
    signal output_count : integer := 0;
    signal start_time   : time;
    signal end_time     : time;
    
begin
    ---------------------------------------------------------------------------
    -- ① 时钟产生
    ---------------------------------------------------------------------------
    clk_gen : process
    begin
        clk <= '0';
        wait for CLKPER/2;
        clk <= '1';
        wait for CLKPER/2;
    end process;
    
    ---------------------------------------------------------------------------
    -- ② 复位
    ---------------------------------------------------------------------------
    rst_n <= '0', '1' after 100 ns;
    
    ---------------------------------------------------------------------------
    -- ③ 实例化双端口RAM优化版本 DUT
    ---------------------------------------------------------------------------
    uut : entity work.SpectAnalyzer_top_dp
        port map (
            clk        => clk,
            rst_n      => rst_n,
            adc_sample => adc_sample,
            adc_valid  => adc_valid,
            adc_ready  => adc_ready,
            dout       => dout,
            dout_valid => dout_valid
        );
    
    ---------------------------------------------------------------------------
    -- ④ 读取激励文件并驱动 DUT
    ---------------------------------------------------------------------------
    stimuli : process
        file f         : text open read_mode is STIM_FILE;
        variable L     : line;
        variable dat_slv: std_logic_vector(DATA_WIDTH-1 downto 0);
    begin
        -- 等待复位结束
        wait until rst_n = '1';
        start_time <= now;
        
        while not endfile(f) loop
            readline(f, L);
            hread(L, dat_slv);
            adc_sample <= signed(dat_slv);
            adc_valid  <= '1';
            sample_count <= sample_count + 1;
            
            wait until rising_edge(clk);
            -- 流控：若 DUT busy，则暂停驱动
            while adc_ready = '0' loop
                wait until rising_edge(clk);
            end loop;
        end loop;
        
        -- 激励已全部发送
        adc_valid <= '0';
        report "All " & integer'image(sample_count) & " samples sent at " & time'image(now);
        wait;
    end process stimuli;
    
    ---------------------------------------------------------------------------
    -- ⑤ 捕获 DUT 输出并写入结果文件
    ---------------------------------------------------------------------------
    dump_out : process
        file g         : text open write_mode is OUT_FILE;
        variable Lw    : line;
    begin
        wait until rst_n = '1';
        loop
            wait until rising_edge(clk);
            if dout_valid = '1' then
                hwrite(Lw, std_logic_vector(dout));
                writeline(g, Lw);
                output_count <= output_count + 1;
                
                -- 检测处理完成
                if output_count = 1 then
                    report "First output at " & time'image(now);
                end if;
            end if;
        end loop;
    end process dump_out;
    
    ---------------------------------------------------------------------------
    -- ⑥ 性能监控和报告
    ---------------------------------------------------------------------------
    monitor : process
    begin
        wait until rst_n = '1';
        wait for 10 us; -- Wait for processing completion
        
        report "=== Dual Port RAM Optimization Performance Report ===";
        report "Input samples: " & integer'image(sample_count);
        report "Output samples: " & integer'image(output_count);
        report "Simulation time: " & time'image(now);
        
        wait;
    end process monitor;
    
end architecture sim;