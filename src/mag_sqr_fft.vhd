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
        start      : in  std_logic;     -- 输入缓存满
        done       : out std_logic;     -- 幅度平方计算完

        -- 单端口 RAM
        ram_addr : out addr_t;
        ram_din  : in  signed(WIDTH-1 downto 0);
        ram_dout : out signed(WIDTH-1 downto 0);
        ram_we   : out std_logic
    );
end;

-- ====================================================================
architecture rtl of mag_sqr_fft is
-- ====================================================================
    subtype wide_t is signed(WIDTH+1 downto 0);  -- 18 位

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
        S1_CALC,      S1_WR_TOP_RE, S1_WR_TOP_IM, S1_WR_BOT_RE, S1_WR_BOT_IM,
        -- Stage-2
        S2_RD_TOP_RE, S2_RD_TOP_IM, S2_RD_BOT_RE, S2_RD_BOT_IM,
        S2_CALC,      S2_WR_TOP_RE, S2_WR_TOP_IM, S2_WR_BOT_RE, S2_WR_BOT_IM,
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
    -- 工具函数
    --------------------------------------------------------------------
    -- 复数索引 → RAM 地址
    function cpx_to_addr(idx : integer; is_im : boolean) return addr_t is
        variable a : integer := idx*2;
    begin
        if is_im then a := a + 1; end if;
        return to_unsigned(a, ADDR_WIDTH);
    end;

    -- bit-reverse（用于倒位序）
    function bit_reverse(x, bits : natural) return natural is
        variable r : natural := 0;
    begin
        for i in 0 to bits-1 loop
            if ((x shr i) and 1) = 1 then
                r := r or (1 shl (bits-1-i));
            end if;
        end loop;
        return r;
    end;

    -- k 计算
    function tw_idx(stage : integer; pair : integer) return integer is
        variable dist   : integer := N / (2**(stage+1)); -- 4/2/1
        variable within : integer := pair mod dist;
    begin
        return within * N / (2*dist);
    end;

    -- Q1.15 × Q1.15 → Q1.15   （修正位宽报错）
    function mul_q15(x, y : signed) return signed is
        variable prod32 : signed(31 downto 0);
    begin
        prod32 := resize(x, 32) * resize(y, 32);      -- 16×16→32
        return resize(prod32(prod32'high downto 15), WIDTH); -- 右移15
    end;

    -- 16 → 18
    function to_wide(x : signed) return wide_t is
    begin
        return resize(x, wide_t'length);
    end;

begin
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
            pair_idx <= 0; mag_idx <= 0;
        elsif rising_edge(clk) then
            case st is
            ----------------------------------------------------------------
            when IDLE =>
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
                w_re <= TW_RE(0); w_im <= TW_IM(0);
                st <= S0_CALC;

            when S0_CALC =>
                up_re <= resize(a_re + b_re, wide_t'length);
                up_im <= resize(a_im + b_im, wide_t'length);
                dn_re <= resize(a_re - b_re, wide_t'length);
                dn_im <= resize(a_im - b_im, wide_t'length);

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
                w_re <= TW_RE(k); w_im <= TW_IM(k);
                st   <= S1_CALC;

            when S1_CALC =>
                dn_re <= to_wide( mul_q15(signed(b_re(WIDTH-1 downto 0)), w_re) ) -
                         to_wide( mul_q15(signed(b_im(WIDTH-1 downto 0)), w_im) );
                dn_im <= to_wide( mul_q15(signed(b_re(WIDTH-1 downto 0)), w_im) ) +
                         to_wide( mul_q15(signed(b_im(WIDTH-1 downto 0)), w_re) );
                up_re <= resize(a_re + dn_re, wide_t'length);
                up_im <= resize(a_im + dn_im, wide_t'length);
                dn_re <= resize(a_re - dn_re, wide_t'length);
                dn_im <= resize(a_im - dn_im, wide_t'length);

                ram_addr <= cpx_to_addr(top_cpx, false);
                ram_dout <= signed(up_re(WIDTH-1 downto 0));
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
                w_re <= TW_RE(k); w_im <= TW_IM(k);
                st   <= S2_CALC;

            when S2_CALC =>
                dn_re <= to_wide( mul_q15(signed(b_re(WIDTH-1 downto 0)), w_re) ) -
                         to_wide( mul_q15(signed(b_im(WIDTH-1 downto 0)), w_im) );
                dn_im <= to_wide( mul_q15(signed(b_re(WIDTH-1 downto 0)), w_im) ) +
                         to_wide( mul_q15(signed(b_im(WIDTH-1 downto 0)), w_re) );
                up_re <= resize(a_re + dn_re, wide_t'length);
                up_im <= resize(a_im + dn_im, wide_t'length);
                dn_re <= resize(a_re - dn_re, wide_t'length);
                dn_im <= resize(a_im - dn_im, wide_t'length);

                ram_addr <= cpx_to_addr(top_cpx, false);
                ram_dout <= signed(up_re(WIDTH-1 downto 0));
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
                ram_dout <= mag32(33 downto 18);          -- Q1.15
                -- ★★ 若未做倒位序可启用：
                ram_addr <= cpx_to_addr( bit_reverse(mag_idx, 3), false );
                -- ram_addr <= cpx_to_addr( mag_idx, false ); -- 若输入已倒序
                ram_we <= '1';
                st <= MAG_WR;

            when MAG_WR =>
                if mag_idx = N-1 then
                    st <= DONE1;
                else
                    mag_idx <= mag_idx + 1;
                    ram_addr <= cpx_to_addr(mag_idx+1, false);
                    st <= MAG_RD_RE;
                end if;

            when DONE1 =>
                done <= '1';
                if start='0' then st <= IDLE; end if;

            end case;
        end if;
    end process;

end architecture;
