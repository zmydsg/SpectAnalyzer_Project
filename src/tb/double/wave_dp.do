# wave_dp.do - 双端口RAM优化版本波形配置
# ============================================================================

# 清除现有波形
delete wave *

# 系统信号
add wave -divider "=== System ==="
add wave -color Yellow /tb_SpectAnalyzer_top_dp/clk
add wave -color Orange /tb_SpectAnalyzer_top_dp/rst_n

# 输入接口
add wave -divider "=== Input Interface ==="
add wave -radix decimal /tb_SpectAnalyzer_top_dp/adc_sample
add wave /tb_SpectAnalyzer_top_dp/adc_valid
add wave /tb_SpectAnalyzer_top_dp/adc_ready

# 输出接口
add wave -divider "=== Output Interface ==="
add wave -radix decimal /tb_SpectAnalyzer_top_dp/dout
add wave /tb_SpectAnalyzer_top_dp/dout_valid

# 内部状态
add wave -divider "=== Internal State ==="
add wave /tb_SpectAnalyzer_top_dp/uut/current_phase
add wave /tb_SpectAnalyzer_top_dp/uut/done_sig

# 双端口RAM接口
add wave -divider "=== Dual Port RAM Interface ==="
add wave -radix unsigned /tb_SpectAnalyzer_top_dp/uut/ram_addr_a
add wave -radix unsigned /tb_SpectAnalyzer_top_dp/uut/ram_addr_b
add wave -radix decimal /tb_SpectAnalyzer_top_dp/uut/ram_din_a
add wave -radix decimal /tb_SpectAnalyzer_top_dp/uut/ram_din_b
add wave /tb_SpectAnalyzer_top_dp/uut/ram_we_a
add wave /tb_SpectAnalyzer_top_dp/uut/ram_we_b
add wave -radix decimal /tb_SpectAnalyzer_top_dp/uut/ram_dout_a
add wave -radix decimal /tb_SpectAnalyzer_top_dp/uut/ram_dout_b

# 性能监控
add wave -divider "=== Performance ==="
add wave -radix decimal /tb_SpectAnalyzer_top_dp/sample_count
add wave -radix decimal /tb_SpectAnalyzer_top_dp/output_count

# 配置波形显示
configure wave -namecolwidth 250
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2

echo "波形配置完成"