###########################################################################
# wave_sys_big.do  ——  系统级 + 常用调试信号，一键生成波形布局
###########################################################################
quietly delete wave *

# ===== 时钟 / 复位 ========================================================
add wave -group ClkRst /top_tb/clk
add wave -group ClkRst /top_tb/rst_n

# ===== 输入接口 ==========================================================
add wave -group Input  /top_tb/adc_sample
property wave -radix hex /top_tb/adc_sample
add wave -group Input  /top_tb/adc_valid
add wave -group Input  /top_tb/adc_ready

# ===== 输出接口 ==========================================================
add wave -group Output /top_tb/dout
property wave -radix hex /top_tb/dout
add wave -group Output /top_tb/dout_valid

# ===== 流程控制 ==========================================================
add wave -group Ctrl   /top_tb/uut/start_sig
add wave -group Ctrl   /top_tb/uut/done_sig
add wave -group Ctrl   /top_tb/uut/done_out

# ======== 以下为“推荐调试信号”，需要就取消注释 ===========================
# -------- 状态机 ---------------------------------------------------------
# add wave -group Status /top_tb/uut/phase

# -------- FFT 内部状态 ----------------------------------------------------
# add wave -group FFT     /top_tb/uut/u_fft/st

# -------- RAM 地址 & 写使能 ----------------------------------------------
# add wave -group RAM     /top_tb/uut/ram_addr   -radix unsigned
# add wave -group RAM     /top_tb/uut/ram_we

# -------- 输出缓冲序号 ----------------------------------------------------
# add wave -group OutBuf  /top_tb/uut/u_out/idx  -radix unsigned
###########################################################################
