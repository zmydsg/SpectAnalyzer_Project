# ============================================================
#  File      : spect_top_all.do
#  Purpose   : Compile RTL & TB, launch sim, keep GUI alive
#  Platform  : ModelSim-Altera 6.4a (VHDL-93)
# ============================================================

# === 1) 目录常量（绝对路径，全正斜杠，末尾不要斜杠） =========
set RTL_DIR "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/"
set TB_DIR  "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/tb/top"

# === 2) 重建工作库 ==========================================
if {[file exists work]} { vdel -all -lib work }
vlib work
vmap work work

# === 3) 编译 RTL（依赖顺序不能乱） ==========================
foreach f {spect_pkg0.vhd
           spect_pkg.vhd
           ram_sp.vhd
           input_buffer.vhd
           mag_sqr_fft.vhd
           output_buffer.vhd
           SpectAnalyzer_top.vhd} {
    vcom -93 "$RTL_DIR/$f"
}

# === 4) 编译 Testbench ======================================
vcom -93 "$TB_DIR/tb_SpectAnalyzer_top.vhd"

# === 5) 启动仿真（保持 GUI、手动可继续 run/stop） ==========
vsim work.tb_SpectAnalyzer_top -t 1ns

# === 6) 常用波形 ==================================================
add wave -divider {TOP I/O}
add wave            /tb_SpectAnalyzer_top/clk
add wave            /tb_SpectAnalyzer_top/rst_n
add wave -hex       /tb_SpectAnalyzer_top/adc_sample
add wave            /tb_SpectAnalyzer_top/adc_valid
add wave            /tb_SpectAnalyzer_top/adc_ready
add wave -hex       /tb_SpectAnalyzer_top/dout
add wave            /tb_SpectAnalyzer_top/dout_valid

add wave -divider {Internal Phase}
add wave            /tb_SpectAnalyzer_top/u_dut/phase
add wave            /tb_SpectAnalyzer_top/u_dut/start_sig
add wave            /tb_SpectAnalyzer_top/u_dut/done_sig
add wave            /tb_SpectAnalyzer_top/u_dut/done_out

add wave -divider {RAM handshake}
add wave            /tb_SpectAnalyzer_top/u_dut/ram_addr
add wave            /tb_SpectAnalyzer_top/u_dut/ram_we
add wave -hex       /tb_SpectAnalyzer_top/u_dut/ram_din
add wave -hex       /tb_SpectAnalyzer_top/u_dut/ram_dout

# === 7) 先跑 5 ms，停下来留给你手动操作 ======================
run 5 ms
echo "INFO: 已运行 5 ms，可继续 run-all / reload / zoom，脚本不会自动退出。"
