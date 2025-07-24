-- Copyright (C) 1991-2009 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II"
-- VERSION "Version 9.0 Build 235 06/17/2009 Service Pack 2 SJ Web Edition"

-- DATE "06/28/2025 07:13:57"

-- 
-- Device: Altera EP20K200EFC672-1 Package FBGA672
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY IEEE, apex20ke;
USE IEEE.std_logic_1164.all;
USE apex20ke.apex20ke_components.all;

ENTITY 	SpectAnalyzer_top_dp IS
    PORT (
	clk : IN std_logic;
	rst_n : IN std_logic;
	adc_sample : IN std_logic_vector(15 DOWNTO 0);
	adc_valid : IN std_logic;
	adc_ready : OUT std_logic;
	dout : OUT std_logic_vector(15 DOWNTO 0);
	dout_valid : OUT std_logic
	);
END SpectAnalyzer_top_dp;

ARCHITECTURE structure OF SpectAnalyzer_top_dp IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_rst_n : std_logic;
SIGNAL ww_adc_sample : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_adc_valid : std_logic;
SIGNAL ww_adc_ready : std_logic;
SIGNAL ww_dout : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_dout_valid : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][0]_WADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][0]_RADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][1]_WADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][1]_RADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][2]_WADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][2]_RADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][3]_WADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][3]_RADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][4]_WADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][4]_RADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][5]_WADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][5]_RADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][6]_WADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][6]_RADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][7]_WADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][7]_RADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][8]_WADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][8]_RADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][9]_WADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][9]_RADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][10]_WADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][10]_RADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][11]_WADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][11]_RADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][12]_WADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][12]_RADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][13]_WADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][13]_RADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][14]_WADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][14]_RADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][15]_WADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][15]_RADDR_bus\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ram_inst|mem_rtl_0|segment[0][0]_modesel\ : std_logic_vector(17 DOWNTO 0) := "010100000100000101";
SIGNAL \ram_inst|mem_rtl_0|segment[0][1]_modesel\ : std_logic_vector(17 DOWNTO 0) := "010100000100000101";
SIGNAL \ram_inst|mem_rtl_0|segment[0][2]_modesel\ : std_logic_vector(17 DOWNTO 0) := "010100000100000101";
SIGNAL \ram_inst|mem_rtl_0|segment[0][3]_modesel\ : std_logic_vector(17 DOWNTO 0) := "010100000100000101";
SIGNAL \ram_inst|mem_rtl_0|segment[0][4]_modesel\ : std_logic_vector(17 DOWNTO 0) := "010100000100000101";
SIGNAL \ram_inst|mem_rtl_0|segment[0][5]_modesel\ : std_logic_vector(17 DOWNTO 0) := "010100000100000101";
SIGNAL \ram_inst|mem_rtl_0|segment[0][6]_modesel\ : std_logic_vector(17 DOWNTO 0) := "010100000100000101";
SIGNAL \ram_inst|mem_rtl_0|segment[0][7]_modesel\ : std_logic_vector(17 DOWNTO 0) := "010100000100000101";
SIGNAL \ram_inst|mem_rtl_0|segment[0][8]_modesel\ : std_logic_vector(17 DOWNTO 0) := "010100000100000101";
SIGNAL \ram_inst|mem_rtl_0|segment[0][9]_modesel\ : std_logic_vector(17 DOWNTO 0) := "010100000100000101";
SIGNAL \ram_inst|mem_rtl_0|segment[0][10]_modesel\ : std_logic_vector(17 DOWNTO 0) := "010100000100000101";
SIGNAL \ram_inst|mem_rtl_0|segment[0][11]_modesel\ : std_logic_vector(17 DOWNTO 0) := "010100000100000101";
SIGNAL \ram_inst|mem_rtl_0|segment[0][12]_modesel\ : std_logic_vector(17 DOWNTO 0) := "010100000100000101";
SIGNAL \ram_inst|mem_rtl_0|segment[0][13]_modesel\ : std_logic_vector(17 DOWNTO 0) := "010100000100000101";
SIGNAL \ram_inst|mem_rtl_0|segment[0][14]_modesel\ : std_logic_vector(17 DOWNTO 0) := "010100000100000101";
SIGNAL \ram_inst|mem_rtl_0|segment[0][15]_modesel\ : std_logic_vector(17 DOWNTO 0) := "010100000100000101";
SIGNAL \ram_din_a[0]~0_combout\ : std_logic;
SIGNAL \ram_din_a[1]~1_combout\ : std_logic;
SIGNAL \ram_din_a[2]~2_combout\ : std_logic;
SIGNAL \ram_din_a[3]~3_combout\ : std_logic;
SIGNAL \ram_din_a[4]~4_combout\ : std_logic;
SIGNAL \ram_din_a[5]~5_combout\ : std_logic;
SIGNAL \ram_din_a[6]~6_combout\ : std_logic;
SIGNAL \ram_din_a[7]~7_combout\ : std_logic;
SIGNAL \ram_din_a[8]~8_combout\ : std_logic;
SIGNAL \ram_din_a[9]~9_combout\ : std_logic;
SIGNAL \ram_din_a[10]~10_combout\ : std_logic;
SIGNAL \ram_din_a[11]~11_combout\ : std_logic;
SIGNAL \ram_din_a[12]~12_combout\ : std_logic;
SIGNAL \ram_din_a[13]~13_combout\ : std_logic;
SIGNAL \ram_din_a[14]~14_combout\ : std_logic;
SIGNAL \ram_din_a[15]~15_combout\ : std_logic;
SIGNAL \fft_inst|Selector1~1_combout\ : std_logic;
SIGNAL \fft_inst|Selector207~4_combout\ : std_logic;
SIGNAL \fft_inst|Selector207~5_combout\ : std_logic;
SIGNAL \fft_inst|Selector9~0_combout\ : std_logic;
SIGNAL \fft_inst|Selector27~1_combout\ : std_logic;
SIGNAL \fft_inst|Selector23~5_combout\ : std_logic;
SIGNAL \clk~combout\ : std_logic;
SIGNAL \rst_n~combout\ : std_logic;
SIGNAL \fft_inst|st.S0_WR_PAIR~regout\ : std_logic;
SIGNAL \output_buffer_inst|Equal0~0_combout\ : std_logic;
SIGNAL \output_buffer_inst|st.IDLE~regout\ : std_logic;
SIGNAL \output_buffer_inst|st.SET_ADDR~regout\ : std_logic;
SIGNAL \output_buffer_inst|st.READ_OUT~regout\ : std_logic;
SIGNAL \output_buffer_inst|Selector2~1_combout\ : std_logic;
SIGNAL \output_buffer_inst|done_out~regout\ : std_logic;
SIGNAL \phase.PH_OUT~regout\ : std_logic;
SIGNAL \adc_valid~combout\ : std_logic;
SIGNAL \input_buffer_inst|ram_we~1_combout\ : std_logic;
SIGNAL \input_buffer_inst|st~26_combout\ : std_logic;
SIGNAL \input_buffer_inst|Selector25~0_combout\ : std_logic;
SIGNAL \input_buffer_inst|st.WAIT_FFT~regout\ : std_logic;
SIGNAL \input_buffer_inst|start_fft~regout\ : std_logic;
SIGNAL \phase.PH_IN~regout\ : std_logic;
SIGNAL \phase.PH_FFT~regout\ : std_logic;
SIGNAL \fft_inst|st.IDLE~regout\ : std_logic;
SIGNAL \fft_inst|Selector1~5_combout\ : std_logic;
SIGNAL \fft_inst|Selector2~1_combout\ : std_logic;
SIGNAL \fft_inst|Selector1~3_combout\ : std_logic;
SIGNAL \fft_inst|Selector2~0_combout\ : std_logic;
SIGNAL \fft_inst|st.S0_ADVANCE~regout\ : std_logic;
SIGNAL \fft_inst|Selector1~0_combout\ : std_logic;
SIGNAL \fft_inst|Selector1~2_combout\ : std_logic;
SIGNAL \fft_inst|Selector1~4_combout\ : std_logic;
SIGNAL \fft_inst|Selector23~4_combout\ : std_logic;
SIGNAL \fft_inst|read_phase~regout\ : std_logic;
SIGNAL \fft_inst|Selector23~9\ : std_logic;
SIGNAL \fft_inst|Selector23~7_combout\ : std_logic;
SIGNAL \fft_inst|st.S1_RD_PAIR~regout\ : std_logic;
SIGNAL \fft_inst|st.S1_CALC~regout\ : std_logic;
SIGNAL \fft_inst|st.S1_BUTTERFLY~regout\ : std_logic;
SIGNAL \fft_inst|st.S1_WR_PAIR~regout\ : std_logic;
SIGNAL \fft_inst|Selector27~0_combout\ : std_logic;
SIGNAL \fft_inst|st.S2_RD_PAIR~regout\ : std_logic;
SIGNAL \fft_inst|st.S2_CALC~regout\ : std_logic;
SIGNAL \fft_inst|st.S2_BUTTERFLY~regout\ : std_logic;
SIGNAL \fft_start~1_combout\ : std_logic;
SIGNAL \fft_inst|Selector19~0_combout\ : std_logic;
SIGNAL \fft_inst|st.S0_RD_PAIR~regout\ : std_logic;
SIGNAL \fft_inst|st.S0_CALC~regout\ : std_logic;
SIGNAL \fft_inst|Selector207~9\ : std_logic;
SIGNAL \fft_inst|Selector207~7_combout\ : std_logic;
SIGNAL \fft_inst|write_phase~regout\ : std_logic;
SIGNAL \fft_inst|st.S2_WR_PAIR~regout\ : std_logic;
SIGNAL \fft_inst|Selector240~0_combout\ : std_logic;
SIGNAL \fft_inst|st.MAG_RD_PAIR~regout\ : std_logic;
SIGNAL \fft_inst|st.MAG_CALC~regout\ : std_logic;
SIGNAL \fft_inst|st.MAG_WR~regout\ : std_logic;
SIGNAL \fft_inst|Selector240~1_combout\ : std_logic;
SIGNAL \fft_inst|Add17~0_combout\ : std_logic;
SIGNAL \fft_inst|Equal3~0_combout\ : std_logic;
SIGNAL \fft_inst|st.DONE1~regout\ : std_logic;
SIGNAL \fft_inst|done~regout\ : std_logic;
SIGNAL \input_buffer_inst|st.IDLE~regout\ : std_logic;
SIGNAL \input_buffer_inst|Selector26~2_combout\ : std_logic;
SIGNAL \input_buffer_inst|st~25_combout\ : std_logic;
SIGNAL \input_buffer_inst|Selector0~0_combout\ : std_logic;
SIGNAL \input_buffer_inst|din_ready~regout\ : std_logic;
SIGNAL \input_buffer_inst|ram_we~regout\ : std_logic;
SIGNAL \ram_we_a~1_combout\ : std_logic;
SIGNAL \input_buffer_inst|ram_dout[0]~16_combout\ : std_logic;
SIGNAL \Selector6~1_combout\ : std_logic;
SIGNAL \Selector5~0_combout\ : std_logic;
SIGNAL \Selector4~0_combout\ : std_logic;
SIGNAL \Selector3~0_combout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][0]~dataout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][1]~dataout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][2]~dataout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][3]~dataout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][4]~dataout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][5]~dataout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][6]~dataout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][7]~dataout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][8]~dataout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][9]~dataout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][10]~dataout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][11]~dataout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][12]~dataout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][13]~dataout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][14]~dataout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][15]~dataout\ : std_logic;
SIGNAL \output_buffer_inst|dout_valid~regout\ : std_logic;
SIGNAL \output_buffer_inst|dout_reg\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \output_buffer_inst|idx\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \fft_inst|mag_idx\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \fft_inst|pair_idx\ : std_logic_vector(1 DOWNTO 0);
SIGNAL \input_buffer_inst|ram_addr\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \input_buffer_inst|ram_dout\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \input_buffer_inst|wr_ptr\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \adc_sample~combout\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ALT_INV_rst_n~combout\ : std_logic;

