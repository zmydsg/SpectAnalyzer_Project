library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity mag_sqr_fft_dp is
    generic (
        WIDTH : natural := DATA_WIDTH;
        N     : natural := N_POINTS
    );
    port (
        clk      : in  std_logic;
        rst_n    : in  std_logic;
        start    : in  std_logic;
        done     : out std_logic;
        
        -- 双端口RAM接口
        ram_addr_a : out addr_t;
        ram_din_a  : in  signed(WIDTH-1 downto 0);
        ram_dout_a : out signed(WIDTH-1 downto 0);
        ram_we_a   : out std_logic;
        
        ram_addr_b : out addr_t;
        ram_din_b  : in  signed(WIDTH-1 downto 0);
        ram_dout_b : out signed(WIDTH-1 downto 0);
        ram_we_b   : out std_logic
    );
end mag_sqr_fft_dp;

architecture rtl of mag_sqr_fft_dp is

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

    -- 保持原有状态机，但优化读写操作
    type st_t is (
        IDLE,
        S0_RD_PAIR, S0_CALC, S0_WR_PAIR, S0_ADVANCE,
        S1_RD_PAIR, S1_CALC, S1_BUTTERFLY, S1_WR_PAIR,
        S2_RD_PAIR, S2_CALC, S2_BUTTERFLY, S2_WR_PAIR,
        MAG_RD_PAIR, MAG_CALC, MAG_WR, DONE1
    );
    signal st : st_t;

    signal pair_idx : integer range 0 to (N/2)-1;
    signal top_cpx, bot_cpx : integer range 0 to N-1;
    signal mag_idx : integer range 0 to N-1;

    signal a_re, a_im, b_re, b_im : wide_t;
    signal w_re, w_im              : signed(WIDTH-1 downto 0);
    signal up_re, up_im, dn_re, dn_im : wide_t;
    
    signal read_phase : integer range 0 to 1; -- 0=实部, 1=虚部
    signal write_phase : integer range 0 to 1;

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
        variable k     : integer range 0 to 3;
        variable tmp32 : signed(31 downto 0);
        variable mag32 : signed(31 downto 0);
    begin
        if rst_n = '0' then
            st        <= IDLE;
            ram_addr_a  <= (others=>'0');
            ram_addr_b  <= (others=>'0');
            ram_we_a    <= '0';
            ram_we_b    <= '0';
            ram_dout_a  <= (others=>'0');
            ram_dout_b  <= (others=>'0');
            done      <= '0';
            pair_idx  <= 0;
            top_cpx   <= 0;
            bot_cpx   <= N/2;
            mag_idx   <= 0;
            read_phase <= 0;
            write_phase <= 0;
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
            ram_we_a   <= '0';
            ram_we_b   <= '0';
            ram_dout_a <= (others=>'0');
            ram_dout_b <= (others=>'0');

            case st is
                when IDLE =>
                    done <= '0';
                    if start='1' then
                        pair_idx <= 0;
                        top_cpx  <= 0;
                        bot_cpx  <= N/2;
                        read_phase <= 0;
                        -- 并行读取top和bot的实部
                        ram_addr_a <= cpx_to_addr(0,false);
                        ram_addr_b <= cpx_to_addr(N/2,false);
                        st <= S0_RD_PAIR;
                    end if;

                -- Stage 0: 优化读取操作
                when S0_RD_PAIR =>
                    if read_phase = 0 then
                        -- 读取实部
                        a_re <= to_wide(ram_din_a);
                        b_re <= to_wide(ram_din_b);
                        -- 准备读取虚部
                        ram_addr_a <= cpx_to_addr(top_cpx,true);
                        ram_addr_b <= cpx_to_addr(bot_cpx,true);
                        read_phase <= 1;
                    else
                        -- 读取虚部
                        a_im <= to_wide(ram_din_a);
                        b_im <= to_wide(ram_din_b);
                        w_re <= TW_RE(0);
                        w_im <= TW_IM(0);
                        read_phase <= 0;
                        st <= S0_CALC;
                    end if;

                when S0_CALC =>
                    up_re <= resize(a_re + b_re, wide_t'length);
                    up_im <= resize(a_im + b_im, wide_t'length);
                    dn_re <= resize(a_re - b_re, wide_t'length);
                    dn_im <= resize(a_im - b_im, wide_t'length);
                    write_phase <= 0;
                    st <= S0_WR_PAIR;

                when S0_WR_PAIR =>
                    if write_phase = 0 then
                        -- 并行写入实部
                        ram_addr_a <= cpx_to_addr(top_cpx,false);
                        ram_addr_b <= cpx_to_addr(bot_cpx,false);
                        ram_dout_a <= signed(up_re(WIDTH-1 downto 0));
                        ram_dout_b <= signed(dn_re(WIDTH-1 downto 0));
                        ram_we_a   <= '1';
                        ram_we_b   <= '1';
                        write_phase <= 1;
                    else
                        -- 并行写入虚部
                        ram_addr_a <= cpx_to_addr(top_cpx,true);
                        ram_addr_b <= cpx_to_addr(bot_cpx,true);
                        ram_dout_a <= signed(up_im(WIDTH-1 downto 0));
                        ram_dout_b <= signed(dn_im(WIDTH-1 downto 0));
                        ram_we_a   <= '1';
                        ram_we_b   <= '1';
                        write_phase <= 0;
                        st <= S0_ADVANCE;
                    end if;

                when S0_ADVANCE =>
                    if pair_idx=(N/2-1) then
                        pair_idx <= 0;
                        top_cpx  <= 0;
                        bot_cpx  <= N/4;
                        ram_addr_a <= cpx_to_addr(0,false);
                        ram_addr_b <= cpx_to_addr(N/4,false);
                        st <= S1_RD_PAIR;
                    else
                        pair_idx <= pair_idx+1;
                        top_cpx  <= pair_idx+1;
                        bot_cpx  <= top_cpx+N/2;
                        ram_addr_a <= cpx_to_addr(pair_idx+1,false);
                        ram_addr_b <= cpx_to_addr(top_cpx+N/2,false);
                        st <= S0_RD_PAIR;
                    end if;

                -- Stage 1: 类似优化
                when S1_RD_PAIR =>
                    if read_phase = 0 then
                        a_re <= to_wide(ram_din_a);
                        b_re <= to_wide(ram_din_b);
                        ram_addr_a <= cpx_to_addr(top_cpx,true);
                        ram_addr_b <= cpx_to_addr(bot_cpx,true);
                        read_phase <= 1;
                    else
                        a_im <= to_wide(ram_din_a);
                        b_im <= to_wide(ram_din_b);
                        k := pair_idx mod 2;
                        w_re <= TW_RE(k);
                        w_im <= TW_IM(k);
                        read_phase <= 0;
                        st <= S1_CALC;
                    end if;

                when S1_CALC =>
                    -- 复数乘法
                    up_re <= resize(to_wide(mul_q15_sat(signed(b_re(WIDTH-1 downto 0)), w_re)) - 
                                   to_wide(mul_q15_sat(signed(b_im(WIDTH-1 downto 0)), w_im)), wide_t'length);
                    up_im <= resize(to_wide(mul_q15_sat(signed(b_re(WIDTH-1 downto 0)), w_im)) + 
                                   to_wide(mul_q15_sat(signed(b_im(WIDTH-1 downto 0)), w_re)), wide_t'length);
                    st <= S1_BUTTERFLY;

                when S1_BUTTERFLY =>
                    dn_re <= resize(a_re + up_re, wide_t'length);
                    dn_im <= resize(a_im + up_im, wide_t'length);
                    up_re <= resize(a_re - up_re, wide_t'length);
                    up_im <= resize(a_im - up_im, wide_t'length);
                    write_phase <= 0;
                    st <= S1_WR_PAIR;

                when S1_WR_PAIR =>
                    if write_phase = 0 then
                        ram_addr_a <= cpx_to_addr(top_cpx,false);
                        ram_addr_b <= cpx_to_addr(bot_cpx,false);
                        ram_dout_a <= signed(dn_re(WIDTH-1 downto 0));
                        ram_dout_b <= signed(up_re(WIDTH-1 downto 0));
                        ram_we_a   <= '1';
                        ram_we_b   <= '1';
                        write_phase <= 1;
                    else
                        ram_addr_a <= cpx_to_addr(top_cpx,true);
                        ram_addr_b <= cpx_to_addr(bot_cpx,true);
                        ram_dout_a <= signed(dn_im(WIDTH-1 downto 0));
                        ram_dout_b <= signed(up_im(WIDTH-1 downto 0));
                        ram_we_a   <= '1';
                        ram_we_b   <= '1';
                        write_phase <= 0;
                        
                        if pair_idx=(N/4-1) then
                            pair_idx <= 0;
                            top_cpx  <= 0;
                            bot_cpx  <= N/8;
                            ram_addr_a <= cpx_to_addr(0,false);
                            ram_addr_b <= cpx_to_addr(N/8,false);
                            st <= S2_RD_PAIR;
                        else
                            pair_idx <= pair_idx+1;
                            top_cpx  <= top_cpx+2;
                            bot_cpx  <= bot_cpx+2;
                            ram_addr_a <= cpx_to_addr(top_cpx+2,false);
                            ram_addr_b <= cpx_to_addr(bot_cpx+2,false);
                            st <= S1_RD_PAIR;
                        end if;
                    end if;

                -- Stage 2: 类似实现
                when S2_RD_PAIR =>
                    if read_phase = 0 then
                        a_re <= to_wide(ram_din_a);
                        b_re <= to_wide(ram_din_b);
                        ram_addr_a <= cpx_to_addr(top_cpx,true);
                        ram_addr_b <= cpx_to_addr(bot_cpx,true);
                        read_phase <= 1;
                    else
                        a_im <= to_wide(ram_din_a);
                        b_im <= to_wide(ram_din_b);
                        k := pair_idx mod 4;
                        w_re <= TW_RE(k);
                        w_im <= TW_IM(k);
                        read_phase <= 0;
                        st <= S2_CALC;
                    end if;

                when S2_CALC =>
                    up_re <= resize(to_wide(mul_q15_sat(signed(b_re(WIDTH-1 downto 0)), w_re)) - 
                                   to_wide(mul_q15_sat(signed(b_im(WIDTH-1 downto 0)), w_im)), wide_t'length);
                    up_im <= resize(to_wide(mul_q15_sat(signed(b_re(WIDTH-1 downto 0)), w_im)) + 
                                   to_wide(mul_q15_sat(signed(b_im(WIDTH-1 downto 0)), w_re)), wide_t'length);
                    st <= S2_BUTTERFLY;

                when S2_BUTTERFLY =>
                    dn_re <= resize(a_re + up_re, wide_t'length);
                    dn_im <= resize(a_im + up_im, wide_t'length);
                    up_re <= resize(a_re - up_re, wide_t'length);
                    up_im <= resize(a_im - up_im, wide_t'length);
                    write_phase <= 0;
                    st <= S2_WR_PAIR;

                when S2_WR_PAIR =>
                    if write_phase = 0 then
                        ram_addr_a <= cpx_to_addr(top_cpx,false);
                        ram_addr_b <= cpx_to_addr(bot_cpx,false);
                        ram_dout_a <= signed(dn_re(WIDTH-1 downto 0));
                        ram_dout_b <= signed(up_re(WIDTH-1 downto 0));
                        ram_we_a   <= '1';
                        ram_we_b   <= '1';
                        write_phase <= 1;
                    else
                        ram_addr_a <= cpx_to_addr(top_cpx,true);
                        ram_addr_b <= cpx_to_addr(bot_cpx,true);
                        ram_dout_a <= signed(dn_im(WIDTH-1 downto 0));
                        ram_dout_b <= signed(up_im(WIDTH-1 downto 0));
                        ram_we_a   <= '1';
                        ram_we_b   <= '1';
                        write_phase <= 0;
                        
                        if pair_idx=(N/8-1) then
                            mag_idx <= 0;
                            ram_addr_a <= cpx_to_addr(0,false);
                            ram_addr_b <= cpx_to_addr(0,true);
                            st <= MAG_RD_PAIR;
                        else
                            pair_idx <= pair_idx+1;
                            top_cpx  <= top_cpx+4;
                            bot_cpx  <= bot_cpx+4;
                            ram_addr_a <= cpx_to_addr(top_cpx+4,false);
                            ram_addr_b <= cpx_to_addr(bot_cpx+4,false);
                            st <= S2_RD_PAIR;
                        end if;
                    end if;

                -- 幅度平方计算：并行读取实部和虚部
                when MAG_RD_PAIR =>
                    a_re <= to_wide(ram_din_a);
                    a_im <= to_wide(ram_din_b);
                    st <= MAG_CALC;

                when MAG_CALC =>
                    tmp32 := signed(a_re(WIDTH-1 downto 0)) * signed(a_re(WIDTH-1 downto 0)) + 
                             signed(a_im(WIDTH-1 downto 0)) * signed(a_im(WIDTH-1 downto 0));
                    mag32 := tmp32;
                    ram_addr_a <= cpx_to_addr(mag_idx,false);
                    ram_dout_a <= signed(mag32(WIDTH-1 downto 0));
                    ram_we_a   <= '1';
                    st <= MAG_WR;

                when MAG_WR =>
                    if mag_idx=(N-1) then
                        st <= DONE1;
                    else
                        mag_idx <= mag_idx+1;
                        ram_addr_a <= cpx_to_addr(mag_idx+1,false);
                        ram_addr_b <= cpx_to_addr(mag_idx+1,true);
                        st <= MAG_RD_PAIR;
                    end if;

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