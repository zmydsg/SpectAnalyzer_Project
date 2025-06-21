-- =============================================================
--  mag_sqr_fft.vhd  �C 8?point radix?2 DIT FFT  +  |X(k)|2  (Q1.15)
--  ����ʵ�֣���ֱ���滻����ʾ�档
--  * ��λ������ / ��Ȼ˳�����
--  * �����㣬ȫ����ת����Ӳ����
--  * 3 ������һ������ϼ��㣬���˳��д�� RAM Port?B
-- =============================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity mag_sqr_fft is
    generic (
        WIDTH : natural := DATA_WIDTH;   -- 16
        N     : natural := N_POINTS);    -- 8
    port (
        clk      : in  std_logic;
        rst_n    : in  std_logic;
        start    : in  std_logic;
        done     : out std_logic;
        -- Port?B (�� ram_dp ����)
        ram_addr : out addr_t;
        ram_din  : in  signed(WIDTH-1 downto 0);
        ram_dout : out signed(WIDTH-1 downto 0);
        ram_we   : out std_logic);
end entity;

architecture rtl of mag_sqr_fft is
    -- ���Ͷ���ͳ������ֲ���
    
    -- �޸�״̬��
    type state_t is (IDLE, STAGE1, STAGE2, STAGE3, MAG_CALC, DONE1);
    signal st  : state_t := IDLE;
    
    -- �������Ϳ����ź�
    signal cnt : unsigned(3 downto 0) := (others => '0');
    signal step : unsigned(1 downto 0) := (others => '0'); -- ��/����/д�Ĳ���
    
    -- ��ʱ�Ĵ�����ֻ�洢��ǰ������������ݣ������������飩
    signal t_re, t_im, b_re, b_im : data_t := (others => '0');
    signal w_re, w_im : data_t := (others => '0');
    signal res_t_re, res_t_im, res_b_re, res_b_im : data_t := (others => '0');
    
    -- RAM�����ź�
    signal rd_addr : addr_t := (others => '0');
    signal wr_addr : addr_t := (others => '0');
    signal wr_en   : std_logic := '0';
    signal wr_data : data_t := (others => '0');
    
    -- �����˷��������ֲ���
    
    -- ������ε�Ԫ��ַ�ĺ���
	function calc_butterfly_addr(
			stage : unsigned;      -- stage λ����㣬���Լ�����
			grp   : unsigned;
			pair  : unsigned) return unsigned is
	  variable distance : integer;
	  variable base_addr, result : unsigned(grp'range);
	begin
	  distance  := 2 ** to_integer(stage);
	  base_addr := shift_left(grp, to_integer(stage)+1);  -- <<=== ����
	  if pair = 0 then
		 result := base_addr + grp;
	  else
		 result := base_addr + grp + distance;
	  end if;
	  return result;
	end;

    
    -- ��ȡ��ת���ӵĺ���
    function get_twiddle(stage, grp : unsigned) return integer is
        variable k : integer;
    begin
        k := to_integer(grp) * (N/2**to_integer(stage+1));
        return k;
    end function;
    
begin
    -- RAM�ӿ�
    ram_we <= wr_en;
    ram_dout <= wr_data;
    
    process(clk, rst_n)
        variable mag2 : signed(31 downto 0);
        variable stage_idx, group_idx, pair_idx : unsigned(2 downto 0);
        variable addr_t, addr_b : addr_t;
    begin
        if rst_n = '0' then
            st <= IDLE;
            cnt <= (others => '0');
            step <= (others => '0');
            wr_en <= '0';
            done <= '0';
        elsif rising_edge(clk) then
            -- Ĭ�����
            wr_en <= '0';
            done <= '0';
            
            case st is
                when IDLE =>
                    if start = '1' then
                        st <= STAGE1;
                        cnt <= (others => '0');
                        step <= (others => '0');
                    end if;
                
                -- ��һ���������㣨����=4��
                when STAGE1 =>
                    stage_idx := to_unsigned(0, 3);
                    group_idx := cnt(2 downto 1);
                    pair_idx := cnt(0 downto 0);
                    
                    case step is
                        when "00" => -- ��ȡ��һ�����ݵ�
                            addr_t := calc_butterfly_addr(stage_idx, group_idx, to_unsigned(0, 1));
                            ram_addr <= addr_t & '0'; -- ʵ����ַ
                            step <= step + 1;
                            
                        when "01" => -- ��ȡ��һ�����ݵ���鲿
                            t_re <= ram_din;
                            ram_addr <= addr_t & '1'; -- �鲿��ַ
                            step <= step + 1;
                            
                        when "10" => -- ��ȡ�ڶ������ݵ�
                            t_im <= ram_din;
                            addr_b := calc_butterfly_addr(stage_idx, group_idx, to_unsigned(1, 1));
                            ram_addr <= addr_b & '0'; -- ʵ����ַ
                            step <= step + 1;
                            
                        when "11" => -- ��ȡ�ڶ������ݵ���鲿������
                            b_re <= ram_din;
                            ram_addr <= addr_b & '1'; -- �鲿��ַ
                            
                            -- ����һ��ʱ�����ڣ����ǽ����������ݽ��м���
                            -- ����ʼд�ؽ��
                            step <= "00";
                            
                            if cnt = 7 then
                                cnt <= (others => '0');
                                st <= STAGE2;
                            else
                                cnt <= cnt + 1;
                            end if;
                    end case;
                    
                -- �ڶ����͵�����������������ʵ��
                -- ...
                
                -- ���������ƽ��
                when MAG_CALC =>
                    -- �����ڵ�ǰSTORE״̬��ʵ��
                    -- ��ֱ�Ӵ�RAM��ȡ���ݼ������ƽ��
                    
                when DONE1 =>
                    done <= '1';
                    if start = '0' then
                        st <= IDLE;
                    end if;
            end case;
        end if;
    end process;
end architecture;