BEGIN

ww_clk <= clk;
ww_rst_n <= rst_n;
ww_adc_sample <= adc_sample;
ww_adc_valid <= adc_valid;
adc_ready <= ww_adc_ready;
dout <= ww_dout;
dout_valid <= ww_dout_valid;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\ram_inst|mem_rtl_0|segment[0][0]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][0]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][1]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][1]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][2]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][2]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][3]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][3]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][4]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][4]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][5]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][5]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][6]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][6]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][7]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][7]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][8]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][8]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][9]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][9]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][10]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][10]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][11]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][11]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][12]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][12]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][13]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][13]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][14]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][14]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][15]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);

\ram_inst|mem_rtl_0|segment[0][15]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Selector3~0_combout\ & \Selector4~0_combout\ & \Selector5~0_combout\ & \Selector6~1_combout\);
\ALT_INV_rst_n~combout\ <= NOT \rst_n~combout\;

\input_buffer_inst|ram_dout[0]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_dout\(0) = DFFE(\adc_sample~combout\(0), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \adc_sample~combout\(0),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_dout\(0));

\ram_din_a[0]~0\ : apex20ke_lcell
-- Equation(s):
-- \ram_din_a[0]~0_combout\ = \input_buffer_inst|ram_dout\(0) & !\phase.PH_IN~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00f0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \input_buffer_inst|ram_dout\(0),
	datad => \phase.PH_IN~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_din_a[0]~0_combout\);

\input_buffer_inst|ram_dout[1]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_dout\(1) = DFFE(\adc_sample~combout\(1), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \adc_sample~combout\(1),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_dout\(1));

\ram_din_a[1]~1\ : apex20ke_lcell
-- Equation(s):
-- \ram_din_a[1]~1_combout\ = !\phase.PH_IN~regout\ & \input_buffer_inst|ram_dout\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0f00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \phase.PH_IN~regout\,
	datad => \input_buffer_inst|ram_dout\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_din_a[1]~1_combout\);

\input_buffer_inst|ram_dout[2]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_dout\(2) = DFFE(\adc_sample~combout\(2), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \adc_sample~combout\(2),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_dout\(2));

\ram_din_a[2]~2\ : apex20ke_lcell
-- Equation(s):
-- \ram_din_a[2]~2_combout\ = \input_buffer_inst|ram_dout\(2) & (!\phase.PH_IN~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00cc",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \input_buffer_inst|ram_dout\(2),
	datad => \phase.PH_IN~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_din_a[2]~2_combout\);

\input_buffer_inst|ram_dout[3]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_dout\(3) = DFFE(\adc_sample~combout\(3), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \adc_sample~combout\(3),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_dout\(3));

\ram_din_a[3]~3\ : apex20ke_lcell
-- Equation(s):
-- \ram_din_a[3]~3_combout\ = !\phase.PH_IN~regout\ & \input_buffer_inst|ram_dout\(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0f00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \phase.PH_IN~regout\,
	datad => \input_buffer_inst|ram_dout\(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_din_a[3]~3_combout\);

\input_buffer_inst|ram_dout[4]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_dout\(4) = DFFE(\adc_sample~combout\(4), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \adc_sample~combout\(4),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_dout\(4));

\ram_din_a[4]~4\ : apex20ke_lcell
-- Equation(s):
-- \ram_din_a[4]~4_combout\ = \input_buffer_inst|ram_dout\(4) & (!\phase.PH_IN~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00cc",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \input_buffer_inst|ram_dout\(4),
	datad => \phase.PH_IN~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_din_a[4]~4_combout\);

\input_buffer_inst|ram_dout[5]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_dout\(5) = DFFE(\adc_sample~combout\(5), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \adc_sample~combout\(5),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_dout\(5));

\ram_din_a[5]~5\ : apex20ke_lcell
-- Equation(s):
-- \ram_din_a[5]~5_combout\ = \input_buffer_inst|ram_dout\(5) & !\phase.PH_IN~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00f0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \input_buffer_inst|ram_dout\(5),
	datad => \phase.PH_IN~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_din_a[5]~5_combout\);

\input_buffer_inst|ram_dout[6]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_dout\(6) = DFFE(\adc_sample~combout\(6), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \adc_sample~combout\(6),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_dout\(6));

\ram_din_a[6]~6\ : apex20ke_lcell
-- Equation(s):
-- \ram_din_a[6]~6_combout\ = !\phase.PH_IN~regout\ & \input_buffer_inst|ram_dout\(6)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0f00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \phase.PH_IN~regout\,
	datad => \input_buffer_inst|ram_dout\(6),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_din_a[6]~6_combout\);

\input_buffer_inst|ram_dout[7]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_dout\(7) = DFFE(\adc_sample~combout\(7), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \adc_sample~combout\(7),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_dout\(7));

\ram_din_a[7]~7\ : apex20ke_lcell
-- Equation(s):
-- \ram_din_a[7]~7_combout\ = !\phase.PH_IN~regout\ & \input_buffer_inst|ram_dout\(7)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0f00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \phase.PH_IN~regout\,
	datad => \input_buffer_inst|ram_dout\(7),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_din_a[7]~7_combout\);

\input_buffer_inst|ram_dout[8]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_dout\(8) = DFFE(\adc_sample~combout\(8), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \adc_sample~combout\(8),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_dout\(8));

\ram_din_a[8]~8\ : apex20ke_lcell
-- Equation(s):
-- \ram_din_a[8]~8_combout\ = !\phase.PH_IN~regout\ & \input_buffer_inst|ram_dout\(8)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0f00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \phase.PH_IN~regout\,
	datad => \input_buffer_inst|ram_dout\(8),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_din_a[8]~8_combout\);

\input_buffer_inst|ram_dout[9]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_dout\(9) = DFFE(\adc_sample~combout\(9), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \adc_sample~combout\(9),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_dout\(9));

\ram_din_a[9]~9\ : apex20ke_lcell
-- Equation(s):
-- \ram_din_a[9]~9_combout\ = !\phase.PH_IN~regout\ & \input_buffer_inst|ram_dout\(9)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0f00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \phase.PH_IN~regout\,
	datad => \input_buffer_inst|ram_dout\(9),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_din_a[9]~9_combout\);

\input_buffer_inst|ram_dout[10]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_dout\(10) = DFFE(\adc_sample~combout\(10), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \adc_sample~combout\(10),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_dout\(10));

\ram_din_a[10]~10\ : apex20ke_lcell
-- Equation(s):
-- \ram_din_a[10]~10_combout\ = \input_buffer_inst|ram_dout\(10) & (!\phase.PH_IN~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00cc",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \input_buffer_inst|ram_dout\(10),
	datad => \phase.PH_IN~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_din_a[10]~10_combout\);

\input_buffer_inst|ram_dout[11]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_dout\(11) = DFFE(\adc_sample~combout\(11), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \adc_sample~combout\(11),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_dout\(11));

\ram_din_a[11]~11\ : apex20ke_lcell
-- Equation(s):
-- \ram_din_a[11]~11_combout\ = \input_buffer_inst|ram_dout\(11) & (!\phase.PH_IN~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00cc",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \input_buffer_inst|ram_dout\(11),
	datad => \phase.PH_IN~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_din_a[11]~11_combout\);

\input_buffer_inst|ram_dout[12]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_dout\(12) = DFFE(\adc_sample~combout\(12), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \adc_sample~combout\(12),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_dout\(12));

\ram_din_a[12]~12\ : apex20ke_lcell
-- Equation(s):
-- \ram_din_a[12]~12_combout\ = !\phase.PH_IN~regout\ & \input_buffer_inst|ram_dout\(12)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0f00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \phase.PH_IN~regout\,
	datad => \input_buffer_inst|ram_dout\(12),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_din_a[12]~12_combout\);

\input_buffer_inst|ram_dout[13]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_dout\(13) = DFFE(\adc_sample~combout\(13), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \adc_sample~combout\(13),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_dout\(13));

