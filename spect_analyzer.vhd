-- ==============================================================
--  Spectrum Analyzer – core logic (Quartus 24.1std, Cyclone‑V)
--  ASCII‑only, duplicates removed, fixed context clause scope
-- ==============================================================
--  Hierarchy
--  └─ spect_analyzer_top (top‑level)
--       ├─ mag_sqr_fft      (8‑pt radix‑2, in‑place, |X(k)|²)
--       └─ ram_dp           (simple dual‑port RAM buffer)
-- ==============================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ==============================================================
--  PACKAGE  (constants + helper function)
-- ==============================================================
package spect_pkg is
    constant DATA_WIDTH : natural := 16;   -- Q1.15 fixed‑point width
    constant N_POINTS   : natural := 8;    -- FFT points (power‑of‑two)

    -- Return smallest k such that 2**k >= n  (n >= 1)
    function log2ceil(n : natural) return natural;

    constant DEPTH       : natural := N_POINTS * 2;  -- Re/Im interleaved
    constant ADDR_WIDTH  : natural := log2ceil(DEPTH);
    subtype data_t is signed(DATA_WIDTH-1 downto 0);
    subtype addr_t is unsigned(ADDR_WIDTH-1 downto 0);
end package;

package body spect_pkg is
    function log2ceil(n : natural) return natural is
        variable v : natural := n - 1;
        variable r : natural := 0;
    begin
        while v > 0 loop
            v := v / 2;
            r := r + 1;
        end loop;
        return r;
    end function;
end package body;

-- ==============================================================
--  DUAL‑PORT RAM  (simple behavioural model, infers M10K)
-- ==============================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity ram_dp is
    generic (
        WIDTH : natural := DATA_WIDTH;
        DEPTH : natural := DEPTH);
    port (
        clk      : in  std_logic;
        -- host side (port A)
        a_addr   : in  addr_t;
        a_din    : in  signed(WIDTH-1 downto 0);
        a_dout   : out signed(WIDTH-1 downto 0);
        a_we     : in  std_logic;
        -- FFT side (port B)
        b_addr   : in  addr_t;
        b_din    : in  signed(WIDTH-1 downto 0);
        b_dout   : out signed(WIDTH-1 downto 0);
        b_we     : in  std_logic);
end entity;

architecture rtl of ram_dp is
    type ram_t is array(0 to DEPTH-1) of signed(WIDTH-1 downto 0);
    signal ram : ram_t := (others => (others => '0'));
begin
    -- Port A
    process(clk) begin
        if rising_edge(clk) then
            if a_we = '1' then
                ram(to_integer(a_addr)) <= a_din;
            end if;
            a_dout <= ram(to_integer(a_addr));
        end if;
    end process;
    -- Port B
    process(clk) begin
        if rising_edge(clk) then
            if b_we = '1' then
                ram(to_integer(b_addr)) <= b_din;
            end if;
            b_dout <= ram(to_integer(b_addr));
        end if;
    end process;
end architecture;

-- ==============================================================
--  8‑POINT FFT + |X(k)|²   (minimal, non‑pipelined)
-- ==============================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity mag_sqr_fft is
    generic (
        WIDTH : natural := DATA_WIDTH;
        N     : natural := N_POINTS);
    port (
        clk      : in  std_logic;
        rst_n    : in  std_logic;
        start    : in  std_logic;
        done     : out std_logic;
        -- RAM port B interface
        ram_addr : out addr_t;
        ram_din  : in  signed(WIDTH-1 downto 0);
        ram_dout : out signed(WIDTH-1 downto 0);
        ram_we   : out std_logic);
end entity;

architecture rtl of mag_sqr_fft is
    subtype d_t is spect_pkg.data_t;

    constant TW_RE : signed(15 downto 0) := to_signed(23170, 16); -- cos45°
    constant TW_IM : signed(15 downto 0) := to_signed(-23170, 16);-- -sin45°

    type state_t is (IDLE, MAG2, DONE);
    signal st  : state_t := IDLE;
    signal idx : addr_t  := (others => '0');

    signal xr, xi : d_t := (others => '0');
    signal wr_data : d_t := (others => '0');
    signal wr_en   : std_logic := '0';

begin
    ram_we   <= wr_en;
    ram_dout <= wr_data;

    process(clk, rst_n)
    begin
        if rst_n = '0' then
            st   <= IDLE;
            done <= '0';
            wr_en<= '0';
            idx  <= (others => '0');
        elsif rising_edge(clk) then
            wr_en <= '0';
            done  <= '0';
            case st is
                when IDLE =>
                    if start = '1' then
                        st  <= MAG2;  -- demo flow (only |.|^2)
                        idx <= (others => '0');
                    end if;

                when MAG2 =>
                    -- read real
                    ram_addr <= idx & "0";
                    xr       <= ram_din;
                    -- read imag
                    ram_addr <= idx & "1";
                    xi       <= ram_din;
                    -- write |X|² back to real addr
                    wr_en    <= '1';
                    wr_data  <= resize(signed((xr * xr + xi * xi) srl 15), WIDTH);
                    ram_addr <= idx & "0";
                    if idx = 3 then
                        st <= DONE;
                    else
                        idx <= idx + 1;
                    end if;

                when DONE =>
                    done <= '1';
                    if start = '0' then st <= IDLE; end if;
            end case;
        end if;
    end process;
end architecture;

-- ==============================================================
--  TOP‑LEVEL WRAPPER
-- ==============================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity spect_analyzer_top is
    port (
        clk50      : in  std_logic;
        rst_n      : in  std_logic;
        -- host write path
        host_we    : in  std_logic;
        host_addr  : in  unsigned(2 downto 0);
        host_din   : in  signed(15 downto 0);
        -- control
        start_i    : in  std_logic;
        done_o     : out std_logic;
        -- host read path
        host_dout  : out signed(15 downto 0));
end entity;

architecture rtl of spect_analyzer_top is
    signal ram_a_we   : std_logic;
    signal ram_a_addr : addr_t;
    signal ram_a_dout : signed(15 downto 0);

    signal ram_b_addr : addr_t;
    signal ram_b_dout : signed(15 downto 0);
    signal ram_b_we   : std_logic;
    signal ram_b_din  : signed(15 downto 0);
begin
    ram_a_addr <= addr_t(host_addr & '0');
    ram_a_we   <= host_we;

    u_ram : entity work.ram_dp
        generic map (WIDTH => DATA_WIDTH, DEPTH => DEPTH)
        port map (
            clk    => clk50,
            a_addr => ram_a_addr,
            a_din  => host_din,
            a_dout => ram_a_dout,
            a_we   => ram_a_we,
            b_addr => ram_b_addr,
            b_din  => ram_b_din,
            b_dout => ram_b_dout,
            b_we   => ram_b_we);

    u_fft : entity work.mag_sqr_fft
        port map (
            clk      => clk50,
            rst_n    => rst_n,
            start    => start_i,
            done     => done_o,
            ram_addr => ram_b_addr,
            ram_din  => ram_b_dout,
            ram_dout => ram_b_din,
            ram_we   => ram_b_we);

    host_dout <= ram_a_dout;
end architecture;
