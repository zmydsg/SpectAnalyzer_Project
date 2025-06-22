library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package spect_pkg is

    function log2ceil(n : natural) return natural;
    constant DATA_WIDTH : natural := 16;   -- Q1.15
    constant N_POINTS   : natural := 8;    -- FFT 点数
    -- 求 ceil(log2(n))

    constant DEPTH      : natural := N_POINTS * 2;            -- Re/Im 交织
    constant ADDR_WIDTH : natural := log2ceil(DEPTH);
    subtype data_t is signed(DATA_WIDTH-1 downto 0);
    subtype addr_t is unsigned(ADDR_WIDTH-1 downto 0);
end package;

package body spect_pkg is
    function log2ceil(n : natural) return natural is
        variable v : natural := n-1;
        variable r : natural := 0;
    begin
        while v > 0 loop
            v := v/2;
            r := r+1;
        end loop;
        return r;
    end function;
end package body;
