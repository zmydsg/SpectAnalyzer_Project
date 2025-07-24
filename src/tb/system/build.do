# ============================================================================
# build.do  ——  编译 RTL + Testbench（使用绝对路径）
# 位置：G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/tb/system
# ============================================================================

if {![file exists work]} {
    vlib work
}
vmap work work

# === 1) 先编译 package（若无可删） =========================
vcom -2002 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/spect_pkg0.vhd"
vcom -2002 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/spect_pkg.vhd"

# === 2) 编译 RTL 顶层及子模块 ===============================
vcom -2002 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/input_buffer.vhd"
vcom -2002 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/mag_sqr_fft.vhd"
vcom -2002 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/output_buffer.vhd"
vcom -2002 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/ram_sp.vhd"
vcom -2002 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/SpectAnalyzer_top.vhd"

# === 3) 最后编译 Testbench（顶层名字: top_tb） =============
vcom -2002 "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/tb/system/top_tb.vhd"

echo "---------- Compile Done ----------"
