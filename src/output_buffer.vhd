-- ================================================================
--  File : output_buffer.vhd           Dir : rtl/output/
--  功能 : 每拍输出 1 个 |X(k)|2 (Q1.15)，输出 N 个后通知系统
--  依赖 : spect_pkg.vhd  (定义 WIDTH / N_POINTS / addr_t ... )
-- ================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.spect_pkg.all;

entity output_buffer is
    generic (
        WIDTH : natural := DATA_WIDTH; -- 16
        N     : natural := N_POINTS    -- 8
    );
    port (
        ---------------- 时钟 / 复位 ----------------
        clk      : in  std_logic;
        rst_n    : in  std_logic;

        ---------------- 与系统时序协议 -------------
        start_in : in  std_logic;   -- 从 FFT 模块的 done 信号 1 拍
        done_out : out std_logic;   -- 本模块输出完一帧数据后 1 拍

        ---------------- RAM 读端口接口 -------------
        ram_addr : out addr_t;
        ram_din  : in  signed(WIDTH-1 downto 0);
        ram_we   : out std_logic;    -- 固定 '0' （只读）

        ---------------- 输出数据流接口 ---------------
        dout        : out signed(WIDTH-1 downto 0);
        dout_valid  : out std_logic
    );
end entity;

-- ================================================================
architecture rtl of output_buffer is
-- ================================================================
    ----------------------------------------------------------------
    -- 状态机：IDLE → SET_ADDR → READ_OUT → SET_ADDR → ... → IDLE
    ----------------------------------------------------------------
    type state_t is (IDLE, SET_ADDR, READ_OUT);
    signal st : state_t := IDLE;

    signal idx      : integer range 0 to N-1 := 0;            -- 输出计数
    signal addr     : addr_t := (others=>'0');                -- RAM 地址
    signal dout_reg : signed(WIDTH-1 downto 0) := (others=>'0'); -- 输出寄存器
begin
    ----------------------------------------------------------------
    -- 默认信号
    ----------------------------------------------------------------
    ram_we     <= '0';          -- 只读
    ram_addr   <= addr;
    dout       <= dout_reg;     -- 使用寄存器输出，避免组合逻辑

    ----------------------------------------------------------------
    -- 主流程
    ----------------------------------------------------------------
    process(clk, rst_n)
    begin
        if rst_n='0' then
            st         <= IDLE;
            idx        <= 0;
            addr       <= (others=>'0');
            dout_reg   <= (others=>'0');
            dout_valid <= '0';
            done_out   <= '0';
        elsif rising_edge(clk) then
            -- 默认清零控制信号
            dout_valid <= '0';
            done_out   <= '0';
            
            case st is
            ----------------------------------------------------------------
            when IDLE =>
                if start_in='1' then              -- FFT 完成信号
                    idx  <= 0;
                    addr <= to_unsigned(0, ADDR_WIDTH);  -- |X(0)|2 对应偶地址 0
                    st   <= SET_ADDR;              -- 先设置地址，预取数据
                end if;

            ----------------------------------------------------------------
            -- SET_ADDR: 将地址送到 RAM，下一拍可读到数据
            when SET_ADDR =>
                st <= READ_OUT;

            ----------------------------------------------------------------
            -- READ_OUT: 输出 ram_din 有效 且 dout_valid=1
            when READ_OUT =>
                dout_reg   <= ram_din;             -- 寄存器化输出
                dout_valid <= '1';
                
                if idx = N-1 then                 -- 最后一个数据
                    done_out <= '1';              -- 直接完成，避免重复输出
                    st       <= IDLE;
                else
                    idx  <= idx + 1;
                    addr <= to_unsigned((idx+1)*2, ADDR_WIDTH);  -- 偶地址 0,2,4…
                    st   <= SET_ADDR;             -- 继续下一个数据的预取
                end if;
            end case;
        end if;
    end process;
end architecture;
