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
    -- �����һ��
    use work.spect_pkg.all;
    
    --------------------------------------------------------------------
    -- ���ͱ���
    --------------------------------------------------------------------
    subtype d_t  is data_t;              -- signed(15 downto 0)
    type vec_t   is array (0 to N-1) of d_t;       -- 8?element ����

    --------------------------------------------------------------------
    -- Twiddle ϵ�� (Q1.15)
    --------------------------------------------------------------------
    constant ONE_RE : d_t := to_signed( 32768, 16);  -- 1 + j0
    constant ONE_IM : d_t := to_signed(     0, 16);
    constant W1_RE  : d_t := to_signed( 23170, 16);  -- 0.7071  - j0.7071
    constant W1_IM  : d_t := to_signed(-23170, 16);
    constant W2_RE  : d_t := to_signed(     0, 16);  -- 0      - j1
    constant W2_IM  : d_t := to_signed(-32768, 16);
    constant W3_RE  : d_t := to_signed(-23170, 16);  -- -0.7071 - j0.7071
    constant W3_IM  : d_t := to_signed(-23170, 16);

    --------------------------------------------------------------------
    -- ״̬��
    --------------------------------------------------------------------
    type state_t is (IDLE, LOAD, CALC, STORE, DONE1);
    signal st  : state_t := IDLE;

    -- ��������LOAD/STORE �� (0..15) / (0..7)
    signal cnt : unsigned(3 downto 0) := (others => '0');

    -- �ڲ��Ĵ�������
    signal xr_buf, xi_buf : vec_t := (others => (others => '0'));

    -- RAM?B д�ź�
    signal wr_en   : std_logic := '0';
    signal wr_data : d_t       := (others => '0');

    --------------------------------------------------------------------
    -- �����˷������� + >>>15���������ͣ�
    --------------------------------------------------------------------
    function cmul_re(ar, ai, br, bi : d_t) return d_t is
        variable tmp : signed(31 downto 0);
    begin
        tmp := resize(ar,32)*resize(br,32) - resize(ai,32)*resize(bi,32);
        return resize(tmp(30 downto 15), WIDTH);
    end function;

    function cmul_im(ar, ai, br, bi : d_t) return d_t is
        variable tmp : signed(31 downto 0);
    begin
        tmp := resize(ar,32)*resize(bi,32) + resize(ai,32)*resize(br,32);
        return resize(tmp(30 downto 15), WIDTH);
    end function;

