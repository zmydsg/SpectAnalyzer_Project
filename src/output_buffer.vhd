-- ================================================================
--  File : output_buffer.vhd           Dir : rtl/output/
--  ���� : ÿ����� 1 �� |X(k)|2 (Q1.15)������� N ���֪ͨϵͳ
--  ���� : spect_pkg.vhd  (���� WIDTH / N_POINTS / addr_t ... )
-- ================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.spect_pkg.all;

entity output_buffer is
    generic (
        WIDTH : natural := DATA_WIDTH; -- 16
        N     : natural := N_POINTS    -- 8
    );
    port (
        ---------------- ʱ�� / ��λ ----------------
        clk      : in  std_logic;
        rst_n    : in  std_logic;

        ---------------- ��ϵͳʱ��Э�� -------------
        start_in : in  std_logic;   -- �� FFT ģ��� done ���� 1 ��
        done_out : out std_logic;   -- ��ģ�������һ֡������ 1 ��

        ---------------- RAM ���˿ڽӿ� -------------
        ram_addr : out addr_t;
        ram_din  : in  signed(WIDTH-1 downto 0);
        ram_we   : out std_logic;    -- �̶� '0' ��ֻ����

        ---------------- ������������ ---------------
        dout        : out signed(WIDTH-1 downto 0);
        dout_valid  : out std_logic
    );
end entity;

-- ================================================================
architecture rtl of output_buffer is
-- ================================================================
    ----------------------------------------------------------------
    -- ״̬����IDLE �� SET_ADDR �� READ_OUT �� LAST �� IDLE
    ----------------------------------------------------------------
    type state_t is (IDLE, SET_ADDR, READ_OUT, LAST);
    signal st : state_t := IDLE;

    signal idx  : integer range 0 to N-1 := 0;            -- �������
    signal addr : addr_t := (others=>'0');                -- RAM ��ַ
begin
    ----------------------------------------------------------------
    -- Ĭ���ź�
    ----------------------------------------------------------------
    ram_we     <= '0';          -- ֻ��
    ram_addr   <= addr;
    dout       <= ram_din;
    --dout_valid <= '0';
    --done_out   <= '0';

    ----------------------------------------------------------------
    -- ������
    ----------------------------------------------------------------
    process(clk, rst_n)
    begin
        if rst_n='0' then
            st   <= IDLE;
            idx  <= 0;
            addr <= (others=>'0');
            dout_valid <= '0';
			done_out   <= '0';
        elsif rising_edge(clk) then
			-- �� ÿ��Ĭ������
			dout_valid <= '0';
			done_out   <= '0';
            
            case st is
            ----------------------------------------------------------------
            when IDLE =>
                if start_in='1' then              -- FFT �������
                    idx  <= 0;
                    addr <= to_unsigned(0, ADDR_WIDTH);  -- |X(0)|2 ����ż��ַ 0
                    st   <= READ_OUT;
                end if;

            ----------------------------------------------------------------
            -- SET_ADDR: �ѵ�ַ�ŵ� RAM����һ�Ŀɶ�������
            when SET_ADDR =>
                st <= READ_OUT;

            ----------------------------------------------------------------
            -- READ_OUT: ���� ram_din ��Ч �� dout_valid=1
            when READ_OUT =>
                dout_valid <= '1';
                if idx = N-1 then                 -- ���һ������
                    st <= LAST;
                else
                    idx  <= idx + 1;
                    addr <= to_unsigned((idx+1)*2, ADDR_WIDTH);  -- ż��ַ 0,2,4��
                    st   <= SET_ADDR;
                end if;

            ----------------------------------------------------------------
            -- LAST: ������һ�����ݣ����� done_out����һ�Ļ� IDLE
            when LAST =>
                dout_valid <= '1';
                done_out   <= '1';
                st         <= IDLE;
            end case;
        end if;
    end process;
end architecture;
