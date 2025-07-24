-- ============================================================================
-- File    : top_tb.vhd
-- Author  : 你的名字
-- Purpose : 行为仿真 testbench for SpectAnalyzer_top
-- Target  : ModelSim 6.4a
-- ============================================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;  -- 使用项目包，提高兼容性
library std;
use std.textio.all;
use ieee.std_logic_textio.all;

entity top_tb is
end entity;

architecture sim of top_tb is
    -- ======== 配置参数 =======================================================
    constant CLKPER : time    := 20 ns; -- 50 MHz
    -- 使用包中定义的DATA_WIDTH，提高兼容性
    -- === 选择激励文件：sig_A.hex / sig_B.hex / sig_C.hex ====================
    constant STIM_FILE : string :=
        "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/tb/system/sig_C.hex";

    -- 仿真结果输出文件
    constant OUT_FILE  : string :=
        "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/tb/system/sim_out.hex";

    -- ======== 信号声明 =======================================================
    signal clk         : std_logic := '0';
    signal rst_n       : std_logic := '0';

    -- 使用包中定义的data_t类型，提高兼容性
    signal adc_sample  : data_t;  -- 等同于signed(DATA_WIDTH-1 downto 0)
    signal adc_valid   : std_logic := '0';
    signal adc_ready   : std_logic;

    signal dout        : data_t;  -- 等同于signed(DATA_WIDTH-1 downto 0)
    signal dout_valid  : std_logic;
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
    -- ③ 实例化设计顶层 DUT
    ---------------------------------------------------------------------------
    uut : entity work.SpectAnalyzer_top
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
        while not endfile(f) loop
            readline(f, L);
            hread(L, dat_slv);                                  
            adc_sample <= signed(dat_slv);                      
            adc_valid  <= '1';

            wait until rising_edge(clk);
            -- 流控：若 DUT busy，则暂停驱动
            while adc_ready = '0' loop
                wait until rising_edge(clk);
            end loop;
        end loop;

        -- 激励已全部发送
        adc_valid <= '0';
        wait;  -- 保持仿真
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
            end if;
        end loop;
    end process dump_out;

end architecture sim;
