library ieee; use ieee.std_logic_1164.all; use ieee.numeric_std.all;
use work.spect_pkg.all;

entity ram_dp is
    port (
        clk : in std_logic;
        -- Port-A : INPUT Ð´
        addr_A : in  addr_t;
        din_A  : in  signed(DATA_WIDTH-1 downto 0);
        we_A   : in  std_logic;
        -- Port-B : FFT ¶Á/Ð´
        addr_B : in  addr_t;
        din_B  : in  signed(DATA_WIDTH-1 downto 0);
        we_B   : in  std_logic;
        dout_B : out signed(DATA_WIDTH-1 downto 0)
    );
end;

architecture rtl of ram_dp is
    type mem_t is array (0 to DEPTH-1) of signed(DATA_WIDTH-1 downto 0);
    signal mem : mem_t := (others=>(others=>'0'));
begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- Port-A : write only
            if we_A='1' then
                mem(to_integer(addr_A)) <= din_A;
            end if;

            -- Port-B : read-before-write
            dout_B <= mem(to_integer(addr_B));
            if we_B='1' then
                mem(to_integer(addr_B)) <= din_B;
            end if;
        end if;
    end process;
end;
