library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SpectAnalyzer_top is
  port (
    clk       : in  std_logic;
    rst_n     : in  std_logic;
    data_in   : in  std_logic_vector(15 downto 0);
    valid_in  : in  std_logic;
    mag2_out  : out std_logic_vector(31 downto 0);
    valid_out : out std_logic;
    done      : out std_logic
  );
end SpectAnalyzer_top;

architecture rtl of SpectAnalyzer_top is
  -- 以后在这里声明内部信号、组件声明
begin
  -- 如果暂时没有并发语句，可以留空，也可以：
  -- dummy: null;  
  -- 添加了标签 dummy，就不会报错
end rtl;
