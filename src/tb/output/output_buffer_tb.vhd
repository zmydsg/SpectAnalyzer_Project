
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity output_buffer_tb is
end entity;

architecture tb of output_buffer_tb is
    -- ���Բ���
    constant CLK_PERIOD : time := 10 ns; -- 100MHzʱ��
    constant WIDTH : natural := DATA_WIDTH;
    constant N : natural := N_POINTS;
    
    -- ����ģ���ź�
    signal clk       : std_logic := '0';
    signal rst_n     : std_logic := '0';
    signal start_in  : std_logic := '0';
    signal done_out  : std_logic;
    signal ram_addr  : addr_t;
    signal ram_din   : signed(WIDTH-1 downto 0);
    signal ram_we    : std_logic;
    signal dout      : signed(WIDTH-1 downto 0);
    signal dout_valid: std_logic;
    
    -- RAMģ��
    type ram_type is array(0 to 2*N-1) of signed(WIDTH-1 downto 0);
    signal test_ram : ram_type;
    
    -- ���Կ���
    signal test_done : boolean := false;
begin
    -- ʱ������
    clk <= not clk after CLK_PERIOD/2 when not test_done else '0';
    
    -- ʵ��������ģ��
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
    
    -- ����RAM����
    ram_din <= test_ram(to_integer(unsigned(ram_addr)));
    
    -- �����Թ���
    process
        -- ��ʼ��RAM����
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
        
        -- ������ֵ
        procedure check_output(expected: integer; msg: string) is
        begin
            if dout /= to_signed(expected, WIDTH) then
                report "�������! ����: " & integer'image(expected) & 
                       " ʵ��: " & integer'image(to_integer(dout)) & 
                       " - " & msg
                severity error;
            end if;
        end procedure;
    begin
        -- ��ʼ��
        rst_n <= '0';
        init_ram;
        wait for CLK_PERIOD * 2;
        rst_n <= '1';
        wait for CLK_PERIOD * 2;
        
        report "��ʼ����1: �������ܲ���";
        start_in <= '1';
        wait until rising_edge(clk);
        start_in <= '0';
        
        -- ���״̬ת�������
        for i in 0 to N-1 loop
            -- �ȴ������Ч
            if dout_valid /= '1' then
                wait until dout_valid = '1';
            end if;
            
            check_output(i, "���ݵ�" & integer'image(i));
            
            -- ���RAM��ַ�Ƿ���ȷ
            if to_integer(unsigned(ram_addr)) /= i*2 then
                report "RAM��ַ����! ����: " & integer'image(i*2) & 
                       " ʵ��: " & integer'image(to_integer(unsigned(ram_addr)))
                severity error;
            end if;
            
            wait for CLK_PERIOD;
        end loop;
        
        -- �������ź�
        if done_out /= '1' then
            wait until done_out = '1';
        end if;
        wait for CLK_PERIOD;
        if done_out /= '0' then
            report "done_outӦֻ����һ������!" severity error;
        end if;
        
        report "��ʼ����2: ��λ����";
        start_in <= '1';
        wait until rising_edge(clk);
        start_in <= '0';
        
        -- �ȴ���һ�����
        wait until dout_valid = '1';
        wait for CLK_PERIOD * 2;
        rst_n <= '0';
        wait for CLK_PERIOD * 2;
        rst_n <= '1';
        
        -- ��λ��Ӧֹͣ���
        if dout_valid = '1' then
            report "��λ�����Ӧֹͣ!" severity error;
        end if;
        
        report "��ʼ����3: ����֡����";
        for frame in 1 to 3 loop
            start_in <= '1';
            wait until rising_edge(clk);
            start_in <= '0';
            
            for i in 0 to N-1 loop
                -- �ȴ������Ч
                if dout_valid /= '1' then
                    wait until dout_valid = '1';
                end if;
                
                check_output(i, "֡" & integer'image(frame) & " ���ݵ�" & integer'image(i));
                wait for CLK_PERIOD;
            end loop;
            
            -- �������ź�
            if done_out /= '1' then
                wait until done_out = '1';
            end if;
            wait for CLK_PERIOD;
        end loop;
        
        report "��ʼ����4: ������ݲ���";
        -- ������������RAM
        for i in 0 to 2*N-1 loop
            if i mod 2 = 0 then
                test_ram(i) <= to_signed(100 + i, WIDTH);
            end if;
        end loop;
        
        start_in <= '1';
        wait until rising_edge(clk);
        start_in <= '0';
        
        for i in 0 to N-1 loop
            -- �ȴ������Ч
            if dout_valid /= '1' then
                wait until dout_valid = '1';
            end if;
            
            check_output(100 + i*2, "������ݵ�" & integer'image(i));
            wait for CLK_PERIOD;
        end loop;
        
        -- ��������
        report "���в������!";
        test_done <= true;
        wait;
    end process;
end architecture;