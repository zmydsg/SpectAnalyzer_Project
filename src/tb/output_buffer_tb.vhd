
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity output_buffer_tb is
end entity;

architecture tb of output_buffer_tb is
    -- 测试参数
    constant CLK_PERIOD : time := 10 ns; -- 100MHz时钟
    constant WIDTH : natural := DATA_WIDTH;
    constant N : natural := N_POINTS;
    
    -- 被测模块信号
    signal clk       : std_logic := '0';
    signal rst_n     : std_logic := '0';
    signal start_in  : std_logic := '0';
    signal done_out  : std_logic;
    signal ram_addr  : addr_t;
    signal ram_din   : signed(WIDTH-1 downto 0);
    signal ram_we    : std_logic;
    signal dout      : signed(WIDTH-1 downto 0);
    signal dout_valid: std_logic;
    
    -- RAM模拟
    type ram_type is array(0 to 2*N-1) of signed(WIDTH-1 downto 0);
    signal test_ram : ram_type;
    
    -- 测试控制
    signal test_done : boolean := false;
begin
    -- 时钟生成
    clk <= not clk after CLK_PERIOD/2 when not test_done else '0';
    
    -- 实例化被测模块
    uut: entity work.output_buffer
        generic map(
            WIDTH => WIDTH,
            N     => N
        )
        port map(
            clk        => clk,
            rst_n      => rst_n,
            start_in   => start_in,
            done_out   => done_out,
            ram_addr   => ram_addr,
            ram_din    => ram_din,
            ram_we     => ram_we,
            dout       => dout,
            dout_valid => dout_valid
        );
    
    -- 连接RAM数据
    ram_din <= test_ram(to_integer(unsigned(ram_addr)));
    
    -- 主测试过程
    process
        -- 初始化RAM内容
        procedure init_ram is
        begin
            for i in 0 to 2*N-1 loop
                if i mod 2 = 0 then
                    test_ram(i) <= to_signed(i/2, WIDTH);
                else
                    test_ram(i) <= (others => '0');
                end if;
            end loop;
        end procedure;
        
        -- 检查输出值
        procedure check_output(expected: integer; msg: string) is
        begin
            if dout /= to_signed(expected, WIDTH) then
                report "输出错误! 期望: " & integer'image(expected) & 
                       " 实际: " & integer'image(to_integer(dout)) & 
                       " - " & msg
                severity error;
            end if;
        end procedure;
    begin
        -- 初始化
        rst_n <= '0';
        init_ram;
        wait for CLK_PERIOD * 2;
        rst_n <= '1';
        wait for CLK_PERIOD * 2;
        
        report "开始测试1: 基本功能测试";
        start_in <= '1';
        wait until rising_edge(clk);
        start_in <= '0';
        
        -- 检查状态转换和输出
        for i in 0 to N-1 loop
            -- 等待输出有效
            if dout_valid /= '1' then
                wait until dout_valid = '1';
            end if;
            
            check_output(i, "数据点" & integer'image(i));
            
            -- 检查RAM地址是否正确
            if to_integer(unsigned(ram_addr)) /= i*2 then
                report "RAM地址错误! 期望: " & integer'image(i*2) & 
                       " 实际: " & integer'image(to_integer(unsigned(ram_addr)))
                severity error;
            end if;
            
            wait for CLK_PERIOD;
        end loop;
        
        -- 检查完成信号
        if done_out /= '1' then
            wait until done_out = '1';
        end if;
        wait for CLK_PERIOD;
        if done_out /= '0' then
            report "done_out应只持续一个周期!" severity error;
        end if;
        
        report "开始测试2: 复位测试";
        start_in <= '1';
        wait until rising_edge(clk);
        start_in <= '0';
        
        -- 等待第一个输出
        wait until dout_valid = '1';
        wait for CLK_PERIOD * 2;
        rst_n <= '0';
        wait for CLK_PERIOD * 2;
        rst_n <= '1';
        
        -- 复位后应停止输出
        if dout_valid = '1' then
            report "复位后输出应停止!" severity error;
        end if;
        
        report "开始测试3: 连续帧测试";
        for frame in 1 to 3 loop
            start_in <= '1';
            wait until rising_edge(clk);
            start_in <= '0';
            
            for i in 0 to N-1 loop
                -- 等待输出有效
                if dout_valid /= '1' then
                    wait until dout_valid = '1';
                end if;
                
                check_output(i, "帧" & integer'image(frame) & " 数据点" & integer'image(i));
                wait for CLK_PERIOD;
            end loop;
            
            -- 检查完成信号
            if done_out /= '1' then
                wait until done_out = '1';
            end if;
            wait for CLK_PERIOD;
        end loop;
        
        report "开始测试4: 随机数据测试";
        -- 用随机数据填充RAM
        for i in 0 to 2*N-1 loop
            if i mod 2 = 0 then
                test_ram(i) <= to_signed(100 + i, WIDTH);
            end if;
        end loop;
        
        start_in <= '1';
        wait until rising_edge(clk);
        start_in <= '0';
        
        for i in 0 to N-1 loop
            -- 等待输出有效
            if dout_valid /= '1' then
                wait until dout_valid = '1';
            end if;
            
            check_output(100 + i*2, "随机数据点" & integer'image(i));
            wait for CLK_PERIOD;
        end loop;
        
        -- 结束测试
        report "所有测试完成!";
        test_done <= true;
        wait;
    end process;
end architecture;