\ram_din_a[13]~13\ : apex20ke_lcell
-- Equation(s):
-- \ram_din_a[13]~13_combout\ = \input_buffer_inst|ram_dout\(13) & !\phase.PH_IN~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00f0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \input_buffer_inst|ram_dout\(13),
	datad => \phase.PH_IN~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_din_a[13]~13_combout\);

\input_buffer_inst|ram_dout[14]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_dout\(14) = DFFE(\adc_sample~combout\(14), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \adc_sample~combout\(14),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_dout\(14));

\ram_din_a[14]~14\ : apex20ke_lcell
-- Equation(s):
-- \ram_din_a[14]~14_combout\ = \input_buffer_inst|ram_dout\(14) & !\phase.PH_IN~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00f0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \input_buffer_inst|ram_dout\(14),
	datad => \phase.PH_IN~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_din_a[14]~14_combout\);

\input_buffer_inst|ram_dout[15]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_dout\(15) = DFFE(\adc_sample~combout\(15), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \adc_sample~combout\(15),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_dout\(15));

\ram_din_a[15]~15\ : apex20ke_lcell
-- Equation(s):
-- \ram_din_a[15]~15_combout\ = !\phase.PH_IN~regout\ & \input_buffer_inst|ram_dout\(15)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0f00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \phase.PH_IN~regout\,
	datad => \input_buffer_inst|ram_dout\(15),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_din_a[15]~15_combout\);

\adc_sample[0]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_adc_sample(0),
	combout => \adc_sample~combout\(0));

\adc_sample[1]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_adc_sample(1),
	combout => \adc_sample~combout\(1));

\adc_sample[2]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_adc_sample(2),
	combout => \adc_sample~combout\(2));

\adc_sample[3]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_adc_sample(3),
	combout => \adc_sample~combout\(3));

\adc_sample[4]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_adc_sample(4),
	combout => \adc_sample~combout\(4));

\adc_sample[5]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_adc_sample(5),
	combout => \adc_sample~combout\(5));

\adc_sample[6]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_adc_sample(6),
	combout => \adc_sample~combout\(6));

\adc_sample[7]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_adc_sample(7),
	combout => \adc_sample~combout\(7));

\adc_sample[8]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_adc_sample(8),
	combout => \adc_sample~combout\(8));

\adc_sample[9]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_adc_sample(9),
	combout => \adc_sample~combout\(9));

\adc_sample[10]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_adc_sample(10),
	combout => \adc_sample~combout\(10));

\adc_sample[11]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_adc_sample(11),
	combout => \adc_sample~combout\(11));

\adc_sample[12]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_adc_sample(12),
	combout => \adc_sample~combout\(12));

\adc_sample[13]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_adc_sample(13),
	combout => \adc_sample~combout\(13));

\adc_sample[14]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_adc_sample(14),
	combout => \adc_sample~combout\(14));

\adc_sample[15]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_adc_sample(15),
	combout => \adc_sample~combout\(15));

\fft_inst|Selector1~1\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector1~1_combout\ = \fft_inst|st.S0_ADVANCE~regout\ # \fft_inst|write_phase~regout\ & \fft_inst|st.S2_WR_PAIR~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fccc",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \fft_inst|st.S0_ADVANCE~regout\,
	datac => \fft_inst|write_phase~regout\,
	datad => \fft_inst|st.S2_WR_PAIR~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector1~1_combout\);

\fft_inst|Selector207~4\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector207~4_combout\ = !\fft_inst|st.S2_WR_PAIR~regout\ & !\fft_inst|st.S0_WR_PAIR~regout\ & \fft_inst|write_phase~regout\ & !\fft_inst|st.S1_WR_PAIR~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|st.S2_WR_PAIR~regout\,
	datab => \fft_inst|st.S0_WR_PAIR~regout\,
	datac => \fft_inst|write_phase~regout\,
	datad => \fft_inst|st.S1_WR_PAIR~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector207~4_combout\);

\fft_inst|Selector9~0\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector9~0_combout\ = !\fft_inst|st.S2_RD_PAIR~regout\ & (!\fft_inst|st.S1_RD_PAIR~regout\ & !\fft_inst|st.S0_RD_PAIR~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0005",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|st.S2_RD_PAIR~regout\,
	datac => \fft_inst|st.S1_RD_PAIR~regout\,
	datad => \fft_inst|st.S0_RD_PAIR~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector9~0_combout\);

\fft_inst|Selector27~1\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector27~1_combout\ = \fft_inst|write_phase~regout\ & !\fft_inst|pair_idx\(1) & \fft_inst|pair_idx\(0) & \fft_inst|st.S1_WR_PAIR~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "2000",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|write_phase~regout\,
	datab => \fft_inst|pair_idx\(1),
	datac => \fft_inst|pair_idx\(0),
	datad => \fft_inst|st.S1_WR_PAIR~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector27~1_combout\);

\clk~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_clk,
	combout => \clk~combout\);

\rst_n~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_rst_n,
	combout => \rst_n~combout\);

\fft_inst|st.S0_WR_PAIR\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|st.S0_WR_PAIR~regout\ = DFFE(\fft_inst|st.S0_CALC~regout\ # \fft_inst|st.S0_WR_PAIR~regout\ & !\fft_inst|write_phase~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aafa",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|st.S0_CALC~regout\,
	datac => \fft_inst|st.S0_WR_PAIR~regout\,
	datad => \fft_inst|write_phase~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|st.S0_WR_PAIR~regout\);

\output_buffer_inst|Equal0~0\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|Equal0~0_combout\ = \output_buffer_inst|idx\(0) & \output_buffer_inst|idx\(1) & \output_buffer_inst|idx\(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c000",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \output_buffer_inst|idx\(0),
	datac => \output_buffer_inst|idx\(1),
	datad => \output_buffer_inst|idx\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output_buffer_inst|Equal0~0_combout\);

