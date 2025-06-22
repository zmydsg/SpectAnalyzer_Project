-- ================================================================
--  File : output_buffer.vhd
--  功能 : 连续输出 |X(k)|2；输出完 N 点后拉高 done_out 1-clk
--  采用伪三态隔离：drive_en = 0 ? ram_addr 输出 'Z'
-- ================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spect_pkg.all;

entity output_buffer is
    generic (
        WIDTH : natural := DATA_WIDTH;  -- 16
        N     : natural := N_POINTS     -- 8
    );
    port (
        ---------------- 时钟 / 复位 ----------------
        clk      : in  std_logic;
        rst_n    : in  std_logic;

        ---------------- 与系统时序协作 -------------
        start_in : in  std_logic;      -- FFT done 的 1-clk 脉冲
        done_out : out std_logic;      -- 本模块输出完毕 1-clk

        ---------------- 单端口 RAM 总线 -------------
        ram_addr : out addr_t;
        ram_din  : in  signed(WIDTH-1 downto 0);
        ram_we   : out std_logic;      -- 高阻 ? 只读

        ---------------- 下游数据流 -----------------
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

    signal idx       : integer range 0 to N-1 := 0;  -- 输出计数
    signal addr_next : addr_t                 := (others=>'0');

    ----------------------------------------------------------------
    -- 内部地址与伪三态控制
    ----------------------------------------------------------------
    signal addr_int  : addr_t                 := (others=>'0');
    signal drive_en  : std_logic              := '0'; -- =1 ? 驱动 RAM

begin
    ----------------------------------------------------------------
    -- 三态映射
    ----------------------------------------------------------------
    ram_addr <= addr_int when drive_en='1' else (others=>'Z');
    ram_we   <= 'Z';           -- 恒高阻（只读）

    ----------------------------------------------------------------
    -- dout 直接转发 RAM 数据
    ----------------------------------------------------------------
    dout <= ram_din;

    ----------------------------------------------------------------
    -- 时序进程
    ----------------------------------------------------------------
    process(clk, rst_n)
    begin
        if rst_n='0' then
            st         <= IDLE;
            idx        <= 0;
            addr_int   <= (others=>'0');
            drive_en   <= '0';
            dout_valid <= '0';
            done_out   <= '0';

        elsif rising_edge(clk) then
            ----------------------------------------------------------------
            -- 每拍默认拉低
            ----------------------------------------------------------------
            drive_en   <= '0';
            dout_valid <= '0';
            done_out   <= '0';

            case st is
            ----------------------------------------------------------------
            when IDLE =>
                if start_in='1' then
                    idx      <= 0;
                    addr_int <= to_unsigned(0, ADDR_WIDTH); -- |X(0)|2 → addr 0
                    drive_en <= '1';
                    st       <= SET_ADDR;
                end if;

            ----------------------------------------------------------------
            when SET_ADDR =>                        -- 地址已送 RAM
                drive_en <= '1';                    -- 需要保持 1 拍
                st       <= READ_OUT;

            ----------------------------------------------------------------
            when READ_OUT =>
                drive_en   <= '1';                  -- 继续保持地址
                dout_valid <= '1';                  -- 此拍 ram_din 有效

                if idx = N-1 then                   -- 最后一个样本
                    st <= LAST;
                else
                    idx      <= idx + 1;
                    addr_int <= to_unsigned((idx+1)*2, ADDR_WIDTH); -- 偶址 0,2,4…
                    -- drive_en 会在下一拍 SET_ADDR 继续为 1
                    st       <= SET_ADDR;
                end if;

            ----------------------------------------------------------------
            when LAST =>
                drive_en   <= '1';      -- 保持最后一个地址
                dout_valid <= '1';
                done_out   <= '1';      -- 单拍脉冲
                st         <= IDLE;

            end case;
        end if;
    end process;
end architecture;
