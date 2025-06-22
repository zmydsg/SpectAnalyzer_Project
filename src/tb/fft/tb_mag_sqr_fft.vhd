type mem_t is array (0 to (N_POINTS*2)-1) of signed(DATA_WIDTH-1 downto 0);
shared variable mem : mem_t := (others => (others => '0'));

procedure ram_access (
        signal clk  : in  std_logic;
        signal we   : in  std_logic;
        signal addr : in  addr_t;
        signal din  : in  signed;
        signal dout : out signed) is
    variable a : integer := to_integer(addr);
begin
    if rising_edge(clk) then
        if we='1' then mem(a) := din; end if;
        dout <= mem(a);
    end if;
end;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity tb_mag_sqr_fft is end;
architecture sim of tb_mag_sqr_fft is

    -- DUT 端口信号
    signal clk   : std_logic := '0';
    signal rst_n : std_logic := '0';
    signal start : std_logic := '0';
    signal done  : std_logic;

    signal addr  : addr_t;
    signal din   : signed(DATA_WIDTH-1 downto 0);
    signal dout  : signed(DATA_WIDTH-1 downto 0);
    signal we    : std_logic;

    constant CLKPER : time := 10 ns;

begin
    clk <= not clk after CLKPER/2;

    ------------------------------------------------------------------
    dut: entity work.mag_sqr_fft
        port map (clk,rst_n,start,done,addr,din,dout,we);

    ------------------------------------------------------------------
    -- RAM 行为过程
    ram_p: process(clk) is
    begin
        ram_access(clk,we,addr,dout,din);  -- 读/写
    end process;

    ------------------------------------------------------------------
    -- 测试流程控制
    stim: process
        procedure load_vector(file_name : string) is
            file f        : binary open read_mode is file_name;
            variable buf  : signed(15 downto 0);
            variable idx  : integer := 0;
        begin
            while not endfile(f) loop
                read(f, buf);
                mem(idx) := buf;      -- 直接写 shared var
                idx      := idx + 1;
            end loop;
            file_close(f);
        end;

        procedure compare_result(file_name : string) is
            file f        : binary open read_mode is file_name;
            variable buf  : signed(15 downto 0);
            variable idx  : integer := 0;
        begin
            while not endfile(f) loop
                read(f, buf);
                assert mem(idx*2) = buf        -- 只比 Re 地址
                    report "Mismatch @ " & integer'image(idx)
                    severity error;
                idx := idx + 1;
            end loop;
            file_close(f);
        end;

    begin
        wait for 1*CLKPER;
        rst_n <= '1';

        -- === 三组向量循环 ===
        for vec in 0 to 2 loop
            case vec is               -- 文件名切换
                when 0 => load_vector("../../stim/impulse_in.bin");
                when 1 => load_vector("../../stim/tone1_in.bin");
                when others => load_vector("../../stim/random_in.bin");
            end case;

            start <= '1'; wait until rising_edge(clk);
            start <= '0';

            wait until done='1';
            wait until rising_edge(clk);  -- 给 DONE1 状态一个周期

            -- 结果比对
            case vec is
                when 0 => compare_result("../../stim/impulse_gold.bin");
                when 1 => compare_result("../../stim/tone1_gold.bin");
                when others => compare_result("../../stim/random_gold.bin");
            end case;

            report "Vector " & integer'image(vec) & " PASS";
        end loop;

        report "All tests passed!" severity note;
        wait;
    end process;
end;
