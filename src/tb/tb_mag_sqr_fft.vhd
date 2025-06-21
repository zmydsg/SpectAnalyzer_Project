library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity tb_mag_sqr_fft is
end;

type vec16_t is array (0 to 15) of data_t;
constant stim : vec16_t := (
    to_signed(-32768, 16),
    to_signed(0, 16),
    to_signed(23170, 16),
    to_signed(0, 16),
    to_signed(0, 16),
    to_signed(0, 16),
    to_signed(-23170, 16),
    to_signed(0, 16),
    to_signed(-32768, 16),
    to_signed(0, 16),
    to_signed(-23170, 16),
    to_signed(0, 16),
    to_signed(0, 16),
    to_signed(0, 16),
    to_signed(23170, 16),
    to_signed(0, 16),
);

    1 => to_signed(0, 16),
    2 => to_signed(0, 16),
    3 => to_signed(0, 16),
    4 => to_signed(0, 16),
    5 => to_signed(0, 16),
    6 => to_signed(0, 16),
    7 => to_signed(0, 16),
    others => (others=>'0'));
);
constant ref_mag2 : vec16_t := (  -- 仅用下标 0..7
    0 => to_signed( ???? ,16),
    1 => ... ,
    ...
    others => (others=>'0'));



architecture sim of tb_mag_sqr_fft is
    -- DUT 端口信号
    signal clk50      : std_logic := '0';
    signal rst_n      : std_logic := '0';
    signal start_i    : std_logic := '0';
    signal done_o     : std_logic;
    signal ram_addr   : addr_t;
    signal ram_din    : data_t;
    signal ram_dout   : data_t;
    signal ram_we     : std_logic;

    -- 片内 RAM 行为模型  (16×16-bit，和 DUT 共用信号)
    type ram_t is array (0 to DEPTH-1) of data_t;
    signal ram : ram_t := (others => (others => '0'));
begin
    ----------------------------------------------------------------
    -- 时钟 50 MHz
    clk50 <= not clk50 after 10 ns;
    -- 复位 100 ns
    rst_n <= '0', '1' after 100 ns;
    ----------------------------------------------------------------
    -- RAM 行为：写后读
    process(clk50)
    begin
        if rising_edge(clk50) then
            if ram_we='1' then
                ram(to_integer(ram_addr)) <= ram_dout;
            end if;
            ram_din <= ram(to_integer(ram_addr));
        end if;
    end process;

    ----------------------------------------------------------------
    -- DUT 实例
    uut: entity work.mag_sqr_fft
        port map (
            clk      => clk50,
            rst_n    => rst_n,
            start    => start_i,
            done     => done_o,
            ram_addr => ram_addr,
            ram_din  => ram_din,
            ram_dout => ram_dout,
            ram_we   => ram_we);

    ----------------------------------------------------------------
    -- **Stimulus 主流程**  (见 B-E 再填具体内容)
	 stim_process : process
		begin
			 -- 1. 等待复位完成
			 wait until rst_n = '1';

			 -- 2. 把 16 个样本写入 DUT 所在 RAM
			 for i in 0 to 15 loop
				  ram(to_integer(unsigned'(i))) <= stim(i);  -- 直接写 RAM 模型
			 end loop;

			 wait for 20 ns;           -- 给一拍读稳定
			 -- 3. 拉高 start
			 start_i <= '1';
			 wait until rising_edge(clk50);
			 start_i <= '0';

			 -- 4. 等待 done
			 wait until done_o = '1';
			 wait until rising_edge(clk50);   -- 再等一拍

			 -- 5. 依次读回 8 个幅度平方并比较
			 for k in 0 to 7 loop
				  ram_addr <= addr_t(unsigned'(k & b"0"));   -- k*2
				  wait until rising_edge(clk50);
				  assert ram_din = ref_mag2(k)
						report "Mismatch at bin" & integer'image(k)
						severity error;
			 end loop;

			 report "Unit-test PASSED" severity note;
			 wait;  -- 停仿
		end process;

end architecture;
