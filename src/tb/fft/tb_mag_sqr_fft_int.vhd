library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity tb_mag_sqr_fft_int is
end entity;

architecture tb of tb_mag_sqr_fft_int is
    constant WIDTH : natural := 16;
    constant DEPTH : natural := 16;

    subtype word_t is signed(WIDTH-1 downto 0);
    type ram_t is array(0 to DEPTH-1) of word_t;

    signal clk       : std_logic := '0';
    signal rst_n     : std_logic := '0';
    signal start     : std_logic := '0';
    signal done      : std_logic;
    signal ram_addr  : addr_t;
    signal ram_din   : word_t;
    signal ram_dout  : word_t;
    signal ram_we    : std_logic;

    signal RAM : ram_t := (
        -- 偶地址为实部样本，奇地址为 0（虚部）
         0 => to_signed(32767/8*1, WIDTH),  1 => (others=>'0'),
         2 => to_signed(32767/8*2, WIDTH),  3 => (others=>'0'),
         4 => to_signed(32767/8*3, WIDTH),  5 => (others=>'0'),
         6 => to_signed(32767/8*4, WIDTH),  7 => (others=>'0'),
         8 => to_signed(32767/8*5, WIDTH),  9 => (others=>'0'),
        10 => to_signed(32767/8*6, WIDTH), 11 => (others=>'0'),
        12 => to_signed(32767/8*7, WIDTH), 13 => (others=>'0'),
        14 => to_signed(32767,     WIDTH), 15 => (others=>'0')
    );
begin

    -- 时钟 100MHz
    clk <= not clk after 5 ns;

    -- DUT 实例
    uut: entity work.mag_sqr_fft
        generic map ( WIDTH => WIDTH, N => 8 )
        port map (
            clk      => clk,
            rst_n    => rst_n,
            start    => start,
            done     => done,
            ram_addr => ram_addr,
            ram_din  => ram_din,
            ram_dout => ram_dout,
            ram_we   => ram_we
        );

    -- 行为 RAM：read-first
    ram_din <= RAM(to_integer(ram_addr));
    process(clk)
    begin
        if rising_edge(clk) then
            if ram_we='1' then
                RAM(to_integer(ram_addr)) <= ram_dout;
            end if;
        end if;
    end process;

    -- 复位+启动
    stim: process
    begin
        rst_n <= '0'; wait for 30 ns;
        rst_n <= '1'; wait for 20 ns;
        start <= '1'; wait for 10 ns;
        start <= '0';
        wait until done='1';
        report ">>>> SIMULATION COMPLETE <<<<" severity note;
        wait;
    end process;

end architecture tb;