\output_buffer_inst|st.IDLE\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|st.IDLE~regout\ = DFFE(\fft_inst|done~regout\ & (!\output_buffer_inst|Equal0~0_combout\ # !\output_buffer_inst|st.READ_OUT~regout\) # !\fft_inst|done~regout\ & \output_buffer_inst|st.IDLE~regout\ & 
-- (!\output_buffer_inst|Equal0~0_combout\ # !\output_buffer_inst|st.READ_OUT~regout\), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0eee",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|done~regout\,
	datab => \output_buffer_inst|st.IDLE~regout\,
	datac => \output_buffer_inst|st.READ_OUT~regout\,
	datad => \output_buffer_inst|Equal0~0_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|st.IDLE~regout\);

\output_buffer_inst|st.SET_ADDR\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|st.SET_ADDR~regout\ = DFFE(\fft_inst|done~regout\ & (\output_buffer_inst|st.READ_OUT~regout\ & !\output_buffer_inst|Equal0~0_combout\ # !\output_buffer_inst|st.IDLE~regout\) # !\fft_inst|done~regout\ & 
-- (\output_buffer_inst|st.READ_OUT~regout\ & !\output_buffer_inst|Equal0~0_combout\), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "22f2",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|done~regout\,
	datab => \output_buffer_inst|st.IDLE~regout\,
	datac => \output_buffer_inst|st.READ_OUT~regout\,
	datad => \output_buffer_inst|Equal0~0_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|st.SET_ADDR~regout\);

\output_buffer_inst|st.READ_OUT\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|st.READ_OUT~regout\ = DFFE(\output_buffer_inst|st.SET_ADDR~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \output_buffer_inst|st.SET_ADDR~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|st.READ_OUT~regout\);

\output_buffer_inst|Selector2~1\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|Selector2~1_combout\ = \output_buffer_inst|st.IDLE~regout\ & (\output_buffer_inst|st.READ_OUT~regout\) # !\output_buffer_inst|st.IDLE~regout\ & (\fft_inst|done~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f5a0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \output_buffer_inst|st.IDLE~regout\,
	datac => \output_buffer_inst|st.READ_OUT~regout\,
	datad => \fft_inst|done~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output_buffer_inst|Selector2~1_combout\);

\output_buffer_inst|idx[0]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|idx\(0) = DFFE(\output_buffer_inst|st.IDLE~regout\ & (\output_buffer_inst|idx\(2) & \output_buffer_inst|idx\(1) # !\output_buffer_inst|idx\(0)), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , 
-- \output_buffer_inst|Selector2~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "80aa",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \output_buffer_inst|st.IDLE~regout\,
	datab => \output_buffer_inst|idx\(2),
	datac => \output_buffer_inst|idx\(1),
	datad => \output_buffer_inst|idx\(0),
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|Selector2~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|idx\(0));

\output_buffer_inst|idx[2]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|idx\(2) = DFFE(\output_buffer_inst|st.IDLE~regout\ & (\output_buffer_inst|idx\(2) # \output_buffer_inst|idx\(1) & \output_buffer_inst|idx\(0)), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \output_buffer_inst|Selector2~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a888",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \output_buffer_inst|st.IDLE~regout\,
	datab => \output_buffer_inst|idx\(2),
	datac => \output_buffer_inst|idx\(1),
	datad => \output_buffer_inst|idx\(0),
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|Selector2~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|idx\(2));

\output_buffer_inst|idx[1]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|idx\(1) = DFFE(\output_buffer_inst|st.IDLE~regout\ & (\output_buffer_inst|idx\(1) & (\output_buffer_inst|idx\(2) # !\output_buffer_inst|idx\(0)) # !\output_buffer_inst|idx\(1) & (\output_buffer_inst|idx\(0))), GLOBAL(\clk~combout\), 
-- GLOBAL(\rst_n~combout\), , \output_buffer_inst|Selector2~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "8aa0",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \output_buffer_inst|st.IDLE~regout\,
	datab => \output_buffer_inst|idx\(2),
	datac => \output_buffer_inst|idx\(1),
	datad => \output_buffer_inst|idx\(0),
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|Selector2~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|idx\(1));

\output_buffer_inst|done_out\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|done_out~regout\ = DFFE(\output_buffer_inst|idx\(0) & \output_buffer_inst|idx\(1) & \output_buffer_inst|idx\(2) & \output_buffer_inst|st.READ_OUT~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "8000",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \output_buffer_inst|idx\(0),
	datab => \output_buffer_inst|idx\(1),
	datac => \output_buffer_inst|idx\(2),
	datad => \output_buffer_inst|st.READ_OUT~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|done_out~regout\);

\phase.PH_OUT\ : apex20ke_lcell
-- Equation(s):
-- \phase.PH_OUT~regout\ = DFFE(\fft_inst|done~regout\ & (\phase.PH_FFT~regout\ # \phase.PH_OUT~regout\ & !\output_buffer_inst|done_out~regout\) # !\fft_inst|done~regout\ & \phase.PH_OUT~regout\ & !\output_buffer_inst|done_out~regout\, GLOBAL(\clk~combout\), 
-- GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ae0c",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|done~regout\,
	datab => \phase.PH_OUT~regout\,
	datac => \output_buffer_inst|done_out~regout\,
	datad => \phase.PH_FFT~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \phase.PH_OUT~regout\);

\adc_valid~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "from_pin",
	operation_mode => "input",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	ena => VCC,
	padio => ww_adc_valid,
	combout => \adc_valid~combout\);

\input_buffer_inst|ram_we~1\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_we~1_combout\ = \adc_valid~combout\ & !\input_buffer_inst|st.WAIT_FFT~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00f0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \adc_valid~combout\,
	datad => \input_buffer_inst|st.WAIT_FFT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \input_buffer_inst|ram_we~1_combout\);

\input_buffer_inst|wr_ptr[0]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|wr_ptr\(0) = DFFE(!\input_buffer_inst|wr_ptr\(0), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \input_buffer_inst|ram_we~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00ff",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \input_buffer_inst|wr_ptr\(0),
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \input_buffer_inst|ram_we~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|wr_ptr\(0));

\input_buffer_inst|wr_ptr[1]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|wr_ptr\(1) = DFFE(\input_buffer_inst|wr_ptr\(1) $ \input_buffer_inst|wr_ptr\(0), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \input_buffer_inst|ram_we~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0ff0",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \input_buffer_inst|wr_ptr\(1),
	datad => \input_buffer_inst|wr_ptr\(0),
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \input_buffer_inst|ram_we~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|wr_ptr\(1));

\input_buffer_inst|wr_ptr[2]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|wr_ptr\(2) = DFFE(\input_buffer_inst|wr_ptr\(2) $ (\input_buffer_inst|wr_ptr\(1) & \input_buffer_inst|wr_ptr\(0)), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \input_buffer_inst|ram_we~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "3ccc",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \input_buffer_inst|wr_ptr\(2),
	datac => \input_buffer_inst|wr_ptr\(1),
	datad => \input_buffer_inst|wr_ptr\(0),
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \input_buffer_inst|ram_we~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|wr_ptr\(2));

\input_buffer_inst|wr_ptr[3]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|wr_ptr\(3) = DFFE(\input_buffer_inst|wr_ptr\(3) $ (\input_buffer_inst|wr_ptr\(0) & \input_buffer_inst|wr_ptr\(1) & \input_buffer_inst|wr_ptr\(2)), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \input_buffer_inst|ram_we~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "6aaa",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \input_buffer_inst|wr_ptr\(3),
	datab => \input_buffer_inst|wr_ptr\(0),
	datac => \input_buffer_inst|wr_ptr\(1),
	datad => \input_buffer_inst|wr_ptr\(2),
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \input_buffer_inst|ram_we~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|wr_ptr\(3));

\input_buffer_inst|st~26\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|st~26_combout\ = \input_buffer_inst|wr_ptr\(0) & \input_buffer_inst|wr_ptr\(1) & \input_buffer_inst|wr_ptr\(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c000",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \input_buffer_inst|wr_ptr\(0),
	datac => \input_buffer_inst|wr_ptr\(1),
	datad => \input_buffer_inst|wr_ptr\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \input_buffer_inst|st~26_combout\);

\input_buffer_inst|Selector25~0\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|Selector25~0_combout\ = \adc_valid~combout\ & \input_buffer_inst|wr_ptr\(3) & !\input_buffer_inst|st.WAIT_FFT~regout\ & \input_buffer_inst|st~26_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0800",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \adc_valid~combout\,
	datab => \input_buffer_inst|wr_ptr\(3),
	datac => \input_buffer_inst|st.WAIT_FFT~regout\,
	datad => \input_buffer_inst|st~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \input_buffer_inst|Selector25~0_combout\);

\input_buffer_inst|st.WAIT_FFT\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|st.WAIT_FFT~regout\ = DFFE(\input_buffer_inst|Selector25~0_combout\ # \input_buffer_inst|st.WAIT_FFT~regout\ & !\fft_inst|done~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff0a",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \input_buffer_inst|st.WAIT_FFT~regout\,
	datac => \fft_inst|done~regout\,
	datad => \input_buffer_inst|Selector25~0_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|st.WAIT_FFT~regout\);

\input_buffer_inst|start_fft\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|start_fft~regout\ = DFFE(\adc_valid~combout\ & !\input_buffer_inst|st.WAIT_FFT~regout\ & \input_buffer_inst|wr_ptr\(3) & \input_buffer_inst|st~26_combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "2000",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \adc_valid~combout\,
	datab => \input_buffer_inst|st.WAIT_FFT~regout\,
	datac => \input_buffer_inst|wr_ptr\(3),
	datad => \input_buffer_inst|st~26_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|start_fft~regout\);

\phase.PH_IN\ : apex20ke_lcell
-- Equation(s):
-- \phase.PH_IN~regout\ = DFFE(\phase.PH_IN~regout\ & (!\output_buffer_inst|done_out~regout\ # !\phase.PH_OUT~regout\) # !\phase.PH_IN~regout\ & \input_buffer_inst|start_fft~regout\ & (!\output_buffer_inst|done_out~regout\ # !\phase.PH_OUT~regout\), 
-- GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "3f2a",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \phase.PH_IN~regout\,
	datab => \phase.PH_OUT~regout\,
	datac => \output_buffer_inst|done_out~regout\,
	datad => \input_buffer_inst|start_fft~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \phase.PH_IN~regout\);

\phase.PH_FFT\ : apex20ke_lcell
-- Equation(s):
-- \phase.PH_FFT~regout\ = DFFE(\input_buffer_inst|start_fft~regout\ & (\phase.PH_FFT~regout\ & !\fft_inst|done~regout\ # !\phase.PH_IN~regout\) # !\input_buffer_inst|start_fft~regout\ & \phase.PH_FFT~regout\ & !\fft_inst|done~regout\, GLOBAL(\clk~combout\), 
-- GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0cae",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \input_buffer_inst|start_fft~regout\,
	datab => \phase.PH_FFT~regout\,
	datac => \fft_inst|done~regout\,
	datad => \phase.PH_IN~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \phase.PH_FFT~regout\);

\fft_inst|st.IDLE\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|st.IDLE~regout\ = DFFE(\input_buffer_inst|start_fft~regout\ & (\phase.PH_FFT~regout\ # !\fft_inst|st.DONE1~regout\ & \fft_inst|st.IDLE~regout\) # !\input_buffer_inst|start_fft~regout\ & !\fft_inst|st.DONE1~regout\ & \fft_inst|st.IDLE~regout\, 
-- GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ba30",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \input_buffer_inst|start_fft~regout\,
	datab => \fft_inst|st.DONE1~regout\,
	datac => \fft_inst|st.IDLE~regout\,
	datad => \phase.PH_FFT~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|st.IDLE~regout\);

\fft_inst|Selector1~5\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector1~5_combout\ = !\fft_inst|st.IDLE~regout\ & (!\phase.PH_FFT~regout\ # !\input_buffer_inst|start_fft~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0333",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \fft_inst|st.IDLE~regout\,
	datac => \input_buffer_inst|start_fft~regout\,
	datad => \phase.PH_FFT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector1~5_combout\);

\fft_inst|Selector2~1\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector2~1_combout\ = \fft_inst|write_phase~regout\ & (\fft_inst|st.S1_WR_PAIR~regout\ # \fft_inst|st.S2_WR_PAIR~regout\ & \fft_inst|pair_idx\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ea00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|st.S1_WR_PAIR~regout\,
	datab => \fft_inst|st.S2_WR_PAIR~regout\,
	datac => \fft_inst|pair_idx\(1),
	datad => \fft_inst|write_phase~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector2~1_combout\);

\fft_inst|Selector1~3\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector1~3_combout\ = !\fft_inst|write_phase~regout\ & (\fft_inst|st.S1_WR_PAIR~regout\ # \fft_inst|st.S2_WR_PAIR~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00fa",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|st.S1_WR_PAIR~regout\,
	datac => \fft_inst|st.S2_WR_PAIR~regout\,
	datad => \fft_inst|write_phase~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector1~3_combout\);

\fft_inst|Selector2~0\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector2~0_combout\ = \fft_inst|pair_idx\(0) & (\fft_inst|Selector1~0_combout\ # \fft_inst|Selector1~3_combout\ # \fft_inst|Selector1~5_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccc8",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|Selector1~0_combout\,
	datab => \fft_inst|pair_idx\(0),
	datac => \fft_inst|Selector1~3_combout\,
	datad => \fft_inst|Selector1~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector2~0_combout\);

\fft_inst|pair_idx[0]\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|pair_idx\(0) = DFFE(\fft_inst|Selector2~0_combout\ # !\fft_inst|pair_idx\(0) & (\fft_inst|st.S0_ADVANCE~regout\ # \fft_inst|Selector2~1_combout\), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff0e",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|st.S0_ADVANCE~regout\,
	datab => \fft_inst|Selector2~1_combout\,
	datac => \fft_inst|pair_idx\(0),
	datad => \fft_inst|Selector2~0_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|pair_idx\(0));

\fft_inst|st.S0_ADVANCE\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|st.S0_ADVANCE~regout\ = DFFE(\fft_inst|write_phase~regout\ & (\fft_inst|st.S0_WR_PAIR~regout\), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cc00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \fft_inst|write_phase~regout\,
	datad => \fft_inst|st.S0_WR_PAIR~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|st.S0_ADVANCE~regout\);

\fft_inst|Selector1~0\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector1~0_combout\ = !\fft_inst|st.S1_WR_PAIR~regout\ & \fft_inst|st.IDLE~regout\ & !\fft_inst|st.S0_ADVANCE~regout\ & !\fft_inst|st.S2_WR_PAIR~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0004",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|st.S1_WR_PAIR~regout\,
	datab => \fft_inst|st.IDLE~regout\,
	datac => \fft_inst|st.S0_ADVANCE~regout\,
	datad => \fft_inst|st.S2_WR_PAIR~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector1~0_combout\);

\fft_inst|Selector1~2\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector1~2_combout\ = \fft_inst|pair_idx\(1) & (\fft_inst|Selector1~0_combout\ # \fft_inst|Selector1~1_combout\ & !\fft_inst|pair_idx\(0)) # !\fft_inst|pair_idx\(1) & \fft_inst|Selector1~1_combout\ & \fft_inst|pair_idx\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ec28",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|Selector1~1_combout\,
	datab => \fft_inst|pair_idx\(1),
	datac => \fft_inst|pair_idx\(0),
	datad => \fft_inst|Selector1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector1~2_combout\);

\fft_inst|Selector1~4\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector1~4_combout\ = \fft_inst|pair_idx\(1) & (\fft_inst|Selector1~3_combout\ # !\fft_inst|pair_idx\(0) & \fft_inst|st.S1_WR_PAIR~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aa20",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|pair_idx\(1),
	datab => \fft_inst|pair_idx\(0),
	datac => \fft_inst|st.S1_WR_PAIR~regout\,
	datad => \fft_inst|Selector1~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector1~4_combout\);

\fft_inst|pair_idx[1]\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|pair_idx\(1) = DFFE(\fft_inst|Selector1~2_combout\ # \fft_inst|Selector1~4_combout\ # \fft_inst|pair_idx\(1) & \fft_inst|Selector1~5_combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fff8",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|pair_idx\(1),
	datab => \fft_inst|Selector1~5_combout\,
	datac => \fft_inst|Selector1~2_combout\,
	datad => \fft_inst|Selector1~4_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|pair_idx\(1));

\fft_inst|Selector23~4\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector23~4_combout\ = \fft_inst|pair_idx\(0) & (\fft_inst|pair_idx\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cc00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \fft_inst|pair_idx\(0),
	datad => \fft_inst|pair_idx\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector23~4_combout\);

\fft_inst|read_phase\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|read_phase~regout\ = DFFE(\fft_inst|read_phase~regout\ & (\fft_inst|Selector1~5_combout\ # \fft_inst|Selector9~0_combout\ & \fft_inst|st.IDLE~regout\) # !\fft_inst|read_phase~regout\ & !\fft_inst|Selector9~0_combout\, GLOBAL(\clk~combout\), 
-- GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f855",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|Selector9~0_combout\,
	datab => \fft_inst|st.IDLE~regout\,
	datac => \fft_inst|Selector1~5_combout\,
	datad => \fft_inst|read_phase~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|read_phase~regout\);

\fft_inst|Selector23~5\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector23~9\ = \fft_inst|st.S1_RD_PAIR~regout\ & \fft_inst|read_phase~regout\ & (!\fft_inst|Selector23~4_combout\ # !\fft_inst|st.S0_ADVANCE~regout\) # !\fft_inst|st.S1_RD_PAIR~regout\ & (!\fft_inst|Selector23~4_combout\ # 
-- !\fft_inst|st.S0_ADVANCE~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "3f15",
	operation_mode => "normal",
	output_mode => "none",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|st.S1_RD_PAIR~regout\,
	datab => \fft_inst|st.S0_ADVANCE~regout\,
	datac => \fft_inst|Selector23~4_combout\,
	datad => \fft_inst|read_phase~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector23~5_combout\,
	cascout => \fft_inst|Selector23~9\);

\fft_inst|Selector23~7\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector23~7_combout\ = (!\fft_inst|pair_idx\(1) & \fft_inst|pair_idx\(0) # !\fft_inst|st.S1_WR_PAIR~regout\ # !\fft_inst|write_phase~regout\) & CASCADE(\fft_inst|Selector23~9\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "75ff",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|write_phase~regout\,
	datab => \fft_inst|pair_idx\(1),
	datac => \fft_inst|pair_idx\(0),
	datad => \fft_inst|st.S1_WR_PAIR~regout\,
	cascin => \fft_inst|Selector23~9\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector23~7_combout\);

\fft_inst|st.S1_RD_PAIR\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|st.S1_RD_PAIR~regout\ = DFFE(!\fft_inst|Selector23~7_combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0f0f",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \fft_inst|Selector23~7_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|st.S1_RD_PAIR~regout\);

\fft_inst|st.S1_CALC\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|st.S1_CALC~regout\ = DFFE(\fft_inst|st.S1_RD_PAIR~regout\ & \fft_inst|read_phase~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \fft_inst|st.S1_RD_PAIR~regout\,
	datad => \fft_inst|read_phase~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|st.S1_CALC~regout\);

\fft_inst|st.S1_BUTTERFLY\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|st.S1_BUTTERFLY~regout\ = DFFE(\fft_inst|st.S1_CALC~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \fft_inst|st.S1_CALC~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|st.S1_BUTTERFLY~regout\);

\fft_inst|st.S1_WR_PAIR\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|st.S1_WR_PAIR~regout\ = DFFE(\fft_inst|st.S1_BUTTERFLY~regout\ # \fft_inst|st.S1_WR_PAIR~regout\ & (!\fft_inst|write_phase~regout\), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccee",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|st.S1_WR_PAIR~regout\,
	datab => \fft_inst|st.S1_BUTTERFLY~regout\,
	datad => \fft_inst|write_phase~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|st.S1_WR_PAIR~regout\);

\fft_inst|Selector27~0\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector27~0_combout\ = \fft_inst|st.S2_WR_PAIR~regout\ & \fft_inst|write_phase~regout\ & (\fft_inst|pair_idx\(1) # \fft_inst|pair_idx\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a080",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|st.S2_WR_PAIR~regout\,
	datab => \fft_inst|pair_idx\(1),
	datac => \fft_inst|write_phase~regout\,
	datad => \fft_inst|pair_idx\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector27~0_combout\);

\fft_inst|st.S2_RD_PAIR\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|st.S2_RD_PAIR~regout\ = DFFE(\fft_inst|Selector27~1_combout\ # \fft_inst|Selector27~0_combout\ # \fft_inst|st.S2_RD_PAIR~regout\ & !\fft_inst|read_phase~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fafe",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|Selector27~1_combout\,
	datab => \fft_inst|st.S2_RD_PAIR~regout\,
	datac => \fft_inst|Selector27~0_combout\,
	datad => \fft_inst|read_phase~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|st.S2_RD_PAIR~regout\);

\fft_inst|st.S2_CALC\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|st.S2_CALC~regout\ = DFFE(\fft_inst|read_phase~regout\ & \fft_inst|st.S2_RD_PAIR~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \fft_inst|read_phase~regout\,
	datad => \fft_inst|st.S2_RD_PAIR~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|st.S2_CALC~regout\);

\fft_inst|st.S2_BUTTERFLY\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|st.S2_BUTTERFLY~regout\ = DFFE(\fft_inst|st.S2_CALC~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \fft_inst|st.S2_CALC~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|st.S2_BUTTERFLY~regout\);

\fft_start~1\ : apex20ke_lcell
-- Equation(s):
-- \fft_start~1_combout\ = \input_buffer_inst|start_fft~regout\ & \phase.PH_FFT~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \input_buffer_inst|start_fft~regout\,
	datad => \phase.PH_FFT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_start~1_combout\);

\fft_inst|Selector19~0\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector19~0_combout\ = \fft_inst|st.IDLE~regout\ & \fft_inst|st.S0_RD_PAIR~regout\ & !\fft_inst|read_phase~regout\ # !\fft_inst|st.IDLE~regout\ & (\fft_start~1_combout\ # \fft_inst|st.S0_RD_PAIR~regout\ & !\fft_inst|read_phase~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "5d0c",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|st.IDLE~regout\,
	datab => \fft_inst|st.S0_RD_PAIR~regout\,
	datac => \fft_inst|read_phase~regout\,
	datad => \fft_start~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector19~0_combout\);

\fft_inst|st.S0_RD_PAIR\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|st.S0_RD_PAIR~regout\ = DFFE(\fft_inst|Selector19~0_combout\ # \fft_inst|st.S0_ADVANCE~regout\ & (!\fft_inst|pair_idx\(0) # !\fft_inst|pair_idx\(1)), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff2a",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|st.S0_ADVANCE~regout\,
	datab => \fft_inst|pair_idx\(1),
	datac => \fft_inst|pair_idx\(0),
	datad => \fft_inst|Selector19~0_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|st.S0_RD_PAIR~regout\);

\fft_inst|st.S0_CALC\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|st.S0_CALC~regout\ = DFFE(\fft_inst|read_phase~regout\ & \fft_inst|st.S0_RD_PAIR~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \fft_inst|read_phase~regout\,
	datad => \fft_inst|st.S0_RD_PAIR~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|st.S0_CALC~regout\);

\fft_inst|Selector207~5\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector207~9\ = \fft_inst|st.S2_BUTTERFLY~regout\ # \fft_inst|st.S1_BUTTERFLY~regout\ # \fft_inst|st.S0_CALC~regout\ # !\fft_inst|Selector207~4_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fffd",
	operation_mode => "normal",
	output_mode => "none",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|Selector207~4_combout\,
	datab => \fft_inst|st.S2_BUTTERFLY~regout\,
	datac => \fft_inst|st.S1_BUTTERFLY~regout\,
	datad => \fft_inst|st.S0_CALC~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector207~5_combout\,
	cascout => \fft_inst|Selector207~9\);

\fft_inst|Selector207~7\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector207~7_combout\ = (\fft_inst|write_phase~regout\ # !\fft_inst|st.S0_WR_PAIR~regout\ & !\fft_inst|st.S1_WR_PAIR~regout\ & !\fft_inst|st.S2_WR_PAIR~regout\) & CASCADE(\fft_inst|Selector207~9\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aaab",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|write_phase~regout\,
	datab => \fft_inst|st.S0_WR_PAIR~regout\,
	datac => \fft_inst|st.S1_WR_PAIR~regout\,
	datad => \fft_inst|st.S2_WR_PAIR~regout\,
	cascin => \fft_inst|Selector207~9\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector207~7_combout\);

\fft_inst|write_phase\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|write_phase~regout\ = DFFE(!\fft_inst|Selector207~7_combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00ff",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \fft_inst|Selector207~7_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|write_phase~regout\);

\fft_inst|st.S2_WR_PAIR\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|st.S2_WR_PAIR~regout\ = DFFE(\fft_inst|st.S2_BUTTERFLY~regout\ # \fft_inst|st.S2_WR_PAIR~regout\ & !\fft_inst|write_phase~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff0a",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|st.S2_WR_PAIR~regout\,
	datac => \fft_inst|write_phase~regout\,
	datad => \fft_inst|st.S2_BUTTERFLY~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|st.S2_WR_PAIR~regout\);

\fft_inst|Selector240~0\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector240~0_combout\ = \fft_inst|write_phase~regout\ & \fft_inst|st.S2_WR_PAIR~regout\ & !\fft_inst|pair_idx\(0) & !\fft_inst|pair_idx\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0008",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|write_phase~regout\,
	datab => \fft_inst|st.S2_WR_PAIR~regout\,
	datac => \fft_inst|pair_idx\(0),
	datad => \fft_inst|pair_idx\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector240~0_combout\);

\fft_inst|st.MAG_RD_PAIR\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|st.MAG_RD_PAIR~regout\ = DFFE(\fft_inst|Selector240~0_combout\ # !\fft_inst|Equal3~0_combout\ & \fft_inst|st.MAG_WR~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff50",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|Equal3~0_combout\,
	datac => \fft_inst|st.MAG_WR~regout\,
	datad => \fft_inst|Selector240~0_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|st.MAG_RD_PAIR~regout\);

\fft_inst|st.MAG_CALC\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|st.MAG_CALC~regout\ = DFFE(\fft_inst|st.MAG_RD_PAIR~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \fft_inst|st.MAG_RD_PAIR~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|st.MAG_CALC~regout\);

\fft_inst|st.MAG_WR\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|st.MAG_WR~regout\ = DFFE(\fft_inst|st.MAG_CALC~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \fft_inst|st.MAG_CALC~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|st.MAG_WR~regout\);

\fft_inst|mag_idx[0]\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|mag_idx\(0) = DFFE(\fft_inst|st.MAG_WR~regout\ & (\fft_inst|mag_idx\(0) $ !\fft_inst|Equal3~0_combout\) # !\fft_inst|st.MAG_WR~regout\ & \fft_inst|mag_idx\(0) & (!\fft_inst|Selector240~0_combout\), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), 
-- , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "84a6",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|mag_idx\(0),
	datab => \fft_inst|st.MAG_WR~regout\,
	datac => \fft_inst|Equal3~0_combout\,
	datad => \fft_inst|Selector240~0_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|mag_idx\(0));

\fft_inst|Selector240~1\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Selector240~1_combout\ = \fft_inst|mag_idx\(2) & (\fft_inst|st.MAG_WR~regout\ # !\fft_inst|Selector240~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c0cc",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \fft_inst|mag_idx\(2),
	datac => \fft_inst|st.MAG_WR~regout\,
	datad => \fft_inst|Selector240~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Selector240~1_combout\);

\fft_inst|mag_idx[2]\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|mag_idx\(2) = DFFE(\fft_inst|Selector240~1_combout\ # \fft_inst|Add17~0_combout\ & \fft_inst|mag_idx\(1) & \fft_inst|st.MAG_WR~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff80",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|Add17~0_combout\,
	datab => \fft_inst|mag_idx\(1),
	datac => \fft_inst|st.MAG_WR~regout\,
	datad => \fft_inst|Selector240~1_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|mag_idx\(2));

\fft_inst|Add17~0\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Add17~0_combout\ = \fft_inst|mag_idx\(0) & (!\fft_inst|mag_idx\(2) # !\fft_inst|mag_idx\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "30f0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \fft_inst|mag_idx\(1),
	datac => \fft_inst|mag_idx\(0),
	datad => \fft_inst|mag_idx\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Add17~0_combout\);

\fft_inst|mag_idx[1]\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|mag_idx\(1) = DFFE(\fft_inst|st.MAG_WR~regout\ & (\fft_inst|mag_idx\(1) $ (\fft_inst|Add17~0_combout\)) # !\fft_inst|st.MAG_WR~regout\ & \fft_inst|mag_idx\(1) & !\fft_inst|Selector240~0_combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , 
-- )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "52a2",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|mag_idx\(1),
	datab => \fft_inst|Selector240~0_combout\,
	datac => \fft_inst|st.MAG_WR~regout\,
	datad => \fft_inst|Add17~0_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|mag_idx\(1));

\fft_inst|Equal3~0\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|Equal3~0_combout\ = \fft_inst|mag_idx\(1) & \fft_inst|mag_idx\(0) & \fft_inst|mag_idx\(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c000",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \fft_inst|mag_idx\(1),
	datac => \fft_inst|mag_idx\(0),
	datad => \fft_inst|mag_idx\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \fft_inst|Equal3~0_combout\);

\fft_inst|st.DONE1\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|st.DONE1~regout\ = DFFE(\fft_inst|st.DONE1~regout\ & (\fft_start~1_combout\ # \fft_inst|Equal3~0_combout\ & \fft_inst|st.MAG_WR~regout\) # !\fft_inst|st.DONE1~regout\ & \fft_inst|Equal3~0_combout\ & \fft_inst|st.MAG_WR~regout\, 
-- GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eac0",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|st.DONE1~regout\,
	datab => \fft_inst|Equal3~0_combout\,
	datac => \fft_inst|st.MAG_WR~regout\,
	datad => \fft_start~1_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|st.DONE1~regout\);

\fft_inst|done\ : apex20ke_lcell
-- Equation(s):
-- \fft_inst|done~regout\ = DFFE(\fft_inst|st.DONE1~regout\ # \fft_inst|st.IDLE~regout\ & \fft_inst|done~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ffa0",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \fft_inst|st.IDLE~regout\,
	datac => \fft_inst|done~regout\,
	datad => \fft_inst|st.DONE1~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \fft_inst|done~regout\);

\input_buffer_inst|st.IDLE\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|st.IDLE~regout\ = DFFE(\adc_valid~combout\ & (!\input_buffer_inst|st.WAIT_FFT~regout\ # !\fft_inst|done~regout\) # !\adc_valid~combout\ & \input_buffer_inst|st.IDLE~regout\ & (!\input_buffer_inst|st.WAIT_FFT~regout\ # 
-- !\fft_inst|done~regout\), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "32fa",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \adc_valid~combout\,
	datab => \fft_inst|done~regout\,
	datac => \input_buffer_inst|st.IDLE~regout\,
	datad => \input_buffer_inst|st.WAIT_FFT~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|st.IDLE~regout\);

\input_buffer_inst|Selector26~2\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|Selector26~2_combout\ = \fft_inst|done~regout\ & (\input_buffer_inst|st.WAIT_FFT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cc00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \fft_inst|done~regout\,
	datad => \input_buffer_inst|st.WAIT_FFT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \input_buffer_inst|Selector26~2_combout\);

\input_buffer_inst|st~25\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|st~25_combout\ = !\input_buffer_inst|wr_ptr\(3) # !\input_buffer_inst|wr_ptr\(2) # !\input_buffer_inst|wr_ptr\(1) # !\input_buffer_inst|wr_ptr\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "7fff",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \input_buffer_inst|wr_ptr\(0),
	datab => \input_buffer_inst|wr_ptr\(1),
	datac => \input_buffer_inst|wr_ptr\(2),
	datad => \input_buffer_inst|wr_ptr\(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \input_buffer_inst|st~25_combout\);

\input_buffer_inst|Selector0~0\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|Selector0~0_combout\ = \input_buffer_inst|st.IDLE~regout\ & (\input_buffer_inst|Selector26~2_combout\) # !\input_buffer_inst|st.IDLE~regout\ & (\input_buffer_inst|st~25_combout\ # !\adc_valid~combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f5b1",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \input_buffer_inst|st.IDLE~regout\,
	datab => \adc_valid~combout\,
	datac => \input_buffer_inst|Selector26~2_combout\,
	datad => \input_buffer_inst|st~25_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \input_buffer_inst|Selector0~0_combout\);

\input_buffer_inst|din_ready\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|din_ready~regout\ = DFFE(\input_buffer_inst|Selector0~0_combout\ # \input_buffer_inst|st.IDLE~regout\ & !\input_buffer_inst|Selector25~0_combout\ & \input_buffer_inst|din_ready~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , 
-- )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff20",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \input_buffer_inst|st.IDLE~regout\,
	datab => \input_buffer_inst|Selector25~0_combout\,
	datac => \input_buffer_inst|din_ready~regout\,
	datad => \input_buffer_inst|Selector0~0_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|din_ready~regout\);

\input_buffer_inst|ram_we\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_we~regout\ = DFFE(\adc_valid~combout\ & !\input_buffer_inst|st.WAIT_FFT~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00f0",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \adc_valid~combout\,
	datad => \input_buffer_inst|st.WAIT_FFT~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_we~regout\);

\ram_we_a~1\ : apex20ke_lcell
-- Equation(s):
-- \ram_we_a~1_combout\ = !\phase.PH_IN~regout\ & \input_buffer_inst|ram_we~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0f00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \phase.PH_IN~regout\,
	datad => \input_buffer_inst|ram_we~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_we_a~1_combout\);

\input_buffer_inst|ram_dout[0]~16\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_dout[0]~16_combout\ = \adc_valid~combout\ & (\rst_n~combout\ & !\input_buffer_inst|st.WAIT_FFT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00a0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \adc_valid~combout\,
	datac => \rst_n~combout\,
	datad => \input_buffer_inst|st.WAIT_FFT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \input_buffer_inst|ram_dout[0]~16_combout\);

\input_buffer_inst|ram_addr[0]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_addr\(0) = DFFE(\input_buffer_inst|wr_ptr\(0), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \input_buffer_inst|wr_ptr\(0),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_addr\(0));

\Selector6~1\ : apex20ke_lcell
-- Equation(s):
-- \Selector6~1_combout\ = \input_buffer_inst|ram_addr\(0) & !\phase.PH_IN~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00f0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \input_buffer_inst|ram_addr\(0),
	datad => \phase.PH_IN~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Selector6~1_combout\);

\input_buffer_inst|ram_addr[1]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_addr\(1) = DFFE(\input_buffer_inst|wr_ptr\(3), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \input_buffer_inst|wr_ptr\(3),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_addr\(1));

\Selector5~0\ : apex20ke_lcell
-- Equation(s):
-- \Selector5~0_combout\ = \phase.PH_IN~regout\ & \output_buffer_inst|idx\(0) & (\phase.PH_OUT~regout\) # !\phase.PH_IN~regout\ & (\input_buffer_inst|ram_addr\(1) # \output_buffer_inst|idx\(0) & \phase.PH_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "dc50",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \phase.PH_IN~regout\,
	datab => \output_buffer_inst|idx\(0),
	datac => \input_buffer_inst|ram_addr\(1),
	datad => \phase.PH_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Selector5~0_combout\);

