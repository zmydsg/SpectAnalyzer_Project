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
  -- �Ժ������������ڲ��źš��������
begin
  -- �����ʱû�в�����䣬�������գ�Ҳ���ԣ�
  -- dummy: null;  
  -- ����˱�ǩ dummy���Ͳ��ᱨ��
end rtl;
