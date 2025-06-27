# ================================================================
#  File : simulate.do
#  Desc : 批量编译 / 仿真 output_buffer 单元（ModelSim 6.4a）
# ================================================================

# === 1. 绝对路径  =================================================
set rtl_path "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/"
set sim_path "G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/tb/output"

# === 2. 建 / 切换工作库 ==========================================
# 若想每次全新编译可取消下一行注释
# vdel -all work

if {![file exists work]} {
    vlib work
}

# === 3. 编译源码 =================================================
vcom -93 $rtl_path/spect_pkg0.vhd
vcom -93 $rtl_path/spect_pkg.vhd
vcom -93 $rtl_path/output_buffer.vhd
vcom -93 $sim_path/tb_output_buffer.vhd

# === 4. 启动仿真并添加波形 ======================================
vsim -voptargs="+acc" work.tb_output_buffer

add wave -group CLK  rst_n clk
add wave -group CTRL start_in done_out
add wave -group RAM  ram_addr ram_din
add wave -group OUT  dout_valid dout
add wave -group DUT  uut/st uut/idx uut/addr

# === 5. 运行 =====================================================
run 2 us
