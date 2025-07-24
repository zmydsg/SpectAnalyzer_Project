library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package spect_pkg0 is
  -- 计算 ceil(log2(n)) 的子程序声明
  function log2ceil(n : natural) return natural;
end package spect_pkg0;

package body spect_pkg0 is
  function log2ceil(n : natural) return natural is
    variable v : natural := n - 1;
    variable r : natural := 0;
  begin
    while v > 0 loop
      v := v / 2;
      r := r + 1;
    end loop;
    return r;
  end function log2ceil;
end package body spect_pkg0;
