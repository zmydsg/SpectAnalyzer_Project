LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all; -- �������������

ENTITY output_buffer_vhd_tst IS
END output_buffer_vhd_tst;

ARCHITECTURE output_buffer_arch OF output_buffer_vhd_tst IS
    -- ��������
    constant CLK_PERIOD : time := 10 ns; -- 100MHz ʱ��
    constant N_POINTS   : natural := 8;  -- FFT ����
    constant DATA_WIDTH : natural := 16; -- ���ݿ��
    
    -- �ź�����
    SIGNAL clk       : STD_LOGIC := '0';
    SIGNAL done_out  : STD_LOGIC;
    SIGNAL dout      : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL dout_valid: STD_LOGIC;
    SIGNAL ram_addr  : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL ram_din   : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL ram_we    : STD_LOGIC;
    SIGNAL rst_n     : STD_LOGIC := '0';
    SIGNAL start_in  : STD_LOGIC := '0';
    
    -- ���Կ����ź�
    signal test_done : boolean := false;
    
    -- RAM ģ��
    type ram_type is array(0 to 2*N_POINTS-1) of std_logic_vector(15 downto 0);
    signal test_ram : ram_type;
    
    -- �������
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
    -- ʱ������
    clk <= not clk after CLK_PERIOD/2 when not test_done else '0';
    
    -- RAM ��������
    ram_din <= test_ram(to_integer(unsigned(ram_addr)));
    
    -- ʵ��������ģ��
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
    
    -- �����Թ���
    stimulus: PROCESS
        -- ��ʼ�� RAM ����
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
        
        -- �ȴ� N ��ʱ������
        procedure wait_cycles(n: natural) is
        begin
            for i in 1 to n loop
                wait until rising_edge(clk);
            end loop;
        end procedure;
        
        -- ������ֵ
        procedure check_output(expected: integer; msg: string) is
        begin
            if unsigned(dout) /= to_unsigned(expected, 16) then
                report "�������! ����: " & integer'image(expected) & 
                       " ʵ��: " & integer'image(to_integer(unsigned(dout))) & 
                       " - " & msg
                severity error;
            end if;
        end procedure;
        
        -- ���е�������֡
        procedure run_test_frame(frame_num: integer) is
        begin
            report "��ʼ����֡: " & integer'image(frame_num);
            start_in <= '1';
            wait_cycles(1);
            start_in <= '0';
            
            for i in 0 to N_POINTS-1 loop
                -- �ȴ������Ч
                wait until dout_valid = '1';
                check_output(i, "֡" & integer'image(frame_num) & " ���ݵ�" & integer'image(i));
                
                -- ��� RAM ��ַ
                if to_integer(unsigned(ram_addr)) /= i*2 then
                    report "RAM��ַ����! ����: " & integer'image(i*2) & 
                           " ʵ��: " & integer'image(to_integer(unsigned(ram_addr)))
                    severity error;
                end if;
                
                wait_cycles(1);
            end loop;
            
            -- �������ź�
            if done_out /= '1' then
                wait until done_out = '1';
            end if;
            wait_cycles(1);
            if done_out /= '0' then
                report "done_outӦֻ����һ������!" severity error;
            end if;
            
            report "����֡ " & integer'image(frame_num) & " ���";
        end procedure;
        
        -- ������ݲ���
        procedure run_random_test is
            variable seed1, seed2: positive;
            variable rand_val: real;
            variable int_val: integer;
        begin
            report "��ʼ������ݲ���";
            
            -- ������������ RAM
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
                
                -- �������Ƿ�ƥ�� RAM ����
                if unsigned(dout) /= unsigned(test_ram(i*2)) then
                    report "������ݲ�ƥ��! ��ַ: " & integer'image(i*2) & 
                           " ����: " & integer'image(to_integer(unsigned(test_ram(i*2)))) & 
                           " ʵ��: " & integer'image(to_integer(unsigned(dout)))
                    severity error;
                end if;
                
                wait_cycles(1);
            end loop;
            
            report "������ݲ������";
        end procedure;
        
    BEGIN
        -- ��ʼ�� RAM
        init_ram;
        
        -- ��λϵͳ
        report "Ӧ�ø�λ...";
        rst_n <= '0';
        wait_cycles(2);
        rst_n <= '1';
        wait_cycles(2);
        
        -- ���� 1: ��������
        run_test_frame(1);
        wait_cycles(5);
        
        -- ���� 2: ����֡
        report "��ʼ����֡����";
        for i in 2 to 4 loop
            run_test_frame(i);
            wait_cycles(2);
        end loop;
        
        -- ���� 3: ��λ����
        report "��ʼ��λ����";
        start_in <= '1';
        wait_cycles(1);
        start_in <= '0';
        
        -- �ȴ���һ�����
        wait until dout_valid = '1';
        wait_cycles(1);
        
        -- ����������и�λ
        rst_n <= '0';
        wait_cycles(2);
        rst_n <= '1';
        wait_cycles(2);
        
        -- ��λ��Ӧֹͣ���
        if dout_valid = '1' then
            report "����: ��λ�����δֹͣ!" severity error;
        end if;
        
        -- ���� 4: �������
        run_random_test;
        
        -- ��ɲ���
        report "���в������!";
        test_done <= true;
        wait;
    END PROCESS stimulus;
    
    -- ���״̬��״̬ (��ѡ)
    monitor: PROCESS
    begin
        wait until rising_edge(clk);
        if dout_valid = '1' then
            report "�������: " & integer'image(to_integer(unsigned(dout))) &
                   " ��ַ: " & integer'image(to_integer(unsigned(ram_addr)));
        end if;
    end process monitor;
END output_buffer_arch;