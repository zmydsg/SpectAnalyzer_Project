LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all; -- 用于随机数生成

ENTITY output_buffer_vhd_tst IS
END output_buffer_vhd_tst;

ARCHITECTURE output_buffer_arch OF output_buffer_vhd_tst IS
    -- 常量定义
    constant CLK_PERIOD : time := 10 ns; -- 100MHz 时钟
    constant N_POINTS   : natural := 8;  -- FFT 点数
    constant DATA_WIDTH : natural := 16; -- 数据宽度
    
    -- 信号声明
    SIGNAL clk       : STD_LOGIC := '0';
    SIGNAL done_out  : STD_LOGIC;
    SIGNAL dout      : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL dout_valid: STD_LOGIC;
    SIGNAL ram_addr  : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL ram_din   : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL ram_we    : STD_LOGIC;
    SIGNAL rst_n     : STD_LOGIC := '0';
    SIGNAL start_in  : STD_LOGIC := '0';
    
    -- 测试控制信号
    signal test_done : boolean := false;
    
    -- RAM 模型
    type ram_type is array(0 to 2*N_POINTS-1) of std_logic_vector(15 downto 0);
    signal test_ram : ram_type;
    
    -- 组件声明
    COMPONENT output_buffer
        PORT (
            clk       : IN STD_LOGIC;
            done_out  : OUT STD_LOGIC;
            dout      : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            dout_valid: OUT STD_LOGIC;
            ram_addr  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            ram_din   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            ram_we    : OUT STD_LOGIC;
            rst_n     : IN STD_LOGIC;
            start_in  : IN STD_LOGIC
        );
    END COMPONENT;
BEGIN
    -- 时钟生成
    clk <= not clk after CLK_PERIOD/2 when not test_done else '0';
    
    -- RAM 数据连接
    ram_din <= test_ram(to_integer(unsigned(ram_addr)));
    
    -- 实例化被测模块
    uut: output_buffer
        PORT MAP (
            clk        => clk,
            done_out   => done_out,
            dout       => dout,
            dout_valid => dout_valid,
            ram_addr   => ram_addr,
            ram_din    => ram_din,
            ram_we     => ram_we,
            rst_n      => rst_n,
            start_in   => start_in
        );
    
    -- 主测试过程
    stimulus: PROCESS
        -- 初始化 RAM 内容
        procedure init_ram is
        begin
            for i in 0 to 2*N_POINTS-1 loop
                if i mod 2 = 0 then
                    test_ram(i) <= std_logic_vector(to_unsigned(i/2, 16));
                else
                    test_ram(i) := (others => '0');
                end if;
            end loop;
        end procedure;
        
        -- 等待 N 个时钟周期
        procedure wait_cycles(n: natural) is
        begin
            for i in 1 to n loop
                wait until rising_edge(clk);
            end loop;
        end procedure;
        
        -- 检查输出值
        procedure check_output(expected: integer; msg: string) is
        begin
            if unsigned(dout) /= to_unsigned(expected, 16) then
                report "输出错误! 期望: " & integer'image(expected) & 
                       " 实际: " & integer'image(to_integer(unsigned(dout))) & 
                       " - " & msg
                severity error;
            end if;
        end procedure;
        
        -- 运行单个测试帧
        procedure run_test_frame(frame_num: integer) is
        begin
            report "开始测试帧: " & integer'image(frame_num);
            start_in <= '1';
            wait_cycles(1);
            start_in <= '0';
            
            for i in 0 to N_POINTS-1 loop
                -- 等待输出有效
                wait until dout_valid = '1';
                check_output(i, "帧" & integer'image(frame_num) & " 数据点" & integer'image(i));
                
                -- 检查 RAM 地址
                if to_integer(unsigned(ram_addr)) /= i*2 then
                    report "RAM地址错误! 期望: " & integer'image(i*2) & 
                           " 实际: " & integer'image(to_integer(unsigned(ram_addr)))
                    severity error;
                end if;
                
                wait_cycles(1);
            end loop;
            
            -- 检查完成信号
            if done_out /= '1' then
                wait until done_out = '1';
            end if;
            wait_cycles(1);
            if done_out /= '0' then
                report "done_out应只持续一个周期!" severity error;
            end if;
            
            report "测试帧 " & integer'image(frame_num) & " 完成";
        end procedure;
        
        -- 随机数据测试
        procedure run_random_test is
            variable seed1, seed2: positive;
            variable rand_val: real;
            variable int_val: integer;
        begin
            report "开始随机数据测试";
            
            -- 用随机数据填充 RAM
            seed1 := 12345;
            seed2 := 67890;
            for i in 0 to 2*N_POINTS-1 loop
                if i mod 2 = 0 then
                    uniform(seed1, seed2, rand_val);
                    int_val := integer(rand_val * 1000.0);
                    test_ram(i) := std_logic_vector(to_unsigned(int_val, 16));
                end if;
            end loop;
            
            start_in <= '1';
            wait_cycles(1);
            start_in <= '0';
            
            for i in 0 to N_POINTS-1 loop
                wait until dout_valid = '1';
                
                -- 检查输出是否匹配 RAM 内容
                if unsigned(dout) /= unsigned(test_ram(i*2)) then
                    report "随机数据不匹配! 地址: " & integer'image(i*2) & 
                           " 期望: " & integer'image(to_integer(unsigned(test_ram(i*2)))) & 
                           " 实际: " & integer'image(to_integer(unsigned(dout)))
                    severity error;
                end if;
                
                wait_cycles(1);
            end loop;
            
            report "随机数据测试完成";
        end procedure;
        
    BEGIN
        -- 初始化 RAM
        init_ram;
        
        -- 复位系统
        report "应用复位...";
        rst_n <= '0';
        wait_cycles(2);
        rst_n <= '1';
        wait_cycles(2);
        
        -- 测试 1: 基本功能
        run_test_frame(1);
        wait_cycles(5);
        
        -- 测试 2: 连续帧
        report "开始连续帧测试";
        for i in 2 to 4 loop
            run_test_frame(i);
            wait_cycles(2);
        end loop;
        
        -- 测试 3: 复位测试
        report "开始复位测试";
        start_in <= '1';
        wait_cycles(1);
        start_in <= '0';
        
        -- 等待第一个输出
        wait until dout_valid = '1';
        wait_cycles(1);
        
        -- 在输出过程中复位
        rst_n <= '0';
        wait_cycles(2);
        rst_n <= '1';
        wait_cycles(2);
        
        -- 复位后应停止输出
        if dout_valid = '1' then
            report "错误: 复位后输出未停止!" severity error;
        end if;
        
        -- 测试 4: 随机数据
        run_random_test;
        
        -- 完成测试
        report "所有测试完成!";
        test_done <= true;
        wait;
    END PROCESS stimulus;
    
    -- 监控状态机状态 (可选)
    monitor: PROCESS
    begin
        wait until rising_edge(clk);
        if dout_valid = '1' then
            report "输出数据: " & integer'image(to_integer(unsigned(dout))) &
                   " 地址: " & integer'image(to_integer(unsigned(ram_addr)));
        end if;
    end process monitor;
END output_buffer_arch;