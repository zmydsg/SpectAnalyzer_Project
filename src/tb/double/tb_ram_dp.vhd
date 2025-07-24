-- 双端口RAM测试台
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity tb_ram_dp is
end entity;

architecture sim of tb_ram_dp is
    signal clk : std_logic := '0';
    signal addr_a, addr_b : addr_t;
    signal din_a, din_b : signed(DATA_WIDTH-1 downto 0);
    signal we_a, we_b : std_logic;
    signal dout_a, dout_b : signed(DATA_WIDTH-1 downto 0);
    
begin
    clk <= not clk after 5 ns;
    
    uut : entity work.ram_dp_optimized
        port map (
            clk => clk,
            addr_a => addr_a, din_a => din_a, we_a => we_a, dout_a => dout_a,
            addr_b => addr_b, din_b => din_b, we_b => we_b, dout_b => dout_b
        );
    
    -- 测试进程
    test_proc: process
    begin
        -- 并行写入测试
        addr_a <= to_unsigned(0, ADDR_WIDTH);
        addr_b <= to_unsigned(1, ADDR_WIDTH);
        din_a <= to_signed(100, DATA_WIDTH);
        din_b <= to_signed(200, DATA_WIDTH);
        we_a <= '1'; we_b <= '1';
        wait for 10 ns;
        
        -- 并行读取测试
        we_a <= '0'; we_b <= '0';
        wait for 10 ns;
        
        -- 验证数据
        assert dout_a = to_signed(100, DATA_WIDTH) report "Port A read failed";
        assert dout_b = to_signed(200, DATA_WIDTH) report "Port B read failed";
        
        wait;
    end process;
end architecture;