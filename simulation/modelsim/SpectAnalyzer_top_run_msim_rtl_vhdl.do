transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/spect_pkg0.vhd}
vcom -93 -work work {G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/spect_pkg.vhd}
vcom -93 -work work {G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/mag_sqr_fft.vhd}
vcom -93 -work work {G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/input_buffer.vhd}
vcom -93 -work work {G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/output_buffer.vhd}
vcom -93 -work work {G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/ram_sp.vhd}
vcom -93 -work work {G:/DSD/EXPERIMENTS/SpectAnalyzer_Project/src/SpectAnalyzer_top.vhd}

