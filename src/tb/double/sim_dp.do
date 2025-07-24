# sim_dp.do - 双端口RAM优化版本仿真脚本
# ============================================================================

do dp_test.do                        ;# 1. 先编译

vsim -novopt work.tb_SpectAnalyzer_top_dp ;# 2. 载入 TB
log -r /*                            ;# 3. 记录所有信号

# 添加关键信号到波形窗口
add wave -divider "Clock & Reset"
add wave /tb_SpectAnalyzer_top_dp/clk
add wave /tb_SpectAnalyzer_top_dp/rst_n

add wave -divider "Input Interface"
add wave /tb_SpectAnalyzer_top_dp/adc_sample
add wave /tb_SpectAnalyzer_top_dp/adc_valid
add wave /tb_SpectAnalyzer_top_dp/adc_ready

add wave -divider "Output Interface"
add wave /tb_SpectAnalyzer_top_dp/dout
add wave /tb_SpectAnalyzer_top_dp/dout_valid

add wave -divider "Performance Monitoring"
add wave /tb_SpectAnalyzer_top_dp/sample_count
add wave /tb_SpectAnalyzer_top_dp/output_count

add wave -divider "Internal Signals"
add wave /tb_SpectAnalyzer_top_dp/uut/phase
add wave /tb_SpectAnalyzer_top_dp/uut/ram_addr_a
add wave /tb_SpectAnalyzer_top_dp/uut/ram_addr_b
add wave /tb_SpectAnalyzer_top_dp/uut/ram_we_a
add wave /tb_SpectAnalyzer_top_dp/uut/ram_we_b

run 10 us                            ;# 4. 运行仿真

echo "=== 双端口RAM优化版本仿真完成 ==="