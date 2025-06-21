-- ====================================================================
--  File : mag_sqr_fft.vhd
--  8-point radix-2 DIT FFT + |X(k)|2  (Q1.15)
-- ====================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity mag_sqr_fft is
    generic (
        WIDTH : natural := DATA_WIDTH;  -- 16
        N     : natural := N_POINTS     -- 8
    );
    port (
        clk, rst_n : in  std_logic;
        start      : in  std_logic;     -- ????????
        done       : out std_logic;     -- ?????????????

        -- ????? RAM
        ram_addr : out addr_t;
        ram_din  : in  signed(WIDTH-1 downto 0);
        ram_dout : out signed(WIDTH-1 downto 0);
        ram_we   : out std_logic
    );
end;

-- ====================================================================
architecture rtl of mag_sqr_fft is
-- ====================================================================
    subtype wide_t is signed(WIDTH+1 downto 0);  -- 18 ��

    ----------------------------------------------------------------
    -- Twiddle ROM Q1.15
    ----------------------------------------------------------------
    type coeff_arr_t is array (0 to 3) of signed(WIDTH-1 downto 0);
    constant TW_RE : coeff_arr_t :=
        ( to_signed( 32767, WIDTH),   --  1
          to_signed( 23170, WIDTH),   --  0.7071
          to_signed(     0, WIDTH),   --  0
          to_signed(-23170, WIDTH) ); -- -0.7071
    constant TW_IM : coeff_arr_t :=
        ( to_signed(     0, WIDTH),
          to_signed(-23170, WIDTH),
          to_signed(-32768, WIDTH),
          to_signed(-23170, WIDTH) );

    --------------------------------------------------------------------
    type st_t is (
        IDLE,
        -- Stage-0
        S0_RD_TOP_RE, S0_RD_TOP_IM, S0_RD_BOT_RE, S0_RD_BOT_IM,
        S0_CALC,      S0_WR_TOP_RE, S0_WR_TOP_IM, S0_WR_BOT_RE, S0_WR_BOT_IM,
        -- Stage-1
        S1_RD_TOP_RE, S1_RD_TOP_IM, S1_RD_BOT_RE, S1_RD_BOT_IM,
        S1_CALC,      S1_BUTTERFLY, S1_WR_TOP_RE, S1_WR_TOP_IM, S1_WR_BOT_RE, S1_WR_BOT_IM,
        -- Stage-2
        S2_RD_TOP_RE, S2_RD_TOP_IM, S2_RD_BOT_RE, S2_RD_BOT_IM,
        S2_CALC,      S2_BUTTERFLY, S2_WR_TOP_RE, S2_WR_TOP_IM, S2_WR_BOT_RE, S2_WR_BOT_IM,
        -- |X|2
        MAG_RD_RE, MAG_RD_IM, MAG_CALC, MAG_WR, DONE1
    );
    signal st : st_t := IDLE;

    signal pair_idx  : integer range 0 to (N/2)-1 := 0;
    signal mag_idx   : integer range 0 to N-1     := 0;
    signal top_cpx   : integer range 0 to N-1     := 0;
    signal bot_cpx   : integer range 0 to N-1     := 0;

    signal a_re, a_im : wide_t := (others=>'0');
    signal b_re, b_im : wide_t := (others=>'0');
    signal w_re, w_im : signed(WIDTH-1 downto 0);

    signal up_re, up_im, dn_re, dn_im : wide_t;

    --------------------------------------------------------------------
    -- ???????
    --------------------------------------------------------------------
    -- ???????? ?? RAM ???
    function cpx_to_addr(idx : integer; is_im : boolean) return addr_t is
        variable a : integer := idx*2;
    begin
        if is_im then a := a + 1; end if;
        return to_unsigned(a, ADDR_WIDTH);
    end;

    -- �Ƴ���ע�͵�bit_reverse����
    -- function bit_reverse(x: natural; bits: natural) return natural is
    --     variable r : natural := 0;
    --     variable temp : natural := x;
    -- begin
    --     for i in 0 to bits-1 loop
    --         r := r * 2 + (temp mod 2);
    --         temp := temp / 2;
    --     end loop;
    --     return r;
    -- end;

    -- k ???? (???????????????)
    function tw_idx(stage : integer; pair : integer) return integer is
        variable dist   : integer := N / (2**(stage+1)); -- 4/2/1
        variable within : integer := pair mod dist;
    begin
        return within * (N / (2 * dist));  -- ????????????
    end;

    -- Q1.15 ?? Q1.15 ?? Q1.15 (??????)
    -- 改进的Q1.15乘法函数，添加饱和处理
    function mul_q15_sat(x, y : signed) return signed is
    variable x_temp : signed(WIDTH-1 downto 0) := x;
    variable y_temp : signed(WIDTH-1 downto 0) := y;
    variable product : signed(2*WIDTH-1 downto 0);
    variable result : signed(WIDTH-1 downto 0);
    begin
    product := x_temp * y_temp;
    -- 右移15位获得Q1.15结果
    result := resize(shift_right(product, 15), WIDTH);
    
    -- 饱和处理
    if product(2*WIDTH-1 downto WIDTH+14) /= (2*WIDTH-1 downto WIDTH+14 => product(2*WIDTH-1)) then
        if product(2*WIDTH-1) = '0' then
            result := to_signed(32767, WIDTH);  -- 正饱和
        else
            result := to_signed(-32768, WIDTH); -- 负饱和
        end if;
    end if;
    
    return result;
    end;
    
    -- 带饱和的加法函数
    function add_sat(x, y : wide_t) return signed is
    variable sum : wide_t;
    variable result : signed(WIDTH-1 downto 0);
    begin
    sum := x + y;
    
    -- 检查溢出并进行饱和处理
    if sum > to_signed(32767, wide_t'length) then
        result := to_signed(32767, WIDTH);
    elsif sum < to_signed(-32768, wide_t'length) then
        result := to_signed(-32768, WIDTH);
    else
        result := resize(sum, WIDTH);
    end if;
    
    return result;
    end;

    -- 带饱和的减法函数
    function sub_sat(x, y : wide_t) return signed is
    variable diff : wide_t;
    variable result : signed(WIDTH-1 downto 0);
    begin
    diff := x - y;
    
    -- 检查溢出并进行饱和处理
    if diff > to_signed(32767, wide_t'length) then
        result := to_signed(32767, WIDTH);
    elsif diff < to_signed(-32768, wide_t'length) then
        result := to_signed(-32768, WIDTH);
    else
        result := resize(diff, WIDTH);
    end if;
    
    return result;
    end;

    -- 16 ?? 18
    function to_wide(x : signed) return wide_t is
    begin
        return resize(x, wide_t'length);
    end;

begin
    -- ???????
    ram_we   <= '0';
    ram_dout <= (others=>'0');
    done     <= '0';

    --------------------------------------------------------------------
    process(clk, rst_n)
        variable mag32 : signed(33 downto 0);
        variable k     : integer;
    begin
        if rst_n = '0' then
            st       <= IDLE;
            ram_addr <= (others=>'0');
            ram_we   <= '0';
            ram_dout <= (others=>'0');
            done     <= '0';
            pair_idx <= 0; 
            mag_idx  <= 0;
            a_re     <= (others=>'0');
            a_im     <= (others=>'0');
            b_re     <= (others=>'0');
            b_im     <= (others=>'0');
            w_re     <= (others=>'0');
            w_im     <= (others=>'0');
        elsif rising_edge(clk) then
            -- Ĭ�ϲ�д��RAM
            ram_we   <= '0';
            ram_dout <= (others=>'0');
            
            case st is
            ----------------------------------------------------------------
            when IDLE =>
                done <= '0';
                if start='1' then
                    pair_idx <= 0;
                    top_cpx  <= 0;
                    bot_cpx  <= N/2;
                    ram_addr <= cpx_to_addr(0, false);
                    st <= S0_RD_TOP_RE;
                end if;

            -- =============== Stage-0 (dist 4) ============================
            when S0_RD_TOP_RE =>
                a_re <= to_wide(ram_din);
                ram_addr <= cpx_to_addr(top_cpx, true);
                st <= S0_RD_TOP_IM;

            when S0_RD_TOP_IM =>
                a_im <= to_wide(ram_din);
                ram_addr <= cpx_to_addr(bot_cpx, false);
                st <= S0_RD_BOT_RE;

            when S0_RD_BOT_RE =>
                b_re <= to_wide(ram_din);
                ram_addr <= cpx_to_addr(bot_cpx, true);
                st <= S0_RD_BOT_IM;

            when S0_RD_BOT_IM =>
                b_im <= to_wide(ram_din);
                w_re <= TW_RE(0); 
                w_im <= TW_IM(0);
                st <= S0_CALC;

            when S0_CALC =>
                up_re <= resize(a_re + b_re, wide_t'length);
                up_im <= resize(a_im + b_im, wide_t'length);
                dn_re <= resize(a_re - b_re, wide_t'length);  -- ?????????????
                dn_im <= resize(a_im - b_im, wide_t'length);  -- ?????????????

                ram_addr <= cpx_to_addr(top_cpx, false);
                ram_dout <= signed(up_re(WIDTH-1 downto 0));
                ram_we   <= '1';
                st <= S0_WR_TOP_RE;

            when S0_WR_TOP_RE =>
                ram_addr <= cpx_to_addr(top_cpx, true);
                ram_dout <= signed(up_im(WIDTH-1 downto 0));
                ram_we   <= '1';
                st <= S0_WR_TOP_IM;

            when S0_WR_TOP_IM =>
                ram_addr <= cpx_to_addr(bot_cpx, false);
                ram_dout <= signed(dn_re(WIDTH-1 downto 0));
                ram_we   <= '1';
                st <= S0_WR_BOT_RE;

            when S0_WR_BOT_RE =>
                ram_addr <= cpx_to_addr(bot_cpx, true);
                ram_dout <= signed(dn_im(WIDTH-1 downto 0));
                ram_we   <= '1';
                st <= S0_WR_BOT_IM;

            when S0_WR_BOT_IM =>
                if pair_idx = 3 then
                    pair_idx <= 0;
                    top_cpx  <= 0;
                    bot_cpx  <= N/4;               -- dist 2
                    ram_addr <= cpx_to_addr(0, false);
                    st <= S1_RD_TOP_RE;
                else
                    pair_idx <= pair_idx + 1;
                    top_cpx  <= pair_idx+1;
                    bot_cpx  <= top_cpx + N/2;
                    ram_addr <= cpx_to_addr(pair_idx+1, false);
                    st <= S0_RD_TOP_RE;
                end if;

            -- =============== Stage-1 (dist 2) ============================
            when S1_RD_TOP_RE =>
                a_re <= to_wide(ram_din);
                ram_addr <= cpx_to_addr(top_cpx, true);
                st <= S1_RD_TOP_IM;

            when S1_RD_TOP_IM =>
                a_im <= to_wide(ram_din);
                ram_addr <= cpx_to_addr(bot_cpx, false);
                st <= S1_RD_BOT_RE;

            when S1_RD_BOT_RE =>
                b_re <= to_wide(ram_din);
                ram_addr <= cpx_to_addr(bot_cpx, true);
                st <= S1_RD_BOT_IM;

            when S1_RD_BOT_IM =>
                b_im <= to_wide(ram_din);
                k    := tw_idx(1, pair_idx);  -- 0 or 2
                w_re <= TW_RE(k);
                w_im <= TW_IM(k);
                st   <= S1_CALC;

            when S1_CALC =>
                -- ���㸴���˷� b * w������洢�� up_re, up_im ����Ϊ��ʱ����
                up_re <= to_wide( mul_q15(signed(b_re(WIDTH-1 downto 0)), w_re) ) -
                         to_wide( mul_q15(signed(b_im(WIDTH-1 downto 0)), w_im) );
                up_im <= to_wide( mul_q15(signed(b_re(WIDTH-1 downto 0)), w_im) ) +
                         to_wide( mul_q15(signed(b_im(WIDTH-1 downto 0)), w_re) );
                st <= S1_BUTTERFLY;
                
            when S1_BUTTERFLY =>
                -- ���������������up_re/up_im ���ڰ��� b*w �Ľ��
                dn_re <= resize(a_re - up_re, wide_t'length);
                dn_im <= resize(a_im - up_im, wide_t'length);
                up_re <= resize(a_re + up_re, wide_t'length);
                up_im <= resize(a_im + up_im, wide_t'length);

                ram_addr <= cpx_to_addr(top_cpx, false);
                ram_dout <= signed(resize(a_re + up_re, WIDTH));
                ram_we   <= '1';
                st <= S1_WR_TOP_RE;

            when S1_WR_TOP_RE =>
                ram_addr <= cpx_to_addr(top_cpx, true);
                ram_dout <= signed(up_im(WIDTH-1 downto 0));
                ram_we   <= '1';
                st <= S1_WR_TOP_IM;

            when S1_WR_TOP_IM =>
                ram_addr <= cpx_to_addr(bot_cpx, false);
                ram_dout <= signed(dn_re(WIDTH-1 downto 0));
                ram_we   <= '1';
                st <= S1_WR_BOT_RE;

            when S1_WR_BOT_RE =>
                ram_addr <= cpx_to_addr(bot_cpx, true);
                ram_dout <= signed(dn_im(WIDTH-1 downto 0));
                ram_we   <= '1';
                st <= S1_WR_BOT_IM;

            when S1_WR_BOT_IM =>
                if pair_idx = 3 then
                    pair_idx <= 0;
                    top_cpx  <= 0;
                    bot_cpx  <= 1;          -- dist 1
                    ram_addr <= cpx_to_addr(0, false);
                    st <= S2_RD_TOP_RE;
                else
                    pair_idx <= pair_idx + 1;
                    top_cpx  <= (pair_idx+1)/2*4 + ((pair_idx+1) mod 2);
                    bot_cpx  <= top_cpx + 2;
                    ram_addr <= cpx_to_addr(top_cpx, false);
                    st <= S1_RD_TOP_RE;
                end if;

            -- =============== Stage-2 (dist 1) ============================
            when S2_RD_TOP_RE =>
                a_re <= to_wide(ram_din);
                ram_addr <= cpx_to_addr(top_cpx, true);
                st <= S2_RD_TOP_IM;

            when S2_RD_TOP_IM =>
                a_im <= to_wide(ram_din);
                ram_addr <= cpx_to_addr(bot_cpx, false);
                st <= S2_RD_BOT_RE;

            when S2_RD_BOT_RE =>
                b_re <= to_wide(ram_din);
                ram_addr <= cpx_to_addr(bot_cpx, true);
                st <= S2_RD_BOT_IM;

            when S2_RD_BOT_IM =>
                b_im <= to_wide(ram_din);
                k    := tw_idx(2, pair_idx);            -- 0-3
                w_re <= TW_RE(k); 
                w_im <= TW_IM(k);
                st   <= S2_CALC;

            when S2_CALC =>
                -- ���㸴���˷� b * w������洢�� up_re, up_im ����Ϊ��ʱ����
                up_re <= to_wide( mul_q15(signed(b_re(WIDTH-1 downto 0)), w_re) ) -
                         to_wide( mul_q15(signed(b_im(WIDTH-1 downto 0)), w_im) );
                up_im <= to_wide( mul_q15(signed(b_re(WIDTH-1 downto 0)), w_im) ) +
                         to_wide( mul_q15(signed(b_im(WIDTH-1 downto 0)), w_re) );
                st <= S2_BUTTERFLY;
                
            when S2_BUTTERFLY =>
                -- ���������������up_re/up_im ���ڰ��� b*w �Ľ��
                dn_re <= resize(a_re - up_re, wide_t'length);
                dn_im <= resize(a_im - up_im, wide_t'length);
                up_re <= resize(a_re + up_re, wide_t'length);
                up_im <= resize(a_im + up_im, wide_t'length);

                ram_addr <= cpx_to_addr(top_cpx, false);
                ram_dout <= signed(resize(a_re + up_re, WIDTH));
                ram_we   <= '1';
                st <= S2_WR_TOP_RE;

            when S2_WR_TOP_RE =>
                ram_addr <= cpx_to_addr(top_cpx, true);
                ram_dout <= signed(up_im(WIDTH-1 downto 0));
                ram_we   <= '1';
                st <= S2_WR_TOP_IM;

            when S2_WR_TOP_IM =>
                ram_addr <= cpx_to_addr(bot_cpx, false);
                ram_dout <= signed(dn_re(WIDTH-1 downto 0));
                ram_we   <= '1';
                st <= S2_WR_BOT_RE;

            when S2_WR_BOT_RE =>
                ram_addr <= cpx_to_addr(bot_cpx, true);
                ram_dout <= signed(dn_im(WIDTH-1 downto 0));
                ram_we   <= '1';
                st <= S2_WR_BOT_IM;

            when S2_WR_BOT_IM =>
                if pair_idx = 7 then
                    mag_idx <= 0;
                    ram_addr <= cpx_to_addr(0, false);
                    st <= MAG_RD_RE;
                else
                    pair_idx <= pair_idx + 1;
                    top_cpx  <= pair_idx + 1;
                    bot_cpx  <= top_cpx + 1;
                    ram_addr <= cpx_to_addr(top_cpx, false);
                    st <= S2_RD_TOP_RE;
                end if;

            -- =============== |X|2 ========================================
            when MAG_RD_RE =>
                a_re <= to_wide(ram_din);
                ram_addr <= cpx_to_addr(mag_idx, true);
                st <= MAG_RD_IM;

            when MAG_RD_IM =>
                a_im <= to_wide(ram_din);
                st <= MAG_CALC;

            when MAG_CALC =>
                mag32 := resize(a_re,34)*resize(a_re,34) +
                         resize(a_im,34)*resize(a_im,34);
                ram_dout <= signed(mag32(33 downto 18));          -- Q1.15
                -- ֱ�Ӱ�˳��������������Ҫ��λ��
                ram_addr <= cpx_to_addr(mag_idx, false);
                ram_we <= '1';
                st <= MAG_WR;

            when MAG_WR =>
                ram_we <= '0';  -- ???��??
                if mag_idx = N-1 then
                    st <= DONE1;
                else
                    mag_idx <= mag_idx + 1;
                    ram_addr <= cpx_to_addr(mag_idx+1, false);
                    st <= MAG_RD_RE;
                end if;

            when DONE1 =>
                done <= '1';
                if start='0' then 
                    st <= IDLE; 
                end if;

            end case;
        end if;
    end process;

end architecture;