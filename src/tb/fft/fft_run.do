# =================================================================
# fft_run.do — 绝对路径版，一键编译 + 仿真 + 查看 RAM
# 使用方法：
#   在 ModelSim Transcript 里直接输入：
#     do G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/fft_run.do
# =================================================================

# —— 0. 建库并映射 —— 
if {![ file isdirectory "work" ]} {
  vlib work
}
vmap work work

# —— 1. 编译 package —— 
vcom -2002 -work work "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/spect_pkg0.vhd"
vcom -2002 -work work "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/spect_pkg.vhd"

# —— 2. 编译 DUT —— 
vcom -2002 -work work "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/mag_sqr_fft.vhd"

# —— 3. 编译 Testbench —— 
vcom -2002 -work work "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/tb/fft/tb_mag_sqr_fft_int.vhd"

# —— 4. 启动仿真 —— 
vsim -novopt work.tb_mag_sqr_fft_int

# —— 5. 加波形 —— 
add wave -r /*

# —— 6. 重置 & 运行 —— 
restart -f
run 5 us

# —— 7. 查看内部 RAM 数组内容（0–15 地址） —— 
mem display -addressradix dec -dataradix signed "/tb_mag_sqr_fft_int/RAM"

echo "===== fft_run.do finished ====="