\input_buffer_inst|ram_addr[2]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_addr\(2) = DFFE(\input_buffer_inst|wr_ptr\(2), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \input_buffer_inst|wr_ptr\(2),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_addr\(2));

\Selector4~0\ : apex20ke_lcell
-- Equation(s):
-- \Selector4~0_combout\ = \phase.PH_IN~regout\ & \output_buffer_inst|idx\(1) & (\phase.PH_OUT~regout\) # !\phase.PH_IN~regout\ & (\input_buffer_inst|ram_addr\(2) # \output_buffer_inst|idx\(1) & \phase.PH_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "dc50",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \phase.PH_IN~regout\,
	datab => \output_buffer_inst|idx\(1),
	datac => \input_buffer_inst|ram_addr\(2),
	datad => \phase.PH_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Selector4~0_combout\);

\input_buffer_inst|ram_addr[3]\ : apex20ke_lcell
-- Equation(s):
-- \input_buffer_inst|ram_addr\(3) = DFFE(\input_buffer_inst|wr_ptr\(1), GLOBAL(\clk~combout\), , , \input_buffer_inst|ram_dout[0]~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \input_buffer_inst|wr_ptr\(1),
	clk => \clk~combout\,
	ena => \input_buffer_inst|ram_dout[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \input_buffer_inst|ram_addr\(3));

\Selector3~0\ : apex20ke_lcell
-- Equation(s):
-- \Selector3~0_combout\ = \phase.PH_IN~regout\ & \output_buffer_inst|idx\(2) & (\phase.PH_OUT~regout\) # !\phase.PH_IN~regout\ & (\input_buffer_inst|ram_addr\(3) # \output_buffer_inst|idx\(2) & \phase.PH_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "dc50",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \phase.PH_IN~regout\,
	datab => \output_buffer_inst|idx\(2),
	datac => \input_buffer_inst|ram_addr\(3),
	datad => \phase.PH_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Selector3~0_combout\);

