library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg0.all;  -- 引用上面这个包

package spect_pkg is
  constant DATA_WIDTH : natural := 16;           -- Q1.15
  constant N_POINTS   : natural := 8;            -- FFT 点数
  constant DEPTH      : natural := N_POINTS * 2; -- Re/Im 交织
  constant ADDR_WIDTH : natural := log2ceil(DEPTH);

  subtype data_t  is signed(DATA_WIDTH-1 downto 0);
  subtype addr_t  is unsigned(ADDR_WIDTH-1 downto 0);
end package spect_pkg;

package body spect_pkg is
end package body spect_pkg;
