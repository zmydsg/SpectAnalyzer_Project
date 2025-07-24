library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity SpectAnalyzer_top_dp is
    port (
        clk        : in  std_logic;
        rst_n      : in  std_logic;
        adc_sample : in  signed(DATA_WIDTH-1 downto 0);
        adc_valid  : in  std_logic;
        adc_ready  : out std_logic;
        dout       : out signed(DATA_WIDTH-1 downto 0);
        dout_valid : out std_logic
    );
end entity;

architecture rtl of SpectAnalyzer_top_dp is
    -- 双端口RAM接口信号
    signal ram_addr_a : addr_t;
    signal ram_din_a  : signed(DATA_WIDTH-1 downto 0);
    signal ram_we_a   : std_logic;
    signal ram_dout_a : signed(DATA_WIDTH-1 downto 0);
    
    signal ram_addr_b : addr_t;
    signal ram_din_b  : signed(DATA_WIDTH-1 downto 0);
    signal ram_we_b   : std_logic;
    signal ram_dout_b : signed(DATA_WIDTH-1 downto 0);
    
    -- 控制信号
    signal start_sig : std_logic;
    signal done_sig  : std_logic;
    signal done_out  : std_logic;
    
    -- 阶段状态机
    type phase_t is (PH_IN, PH_FFT, PH_OUT);
    signal phase : phase_t := PH_IN;
    
    -- 输入缓冲信号（使用原有input_buffer）
    signal in_ram_addr : addr_t;
    signal in_ram_dout : signed(DATA_WIDTH-1 downto 0);
    signal in_ram_we   : std_logic;
    
    -- 输出缓冲信号（使用原有output_buffer）
    signal out_ram_addr : addr_t;
    
    -- FFT控制信号
    signal fft_start      : std_logic;
    signal fft_ram_addr_a : addr_t;  -- 修改：从 std_logic_vector(5 downto 0) 改为 addr_t
    signal fft_ram_dout_a : signed(DATA_WIDTH-1 downto 0);  -- 修改：从 std_logic_vector(31 downto 0) 改为 signed(DATA_WIDTH-1 downto 0)
    signal fft_ram_we_a   : std_logic;
    signal fft_ram_addr_b : addr_t;  -- 修改：从 std_logic_vector(5 downto 0) 改为 addr_t
    signal fft_ram_dout_b : signed(DATA_WIDTH-1 downto 0);  -- 修改：从 std_logic_vector(31 downto 0) 改为 signed(DATA_WIDTH-1 downto 0)
    signal fft_ram_we_b   : std_logic;
    
begin
    -- 阶段状态机
    process(clk, rst_n)
    begin
        if rst_n = '0' then
            phase <= PH_IN;
        elsif rising_edge(clk) then
            case phase is
                when PH_IN  =>
                    if start_sig = '1' then
                        phase <= PH_FFT;
                    end if;
                when PH_FFT =>
                    if done_sig = '1' then
                        phase <= PH_OUT;
                    end if;
                when PH_OUT =>
                    if done_out = '1' then
                        phase <= PH_IN;
                    end if;
            end case;
        end if;
    end process;
    
    -- RAM接口多路选择器
    ram_mux: process(phase, in_ram_addr, in_ram_dout, in_ram_we, out_ram_addr)
    begin
        -- 默认值
        ram_addr_a <= (others => '0');
        ram_din_a  <= (others => '0');
        ram_we_a   <= '0';
        ram_addr_b <= (others => '0');
        ram_din_b  <= (others => '0');
        ram_we_b   <= '0';
        
        case phase is
            when PH_IN =>
                -- 输入阶段：输入缓冲使用Port-A
                ram_addr_a <= in_ram_addr;
                ram_din_a  <= in_ram_dout;
                ram_we_a   <= in_ram_we;
                
            when PH_FFT =>
                -- FFT阶段：由FFT模块直接控制双端口
                -- 在FFT模块实例化中连接
                null;
                
            when PH_OUT =>
                -- 输出阶段：输出缓冲使用Port-A读取
                ram_addr_a <= out_ram_addr;
                ram_we_a   <= '0';
        end case;
    end process;
    
    -- 双端口RAM实例
    ram_inst: entity work.ram_dp_optimized
        port map (
            clk    => clk,
            addr_a => ram_addr_a,
            din_a  => ram_din_a,
            we_a   => ram_we_a,
            dout_a => ram_dout_a,
            addr_b => ram_addr_b,
            din_b  => ram_din_b,
            we_b   => ram_we_b,
            dout_b => ram_dout_b
        );
    
    -- 输入缓冲实例（复用原有模块）
    -- 输入缓冲实例（复用原有模块）
    input_buffer_inst: entity work.input_buffer
        port map (
            clk        => clk,
            rst_n      => rst_n,
            din        => adc_sample,
            din_valid  => adc_valid,
            din_ready  => adc_ready,
            start_fft  => start_sig,
            fft_done   => done_sig,
            ram_addr   => in_ram_addr,
            ram_dout   => in_ram_dout,
            ram_we     => in_ram_we
        );
    
    -- FFT控制逻辑
    process(phase, start_sig, ram_addr_a, ram_din_a, ram_we_a, ram_addr_b, ram_din_b, ram_we_b)
    begin
        if phase = PH_FFT then
            fft_start      <= start_sig;
            fft_ram_addr_a <= ram_addr_a;
            fft_ram_dout_a <= ram_din_a;
            fft_ram_we_a   <= ram_we_a;
            fft_ram_addr_b <= ram_addr_b;
            fft_ram_dout_b <= ram_din_b;
            fft_ram_we_b   <= ram_we_b;
        else
            fft_start      <= '0';
            fft_ram_addr_a <= (others => '0');
            fft_ram_dout_a <= (others => '0');
            fft_ram_we_a   <= '0';
            fft_ram_addr_b <= (others => '0');
            fft_ram_dout_b <= (others => '0');
            fft_ram_we_b   <= '0';
        end if;
    end process;
    
    -- FFT处理实例
    fft_inst: entity work.mag_sqr_fft_dp
        port map (
            clk        => clk,
            rst_n      => rst_n,
            start      => fft_start,
            done       => done_sig,
            ram_addr_a => fft_ram_addr_a,
            ram_din_a  => ram_dout_a,
            ram_dout_a => fft_ram_dout_a,
            ram_we_a   => fft_ram_we_a,
            ram_addr_b => fft_ram_addr_b,
            ram_din_b  => ram_dout_b,
            ram_dout_b => fft_ram_dout_b,
            ram_we_b   => fft_ram_we_b
        );
    
    -- 输出缓冲实例（复用原有模块）
    -- 输出缓冲实例（复用原有模块）
    output_buffer_inst: entity work.output_buffer
        port map (
            clk        => clk,
            rst_n      => rst_n,
            start_in   => done_sig,     -- 修改：start 改为 start_in
            done_out   => done_out,
            dout       => dout,
            dout_valid => dout_valid,
            ram_addr   => out_ram_addr,
            ram_din    => ram_dout_a,
            ram_we     => open          -- 添加：ram_we端口映射（输出缓冲只读，所以悬空）
        );
        
end architecture rtl;