\ram_inst|mem_rtl_0|segment[0][0]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	address_width => 4,
	bit_number => 0,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "none",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_dp_optimized:ram_inst|altdpram:mem_rtl_0|content",
	logical_ram_width => 16,
	operation_mode => "dual_port",
	read_address_clear => "none",
	read_address_clock => "none",
	read_enable_clear => "none",
	read_enable_clock => "none",
	write_logic_clear => "none",
	write_logic_clock => "clock0")
-- pragma translate_on
PORT MAP (
	datain => \ram_din_a[0]~0_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we_a~1_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][0]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][0]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][0]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][0]~dataout\);

\output_buffer_inst|dout_reg[0]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|dout_reg\(0) = DFFE(\ram_inst|mem_rtl_0|segment[0][0]~dataout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \output_buffer_inst|st.READ_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \ram_inst|mem_rtl_0|segment[0][0]~dataout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|st.READ_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|dout_reg\(0));

\ram_inst|mem_rtl_0|segment[0][1]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	address_width => 4,
	bit_number => 1,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "none",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_dp_optimized:ram_inst|altdpram:mem_rtl_0|content",
	logical_ram_width => 16,
	operation_mode => "dual_port",
	read_address_clear => "none",
	read_address_clock => "none",
	read_enable_clear => "none",
	read_enable_clock => "none",
	write_logic_clear => "none",
	write_logic_clock => "clock0")
