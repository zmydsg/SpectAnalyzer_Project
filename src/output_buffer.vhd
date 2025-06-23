-- ================================================================
--  File : output_buffer.vhd           Dir : rtl/output/
--  功能 : 每拍输出 1 个 |X(k)|2 (Q1.15)；输出完 N 点后通知系统
--  依赖 : spect_pkg.vhd  (常量 WIDTH / N_POINTS / addr_t ... )
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

        ---------------- 与系统时序协作 -------------
        start_in : in  std_logic;   -- 由 FFT 模块的 done 拉高 1 拍
        done_out : out std_logic;   -- 本模块输出完一帧后拉高 1 拍

        ---------------- RAM 单端口接口 -------------
        ram_addr : out addr_t;
        ram_din  : in  signed(WIDTH-1 downto 0);
        ram_we   : out std_logic;    -- 固定 '0' （只读）

        ---------------- 对下游数据流 ---------------
        dout        : out signed(WIDTH-1 downto 0);
        dout_valid  : out std_logic
    );
end entity;

-- ================================================================
architecture rtl of output_buffer is
-- ================================================================
    ----------------------------------------------------------------
    -- 状态机：IDLE → SET_ADDR → READ_OUT → LAST → IDLE
    ----------------------------------------------------------------
    type state_t is (IDLE, SET_ADDR, READ_OUT, LAST);
    signal st : state_t := IDLE;

    signal idx  : integer range 0 to N-1 := 0;            -- 输出计数
    signal addr : addr_t := (others=>'0');                -- RAM 地址
begin
    ----------------------------------------------------------------
    -- 默认信号
    ----------------------------------------------------------------
    ram_we     <= '0';          -- 只读
    ram_addr   <= addr;
    dout       <= ram_din;
    --dout_valid <= '0';
    --done_out   <= '0';

    ----------------------------------------------------------------
    -- 主进程
    ----------------------------------------------------------------
    process(clk, rst_n)
    begin
        if rst_n='0' then
            st   <= IDLE;
            idx  <= 0;
            addr <= (others=>'0');
            dout_valid <= '0';
			done_out   <= '0';
        elsif rising_edge(clk) then
			-- ★ 每拍默认拉低
			dout_valid <= '0';
			done_out   <= '0';
            
            case st is
            ----------------------------------------------------------------
            when IDLE =>
                if start_in='1' then              -- FFT 计算完毕
                    idx  <= 0;
                    addr <= to_unsigned(0, ADDR_WIDTH);  -- |X(0)|2 存在偶地址 0
                    st   <= READ_OUT;
                end if;

            ----------------------------------------------------------------
            -- SET_ADDR: 把地址放到 RAM，下一拍可读出数据
            when SET_ADDR =>
                st <= READ_OUT;

            ----------------------------------------------------------------
            -- READ_OUT: 此拍 ram_din 有效 → dout_valid=1
            when READ_OUT =>
                dout_valid <= '1';
                if idx = N-1 then                 -- 最后一个样本
                    st <= LAST;
                else
                    idx  <= idx + 1;
                    addr <= to_unsigned((idx+1)*2, ADDR_WIDTH);  -- 偶地址 0,2,4…
                    st   <= SET_ADDR;
                end if;

            ----------------------------------------------------------------
            -- LAST: 输出最后一个数据，拉高 done_out，下一拍回 IDLE
            when LAST =>
                dout_valid <= '1';
                done_out   <= '1';
                st         <= IDLE;
            end case;
        end if;
    end process;
end architecture;
