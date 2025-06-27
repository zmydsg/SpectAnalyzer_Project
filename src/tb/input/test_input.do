#######################################################################
#  test_input.do  —— 绝对路径版本
#  ModelSim 6.4a / VHDL-93
#######################################################################

# 若 work 库已存在，vlib 会给出 Warning，无碍
vlib work

# ---------- 源文件编译 ----------
vcom -93 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/spect_pkg0.vhd"
vcom -93 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/spect_pkg.vhd"
vcom -93 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/input_buffer.vhd"
vcom -93 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/tb/input/tb_input_buffer.vhd"

# ---------- 载入仿真 ----------
vsim work.tb_input_buffer

# ---------- 波形 ----------
add wave -divider "==== 时钟 / 复位 ===="
add wave -radix unsigned sim:/tb_input_buffer/clk
add wave                     sim:/tb_input_buffer/rst_n

add wave -divider "==== 输入侧 ===="
add wave -radix signed   sim:/tb_input_buffer/din
add wave                 sim:/tb_input_buffer/din_valid
add wave                 sim:/tb_input_buffer/din_ready

add wave -divider "==== 启停信号 ===="
add wave                 sim:/tb_input_buffer/start_fft
add wave                 sim:/tb_input_buffer/fft_done

add wave -divider "==== RAM 接口 ===="
add wave -radix unsigned sim:/tb_input_buffer/ram_addr
add wave -radix signed   sim:/tb_input_buffer/ram_dout
add wave                 sim:/tb_input_buffer/ram_we

# ---------- 运行 ----------
run 2 us                  ;# 按需加长


# -------- 断言统计 --------
set errList [verror -error]
set errCnt  [llength $errList]
echo "======== ASSERT SUMMARY ========"
echo "Errors : $errCnt"

