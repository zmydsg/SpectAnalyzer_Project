vlib work
vcom  ../../spect_pkg.vhd
vcom  ../../mag_sqr_fft.vhd
vcom  ../../ram_sp.vhd
vcom  mag_sqr_fft_tb.vhd

vsim -voptargs=+acc work.mag_sqr_fft_tb
add wave -hexadecimal /uut/* /ram/*
run -all
quit -f