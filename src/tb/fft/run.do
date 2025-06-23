   vlib work
   vcom  ../../spect_pkg.vhd
   vcom  ../../mag_sqr_fft.vhd
   vcom  tb_mag_sqr_fft.vhd
   vsim -voptargs=+acc work.tb_mag_sqr_fft
add wave -hexadecimal /dut/* /ram_inst/*
   run -all
   quit -f