library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity mag_sqr_fft is
    generic (
        WIDTH : natural := DATA_WIDTH;
        N     : natural := N_POINTS
    );
    port (
        clk      : in  std_logic;
        rst_n    : in  std_logic;
        start    : in  std_logic;
        done     : out std_logic;
        ram_addr : out addr_t;
        ram_din  : in  signed(WIDTH-1 downto 0);
        ram_dout : out signed(WIDTH-1 downto 0);
        ram_we   : out std_logic
    );
end mag_sqr_fft;

architecture rtl of mag_sqr_fft is

    subtype wide_t is signed(WIDTH+1 downto 0);

    type coeff_arr_t is array(0 to 3) of signed(WIDTH-1 downto 0);
    constant TW_RE : coeff_arr_t := (
        to_signed( 32767, WIDTH),
        to_signed( 23170, WIDTH),
        to_signed(     0, WIDTH),
        to_signed(-23170, WIDTH)
    );
    constant TW_IM : coeff_arr_t := (
        to_signed(     0, WIDTH),
        to_signed(-23170, WIDTH),
        to_signed(-32768, WIDTH),
        to_signed(-23170, WIDTH)
    );

    type st_t is (
        IDLE,
        S0_RD_TOP_RE, S0_RD_TOP_IM, S0_RD_BOT_RE, S0_RD_BOT_IM,
        S0_CALC, S0_WR_TOP_RE, S0_WR_TOP_IM, S0_WR_BOT_RE, S0_WR_BOT_IM,
        S0_ADVANCE,
        S1_RD_TOP_RE, S1_RD_TOP_IM, S1_RD_BOT_RE, S1_RD_BOT_IM,
        S1_CALC, S1_BUTTERFLY, S1_WR_TOP_RE, S1_WR_TOP_IM, S1_WR_BOT_RE, S1_WR_BOT_IM,
        S2_RD_TOP_RE, S2_RD_TOP_IM, S2_RD_BOT_RE, S2_RD_BOT_IM,
        S2_CALC, S2_BUTTERFLY, S2_WR_TOP_RE, S2_WR_TOP_IM, S2_WR_BOT_RE, S2_WR_BOT_IM,
        MAG_RD_RE, MAG_RD_IM, MAG_CALC, MAG_WR, DONE1
    );
    signal st : st_t;

    signal pair_idx : integer range 0 to (N/2)-1;
    signal top_cpx, bot_cpx : integer range 0 to N-1;
    signal mag_idx : integer range 0 to N-1;

    signal a_re, a_im, b_re, b_im : wide_t;
    signal w_re, w_im              : signed(WIDTH-1 downto 0);
    signal up_re, up_im, dn_re, dn_im : wide_t;

    function cpx_to_addr(idx : integer; is_im : boolean) return addr_t is
        variable a : integer := idx * 2;
    begin
        if is_im then a := a + 1; end if;
        return to_unsigned(a, ADDR_WIDTH);
    end;

    function mul_q15_sat(x, y : signed) return signed is
        variable p : signed(2*WIDTH-1 downto 0) := x*y;
        variable r : signed(WIDTH-1 downto 0) := resize(shift_right(p,15), WIDTH);
    begin
        if p(2*WIDTH-1 downto WIDTH+14) /= (p(2*WIDTH-1 downto WIDTH+14)'range => p(2*WIDTH-1)) then
            if p(2*WIDTH-1) = '0' then
                r := to_signed(32767, WIDTH);
            else
                r := to_signed(-32768, WIDTH);
            end if;
        end if;
        return r;
    end;

    function to_wide(x : signed) return wide_t is
    begin
        return resize(x, wide_t'length);
    end;

begin

    main_proc: process(clk, rst_n)
        variable k     : integer;
        variable tmp68 : signed(67 downto 0);
        variable mag32 : signed(33 downto 0);
    begin
        if rst_n = '0' then
            -- 用 <= 进行复位赋值
            st        <= IDLE;
            ram_addr  <= (others=>'0');
            ram_we    <= '0';
            ram_dout  <= (others=>'0');
            done      <= '0';
            pair_idx  <= 0;
            top_cpx   <= 0;
            bot_cpx   <= N/2;
            mag_idx   <= 0;
            a_re      <= (others=>'0');
            a_im      <= (others=>'0');
            b_re      <= (others=>'0');
            b_im      <= (others=>'0');
            w_re      <= (others=>'0');
            w_im      <= (others=>'0');
            up_re     <= (others=>'0');
            up_im     <= (others=>'0');
            dn_re     <= (others=>'0');
            dn_im     <= (others=>'0');
        elsif rising_edge(clk) then
            ram_we   <= '0';
            ram_dout <= (others=>'0');

            case st is
                when IDLE =>
                    done <= '0';
                    if start='1' then
                        pair_idx <= 0;
                        top_cpx  <= 0;
                        bot_cpx  <= N/2;
                        ram_addr <= cpx_to_addr(0,false);
                        st <= S0_RD_TOP_RE;
                    end if;

                when S0_RD_TOP_RE =>
                    a_re <= to_wide(ram_din);
                    ram_addr <= cpx_to_addr(top_cpx,true);
                    st <= S0_RD_TOP_IM;

                when S0_RD_TOP_IM =>
                    a_im <= to_wide(ram_din);
                    ram_addr <= cpx_to_addr(bot_cpx,false);
                    st <= S0_RD_BOT_RE;

                when S0_RD_BOT_RE =>
                    b_re <= to_wide(ram_din);
                    ram_addr <= cpx_to_addr(bot_cpx,true);
                    st <= S0_RD_BOT_IM;

                when S0_RD_BOT_IM =>
                    b_im <= to_wide(ram_din);
                    w_re <= TW_RE(0);
                    w_im <= TW_IM(0);
                    st <= S0_CALC;

                when S0_CALC =>
                    up_re <= resize(a_re + b_re, wide_t'length);
                    up_im <= resize(a_im + b_im, wide_t'length);
                    dn_re <= resize(a_re - b_re, wide_t'length);
                    dn_im <= resize(a_im - b_im, wide_t'length);
                    ram_addr <= cpx_to_addr(top_cpx,false);
                    ram_dout <= signed(up_re(WIDTH-1 downto 0));
                    ram_we   <= '1';
                    st <= S0_WR_TOP_RE;

                when S0_WR_TOP_RE =>
                    ram_addr <= cpx_to_addr(top_cpx,true);
                    ram_dout <= signed(up_im(WIDTH-1 downto 0));
                    ram_we   <= '1';
                    st <= S0_WR_TOP_IM;

                when S0_WR_TOP_IM =>
                    ram_addr <= cpx_to_addr(bot_cpx,false);
                    ram_dout <= signed(dn_re(WIDTH-1 downto 0));
                    ram_we   <= '1';
                    st <= S0_WR_BOT_RE;

                when S0_WR_BOT_RE =>
                    ram_addr <= cpx_to_addr(bot_cpx,true);
                    ram_dout <= signed(dn_im(WIDTH-1 downto 0));
                    ram_we   <= '1';
                    st <= S0_WR_BOT_IM;

                when S0_WR_BOT_IM =>
                    st <= S0_ADVANCE;

                when S0_ADVANCE =>
                    if pair_idx=(N/2-1) then
                        pair_idx <= 0;
                        top_cpx  <= 0;
                        bot_cpx  <= N/4;
                        ram_addr <= cpx_to_addr(0,false);
                        st <= S1_RD_TOP_RE;
                    else
                        pair_idx <= pair_idx+1;
                        top_cpx  <= pair_idx+1;
                        bot_cpx  <= top_cpx+N/2;
                        ram_addr <= cpx_to_addr(pair_idx+1,false);
                        st <= S0_RD_TOP_RE;
                    end if;

                -- Stage-1、Stage-2、MAG 省略，照原样粘过去…

                when DONE1 =>
                    done <= '1';
                    if start='0' then
                        st <= IDLE;
                    end if;

                when others =>
                    st <= IDLE;
            end case;
        end if;
    end process main_proc;

end architecture rtl;
