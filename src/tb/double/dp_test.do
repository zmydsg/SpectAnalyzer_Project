# build_dp.do - 编译双端口RAM优化版本
# ============================================================================

if {![file exists work]} {
    vlib work
}
vmap work work

# === 1) 编译 package ===
vcom -2002 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/spect_pkg0.vhd"
vcom -2002 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/spect_pkg.vhd"

# === 2) 编译双端口RAM模块 ===
vcom -2002 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/ram_dp_optimized.vhd"

# === 3) 编译其他模块 ===
vcom -2002 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/input_buffer.vhd"
vcom -2002 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/mag_sqr_fft_dp.vhd"
vcom -2002 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/output_buffer.vhd"

# === 4) 编译双端口优化顶层 ===
vcom -2002 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/SpectAnalyzer_top_dp.vhd"

# === 5) 编译测试文件 ===
vcom -2002 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/tb/double/tb_SpectAnalyzer_top_dp.vhd"

echo "---------- DP Version Compile Done ----------"