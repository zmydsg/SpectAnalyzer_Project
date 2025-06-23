library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;       -- 读 mem 文件
use work.spect_pkg.all;

entity mag_sqr_fft_tb is end;
architecture tb of mag_sqr_fft_tb is
    -- 时钟复位
    constant PERIOD : time := 10 ns;
    signal clk, rst_n : std_logic := '0';

    -- 单端口 RAM 总线（解析型）
    signal ram_addr_s  : addr_t;
    signal ram_dout_s  : signed(DATA_WIDTH-1 downto 0);
    signal ram_din_s   : signed(DATA_WIDTH-1 downto 0);
    signal ram_we_s    : std_logic;

    -- UUT 端口
    signal start, done : std_logic := '0';
begin
    ----------------------------------------------------------------
    -- 1) 时钟
    clk <= not clk after PERIOD/2;

    -- 2) DUT
    uut: entity work.mag_sqr_fft
        port map (
            clk   => clk,
            rst_n => rst_n,
            start => start,
            done  => done,
            ram_addr => ram_addr_s,
            ram_din  => ram_din_s,
            ram_dout => ram_dout_s,
            ram_we   => ram_we_s
        );

    -- 3) 行为 RAM
    ram: entity work.ram_sp
        port map (
            clk  => clk,
            addr => ram_addr_s,
            din  => ram_dout_s,
            we   => ram_we_s,
            dout => ram_din_s
        );

    ----------------------------------------------------------------
    -- 4) 主激励流程
    stim: process
        file f_stim  : text open read_mode  is "stim.mem";
        variable L   : line;
        variable idx : integer := 0;
        variable w   : signed(DATA_WIDTH-1 downto 0);
    begin
        -- 全复位
        rst_n <= '0'; wait for 5*PERIOD;
        rst_n <= '1'; wait for PEROID;

        -- 4-A 写输入采样到 RAM 0..N-1（偶实奇虚）
        while not endfile(f_stim) loop
            readline(f_stim, L);
            hread(L, w);                -- 十六进制读
            ram_we_s   <= '1';
            ram_addr_s <= to_unsigned(idx, ADDR_WIDTH);
            ram_dout_s <= w;
            wait until rising_edge(clk);
            ram_we_s <= '0';
            idx := idx + 1;
        end loop;

        wait for PERIOD;

        -- 4-B 发 start 脉冲
        start <= '1'; wait until rising_edge(clk);
        start <= '0';

        -- 4-C 等待 done
        wait until done='1';
        wait until rising_edge(clk);  -- done 为 1-clk 脉冲

        -- 4-D 读回并比对
        file f_golden : text open read_mode  is "golden.mem";
        idx := 0;
        while not endfile(f_golden) loop
            readline(f_golden, L);
            hread(L, w);

            ram_addr_s <= to_unsigned(idx*2, ADDR_WIDTH);  -- 偶地址存幅度²
            wait until rising_edge(clk);

            assert ram_din_s = w
            report "Mismatch @k=" & integer'image(idx) &
                   ". expect=" & integer'image(to_integer(w)) &
                   ", got=" & integer'image(to_integer(ram_din_s))
            severity error;

            idx := idx + 1;
        end loop;

        report "All samples matched – TEST PASSED" severity note;
        wait;
    end process;
end;