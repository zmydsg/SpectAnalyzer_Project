library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity input_buffer is
    port (
        clk, rst_n : in  std_logic;
        ----------------------------------------------------------------
        -- �� ADC ������
        ----------------------------------------------------------------
        din        : in  signed(DATA_WIDTH-1 downto 0);
        din_valid  : in  std_logic;
        din_ready  : out std_logic;
        ----------------------------------------------------------------
        -- �� FFT ������
        ----------------------------------------------------------------
        start_fft  : out std_logic;   -- ��������
        fft_done   : in  std_logic;
        ----------------------------------------------------------------
        -- ���˿� RAM ���ߣ���ģ�鹲��
        ----------------------------------------------------------------
        ram_addr   : out addr_t;
        ram_dout   : out signed(DATA_WIDTH-1 downto 0);
        ram_we     : out std_logic
    );
end entity;

------------------------------------------------------------------------
architecture rtl of input_buffer is
------------------------------------------------------------------------
    --------------------------------------------------------------------
    -- �Ĵ��� / ״̬��
    --------------------------------------------------------------------
    signal wr_ptr : integer range 0 to DEPTH-1 := 0;

    type s_t is (IDLE, WRITE, WAIT_1, WAIT_FFT);
    signal st : s_t := IDLE;

    --------------------------------------------------------------------
    -- �ڲ� RAM �ź� + α��̬����
    --------------------------------------------------------------------
    signal addr_int : addr_t                          := (others=>'0');
    signal dout_int : signed(DATA_WIDTH-1 downto 0)   := (others=>'0');
    signal we_int   : std_logic                       := '0';
    signal drive_en : std_logic                       := '0';   -- =1 ��ʾ��ģ����������

    --------------------------------------------------------------------
    -- ���ߺ���
    --------------------------------------------------------------------
    -- bit_reverse��wr_ptr/2 ȡ 3 λ ? 8 �� FFT
    function bit_reverse(x: natural; bits: natural) return natural is
        variable r    : natural := 0;
        variable temp : natural := x;
    begin
        for i in 0 to bits-1 loop
            r    := r * 2 + (temp mod 2);
            temp := temp / 2;
        end loop;
        return r;
    end;

    -- �������� �� RAM ��ַ��żʵ�����飩
    function cpx_to_addr(idx : integer; is_im : boolean) return addr_t is
        variable a : integer := idx*2;
    begin
        if is_im then
            a := a + 1;
        end if;
        return to_unsigned(a, ADDR_WIDTH);
    end;
begin
    --------------------------------------------------------------------
    -- α��̬���ߣ��� drive_en ʱ��� 'Z'
    --------------------------------------------------------------------
    ram_addr <= addr_int                when drive_en='1' else (others=>'Z');
    ram_dout <= dout_int                when drive_en='1' else (others=>'Z');
    ram_we   <= we_int                  when drive_en='1' else 'Z'; -- 'Z'��0

    --------------------------------------------------------------------
    -- ��ʱ�����
    --------------------------------------------------------------------
    process(clk, rst_n)
        variable bit_rev_idx : integer;
    begin
        if rst_n='0' then
            st        <= IDLE;
            wr_ptr    <= 0;
            din_ready <= '0';
            start_fft <= '0';

            drive_en  <= '0';
            we_int    <= '0';
        elsif rising_edge(clk) then
            ----------------------------------------------------------------
            -- ÿ��Ĭ��ֵ
            ----------------------------------------------------------------
            drive_en  <= '0';       -- �����Ĳ����¸� 1������� 'Z'
            we_int    <= '0';
            start_fft <= '0';
            -- din_ready ȱʡ������һ�ε�ֵ��ֻ����Ҫʱ�޸ģ�

            case st is
            ----------------------------------------------------------------
            when IDLE =>
                din_ready <= '1';

                if din_valid='1' then
                    -- �����ַ & д RAM
                    bit_rev_idx := bit_reverse(wr_ptr/2, 3);

                    addr_int  <= cpx_to_addr(bit_rev_idx, (wr_ptr mod 2)=1);
                    dout_int  <= din;
                    we_int    <= '1';
                    drive_en  <= '1';

                    wr_ptr    <= wr_ptr + 1;
                    st        <= WRITE;
                end if;

            ----------------------------------------------------------------
            when WRITE =>
                if din_valid='1' then
                    bit_rev_idx := bit_reverse(wr_ptr/2, 3);

                    addr_int  <= cpx_to_addr(bit_rev_idx, (wr_ptr mod 2)=1);
                    dout_int  <= din;
                    we_int    <= '1';
                    drive_en  <= '1';

                    wr_ptr    <= wr_ptr + 1;
                end if;

                if wr_ptr = DEPTH-1 then      -- ���һ��������д��
                    din_ready <= '0';         -- ��ͣ ADC
                    st        <= WAIT_1;      -- �������ߣ��ٷ�����
                end if;

            ----------------------------------------------------------------
            when WAIT_1 =>
                -- �����Ѳ������� RAM��drive_en Ĭ�� 0��
                start_fft <= '1';             -- ��������
                st        <= WAIT_FFT;

            ----------------------------------------------------------------
            when WAIT_FFT =>
                if fft_done='1' then
                    wr_ptr    <= 0;
                    din_ready <= '1';
                    st        <= IDLE;
                end if;

            end case;
        end if;
    end process;

end architecture;
