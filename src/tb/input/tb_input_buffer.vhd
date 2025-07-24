library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity tb_input_buffer is end;
architecture sim of tb_input_buffer is
    -- 被测件接口信号
    signal clk, rst_n   : std_logic;
    signal din          : signed(DATA_WIDTH-1 downto 0);
    signal din_valid    : std_logic;
    signal din_ready    : std_logic;
    signal start_fft    : std_logic;
    signal fft_done     : std_logic := '0';
    signal ram_addr     : addr_t;
    signal ram_dout     : signed(DATA_WIDTH-1 downto 0);
    signal ram_we       : std_logic;

    -- 影子 RAM，用于检查写入
    type ram_array_t is array (0 to DEPTH-1) of signed(DATA_WIDTH-1 downto 0);
    signal shadow_ram : ram_array_t := (others => (others => '0'));

    -- 时钟周期
    constant CLK_PER : time := 20 ns;
    
    -- 添加bit_reverse函数定义
    function bit_reverse(val : natural; width : natural) return natural is
        variable result : natural := 0;
        variable temp : natural := val;
    begin
        for i in 0 to width-1 loop
            result := result * 2 + (temp mod 2);
            temp := temp / 2;
        end loop;
        return result;
    end function;
    
begin
    -- 实例化被测单元
    uut : entity work.input_buffer
        port map(
            clk      => clk,
            rst_n    => rst_n,
            din      => din,
            din_valid=> din_valid,
            din_ready=> din_ready,
            start_fft=> start_fft,
            fft_done => fft_done,
            ram_addr => ram_addr,
            ram_dout => ram_dout,
            ram_we   => ram_we
        );

    clk_gen : process
    begin
        clk <= '0'; wait for CLK_PER/2;
        clk <= '1'; wait for CLK_PER/2;
    end process;

    reset_proc : process
    begin
        rst_n <= '0'; wait for 5*CLK_PER;
        rst_n <= '1';
        wait;
    end process;
    
    driver : process
        variable sample_cnt : integer := 0;
    begin
        wait until rst_n = '1';
        wait until rising_edge(clk);

        while sample_cnt < 2*DEPTH loop  -- 连续发两帧
            if din_ready = '1' then
                din       <= to_signed(sample_cnt, DATA_WIDTH);
                din_valid <= '1';
                sample_cnt := sample_cnt + 1;
            else
                din_valid <= '0';
            end if;
            wait until rising_edge(clk);
        end loop;

        din_valid <= '0';                -- 输入结束
        wait;
    end process;
    
    fft_proc : process
    begin
        wait until start_fft = '1';          -- 侦测到启动
        wait for 10*CLK_PER;                 -- 假设 FFT 10 周期完成
        fft_done <= '1';
        wait until rising_edge(clk);
        fft_done <= '0';
        wait;                                -- 后续帧同理
    end process;
    
    -- 捕获写入
    ram_cap : process(clk)
    begin
        if rising_edge(clk) then
            if ram_we = '1' then
                shadow_ram(to_integer(ram_addr)) <= ram_dout;
            end if;
        end if;
    end process;

    -- 断言地址正确 - 使用独立的wr_ptr跟踪
    checker : process
        variable wr_ptr : integer range 0 to DEPTH-1 := 0;
        variable exp_idx : integer;
        variable exp_addr : addr_t;
    begin
        wait until rst_n = '1';
        
        while true loop
            wait until rising_edge(clk);
            
            if ram_we = '1' then
                -- 使用与设计完全相同的计算方式
                exp_idx := bit_reverse(wr_ptr/2, 3);
                if (wr_ptr mod 2) = 1 then
                    exp_addr := to_unsigned(exp_idx*2 + 1, ADDR_WIDTH);
                else
                    exp_addr := to_unsigned(exp_idx*2, ADDR_WIDTH);
                end if;
                
                assert ram_addr = exp_addr
                    report "Addr mismatch at wr_ptr=" & integer'image(wr_ptr) & 
                           ", expected=" & integer'image(to_integer(exp_addr)) &
                           ", actual=" & integer'image(to_integer(ram_addr))
                    severity error;
                    
                -- 更新wr_ptr
                if wr_ptr = DEPTH-1 then
                    wr_ptr := 0;
                else
                    wr_ptr := wr_ptr + 1;
                end if;
            end if;
        end loop;
    end process;

end architecture;

