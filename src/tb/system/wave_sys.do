# ======================================================================
# 仅保留系统级验收必需信号 —— 稳定版
# ======================================================================
delete wave *

# ---------- 基础时序 ----------
add wave -group ClkRst /top_tb/clk
add wave -group ClkRst /top_tb/rst_n

# ---------- 输入接口 ----------
add wave -group Input  /top_tb/adc_sample
property wave -radix hex /top_tb/adc_sample  ;# 向量改显示进制
add wave -group Input  /top_tb/adc_valid
add wave -group Input  /top_tb/adc_ready

# ---------- 输出接口 ----------
add wave -group Output /top_tb/dout
property wave -radix hex /top_tb/dout
add wave -group Output /top_tb/dout_valid

# ---------- 流程控制 ----------
add wave -group Control /top_tb/uut/start_sig
add wave -group Control /top_tb/uut/done_sig
add wave -group Control /top_tb/uut/done_out

# ---------- 可选状态机 ----------
# add wave -group Control /top_tb/uut/phase