begin
    --------------------------------------------------------------------
    -- ���� RAM?B �ӿ�
    --------------------------------------------------------------------
    ram_we   <= wr_en;
    ram_dout <= wr_data;

    --------------------------------------------------------------------
    -- ��ͬ������
    --------------------------------------------------------------------
    process(clk, rst_n)
        variable idx                  : integer;
        variable t_re, t_im           : d_t;
        variable b_re, b_im           : d_t;
        variable w_re, w_im           : d_t;
        variable xr, xi               : vec_t;
        variable mag2                 : signed(31 downto 0);
    begin
        if rst_n = '0' then
            st   <= IDLE;
            cnt  <= (others => '0');
            wr_en<= '0';
            done <= '0';
        elsif rising_edge(clk) then
            ------------------------------------------------------------
            -- Ĭ�����
            ------------------------------------------------------------
            wr_en <= '0';
            done  <= '0';

            case st is

                --------------------------------------------------------
                when IDLE =>
                    if start = '1' then
                        cnt <= (others => '0');
                        st  <= LOAD;
                    end if;

                --------------------------------------------------------
                -- LOAD��16 �İ� Re/Im �������ڲ�
                --------------------------------------------------------
                when LOAD =>
                    ram_addr <= addr_t(cnt);
                    if cnt(0) = '0' then                       -- ʵ��
                        xr_buf(to_integer(cnt(3 downto 1))) <= ram_din;
                    else                                       -- �鲿
                        xi_buf(to_integer(cnt(3 downto 1))) <= ram_din;
                    end if;

                    if cnt = 15 then
                        st <= CALC;
                    else
                        cnt <= cnt + 1;
                    end if;

                --------------------------------------------------------
                -- CALC��һ������� 3 ������
                --------------------------------------------------------
                when CALC =>
                    xr := xr_buf;  xi := xi_buf;   -- ���ػ���

                    ----------------------------------------------------
                    -- Stage?1 (�� 1)
                    ----------------------------------------------------
                    for p in 0 to 3 loop
                        t_re := xr(p);   t_im := xi(p);
                        b_re := xr(p+4); b_im := xi(p+4);

                        xr(p)   := t_re + b_re;
                        xi(p)   := t_im + b_im;
                        xr(p+4) := t_re - b_re;
                        xi(p+4) := t_im - b_im;
                    end loop;

                    ----------------------------------------------------
                    -- Stage?2 (�� 2)
                    ----------------------------------------------------
                    for g in 0 to 1 loop
                        idx := g*2;
                        -- W0 ����
                        t_re := xr(idx);   t_im := xi(idx);
                        b_re := xr(idx+2); b_im := xi(idx+2);
                        xr(idx)   := t_re + b_re;
                        xi(idx)   := t_im + b_im;
                        xr(idx+2) := t_re - b_re;
                        xi(idx+2) := t_im - b_im;

                        -- W2 = (0, -1)
                        t_re := xr(idx+1); t_im := xi(idx+1);
                        b_re := xr(idx+3); b_im := xi(idx+3);
                        w_re := cmul_re(b_re, b_im, W2_RE, W2_IM);
                        w_im := cmul_im(b_re, b_im, W2_RE, W2_IM);
                        xr(idx+1) := t_re + w_re;
                        xi(idx+1) := t_im + w_im;
                        xr(idx+3) := t_re - w_re;
                        xi(idx+3) := t_im - w_im;
                    end loop;

                    ----------------------------------------------------
                    -- Stage?3 (�� 4)
                    ----------------------------------------------------
                    for k in 0 to 3 loop
                        t_re := xr(k);   t_im := xi(k);
                        b_re := xr(k+4); b_im := xi(k+4);
                        -- ѡ Twiddle
                        case k is
                            when 0 => w_re := ONE_RE; w_im := ONE_IM;
                            when 1 => w_re := W1_RE;  w_im := W1_IM;
                            when 2 => w_re := W2_RE;  w_im := W2_IM;
                            when others => w_re := W3_RE; w_im := W3_IM;
                        end case;
                        -- ���� Wk
                        w_re := cmul_re(b_re, b_im, w_re, w_im);
                        w_im := cmul_im(b_re, b_im, w_re, w_im);
                        xr(k)     := t_re + w_re;
                        xi(k)     := t_im + w_im;
                        xr(k+4)   := t_re - w_re;
                        xi(k+4)   := t_im - w_im;
                    end loop;

                    -- д�ؼĴ�����
                    xr_buf <= xr;
                    xi_buf <= xi;

                    cnt <= (others => '0');
                    st  <= STORE;

                --------------------------------------------------------
                -- STORE��8 �İ� |X|2 д�ص� "ʵ����ַ"
                --------------------------------------------------------
                when STORE =>
                    ram_addr <= addr_t(cnt & '0');  -- ʵ����ַ
                    mag2 := resize(xr_buf(to_integer(cnt)),32)*resize(xr_buf(to_integer(cnt)),32) +
                            resize(xi_buf(to_integer(cnt)),32)*resize(xi_buf(to_integer(cnt)),32);
                    wr_data <= resize(mag2(30 downto 15), WIDTH);
                    wr_en   <= '1';

                    if cnt = 7 then
                        st <= DONE1;
                    else
                        cnt <= cnt + 1;
                    end if;

                --------------------------------------------------------
                when DONE1 =>
                    done <= '1';
                    if start = '0' then
                        st <= IDLE;
                    end if;
            end case;
        end if;
    end process;
end architecture;
