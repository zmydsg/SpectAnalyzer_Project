-- ================================================================
--  File : output_buffer.vhd
--  ���� : ������� |X(k)|2������� N ������� done_out 1-clk
--  ����α��̬���룺drive_en = 0 ? ram_addr ��� 'Z'
-- ================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity output_buffer is
    generic (
        WIDTH : natural := DATA_WIDTH;  -- 16
        N     : natural := N_POINTS     -- 8
    );
    port (
        ---------------- ʱ�� / ��λ ----------------
        clk      : in  std_logic;
        rst_n    : in  std_logic;

        ---------------- ��ϵͳʱ��Э�� -------------
        start_in : in  std_logic;      -- FFT done �� 1-clk ����
        done_out : out std_logic;      -- ��ģ�������� 1-clk

        ---------------- ���˿� RAM ���� -------------
        ram_addr : out addr_t;
        ram_din  : in  signed(WIDTH-1 downto 0);
        ram_we   : out std_logic;      -- ���� ? ֻ��

        ---------------- ���������� -----------------
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

    signal idx       : integer range 0 to N-1 := 0;  -- �������
    signal addr_next : addr_t                 := (others=>'0');

    ----------------------------------------------------------------
    -- �ڲ���ַ��α��̬����
    ----------------------------------------------------------------
    signal addr_int  : addr_t                 := (others=>'0');
    signal drive_en  : std_logic              := '0'; -- =1 ? ���� RAM

begin
    ----------------------------------------------------------------
    -- ��̬ӳ��
    ----------------------------------------------------------------
    ram_addr <= addr_int when drive_en='1' else (others=>'Z');
    ram_we   <= 'Z';           -- ����裨ֻ����

    ----------------------------------------------------------------
    -- dout ֱ��ת�� RAM ����
    ----------------------------------------------------------------
    dout <= ram_din;

    ----------------------------------------------------------------
    -- ʱ�����
    ----------------------------------------------------------------
    process(clk, rst_n)
    begin
        if rst_n='0' then
            st         <= IDLE;
            idx        <= 0;
            addr_int   <= (others=>'0');
            drive_en   <= '0';
            dout_valid <= '0';
            done_out   <= '0';

        elsif rising_edge(clk) then
            ----------------------------------------------------------------
            -- ÿ��Ĭ������
            ----------------------------------------------------------------
            drive_en   <= '0';
            dout_valid <= '0';
            done_out   <= '0';

            case st is
            ----------------------------------------------------------------
            when IDLE =>
                if start_in='1' then
                    idx      <= 0;
                    addr_int <= to_unsigned(0, ADDR_WIDTH); -- |X(0)|2 �� addr 0
                    drive_en <= '1';
                    st       <= SET_ADDR;
                end if;

            ----------------------------------------------------------------
            when SET_ADDR =>                        -- ��ַ���� RAM
                drive_en <= '1';                    -- ��Ҫ���� 1 ��
                st       <= READ_OUT;

            ----------------------------------------------------------------
            when READ_OUT =>
                drive_en   <= '1';                  -- �������ֵ�ַ
                dout_valid <= '1';                  -- ���� ram_din ��Ч

                if idx = N-1 then                   -- ���һ������
                    st <= LAST;
                else
                    idx      <= idx + 1;
                    addr_int <= to_unsigned((idx+1)*2, ADDR_WIDTH); -- żַ 0,2,4��
                    -- drive_en ������һ�� SET_ADDR ����Ϊ 1
                    st       <= SET_ADDR;
                end if;

            ----------------------------------------------------------------
            when LAST =>
                drive_en   <= '1';      -- �������һ����ַ
                dout_valid <= '1';
                done_out   <= '1';      -- ��������
                st         <= IDLE;

            end case;
        end if;
    end process;
end architecture;
