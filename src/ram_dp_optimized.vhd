library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity ram_dp_optimized is
    port (
        clk : in std_logic;
        
        -- Port-A: 读写端口
        addr_a : in  addr_t;
        din_a  : in  signed(DATA_WIDTH-1 downto 0);
        we_a   : in  std_logic;
        dout_a : out signed(DATA_WIDTH-1 downto 0);
        
        -- Port-B: 读写端口
        addr_b : in  addr_t;
        din_b  : in  signed(DATA_WIDTH-1 downto 0);
        we_b   : in  std_logic;
        dout_b : out signed(DATA_WIDTH-1 downto 0)
    );
end entity;

architecture rtl of ram_dp_optimized is
    type mem_t is array (0 to DEPTH-1) of signed(DATA_WIDTH-1 downto 0);
    signal mem : mem_t := (others => (others => '0'));
    
    -- 地址冲突检测
    signal addr_conflict : std_logic;
    
begin
    -- 地址冲突检测：同时写入相同地址时，Port-B优先
    addr_conflict <= '1' when (addr_a = addr_b and we_a = '1' and we_b = '1') else '0';
    
    process(clk)
    begin
        if rising_edge(clk) then
            -- Port-A 操作
            if we_a = '1' and addr_conflict = '0' then
                mem(to_integer(addr_a)) <= din_a;
            end if;
            dout_a <= mem(to_integer(addr_a));
            
            -- Port-B 操作（优先级更高）
            if we_b = '1' then
                mem(to_integer(addr_b)) <= din_b;
            end if;
            dout_b <= mem(to_integer(addr_b));
        end if;
    end process;
    
end architecture rtl;