-- pragma translate_on
PORT MAP (
	datain => \ram_din_a[1]~1_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we_a~1_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][1]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][1]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][1]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][1]~dataout\);

\output_buffer_inst|dout_reg[1]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|dout_reg\(1) = DFFE(\ram_inst|mem_rtl_0|segment[0][1]~dataout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \output_buffer_inst|st.READ_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \ram_inst|mem_rtl_0|segment[0][1]~dataout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|st.READ_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|dout_reg\(1));

\ram_inst|mem_rtl_0|segment[0][2]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	address_width => 4,
	bit_number => 2,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "none",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_dp_optimized:ram_inst|altdpram:mem_rtl_0|content",
	logical_ram_width => 16,
	operation_mode => "dual_port",
	read_address_clear => "none",
	read_address_clock => "none",
	read_enable_clear => "none",
	read_enable_clock => "none",
	write_logic_clear => "none",
	write_logic_clock => "clock0")
-- pragma translate_on
PORT MAP (
	datain => \ram_din_a[2]~2_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we_a~1_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][2]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][2]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][2]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][2]~dataout\);

\output_buffer_inst|dout_reg[2]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|dout_reg\(2) = DFFE(\ram_inst|mem_rtl_0|segment[0][2]~dataout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \output_buffer_inst|st.READ_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \ram_inst|mem_rtl_0|segment[0][2]~dataout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|st.READ_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|dout_reg\(2));

\ram_inst|mem_rtl_0|segment[0][3]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	address_width => 4,
	bit_number => 3,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "none",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_dp_optimized:ram_inst|altdpram:mem_rtl_0|content",
	logical_ram_width => 16,
	operation_mode => "dual_port",
	read_address_clear => "none",
	read_address_clock => "none",
	read_enable_clear => "none",
	read_enable_clock => "none",
	write_logic_clear => "none",
	write_logic_clock => "clock0")
-- pragma translate_on
PORT MAP (
	datain => \ram_din_a[3]~3_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we_a~1_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][3]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][3]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][3]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][3]~dataout\);

\output_buffer_inst|dout_reg[3]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|dout_reg\(3) = DFFE(\ram_inst|mem_rtl_0|segment[0][3]~dataout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \output_buffer_inst|st.READ_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \ram_inst|mem_rtl_0|segment[0][3]~dataout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|st.READ_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|dout_reg\(3));

\ram_inst|mem_rtl_0|segment[0][4]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	address_width => 4,
	bit_number => 4,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "none",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_dp_optimized:ram_inst|altdpram:mem_rtl_0|content",
	logical_ram_width => 16,
	operation_mode => "dual_port",
	read_address_clear => "none",
	read_address_clock => "none",
	read_enable_clear => "none",
	read_enable_clock => "none",
	write_logic_clear => "none",
	write_logic_clock => "clock0")
-- pragma translate_on
PORT MAP (
	datain => \ram_din_a[4]~4_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we_a~1_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][4]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][4]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][4]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][4]~dataout\);

\output_buffer_inst|dout_reg[4]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|dout_reg\(4) = DFFE(\ram_inst|mem_rtl_0|segment[0][4]~dataout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \output_buffer_inst|st.READ_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \ram_inst|mem_rtl_0|segment[0][4]~dataout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|st.READ_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|dout_reg\(4));

\ram_inst|mem_rtl_0|segment[0][5]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	address_width => 4,
	bit_number => 5,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "none",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_dp_optimized:ram_inst|altdpram:mem_rtl_0|content",
	logical_ram_width => 16,
	operation_mode => "dual_port",
	read_address_clear => "none",
	read_address_clock => "none",
	read_enable_clear => "none",
	read_enable_clock => "none",
	write_logic_clear => "none",
	write_logic_clock => "clock0")
-- pragma translate_on
PORT MAP (
	datain => \ram_din_a[5]~5_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we_a~1_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][5]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][5]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][5]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][5]~dataout\);

\output_buffer_inst|dout_reg[5]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|dout_reg\(5) = DFFE(\ram_inst|mem_rtl_0|segment[0][5]~dataout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \output_buffer_inst|st.READ_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \ram_inst|mem_rtl_0|segment[0][5]~dataout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|st.READ_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|dout_reg\(5));

\ram_inst|mem_rtl_0|segment[0][6]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	address_width => 4,
	bit_number => 6,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "none",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_dp_optimized:ram_inst|altdpram:mem_rtl_0|content",
	logical_ram_width => 16,
	operation_mode => "dual_port",
	read_address_clear => "none",
	read_address_clock => "none",
	read_enable_clear => "none",
	read_enable_clock => "none",
	write_logic_clear => "none",
	write_logic_clock => "clock0")
-- pragma translate_on
PORT MAP (
	datain => \ram_din_a[6]~6_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we_a~1_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][6]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][6]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][6]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][6]~dataout\);

\output_buffer_inst|dout_reg[6]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|dout_reg\(6) = DFFE(\ram_inst|mem_rtl_0|segment[0][6]~dataout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \output_buffer_inst|st.READ_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \ram_inst|mem_rtl_0|segment[0][6]~dataout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|st.READ_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|dout_reg\(6));

