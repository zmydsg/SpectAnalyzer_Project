-- ================================================================
--  Testbench : tb_output_buffer.vhd
-- ================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.spect_pkg.all;

entity tb_output_buffer is
end entity;

architecture sim of tb_output_buffer is
    ----------------------------------------------------------------
    -- 常量 / 信号
    ----------------------------------------------------------------
    constant CLK_PERIOD : time := 20 ns;

    signal clk        : std_logic := '0';
    signal rst_n      : std_logic := '0';

    signal start_in   : std_logic := '0';
    signal done_out   : std_logic;

    signal ram_addr   : addr_t;
    signal ram_din    : signed(DATA_WIDTH-1 downto 0);
    signal ram_we     : std_logic;

    signal dout       : signed(DATA_WIDTH-1 downto 0);
    signal dout_valid : std_logic;

    -- 简易同步读 RAM
    type ram_t is array (0 to N_POINTS*2-1) of signed(DATA_WIDTH-1 downto 0);
    signal ram : ram_t := (others => (others => '0'));
begin
    ----------------------------------------------------------------
    -- 1. 时钟
    ----------------------------------------------------------------
    clk <= not clk after CLK_PERIOD/2;

    ----------------------------------------------------------------
    -- 2. 复位
    ----------------------------------------------------------------
    rst_proc : process
    begin
        rst_n <= '0';
        wait for 50 ns;
        rst_n <= '1';
        wait;
    end process;

    ----------------------------------------------------------------
    -- 3. 预置 RAM 数据
    ----------------------------------------------------------------
    init_proc : process
    begin
        wait for 30 ns;
        for k in 0 to N_POINTS-1 loop
            ram(k*2) <= to_signed(k+1, DATA_WIDTH);  -- 1, 2, 3, ...
        end loop;
        wait;
    end process;

    ----------------------------------------------------------------
    -- 4. RAM 同步读
    ----------------------------------------------------------------
    ram_proc : process(clk)
    begin
        if rising_edge(clk) then
            ram_din <= ram(to_integer(ram_addr));
        end if;
    end process;

    ----------------------------------------------------------------
    -- 5. 激励
    ----------------------------------------------------------------
    stim_proc : process
    begin
        -- 等待复位完成
        wait until rst_n='1' and rising_edge(clk);

        -- start_in 脉冲
        start_in <= '1';
        wait for CLK_PERIOD;
        start_in <= '0';

        -- 等待 done_out
        wait until done_out='1';

        -- 观测窗口
        wait for 200 ns;

        -- 打印信息，但不终止仿真
        assert false
            report "Simulation reached observation point; manual stop when done."
            severity note;

        wait;                     -- 不再自动结束，保持运行
    end process;

    ----------------------------------------------------------------
    -- 6. DUT 实例
    ----------------------------------------------------------------
    uut : entity work.output_buffer
        generic map (
            WIDTH => DATA_WIDTH,
            N     => N_POINTS
        )
        port map (
            clk        => clk,
            rst_n      => rst_n,
            start_in   => start_in,
            done_out   => done_out,
            ram_addr   => ram_addr,
            ram_din    => ram_din,
            ram_we     => ram_we,
            dout       => dout,
            dout_valid => dout_valid
        );
end architecture;