\ram_inst|mem_rtl_0|segment[0][7]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	address_width => 4,
	bit_number => 7,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "none",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_dp_optimized:ram_inst|altdpram:mem_rtl_0|content",
	logical_ram_width => 16,
	operation_mode => "dual_port",
	read_address_clear => "none",
	read_address_clock => "none",
	read_enable_clear => "none",
	read_enable_clock => "none",
	write_logic_clear => "none",
	write_logic_clock => "clock0")
-- pragma translate_on
PORT MAP (
	datain => \ram_din_a[7]~7_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we_a~1_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][7]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][7]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][7]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][7]~dataout\);

\output_buffer_inst|dout_reg[7]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|dout_reg\(7) = DFFE(\ram_inst|mem_rtl_0|segment[0][7]~dataout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \output_buffer_inst|st.READ_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \ram_inst|mem_rtl_0|segment[0][7]~dataout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|st.READ_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|dout_reg\(7));

\ram_inst|mem_rtl_0|segment[0][8]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	address_width => 4,
	bit_number => 8,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "none",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_dp_optimized:ram_inst|altdpram:mem_rtl_0|content",
	logical_ram_width => 16,
	operation_mode => "dual_port",
	read_address_clear => "none",
	read_address_clock => "none",
	read_enable_clear => "none",
	read_enable_clock => "none",
	write_logic_clear => "none",
	write_logic_clock => "clock0")
-- pragma translate_on
PORT MAP (
	datain => \ram_din_a[8]~8_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we_a~1_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][8]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][8]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][8]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][8]~dataout\);

\output_buffer_inst|dout_reg[8]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|dout_reg\(8) = DFFE(\ram_inst|mem_rtl_0|segment[0][8]~dataout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \output_buffer_inst|st.READ_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \ram_inst|mem_rtl_0|segment[0][8]~dataout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|st.READ_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|dout_reg\(8));

\ram_inst|mem_rtl_0|segment[0][9]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	address_width => 4,
	bit_number => 9,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "none",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_dp_optimized:ram_inst|altdpram:mem_rtl_0|content",
	logical_ram_width => 16,
	operation_mode => "dual_port",
	read_address_clear => "none",
	read_address_clock => "none",
	read_enable_clear => "none",
	read_enable_clock => "none",
	write_logic_clear => "none",
	write_logic_clock => "clock0")
-- pragma translate_on
PORT MAP (
	datain => \ram_din_a[9]~9_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we_a~1_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][9]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][9]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][9]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][9]~dataout\);

\output_buffer_inst|dout_reg[9]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|dout_reg\(9) = DFFE(\ram_inst|mem_rtl_0|segment[0][9]~dataout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \output_buffer_inst|st.READ_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \ram_inst|mem_rtl_0|segment[0][9]~dataout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|st.READ_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|dout_reg\(9));

\ram_inst|mem_rtl_0|segment[0][10]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	address_width => 4,
	bit_number => 10,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "none",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_dp_optimized:ram_inst|altdpram:mem_rtl_0|content",
	logical_ram_width => 16,
	operation_mode => "dual_port",
	read_address_clear => "none",
	read_address_clock => "none",
	read_enable_clear => "none",
	read_enable_clock => "none",
	write_logic_clear => "none",
	write_logic_clock => "clock0")
-- pragma translate_on
PORT MAP (
	datain => \ram_din_a[10]~10_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we_a~1_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][10]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][10]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][10]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][10]~dataout\);

\output_buffer_inst|dout_reg[10]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|dout_reg\(10) = DFFE(\ram_inst|mem_rtl_0|segment[0][10]~dataout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \output_buffer_inst|st.READ_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \ram_inst|mem_rtl_0|segment[0][10]~dataout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|st.READ_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|dout_reg\(10));

\ram_inst|mem_rtl_0|segment[0][11]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	address_width => 4,
	bit_number => 11,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "none",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_dp_optimized:ram_inst|altdpram:mem_rtl_0|content",
	logical_ram_width => 16,
	operation_mode => "dual_port",
	read_address_clear => "none",
	read_address_clock => "none",
	read_enable_clear => "none",
	read_enable_clock => "none",
	write_logic_clear => "none",
	write_logic_clock => "clock0")
-- pragma translate_on
PORT MAP (
	datain => \ram_din_a[11]~11_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we_a~1_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][11]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][11]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][11]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][11]~dataout\);

\output_buffer_inst|dout_reg[11]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|dout_reg\(11) = DFFE(\ram_inst|mem_rtl_0|segment[0][11]~dataout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \output_buffer_inst|st.READ_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \ram_inst|mem_rtl_0|segment[0][11]~dataout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|st.READ_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|dout_reg\(11));

\ram_inst|mem_rtl_0|segment[0][12]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	address_width => 4,
	bit_number => 12,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "none",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_dp_optimized:ram_inst|altdpram:mem_rtl_0|content",
	logical_ram_width => 16,
	operation_mode => "dual_port",
	read_address_clear => "none",
	read_address_clock => "none",
	read_enable_clear => "none",
	read_enable_clock => "none",
	write_logic_clear => "none",
	write_logic_clock => "clock0")
-- pragma translate_on
PORT MAP (
	datain => \ram_din_a[12]~12_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we_a~1_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][12]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][12]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][12]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][12]~dataout\);

\output_buffer_inst|dout_reg[12]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|dout_reg\(12) = DFFE(\ram_inst|mem_rtl_0|segment[0][12]~dataout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \output_buffer_inst|st.READ_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \ram_inst|mem_rtl_0|segment[0][12]~dataout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|st.READ_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|dout_reg\(12));

\ram_inst|mem_rtl_0|segment[0][13]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	address_width => 4,
	bit_number => 13,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "none",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_dp_optimized:ram_inst|altdpram:mem_rtl_0|content",
	logical_ram_width => 16,
	operation_mode => "dual_port",
	read_address_clear => "none",
	read_address_clock => "none",
	read_enable_clear => "none",
	read_enable_clock => "none",
	write_logic_clear => "none",
	write_logic_clock => "clock0")
-- pragma translate_on
PORT MAP (
	datain => \ram_din_a[13]~13_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we_a~1_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][13]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][13]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][13]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][13]~dataout\);

\output_buffer_inst|dout_reg[13]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|dout_reg\(13) = DFFE(\ram_inst|mem_rtl_0|segment[0][13]~dataout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \output_buffer_inst|st.READ_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \ram_inst|mem_rtl_0|segment[0][13]~dataout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|st.READ_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|dout_reg\(13));

\ram_inst|mem_rtl_0|segment[0][14]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	address_width => 4,
	bit_number => 14,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "none",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_dp_optimized:ram_inst|altdpram:mem_rtl_0|content",
	logical_ram_width => 16,
	operation_mode => "dual_port",
	read_address_clear => "none",
	read_address_clock => "none",
	read_enable_clear => "none",
	read_enable_clock => "none",
	write_logic_clear => "none",
	write_logic_clock => "clock0")
-- pragma translate_on
PORT MAP (
	datain => \ram_din_a[14]~14_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we_a~1_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][14]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][14]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][14]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][14]~dataout\);

\output_buffer_inst|dout_reg[14]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|dout_reg\(14) = DFFE(\ram_inst|mem_rtl_0|segment[0][14]~dataout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \output_buffer_inst|st.READ_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \ram_inst|mem_rtl_0|segment[0][14]~dataout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|st.READ_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|dout_reg\(14));

\ram_inst|mem_rtl_0|segment[0][15]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	address_width => 4,
	bit_number => 15,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "none",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_dp_optimized:ram_inst|altdpram:mem_rtl_0|content",
	logical_ram_width => 16,
	operation_mode => "dual_port",
	read_address_clear => "none",
	read_address_clock => "none",
	read_enable_clear => "none",
	read_enable_clock => "none",
	write_logic_clear => "none",
	write_logic_clock => "clock0")
-- pragma translate_on
PORT MAP (
	datain => \ram_din_a[15]~15_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we_a~1_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][15]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][15]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][15]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][15]~dataout\);

\output_buffer_inst|dout_reg[15]\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|dout_reg\(15) = DFFE(\ram_inst|mem_rtl_0|segment[0][15]~dataout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \output_buffer_inst|st.READ_OUT~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \ram_inst|mem_rtl_0|segment[0][15]~dataout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \output_buffer_inst|st.READ_OUT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|dout_reg\(15));

\output_buffer_inst|dout_valid\ : apex20ke_lcell
-- Equation(s):
-- \output_buffer_inst|dout_valid~regout\ = DFFE(\output_buffer_inst|st.READ_OUT~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \output_buffer_inst|st.READ_OUT~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output_buffer_inst|dout_valid~regout\);

\adc_ready~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \input_buffer_inst|din_ready~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_adc_ready);

\dout[0]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \output_buffer_inst|dout_reg\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout(0));

\dout[1]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \output_buffer_inst|dout_reg\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout(1));

\dout[2]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \output_buffer_inst|dout_reg\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout(2));

\dout[3]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \output_buffer_inst|dout_reg\(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout(3));

\dout[4]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \output_buffer_inst|dout_reg\(4),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout(4));

\dout[5]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \output_buffer_inst|dout_reg\(5),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout(5));

\dout[6]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \output_buffer_inst|dout_reg\(6),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout(6));

\dout[7]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \output_buffer_inst|dout_reg\(7),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout(7));

\dout[8]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \output_buffer_inst|dout_reg\(8),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout(8));

\dout[9]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \output_buffer_inst|dout_reg\(9),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout(9));

\dout[10]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \output_buffer_inst|dout_reg\(10),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout(10));

\dout[11]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \output_buffer_inst|dout_reg\(11),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout(11));

\dout[12]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \output_buffer_inst|dout_reg\(12),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout(12));

\dout[13]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \output_buffer_inst|dout_reg\(13),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout(13));

\dout[14]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \output_buffer_inst|dout_reg\(14),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout(14));

\dout[15]~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \output_buffer_inst|dout_reg\(15),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout(15));

\dout_valid~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \output_buffer_inst|dout_valid~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout_valid);
END structure;


