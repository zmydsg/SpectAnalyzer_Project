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

-- DATE "06/22/2025 16:20:53"

-- 
-- Device: Altera EP20K200EFC672-1 Package FBGA672
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY IEEE, apex20ke;
USE IEEE.std_logic_1164.all;
USE apex20ke.apex20ke_components.all;

ENTITY 	SpectAnalyzer_top IS
    PORT (
	clk : IN std_logic;
	rst_n : IN std_logic;
	adc_sample : IN std_logic_vector(15 DOWNTO 0);
	adc_valid : IN std_logic;
	adc_ready : OUT std_logic;
	dout : OUT std_logic_vector(15 DOWNTO 0);
	dout_valid : OUT std_logic
	);
END SpectAnalyzer_top;

ARCHITECTURE structure OF SpectAnalyzer_top IS
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
SIGNAL \u_in|st.IDLE~regout\ : std_logic;
SIGNAL \u_in|Selector21~0_combout\ : std_logic;
SIGNAL \u_fft|Selector40~2_combout\ : std_logic;
SIGNAL \u_fft|Selector39~2_combout\ : std_logic;
SIGNAL \u_fft|Selector38~2_combout\ : std_logic;
SIGNAL \u_fft|dn_im[6]~28\ : std_logic;
SIGNAL \u_fft|dn_im[7]~30\ : std_logic;
SIGNAL \u_fft|dn_im[8]~32\ : std_logic;
SIGNAL \u_fft|Selector33~2_combout\ : std_logic;
SIGNAL \u_fft|dn_im[9]~34\ : std_logic;
SIGNAL \u_fft|Selector32~2_combout\ : std_logic;
SIGNAL \u_fft|dn_im[10]~36\ : std_logic;
SIGNAL \u_fft|dn_im[11]~38\ : std_logic;
SIGNAL \u_fft|Selector30~2_combout\ : std_logic;
SIGNAL \u_fft|dn_im[12]~40\ : std_logic;
SIGNAL \u_fft|Selector29~2_combout\ : std_logic;
SIGNAL \u_fft|dn_im[13]~42\ : std_logic;
SIGNAL \u_fft|Selector28~2_combout\ : std_logic;
SIGNAL \u_fft|dn_im[14]~44\ : std_logic;
SIGNAL \u_fft|bot_cpx[0]~7_combout\ : std_logic;
SIGNAL \u_fft|up_re[1]~47COMB\ : std_logic;
SIGNAL \u_fft|up_im[1]~46COMB\ : std_logic;
SIGNAL \adc_valid~combout\ : std_logic;
SIGNAL \clk~combout\ : std_logic;
SIGNAL \rst_n~combout\ : std_logic;
SIGNAL \u_in|st.WAIT_1~regout\ : std_logic;
SIGNAL \u_in|st.WAIT_FFT~regout\ : std_logic;
SIGNAL \u_in|dout_int~16_combout\ : std_logic;
SIGNAL \u_in|Add0~2_combout\ : std_logic;
SIGNAL \u_in|Add0~1_combout\ : std_logic;
SIGNAL \u_in|Add0~0_combout\ : std_logic;
SIGNAL \u_in|Equal0~0_combout\ : std_logic;
SIGNAL \u_in|st.WRITE~regout\ : std_logic;
SIGNAL \u_in|din_ready~regout\ : std_logic;
SIGNAL \u_in|start_fft~regout\ : std_logic;
SIGNAL \u_fft|st.S0_WR_TOP_RE~regout\ : std_logic;
SIGNAL \u_fft|st.S0_WR_TOP_IM~regout\ : std_logic;
SIGNAL \u_fft|st.S0_WR_BOT_RE~regout\ : std_logic;
SIGNAL \u_fft|WideOr18~5_combout\ : std_logic;
SIGNAL \u_fft|WideOr17~6_combout\ : std_logic;
SIGNAL \u_fft|WideNor0~combout\ : std_logic;
SIGNAL \u_fft|st.IDLE~regout\ : std_logic;
SIGNAL \u_fft|st.S0_WR_BOT_IM~regout\ : std_logic;
SIGNAL \u_fft|Selector1~1_combout\ : std_logic;
SIGNAL \u_fft|Equal0~0_combout\ : std_logic;
SIGNAL \u_fft|st.S0_RD_TOP_RE~regout\ : std_logic;
SIGNAL \u_fft|st.S0_RD_TOP_IM~regout\ : std_logic;
SIGNAL \u_fft|st.S0_RD_BOT_RE~regout\ : std_logic;
SIGNAL \u_fft|st.S0_RD_BOT_IM~regout\ : std_logic;
SIGNAL \u_fft|st.S0_CALC~regout\ : std_logic;
SIGNAL \u_fft|a_re[0]~18_combout\ : std_logic;
SIGNAL \u_fft|up_re[0]~46_combout\ : std_logic;
SIGNAL \u_fft|b_im[0]~18_combout\ : std_logic;
SIGNAL \u_fft|Selector41~1_combout\ : std_logic;
SIGNAL \u_fft|Selector41~2_combout\ : std_logic;
SIGNAL \u_fft|WideOr17~combout\ : std_logic;
SIGNAL \u_in|dout_int[0]~17_combout\ : std_logic;
SIGNAL \phase.PH_FFT~regout\ : std_logic;
SIGNAL \ram_dout[0]~16_combout\ : std_logic;
SIGNAL \u_fft|we_int~regout\ : std_logic;
SIGNAL \u_in|we_int~regout\ : std_logic;
SIGNAL \ram_we~4_combout\ : std_logic;
SIGNAL \u_fft|WideOr5~combout\ : std_logic;
SIGNAL \u_fft|Selector11~0_combout\ : std_logic;
SIGNAL \ram_addr[0]~4_combout\ : std_logic;
SIGNAL \u_fft|bot_cpx[0]~6_combout\ : std_logic;
SIGNAL \u_fft|Selector8~0_combout\ : std_logic;
SIGNAL \u_fft|Selector10~0_combout\ : std_logic;
SIGNAL \u_fft|Selector10~1_combout\ : std_logic;
SIGNAL \u_fft|Selector10~2_combout\ : std_logic;
SIGNAL \u_fft|Selector10~3_combout\ : std_logic;
SIGNAL \ram_addr[1]~5_combout\ : std_logic;
SIGNAL \u_fft|Selector0~0_combout\ : std_logic;
SIGNAL \u_fft|bot_cpx[1]~9_combout\ : std_logic;
SIGNAL \u_fft|Selector9~0_combout\ : std_logic;
SIGNAL \u_fft|Selector9~1_combout\ : std_logic;
SIGNAL \u_fft|Selector9~2_combout\ : std_logic;
SIGNAL \ram_addr[2]~6_combout\ : std_logic;
SIGNAL \u_fft|WideOr1~0_combout\ : std_logic;
SIGNAL \u_fft|Selector8~1_combout\ : std_logic;
SIGNAL \ram_addr[3]~7_combout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][0]~dataout\ : std_logic;
SIGNAL \u_fft|b_re[0]~18_combout\ : std_logic;
SIGNAL \u_fft|dn_re[0]~16\ : std_logic;
SIGNAL \u_fft|up_re[1]~48_cout\ : std_logic;
SIGNAL \u_fft|Selector40~1_combout\ : std_logic;
SIGNAL \ram_dout[1]~17_combout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][1]~dataout\ : std_logic;
SIGNAL \u_fft|dn_re[1]~18\ : std_logic;
SIGNAL \u_fft|Selector39~1_combout\ : std_logic;
SIGNAL \ram_dout[2]~18_combout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][2]~dataout\ : std_logic;
SIGNAL \u_fft|dn_re[2]~20\ : std_logic;
SIGNAL \u_fft|Selector38~1_combout\ : std_logic;
SIGNAL \ram_dout[3]~19_combout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][3]~dataout\ : std_logic;
SIGNAL \u_fft|dn_im[0]~16\ : std_logic;
SIGNAL \u_fft|dn_im[1]~18\ : std_logic;
SIGNAL \u_fft|dn_im[2]~20\ : std_logic;
SIGNAL \u_fft|dn_im[3]~22\ : std_logic;
SIGNAL \u_fft|up_im[1]~47_cout\ : std_logic;
SIGNAL \u_fft|up_im[1]~16\ : std_logic;
SIGNAL \u_fft|up_im[2]~18\ : std_logic;
SIGNAL \u_fft|up_im[3]~20\ : std_logic;
SIGNAL \u_fft|Selector37~2_combout\ : std_logic;
SIGNAL \u_fft|dn_re[3]~22\ : std_logic;
SIGNAL \u_fft|Selector37~1_combout\ : std_logic;
SIGNAL \ram_dout[4]~20_combout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][4]~dataout\ : std_logic;
SIGNAL \u_fft|a_im[0]~18_combout\ : std_logic;
SIGNAL \u_fft|dn_im[4]~24\ : std_logic;
SIGNAL \u_fft|up_im[4]~22\ : std_logic;
SIGNAL \u_fft|Selector36~2_combout\ : std_logic;
SIGNAL \u_fft|dn_re[4]~24\ : std_logic;
SIGNAL \u_fft|Selector36~1_combout\ : std_logic;
SIGNAL \ram_dout[5]~21_combout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][5]~dataout\ : std_logic;
SIGNAL \u_fft|up_re[1]~16\ : std_logic;
SIGNAL \u_fft|up_re[2]~18\ : std_logic;
SIGNAL \u_fft|up_re[3]~20\ : std_logic;
SIGNAL \u_fft|up_re[4]~22\ : std_logic;
SIGNAL \u_fft|up_re[5]~24\ : std_logic;
SIGNAL \u_fft|dn_re[5]~26\ : std_logic;
SIGNAL \u_fft|Selector35~1_combout\ : std_logic;
SIGNAL \u_fft|up_im[5]~24\ : std_logic;
SIGNAL \u_fft|dn_im[5]~26\ : std_logic;
SIGNAL \u_fft|Selector35~2_combout\ : std_logic;
SIGNAL \ram_dout[6]~22_combout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][6]~dataout\ : std_logic;
SIGNAL \u_fft|dn_re[6]~28\ : std_logic;
SIGNAL \u_fft|up_re[6]~26\ : std_logic;
SIGNAL \u_fft|Selector34~1_combout\ : std_logic;
SIGNAL \u_fft|up_im[6]~26\ : std_logic;
SIGNAL \u_fft|Selector34~2_combout\ : std_logic;
SIGNAL \ram_dout[7]~23_combout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][7]~dataout\ : std_logic;
SIGNAL \u_fft|dn_re[7]~30\ : std_logic;
SIGNAL \u_fft|up_re[7]~28\ : std_logic;
SIGNAL \u_fft|Selector33~1_combout\ : std_logic;
SIGNAL \ram_dout[8]~24_combout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][8]~dataout\ : std_logic;
SIGNAL \u_fft|up_re[8]~30\ : std_logic;
SIGNAL \u_fft|Selector32~1_combout\ : std_logic;
SIGNAL \ram_dout[9]~25_combout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][9]~dataout\ : std_logic;
SIGNAL \u_fft|dn_re[8]~32\ : std_logic;
SIGNAL \u_fft|dn_re[9]~34\ : std_logic;
SIGNAL \u_fft|Selector31~1_combout\ : std_logic;
SIGNAL \u_fft|up_im[7]~28\ : std_logic;
SIGNAL \u_fft|up_im[8]~30\ : std_logic;
SIGNAL \u_fft|up_im[9]~32\ : std_logic;
SIGNAL \u_fft|Selector31~2_combout\ : std_logic;
SIGNAL \ram_dout[10]~26_combout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][10]~dataout\ : std_logic;
SIGNAL \u_fft|dn_re[10]~36\ : std_logic;
SIGNAL \u_fft|Selector30~1_combout\ : std_logic;
SIGNAL \ram_dout[11]~27_combout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][11]~dataout\ : std_logic;
SIGNAL \u_fft|up_re[9]~32\ : std_logic;
SIGNAL \u_fft|up_re[10]~34\ : std_logic;
SIGNAL \u_fft|up_re[11]~36\ : std_logic;
SIGNAL \u_fft|dn_re[11]~38\ : std_logic;
SIGNAL \u_fft|Selector29~1_combout\ : std_logic;
SIGNAL \ram_dout[12]~28_combout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][12]~dataout\ : std_logic;
SIGNAL \u_fft|dn_re[12]~40\ : std_logic;
SIGNAL \u_fft|up_re[12]~38\ : std_logic;
SIGNAL \u_fft|Selector28~1_combout\ : std_logic;
SIGNAL \ram_dout[13]~29_combout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][13]~dataout\ : std_logic;
SIGNAL \u_fft|up_im[10]~34\ : std_logic;
SIGNAL \u_fft|up_im[11]~36\ : std_logic;
SIGNAL \u_fft|up_im[12]~38\ : std_logic;
SIGNAL \u_fft|up_im[13]~40\ : std_logic;
SIGNAL \u_fft|Selector27~2_combout\ : std_logic;
SIGNAL \u_fft|dn_re[13]~42\ : std_logic;
SIGNAL \u_fft|up_re[13]~40\ : std_logic;
SIGNAL \u_fft|Selector27~1_combout\ : std_logic;
SIGNAL \ram_dout[14]~30_combout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][14]~dataout\ : std_logic;
SIGNAL \u_fft|dn_re[14]~44\ : std_logic;
SIGNAL \u_fft|up_re[14]~42\ : std_logic;
SIGNAL \u_fft|Selector26~0_combout\ : std_logic;
SIGNAL \u_fft|up_im[14]~42\ : std_logic;
SIGNAL \u_fft|Selector26~1_combout\ : std_logic;
SIGNAL \ram_dout[15]~31_combout\ : std_logic;
SIGNAL \ram_inst|mem_rtl_0|segment[0][15]~dataout\ : std_logic;
SIGNAL \u_fft|a_im\ : std_logic_vector(17 DOWNTO 0);
SIGNAL \u_fft|a_re\ : std_logic_vector(17 DOWNTO 0);
SIGNAL \u_fft|addr_int\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \u_fft|b_im\ : std_logic_vector(17 DOWNTO 0);
SIGNAL \u_fft|b_re\ : std_logic_vector(17 DOWNTO 0);
SIGNAL \u_fft|bot_cpx\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \u_fft|dn_im\ : std_logic_vector(17 DOWNTO 0);
SIGNAL \u_fft|dn_re\ : std_logic_vector(17 DOWNTO 0);
SIGNAL \u_fft|dout_int\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \u_fft|pair_idx\ : std_logic_vector(1 DOWNTO 0);
SIGNAL \u_fft|top_cpx\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \u_fft|up_im\ : std_logic_vector(17 DOWNTO 0);
SIGNAL \u_fft|up_re\ : std_logic_vector(17 DOWNTO 0);
SIGNAL \u_in|addr_int\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \u_in|dout_int\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \u_in|wr_ptr\ : std_logic_vector(3 DOWNTO 0);
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

\ram_inst|mem_rtl_0|segment[0][0]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][0]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][1]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][1]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][2]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][2]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][3]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][3]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][4]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][4]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][5]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][5]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][6]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][6]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][7]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][7]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][8]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][8]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][9]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][9]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][10]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][10]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][11]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][11]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][12]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][12]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][13]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][13]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][14]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][14]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][15]_WADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);

\ram_inst|mem_rtl_0|segment[0][15]_RADDR_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \ram_addr[3]~7_combout\ & \ram_addr[2]~6_combout\ & \ram_addr[1]~5_combout\ & \ram_addr[0]~4_combout\);
\ALT_INV_rst_n~combout\ <= NOT \rst_n~combout\;

\u_in|addr_int[0]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|addr_int\(0) = DFFE(\u_in|wr_ptr\(0), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \u_in|wr_ptr\(0),
	clk => \clk~combout\,
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|addr_int\(0));

\u_in|dout_int[14]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int\(14) = DFFE(\adc_sample~combout\(14), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

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
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|dout_int\(14));

\u_in|st.IDLE\ : apex20ke_lcell
-- Equation(s):
-- \u_in|st.IDLE~regout\ = DFFE(\u_in|st.IDLE~regout\ # \adc_valid~combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fafa",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_in|st.IDLE~regout\,
	datac => \adc_valid~combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|st.IDLE~regout\);

\u_in|Selector21~0\ : apex20ke_lcell
-- Equation(s):
-- \u_in|Selector21~0_combout\ = \u_in|st.WRITE~regout\ # !\u_in|st.IDLE~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff0f",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \u_in|st.IDLE~regout\,
	datad => \u_in|st.WRITE~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_in|Selector21~0_combout\);

\u_fft|dn_im[1]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_im\(1) = DFFE(\u_fft|a_im\(1) $ \u_fft|b_im\(1) $ !\u_fft|dn_im[0]~16\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_im[1]~18\ = CARRY(\u_fft|a_im\(1) & \u_fft|b_im\(1) & !\u_fft|dn_im[0]~16\ # !\u_fft|a_im\(1) & (\u_fft|b_im\(1) # !\u_fft|dn_im[0]~16\))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "694d",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(1),
	datab => \u_fft|b_im\(1),
	cin => \u_fft|dn_im[0]~16\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_im\(1),
	cout => \u_fft|dn_im[1]~18\);

\u_fft|up_im[1]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_im\(1) = DFFE(\u_fft|a_im\(1) $ \u_fft|b_im\(1) $ \u_fft|up_im[1]~47_cout\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_im[1]~16\ = CARRY(\u_fft|a_im\(1) & !\u_fft|b_im\(1) & !\u_fft|up_im[1]~47_cout\ # !\u_fft|a_im\(1) & (!\u_fft|up_im[1]~47_cout\ # !\u_fft|b_im\(1)))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(1),
	datab => \u_fft|b_im\(1),
	cin => \u_fft|up_im[1]~47_cout\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_im\(1),
	cout => \u_fft|up_im[1]~16\);

\u_fft|Selector40~2\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector40~2_combout\ = \u_fft|up_im\(1) & (\u_fft|st.S0_WR_TOP_RE~regout\ # \u_fft|dn_im\(1) & \u_fft|st.S0_WR_BOT_RE~regout\) # !\u_fft|up_im\(1) & \u_fft|dn_im\(1) & \u_fft|st.S0_WR_BOT_RE~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eac0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|up_im\(1),
	datab => \u_fft|dn_im\(1),
	datac => \u_fft|st.S0_WR_BOT_RE~regout\,
	datad => \u_fft|st.S0_WR_TOP_RE~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector40~2_combout\);

\u_fft|up_re[2]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_re\(2) = DFFE(\u_fft|b_re\(2) $ \u_fft|a_re\(2) $ !\u_fft|up_re[1]~16\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_re[2]~18\ = CARRY(\u_fft|b_re\(2) & (\u_fft|a_re\(2) # !\u_fft|up_re[1]~16\) # !\u_fft|b_re\(2) & \u_fft|a_re\(2) & !\u_fft|up_re[1]~16\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "698e",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_re\(2),
	datab => \u_fft|a_re\(2),
	cin => \u_fft|up_re[1]~16\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_re\(2),
	cout => \u_fft|up_re[2]~18\);

\u_fft|dn_im[2]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_im\(2) = DFFE(\u_fft|a_im\(2) $ \u_fft|b_im\(2) $ \u_fft|dn_im[1]~18\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_im[2]~20\ = CARRY(\u_fft|a_im\(2) & (!\u_fft|dn_im[1]~18\ # !\u_fft|b_im\(2)) # !\u_fft|a_im\(2) & !\u_fft|b_im\(2) & !\u_fft|dn_im[1]~18\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "962b",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(2),
	datab => \u_fft|b_im\(2),
	cin => \u_fft|dn_im[1]~18\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_im\(2),
	cout => \u_fft|dn_im[2]~20\);

\u_fft|up_im[2]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_im\(2) = DFFE(\u_fft|a_im\(2) $ \u_fft|b_im\(2) $ !\u_fft|up_im[1]~16\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_im[2]~18\ = CARRY(\u_fft|a_im\(2) & (\u_fft|b_im\(2) # !\u_fft|up_im[1]~16\) # !\u_fft|a_im\(2) & \u_fft|b_im\(2) & !\u_fft|up_im[1]~16\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "698e",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(2),
	datab => \u_fft|b_im\(2),
	cin => \u_fft|up_im[1]~16\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_im\(2),
	cout => \u_fft|up_im[2]~18\);

\u_fft|Selector39~2\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector39~2_combout\ = \u_fft|dn_im\(2) & (\u_fft|st.S0_WR_BOT_RE~regout\ # \u_fft|up_im\(2) & \u_fft|st.S0_WR_TOP_RE~regout\) # !\u_fft|dn_im\(2) & \u_fft|up_im\(2) & \u_fft|st.S0_WR_TOP_RE~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eac0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|dn_im\(2),
	datab => \u_fft|up_im\(2),
	datac => \u_fft|st.S0_WR_TOP_RE~regout\,
	datad => \u_fft|st.S0_WR_BOT_RE~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector39~2_combout\);

\u_fft|up_re[3]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_re\(3) = DFFE(\u_fft|b_re\(3) $ \u_fft|a_re\(3) $ \u_fft|up_re[2]~18\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_re[3]~20\ = CARRY(\u_fft|b_re\(3) & !\u_fft|a_re\(3) & !\u_fft|up_re[2]~18\ # !\u_fft|b_re\(3) & (!\u_fft|up_re[2]~18\ # !\u_fft|a_re\(3)))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_re\(3),
	datab => \u_fft|a_re\(3),
	cin => \u_fft|up_re[2]~18\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_re\(3),
	cout => \u_fft|up_re[3]~20\);

\u_fft|dn_im[3]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_im\(3) = DFFE(\u_fft|a_im\(3) $ \u_fft|b_im\(3) $ !\u_fft|dn_im[2]~20\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_im[3]~22\ = CARRY(\u_fft|a_im\(3) & \u_fft|b_im\(3) & !\u_fft|dn_im[2]~20\ # !\u_fft|a_im\(3) & (\u_fft|b_im\(3) # !\u_fft|dn_im[2]~20\))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "694d",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(3),
	datab => \u_fft|b_im\(3),
	cin => \u_fft|dn_im[2]~20\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_im\(3),
	cout => \u_fft|dn_im[3]~22\);

\u_fft|up_im[3]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_im\(3) = DFFE(\u_fft|a_im\(3) $ \u_fft|b_im\(3) $ \u_fft|up_im[2]~18\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_im[3]~20\ = CARRY(\u_fft|a_im\(3) & !\u_fft|b_im\(3) & !\u_fft|up_im[2]~18\ # !\u_fft|a_im\(3) & (!\u_fft|up_im[2]~18\ # !\u_fft|b_im\(3)))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(3),
	datab => \u_fft|b_im\(3),
	cin => \u_fft|up_im[2]~18\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_im\(3),
	cout => \u_fft|up_im[3]~20\);

\u_fft|Selector38~2\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector38~2_combout\ = \u_fft|st.S0_WR_TOP_RE~regout\ & (\u_fft|up_im\(3) # \u_fft|st.S0_WR_BOT_RE~regout\ & \u_fft|dn_im\(3)) # !\u_fft|st.S0_WR_TOP_RE~regout\ & \u_fft|st.S0_WR_BOT_RE~regout\ & (\u_fft|dn_im\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eca0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_TOP_RE~regout\,
	datab => \u_fft|st.S0_WR_BOT_RE~regout\,
	datac => \u_fft|up_im\(3),
	datad => \u_fft|dn_im\(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector38~2_combout\);

\u_fft|up_re[4]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_re\(4) = DFFE(\u_fft|b_re\(4) $ \u_fft|a_re\(4) $ !\u_fft|up_re[3]~20\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_re[4]~22\ = CARRY(\u_fft|b_re\(4) & (\u_fft|a_re\(4) # !\u_fft|up_re[3]~20\) # !\u_fft|b_re\(4) & \u_fft|a_re\(4) & !\u_fft|up_re[3]~20\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "698e",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_re\(4),
	datab => \u_fft|a_re\(4),
	cin => \u_fft|up_re[3]~20\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_re\(4),
	cout => \u_fft|up_re[4]~22\);

\u_fft|up_re[5]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_re\(5) = DFFE(\u_fft|b_re\(5) $ \u_fft|a_re\(5) $ \u_fft|up_re[4]~22\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_re[5]~24\ = CARRY(\u_fft|b_re\(5) & !\u_fft|a_re\(5) & !\u_fft|up_re[4]~22\ # !\u_fft|b_re\(5) & (!\u_fft|up_re[4]~22\ # !\u_fft|a_re\(5)))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_re\(5),
	datab => \u_fft|a_re\(5),
	cin => \u_fft|up_re[4]~22\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_re\(5),
	cout => \u_fft|up_re[5]~24\);

\u_fft|dn_im[6]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_im\(6) = DFFE(\u_fft|a_im\(6) $ \u_fft|b_im\(6) $ \u_fft|dn_im[5]~26\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_im[6]~28\ = CARRY(\u_fft|a_im\(6) & (!\u_fft|dn_im[5]~26\ # !\u_fft|b_im\(6)) # !\u_fft|a_im\(6) & !\u_fft|b_im\(6) & !\u_fft|dn_im[5]~26\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "962b",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(6),
	datab => \u_fft|b_im\(6),
	cin => \u_fft|dn_im[5]~26\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_im\(6),
	cout => \u_fft|dn_im[6]~28\);

\u_fft|dn_im[7]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_im\(7) = DFFE(\u_fft|a_im\(7) $ \u_fft|b_im\(7) $ !\u_fft|dn_im[6]~28\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_im[7]~30\ = CARRY(\u_fft|a_im\(7) & \u_fft|b_im\(7) & !\u_fft|dn_im[6]~28\ # !\u_fft|a_im\(7) & (\u_fft|b_im\(7) # !\u_fft|dn_im[6]~28\))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "694d",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(7),
	datab => \u_fft|b_im\(7),
	cin => \u_fft|dn_im[6]~28\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_im\(7),
	cout => \u_fft|dn_im[7]~30\);

\u_fft|dn_im[8]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_im\(8) = DFFE(\u_fft|b_im\(8) $ \u_fft|a_im\(8) $ \u_fft|dn_im[7]~30\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_im[8]~32\ = CARRY(\u_fft|b_im\(8) & \u_fft|a_im\(8) & !\u_fft|dn_im[7]~30\ # !\u_fft|b_im\(8) & (\u_fft|a_im\(8) # !\u_fft|dn_im[7]~30\))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "964d",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_im\(8),
	datab => \u_fft|a_im\(8),
	cin => \u_fft|dn_im[7]~30\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_im\(8),
	cout => \u_fft|dn_im[8]~32\);

\u_fft|up_im[8]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_im\(8) = DFFE(\u_fft|a_im\(8) $ \u_fft|b_im\(8) $ !\u_fft|up_im[7]~28\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_im[8]~30\ = CARRY(\u_fft|a_im\(8) & (\u_fft|b_im\(8) # !\u_fft|up_im[7]~28\) # !\u_fft|a_im\(8) & \u_fft|b_im\(8) & !\u_fft|up_im[7]~28\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "698e",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(8),
	datab => \u_fft|b_im\(8),
	cin => \u_fft|up_im[7]~28\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_im\(8),
	cout => \u_fft|up_im[8]~30\);

\u_fft|Selector33~2\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector33~2_combout\ = \u_fft|st.S0_WR_TOP_RE~regout\ & (\u_fft|up_im\(8) # \u_fft|st.S0_WR_BOT_RE~regout\ & \u_fft|dn_im\(8)) # !\u_fft|st.S0_WR_TOP_RE~regout\ & \u_fft|st.S0_WR_BOT_RE~regout\ & (\u_fft|dn_im\(8))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eca0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_TOP_RE~regout\,
	datab => \u_fft|st.S0_WR_BOT_RE~regout\,
	datac => \u_fft|up_im\(8),
	datad => \u_fft|dn_im\(8),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector33~2_combout\);

\u_fft|dn_re[9]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_re\(9) = DFFE(\u_fft|a_re\(9) $ \u_fft|b_re\(9) $ !\u_fft|dn_re[8]~32\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_re[9]~34\ = CARRY(\u_fft|a_re\(9) & \u_fft|b_re\(9) & !\u_fft|dn_re[8]~32\ # !\u_fft|a_re\(9) & (\u_fft|b_re\(9) # !\u_fft|dn_re[8]~32\))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "694d",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_re\(9),
	datab => \u_fft|b_re\(9),
	cin => \u_fft|dn_re[8]~32\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_re\(9),
	cout => \u_fft|dn_re[9]~34\);

\u_fft|dn_im[9]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_im\(9) = DFFE(\u_fft|b_im\(9) $ \u_fft|a_im\(9) $ !\u_fft|dn_im[8]~32\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_im[9]~34\ = CARRY(\u_fft|b_im\(9) & (!\u_fft|dn_im[8]~32\ # !\u_fft|a_im\(9)) # !\u_fft|b_im\(9) & !\u_fft|a_im\(9) & !\u_fft|dn_im[8]~32\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "692b",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_im\(9),
	datab => \u_fft|a_im\(9),
	cin => \u_fft|dn_im[8]~32\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_im\(9),
	cout => \u_fft|dn_im[9]~34\);

\u_fft|up_im[9]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_im\(9) = DFFE(\u_fft|a_im\(9) $ \u_fft|b_im\(9) $ \u_fft|up_im[8]~30\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_im[9]~32\ = CARRY(\u_fft|a_im\(9) & !\u_fft|b_im\(9) & !\u_fft|up_im[8]~30\ # !\u_fft|a_im\(9) & (!\u_fft|up_im[8]~30\ # !\u_fft|b_im\(9)))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(9),
	datab => \u_fft|b_im\(9),
	cin => \u_fft|up_im[8]~30\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_im\(9),
	cout => \u_fft|up_im[9]~32\);

\u_fft|Selector32~2\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector32~2_combout\ = \u_fft|st.S0_WR_TOP_RE~regout\ & (\u_fft|up_im\(9) # \u_fft|st.S0_WR_BOT_RE~regout\ & \u_fft|dn_im\(9)) # !\u_fft|st.S0_WR_TOP_RE~regout\ & \u_fft|st.S0_WR_BOT_RE~regout\ & (\u_fft|dn_im\(9))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eca0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_TOP_RE~regout\,
	datab => \u_fft|st.S0_WR_BOT_RE~regout\,
	datac => \u_fft|up_im\(9),
	datad => \u_fft|dn_im\(9),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector32~2_combout\);

\u_fft|up_re[10]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_re\(10) = DFFE(\u_fft|b_re\(10) $ \u_fft|a_re\(10) $ !\u_fft|up_re[9]~32\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_re[10]~34\ = CARRY(\u_fft|b_re\(10) & (\u_fft|a_re\(10) # !\u_fft|up_re[9]~32\) # !\u_fft|b_re\(10) & \u_fft|a_re\(10) & !\u_fft|up_re[9]~32\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "698e",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_re\(10),
	datab => \u_fft|a_re\(10),
	cin => \u_fft|up_re[9]~32\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_re\(10),
	cout => \u_fft|up_re[10]~34\);

\u_fft|dn_im[10]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_im\(10) = DFFE(\u_fft|a_im\(10) $ \u_fft|b_im\(10) $ \u_fft|dn_im[9]~34\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_im[10]~36\ = CARRY(\u_fft|a_im\(10) & (!\u_fft|dn_im[9]~34\ # !\u_fft|b_im\(10)) # !\u_fft|a_im\(10) & !\u_fft|b_im\(10) & !\u_fft|dn_im[9]~34\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "962b",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(10),
	datab => \u_fft|b_im\(10),
	cin => \u_fft|dn_im[9]~34\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_im\(10),
	cout => \u_fft|dn_im[10]~36\);

\u_fft|up_re[11]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_re\(11) = DFFE(\u_fft|b_re\(11) $ \u_fft|a_re\(11) $ \u_fft|up_re[10]~34\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_re[11]~36\ = CARRY(\u_fft|b_re\(11) & !\u_fft|a_re\(11) & !\u_fft|up_re[10]~34\ # !\u_fft|b_re\(11) & (!\u_fft|up_re[10]~34\ # !\u_fft|a_re\(11)))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_re\(11),
	datab => \u_fft|a_re\(11),
	cin => \u_fft|up_re[10]~34\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_re\(11),
	cout => \u_fft|up_re[11]~36\);

\u_fft|dn_im[11]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_im\(11) = DFFE(\u_fft|b_im\(11) $ \u_fft|a_im\(11) $ !\u_fft|dn_im[10]~36\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_im[11]~38\ = CARRY(\u_fft|b_im\(11) & (!\u_fft|dn_im[10]~36\ # !\u_fft|a_im\(11)) # !\u_fft|b_im\(11) & !\u_fft|a_im\(11) & !\u_fft|dn_im[10]~36\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "692b",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_im\(11),
	datab => \u_fft|a_im\(11),
	cin => \u_fft|dn_im[10]~36\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_im\(11),
	cout => \u_fft|dn_im[11]~38\);

\u_fft|up_im[11]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_im\(11) = DFFE(\u_fft|b_im\(11) $ \u_fft|a_im\(11) $ \u_fft|up_im[10]~34\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_im[11]~36\ = CARRY(\u_fft|b_im\(11) & !\u_fft|a_im\(11) & !\u_fft|up_im[10]~34\ # !\u_fft|b_im\(11) & (!\u_fft|up_im[10]~34\ # !\u_fft|a_im\(11)))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_im\(11),
	datab => \u_fft|a_im\(11),
	cin => \u_fft|up_im[10]~34\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_im\(11),
	cout => \u_fft|up_im[11]~36\);

\u_fft|Selector30~2\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector30~2_combout\ = \u_fft|st.S0_WR_BOT_RE~regout\ & (\u_fft|dn_im\(11) # \u_fft|st.S0_WR_TOP_RE~regout\ & \u_fft|up_im\(11)) # !\u_fft|st.S0_WR_BOT_RE~regout\ & (\u_fft|st.S0_WR_TOP_RE~regout\ & \u_fft|up_im\(11))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f888",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_BOT_RE~regout\,
	datab => \u_fft|dn_im\(11),
	datac => \u_fft|st.S0_WR_TOP_RE~regout\,
	datad => \u_fft|up_im\(11),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector30~2_combout\);

\u_fft|dn_im[12]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_im\(12) = DFFE(\u_fft|a_im\(12) $ \u_fft|b_im\(12) $ \u_fft|dn_im[11]~38\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_im[12]~40\ = CARRY(\u_fft|a_im\(12) & (!\u_fft|dn_im[11]~38\ # !\u_fft|b_im\(12)) # !\u_fft|a_im\(12) & !\u_fft|b_im\(12) & !\u_fft|dn_im[11]~38\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "962b",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(12),
	datab => \u_fft|b_im\(12),
	cin => \u_fft|dn_im[11]~38\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_im\(12),
	cout => \u_fft|dn_im[12]~40\);

\u_fft|up_im[12]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_im\(12) = DFFE(\u_fft|a_im\(12) $ \u_fft|b_im\(12) $ !\u_fft|up_im[11]~36\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_im[12]~38\ = CARRY(\u_fft|a_im\(12) & (\u_fft|b_im\(12) # !\u_fft|up_im[11]~36\) # !\u_fft|a_im\(12) & \u_fft|b_im\(12) & !\u_fft|up_im[11]~36\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "698e",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(12),
	datab => \u_fft|b_im\(12),
	cin => \u_fft|up_im[11]~36\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_im\(12),
	cout => \u_fft|up_im[12]~38\);

\u_fft|Selector29~2\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector29~2_combout\ = \u_fft|st.S0_WR_BOT_RE~regout\ & (\u_fft|dn_im\(12) # \u_fft|st.S0_WR_TOP_RE~regout\ & \u_fft|up_im\(12)) # !\u_fft|st.S0_WR_BOT_RE~regout\ & \u_fft|st.S0_WR_TOP_RE~regout\ & \u_fft|up_im\(12)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eac0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_BOT_RE~regout\,
	datab => \u_fft|st.S0_WR_TOP_RE~regout\,
	datac => \u_fft|up_im\(12),
	datad => \u_fft|dn_im\(12),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector29~2_combout\);

\u_fft|dn_im[13]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_im\(13) = DFFE(\u_fft|b_im\(13) $ \u_fft|a_im\(13) $ !\u_fft|dn_im[12]~40\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_im[13]~42\ = CARRY(\u_fft|b_im\(13) & (!\u_fft|dn_im[12]~40\ # !\u_fft|a_im\(13)) # !\u_fft|b_im\(13) & !\u_fft|a_im\(13) & !\u_fft|dn_im[12]~40\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "692b",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_im\(13),
	datab => \u_fft|a_im\(13),
	cin => \u_fft|dn_im[12]~40\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_im\(13),
	cout => \u_fft|dn_im[13]~42\);

\u_fft|up_im[13]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_im\(13) = DFFE(\u_fft|b_im\(13) $ \u_fft|a_im\(13) $ \u_fft|up_im[12]~38\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_im[13]~40\ = CARRY(\u_fft|b_im\(13) & !\u_fft|a_im\(13) & !\u_fft|up_im[12]~38\ # !\u_fft|b_im\(13) & (!\u_fft|up_im[12]~38\ # !\u_fft|a_im\(13)))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_im\(13),
	datab => \u_fft|a_im\(13),
	cin => \u_fft|up_im[12]~38\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_im\(13),
	cout => \u_fft|up_im[13]~40\);

\u_fft|Selector28~2\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector28~2_combout\ = \u_fft|st.S0_WR_BOT_RE~regout\ & (\u_fft|dn_im\(13) # \u_fft|st.S0_WR_TOP_RE~regout\ & \u_fft|up_im\(13)) # !\u_fft|st.S0_WR_BOT_RE~regout\ & \u_fft|st.S0_WR_TOP_RE~regout\ & \u_fft|up_im\(13)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eac0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_BOT_RE~regout\,
	datab => \u_fft|st.S0_WR_TOP_RE~regout\,
	datac => \u_fft|up_im\(13),
	datad => \u_fft|dn_im\(13),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector28~2_combout\);

\u_fft|dn_im[14]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_im\(14) = DFFE(\u_fft|b_im\(14) $ \u_fft|a_im\(14) $ \u_fft|dn_im[13]~42\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_im[14]~44\ = CARRY(\u_fft|b_im\(14) & \u_fft|a_im\(14) & !\u_fft|dn_im[13]~42\ # !\u_fft|b_im\(14) & (\u_fft|a_im\(14) # !\u_fft|dn_im[13]~42\))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "964d",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_im\(14),
	datab => \u_fft|a_im\(14),
	cin => \u_fft|dn_im[13]~42\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_im\(14),
	cout => \u_fft|dn_im[14]~44\);

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

\u_fft|dn_im[15]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_im\(15) = DFFE(\u_fft|b_im\(15) $ (\u_fft|dn_im[14]~44\ $ !\u_fft|a_im\(15)), GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "5aa5",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_im\(15),
	datad => \u_fft|a_im\(15),
	cin => \u_fft|dn_im[14]~44\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_im\(15));

\u_fft|a_im[0]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_im\(0) = DFFE(\ram_inst|mem_rtl_0|segment[0][0]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_im[0]~18_combout\)

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
	ena => \u_fft|a_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_im\(0));

\u_fft|bot_cpx[0]~7\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|bot_cpx[0]~7_combout\ = \u_fft|top_cpx\(0) & (!\u_fft|pair_idx\(0) # !\u_fft|pair_idx\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "5f00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|pair_idx\(1),
	datac => \u_fft|pair_idx\(0),
	datad => \u_fft|top_cpx\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|bot_cpx[0]~7_combout\);

\u_fft|a_im[1]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_im\(1) = DFFE(\ram_inst|mem_rtl_0|segment[0][1]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_im[0]~18_combout\)

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
	ena => \u_fft|a_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_im\(1));

\u_fft|b_re[2]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_re\(2) = DFFE(\ram_inst|mem_rtl_0|segment[0][2]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_re[0]~18_combout\)

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
	ena => \u_fft|b_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_re\(2));

\u_fft|a_im[2]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_im\(2) = DFFE(\ram_inst|mem_rtl_0|segment[0][2]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_im[0]~18_combout\)

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
	ena => \u_fft|a_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_im\(2));

\u_fft|b_re[3]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_re\(3) = DFFE(\ram_inst|mem_rtl_0|segment[0][3]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_re[0]~18_combout\)

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
	ena => \u_fft|b_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_re\(3));

\u_fft|a_im[3]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_im\(3) = DFFE(\ram_inst|mem_rtl_0|segment[0][3]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_im[0]~18_combout\)

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
	ena => \u_fft|a_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_im\(3));

\u_fft|a_im[4]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_im\(4) = DFFE(\ram_inst|mem_rtl_0|segment[0][4]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_im[0]~18_combout\)

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
	ena => \u_fft|a_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_im\(4));

\u_fft|a_im[6]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_im\(6) = DFFE(\ram_inst|mem_rtl_0|segment[0][6]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_im[0]~18_combout\)

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
	ena => \u_fft|a_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_im\(6));

\u_fft|a_im[7]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_im\(7) = DFFE(\ram_inst|mem_rtl_0|segment[0][7]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_im[0]~18_combout\)

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
	ena => \u_fft|a_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_im\(7));

\u_fft|a_im[8]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_im\(8) = DFFE(\ram_inst|mem_rtl_0|segment[0][8]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_im[0]~18_combout\)

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
	ena => \u_fft|a_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_im\(8));

\u_fft|a_im[9]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_im\(9) = DFFE(\ram_inst|mem_rtl_0|segment[0][9]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_im[0]~18_combout\)

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
	ena => \u_fft|a_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_im\(9));

\u_fft|b_im[10]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_im\(10) = DFFE(\ram_inst|mem_rtl_0|segment[0][10]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_im[0]~18_combout\)

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
	ena => \u_fft|b_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_im\(10));

\u_fft|b_im[11]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_im\(11) = DFFE(\ram_inst|mem_rtl_0|segment[0][11]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_im[0]~18_combout\)

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
	ena => \u_fft|b_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_im\(11));

\u_fft|a_re[12]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_re\(12) = DFFE(\ram_inst|mem_rtl_0|segment[0][12]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_re[0]~18_combout\)

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
	ena => \u_fft|a_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_re\(12));

\u_fft|a_im[12]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_im\(12) = DFFE(\ram_inst|mem_rtl_0|segment[0][12]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_im[0]~18_combout\)

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
	ena => \u_fft|a_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_im\(12));

\u_fft|b_im[13]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_im\(13) = DFFE(\ram_inst|mem_rtl_0|segment[0][13]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_im[0]~18_combout\)

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
	ena => \u_fft|b_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_im\(13));

\u_fft|b_im[14]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_im\(14) = DFFE(\ram_inst|mem_rtl_0|segment[0][14]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_im[0]~18_combout\)

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
	ena => \u_fft|b_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_im\(14));

\u_fft|b_im[15]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_im\(15) = DFFE(\ram_inst|mem_rtl_0|segment[0][15]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_im[0]~18_combout\)

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
	ena => \u_fft|b_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_im\(15));

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

\u_in|st.WAIT_1\ : apex20ke_lcell
-- Equation(s):
-- \u_in|st.WAIT_1~regout\ = DFFE(\u_in|Equal0~0_combout\ & (\u_in|st.WRITE~regout\), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cc00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_in|Equal0~0_combout\,
	datad => \u_in|st.WRITE~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|st.WAIT_1~regout\);

\u_in|st.WAIT_FFT\ : apex20ke_lcell
-- Equation(s):
-- \u_in|st.WAIT_FFT~regout\ = DFFE(\u_in|st.WAIT_1~regout\ # \u_in|st.WAIT_FFT~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ffcc",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_in|st.WAIT_1~regout\,
	datad => \u_in|st.WAIT_FFT~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|st.WAIT_FFT~regout\);

\u_in|dout_int~16\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int~16_combout\ = \u_in|st.WAIT_1~regout\ # \u_in|st.WAIT_FFT~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ffcc",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_in|st.WAIT_1~regout\,
	datad => \u_in|st.WAIT_FFT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_in|dout_int~16_combout\);

\u_in|wr_ptr[0]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|wr_ptr\(0) = DFFE(\u_in|wr_ptr\(0) & (\u_in|dout_int~16_combout\ # \u_in|Selector21~0_combout\ & !\adc_valid~combout\) # !\u_in|wr_ptr\(0) & \u_in|Selector21~0_combout\ & \adc_valid~combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f288",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_in|Selector21~0_combout\,
	datab => \adc_valid~combout\,
	datac => \u_in|dout_int~16_combout\,
	datad => \u_in|wr_ptr\(0),
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|wr_ptr\(0));

\u_in|Add0~2\ : apex20ke_lcell
-- Equation(s):
-- \u_in|Add0~2_combout\ = \adc_valid~combout\ & \u_in|wr_ptr\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \adc_valid~combout\,
	datad => \u_in|wr_ptr\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_in|Add0~2_combout\);

\u_in|wr_ptr[1]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|wr_ptr\(1) = DFFE(\u_in|wr_ptr\(1) & (\u_in|dout_int~16_combout\ # \u_in|Selector21~0_combout\ & !\u_in|Add0~2_combout\) # !\u_in|wr_ptr\(1) & \u_in|Selector21~0_combout\ & \u_in|Add0~2_combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f288",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_in|Selector21~0_combout\,
	datab => \u_in|Add0~2_combout\,
	datac => \u_in|dout_int~16_combout\,
	datad => \u_in|wr_ptr\(1),
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|wr_ptr\(1));

\u_in|Add0~1\ : apex20ke_lcell
-- Equation(s):
-- \u_in|Add0~1_combout\ = \u_in|wr_ptr\(0) & \adc_valid~combout\ & \u_in|wr_ptr\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c000",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_in|wr_ptr\(0),
	datac => \adc_valid~combout\,
	datad => \u_in|wr_ptr\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_in|Add0~1_combout\);

\u_in|wr_ptr[2]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|wr_ptr\(2) = DFFE(\u_in|wr_ptr\(2) & (\u_in|dout_int~16_combout\ # \u_in|Selector21~0_combout\ & !\u_in|Add0~1_combout\) # !\u_in|wr_ptr\(2) & \u_in|Selector21~0_combout\ & (\u_in|Add0~1_combout\), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "e2c8",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_in|Selector21~0_combout\,
	datab => \u_in|wr_ptr\(2),
	datac => \u_in|dout_int~16_combout\,
	datad => \u_in|Add0~1_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|wr_ptr\(2));

\u_in|Add0~0\ : apex20ke_lcell
-- Equation(s):
-- \u_in|Add0~0_combout\ = \adc_valid~combout\ & \u_in|wr_ptr\(0) & \u_in|wr_ptr\(2) & \u_in|wr_ptr\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "8000",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \adc_valid~combout\,
	datab => \u_in|wr_ptr\(0),
	datac => \u_in|wr_ptr\(2),
	datad => \u_in|wr_ptr\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_in|Add0~0_combout\);

\u_in|wr_ptr[3]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|wr_ptr\(3) = DFFE(\u_in|wr_ptr\(3) & (\u_in|dout_int~16_combout\ # \u_in|Selector21~0_combout\ & !\u_in|Add0~0_combout\) # !\u_in|wr_ptr\(3) & \u_in|Selector21~0_combout\ & (\u_in|Add0~0_combout\), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "e2c8",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_in|Selector21~0_combout\,
	datab => \u_in|wr_ptr\(3),
	datac => \u_in|dout_int~16_combout\,
	datad => \u_in|Add0~0_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|wr_ptr\(3));

\u_in|Equal0~0\ : apex20ke_lcell
-- Equation(s):
-- \u_in|Equal0~0_combout\ = \u_in|wr_ptr\(2) & \u_in|wr_ptr\(0) & \u_in|wr_ptr\(3) & \u_in|wr_ptr\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "8000",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_in|wr_ptr\(2),
	datab => \u_in|wr_ptr\(0),
	datac => \u_in|wr_ptr\(3),
	datad => \u_in|wr_ptr\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_in|Equal0~0_combout\);

\u_in|st.WRITE\ : apex20ke_lcell
-- Equation(s):
-- \u_in|st.WRITE~regout\ = DFFE(\u_in|st.IDLE~regout\ & \u_in|st.WRITE~regout\ & (!\u_in|Equal0~0_combout\) # !\u_in|st.IDLE~regout\ & (\adc_valid~combout\ # \u_in|st.WRITE~regout\ & !\u_in|Equal0~0_combout\), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), 
-- , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "50dc",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_in|st.IDLE~regout\,
	datab => \u_in|st.WRITE~regout\,
	datac => \adc_valid~combout\,
	datad => \u_in|Equal0~0_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|st.WRITE~regout\);

\u_in|din_ready\ : apex20ke_lcell
-- Equation(s):
-- \u_in|din_ready~regout\ = DFFE(\u_in|st.WRITE~regout\ & !\u_in|Equal0~0_combout\ & \u_in|din_ready~regout\ # !\u_in|st.WRITE~regout\ & (\u_in|din_ready~regout\ # !\u_in|dout_int~16_combout\), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "7075",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_in|st.WRITE~regout\,
	datab => \u_in|Equal0~0_combout\,
	datac => \u_in|din_ready~regout\,
	datad => \u_in|dout_int~16_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|din_ready~regout\);

\u_in|start_fft\ : apex20ke_lcell
-- Equation(s):
-- \u_in|start_fft~regout\ = DFFE(\u_in|st.WAIT_1~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \u_in|st.WAIT_1~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|start_fft~regout\);

\u_fft|st.S0_WR_TOP_RE\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|st.S0_WR_TOP_RE~regout\ = DFFE(\u_fft|st.S0_CALC~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \u_fft|st.S0_CALC~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|st.S0_WR_TOP_RE~regout\);

\u_fft|st.S0_WR_TOP_IM\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|st.S0_WR_TOP_IM~regout\ = DFFE(\u_fft|st.S0_WR_TOP_RE~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \u_fft|st.S0_WR_TOP_RE~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|st.S0_WR_TOP_IM~regout\);

\u_fft|st.S0_WR_BOT_RE\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|st.S0_WR_BOT_RE~regout\ = DFFE(\u_fft|st.S0_WR_TOP_IM~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0f0",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \u_fft|st.S0_WR_TOP_IM~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|st.S0_WR_BOT_RE~regout\);

\u_fft|WideOr18~5\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|WideOr18~5_combout\ = !\u_fft|st.S0_WR_TOP_RE~regout\ & !\u_fft|st.S0_WR_BOT_RE~regout\ & !\u_fft|st.S0_WR_TOP_IM~regout\ & !\u_fft|st.S0_CALC~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_TOP_RE~regout\,
	datab => \u_fft|st.S0_WR_BOT_RE~regout\,
	datac => \u_fft|st.S0_WR_TOP_IM~regout\,
	datad => \u_fft|st.S0_CALC~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|WideOr18~5_combout\);

\u_fft|WideOr17~6\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|WideOr17~6_combout\ = !\u_fft|st.S0_RD_BOT_RE~regout\ & !\u_fft|st.S0_RD_TOP_RE~regout\ & !\u_fft|st.S0_RD_TOP_IM~regout\ & \u_fft|st.IDLE~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_RD_BOT_RE~regout\,
	datab => \u_fft|st.S0_RD_TOP_RE~regout\,
	datac => \u_fft|st.S0_RD_TOP_IM~regout\,
	datad => \u_fft|st.IDLE~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|WideOr17~6_combout\);

\u_fft|WideNor0\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|WideNor0~combout\ = \u_fft|st.S0_WR_BOT_IM~regout\ # \u_fft|st.S0_RD_BOT_IM~regout\ # !\u_fft|WideOr17~6_combout\ # !\u_fft|WideOr18~5_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "efff",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_BOT_IM~regout\,
	datab => \u_fft|st.S0_RD_BOT_IM~regout\,
	datac => \u_fft|WideOr18~5_combout\,
	datad => \u_fft|WideOr17~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|WideNor0~combout\);

\u_fft|st.IDLE\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|st.IDLE~regout\ = DFFE(\u_fft|WideNor0~combout\ & (\u_fft|st.IDLE~regout\ # \u_in|start_fft~regout\), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fc00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|st.IDLE~regout\,
	datac => \u_in|start_fft~regout\,
	datad => \u_fft|WideNor0~combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|st.IDLE~regout\);

\u_fft|st.S0_WR_BOT_IM\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|st.S0_WR_BOT_IM~regout\ = DFFE(\u_fft|st.S0_WR_BOT_RE~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \u_fft|st.S0_WR_BOT_RE~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|st.S0_WR_BOT_IM~regout\);

\u_fft|Selector1~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector1~1_combout\ = \u_fft|st.IDLE~regout\ & \u_fft|st.S0_WR_BOT_IM~regout\ # !\u_fft|st.IDLE~regout\ & (\u_in|start_fft~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f3c0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|st.IDLE~regout\,
	datac => \u_fft|st.S0_WR_BOT_IM~regout\,
	datad => \u_in|start_fft~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector1~1_combout\);

\u_fft|pair_idx[0]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|pair_idx\(0) = DFFE(!\u_fft|pair_idx\(0) & \u_fft|st.IDLE~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \u_fft|Selector1~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0f00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \u_fft|pair_idx\(0),
	datad => \u_fft|st.IDLE~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \u_fft|Selector1~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|pair_idx\(0));

\u_fft|pair_idx[1]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|pair_idx\(1) = DFFE(\u_fft|st.IDLE~regout\ & (\u_fft|pair_idx\(0) $ \u_fft|pair_idx\(1)), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , \u_fft|Selector1~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "5a00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|pair_idx\(0),
	datac => \u_fft|pair_idx\(1),
	datad => \u_fft|st.IDLE~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	ena => \u_fft|Selector1~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|pair_idx\(1));

\u_fft|Equal0~0\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Equal0~0_combout\ = \u_fft|pair_idx\(0) & (\u_fft|pair_idx\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cc00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|pair_idx\(0),
	datad => \u_fft|pair_idx\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Equal0~0_combout\);

\u_fft|st.S0_RD_TOP_RE\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|st.S0_RD_TOP_RE~regout\ = DFFE(\u_fft|st.S0_WR_BOT_IM~regout\ & (\u_in|start_fft~regout\ & !\u_fft|st.IDLE~regout\ # !\u_fft|Equal0~0_combout\) # !\u_fft|st.S0_WR_BOT_IM~regout\ & \u_in|start_fft~regout\ & !\u_fft|st.IDLE~regout\, 
-- GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0cae",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_BOT_IM~regout\,
	datab => \u_in|start_fft~regout\,
	datac => \u_fft|st.IDLE~regout\,
	datad => \u_fft|Equal0~0_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|st.S0_RD_TOP_RE~regout\);

\u_fft|st.S0_RD_TOP_IM\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|st.S0_RD_TOP_IM~regout\ = DFFE(\u_fft|st.S0_RD_TOP_RE~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \u_fft|st.S0_RD_TOP_RE~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|st.S0_RD_TOP_IM~regout\);

\u_fft|st.S0_RD_BOT_RE\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|st.S0_RD_BOT_RE~regout\ = DFFE(\u_fft|st.S0_RD_TOP_IM~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0f0",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \u_fft|st.S0_RD_TOP_IM~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|st.S0_RD_BOT_RE~regout\);

\u_fft|st.S0_RD_BOT_IM\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|st.S0_RD_BOT_IM~regout\ = DFFE(\u_fft|st.S0_RD_BOT_RE~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0f0",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \u_fft|st.S0_RD_BOT_RE~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|st.S0_RD_BOT_IM~regout\);

\u_fft|st.S0_CALC\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|st.S0_CALC~regout\ = DFFE(\u_fft|st.S0_RD_BOT_IM~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \u_fft|st.S0_RD_BOT_IM~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|st.S0_CALC~regout\);

\u_fft|a_re[0]~18\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_re[0]~18_combout\ = \rst_n~combout\ & \u_fft|st.S0_RD_TOP_RE~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \rst_n~combout\,
	datad => \u_fft|st.S0_RD_TOP_RE~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|a_re[0]~18_combout\);

\u_fft|a_re[0]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_re\(0) = DFFE(\ram_inst|mem_rtl_0|segment[0][0]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_re[0]~18_combout\)

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
	ena => \u_fft|a_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_re\(0));

\u_fft|up_re[0]~46\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_re[0]~46_combout\ = \rst_n~combout\ & (\u_fft|st.S0_CALC~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cc00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \rst_n~combout\,
	datad => \u_fft|st.S0_CALC~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|up_re[0]~46_combout\);

\u_fft|dn_re[0]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_re\(0) = DFFE(\u_fft|b_re\(0) $ \u_fft|a_re\(0), GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_re[0]~16\ = CARRY(\u_fft|a_re\(0) # !\u_fft|b_re\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "66dd",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_re\(0),
	datab => \u_fft|a_re\(0),
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_re\(0),
	cout => \u_fft|dn_re[0]~16\);

\u_fft|b_im[0]~18\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_im[0]~18_combout\ = \rst_n~combout\ & \u_fft|st.S0_RD_BOT_IM~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c0c0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \rst_n~combout\,
	datac => \u_fft|st.S0_RD_BOT_IM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|b_im[0]~18_combout\);

\u_fft|b_im[0]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_im\(0) = DFFE(\ram_inst|mem_rtl_0|segment[0][0]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_im[0]~18_combout\)

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
	ena => \u_fft|b_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_im\(0));

\u_fft|dn_im[0]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_im\(0) = DFFE(\u_fft|a_im\(0) $ \u_fft|b_im\(0), GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_im[0]~16\ = CARRY(\u_fft|a_im\(0) # !\u_fft|b_im\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "66bb",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(0),
	datab => \u_fft|b_im\(0),
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_im\(0),
	cout => \u_fft|dn_im[0]~16\);

\u_fft|Selector41~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector41~1_combout\ = \u_fft|dn_im\(0) & (\u_fft|st.S0_WR_BOT_RE~regout\ # \u_fft|st.S0_WR_TOP_RE~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccc0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|dn_im\(0),
	datac => \u_fft|st.S0_WR_BOT_RE~regout\,
	datad => \u_fft|st.S0_WR_TOP_RE~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector41~1_combout\);

\u_fft|Selector41~2\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector41~2_combout\ = \u_fft|Selector41~1_combout\ # \u_fft|dn_re\(0) & (\u_fft|st.S0_WR_TOP_IM~regout\ # \u_fft|st.S0_CALC~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ffe0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_TOP_IM~regout\,
	datab => \u_fft|st.S0_CALC~regout\,
	datac => \u_fft|dn_re\(0),
	datad => \u_fft|Selector41~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector41~2_combout\);

\u_fft|WideOr17\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|WideOr17~combout\ = \u_fft|st.S0_RD_BOT_IM~regout\ # \u_fft|WideOr18~5_combout\ # \u_fft|st.S0_WR_BOT_IM~regout\ # !\u_fft|WideOr17~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "feff",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_RD_BOT_IM~regout\,
	datab => \u_fft|WideOr18~5_combout\,
	datac => \u_fft|st.S0_WR_BOT_IM~regout\,
	datad => \u_fft|WideOr17~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|WideOr17~combout\);

\u_fft|dout_int[0]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dout_int\(0) = DFFE(\u_fft|Selector41~2_combout\ # \u_fft|dout_int\(0) & \u_fft|WideOr17~combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fcf0",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|dout_int\(0),
	datac => \u_fft|Selector41~2_combout\,
	datad => \u_fft|WideOr17~combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dout_int\(0));

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

\u_in|dout_int[0]~17\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int[0]~17_combout\ = \adc_valid~combout\ & !\u_in|st.WAIT_1~regout\ & \rst_n~combout\ & !\u_in|st.WAIT_FFT~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0020",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \adc_valid~combout\,
	datab => \u_in|st.WAIT_1~regout\,
	datac => \rst_n~combout\,
	datad => \u_in|st.WAIT_FFT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_in|dout_int[0]~17_combout\);

\u_in|dout_int[0]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int\(0) = DFFE(\adc_sample~combout\(0), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

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
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|dout_int\(0));

\phase.PH_FFT\ : apex20ke_lcell
-- Equation(s):
-- \phase.PH_FFT~regout\ = DFFE(\phase.PH_FFT~regout\ # \u_in|start_fft~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fff0",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \phase.PH_FFT~regout\,
	datad => \u_in|start_fft~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \phase.PH_FFT~regout\);

\ram_dout[0]~16\ : apex20ke_lcell
-- Equation(s):
-- \ram_dout[0]~16_combout\ = \phase.PH_FFT~regout\ & \u_fft|dout_int\(0) # !\phase.PH_FFT~regout\ & (\u_in|dout_int\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccf0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|dout_int\(0),
	datac => \u_in|dout_int\(0),
	datad => \phase.PH_FFT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_dout[0]~16_combout\);

\u_fft|we_int\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|we_int~regout\ = DFFE(\u_fft|st.S0_WR_TOP_IM~regout\ # \u_fft|st.S0_CALC~regout\ # \u_fft|st.S0_WR_BOT_RE~regout\ # \u_fft|st.S0_WR_TOP_RE~regout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fffe",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_TOP_IM~regout\,
	datab => \u_fft|st.S0_CALC~regout\,
	datac => \u_fft|st.S0_WR_BOT_RE~regout\,
	datad => \u_fft|st.S0_WR_TOP_RE~regout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|we_int~regout\);

\u_in|we_int\ : apex20ke_lcell
-- Equation(s):
-- \u_in|we_int~regout\ = DFFE(\adc_valid~combout\ & (\u_in|st.WRITE~regout\ # !\u_in|st.IDLE~regout\), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "d0d0",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_in|st.IDLE~regout\,
	datab => \u_in|st.WRITE~regout\,
	datac => \adc_valid~combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|we_int~regout\);

\ram_we~4\ : apex20ke_lcell
-- Equation(s):
-- \ram_we~4_combout\ = \phase.PH_FFT~regout\ & \u_fft|we_int~regout\ # !\phase.PH_FFT~regout\ & (\u_in|we_int~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cfc0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|we_int~regout\,
	datac => \phase.PH_FFT~regout\,
	datad => \u_in|we_int~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_we~4_combout\);

\u_fft|WideOr5\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|WideOr5~combout\ = \u_fft|st.S0_RD_BOT_IM~regout\ # !\u_fft|st.S0_WR_BOT_IM~regout\ & \u_fft|WideOr18~5_combout\ & \u_fft|WideOr17~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "dccc",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_BOT_IM~regout\,
	datab => \u_fft|st.S0_RD_BOT_IM~regout\,
	datac => \u_fft|WideOr18~5_combout\,
	datad => \u_fft|WideOr17~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|WideOr5~combout\);

\u_fft|Selector11~0\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector11~0_combout\ = \u_fft|st.S0_RD_TOP_RE~regout\ # \u_fft|st.S0_WR_TOP_RE~regout\ # \u_fft|st.S0_RD_BOT_RE~regout\ # \u_fft|st.S0_WR_BOT_RE~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fffe",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_RD_TOP_RE~regout\,
	datab => \u_fft|st.S0_WR_TOP_RE~regout\,
	datac => \u_fft|st.S0_RD_BOT_RE~regout\,
	datad => \u_fft|st.S0_WR_BOT_RE~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector11~0_combout\);

\u_fft|addr_int[0]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|addr_int\(0) = DFFE(\u_fft|Selector11~0_combout\ # \u_fft|addr_int\(0) & (\u_fft|Selector8~0_combout\ # \u_fft|WideOr5~combout\), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ffc8",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|Selector8~0_combout\,
	datab => \u_fft|addr_int\(0),
	datac => \u_fft|WideOr5~combout\,
	datad => \u_fft|Selector11~0_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|addr_int\(0));

\ram_addr[0]~4\ : apex20ke_lcell
-- Equation(s):
-- \ram_addr[0]~4_combout\ = \phase.PH_FFT~regout\ & (\u_fft|addr_int\(0)) # !\phase.PH_FFT~regout\ & \u_in|addr_int\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0aa",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_in|addr_int\(0),
	datac => \u_fft|addr_int\(0),
	datad => \phase.PH_FFT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_addr[0]~4_combout\);

\u_in|addr_int[1]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|addr_int\(1) = DFFE(\u_in|wr_ptr\(3), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \u_in|wr_ptr\(3),
	clk => \clk~combout\,
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|addr_int\(1));

\u_fft|bot_cpx[0]~6\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|bot_cpx[0]~6_combout\ = \rst_n~combout\ & (\u_fft|st.IDLE~regout\ & \u_fft|st.S0_WR_BOT_IM~regout\ # !\u_fft|st.IDLE~regout\ & (\u_in|start_fft~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a280",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \rst_n~combout\,
	datab => \u_fft|st.IDLE~regout\,
	datac => \u_fft|st.S0_WR_BOT_IM~regout\,
	datad => \u_in|start_fft~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|bot_cpx[0]~6_combout\);

\u_fft|bot_cpx[0]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|bot_cpx\(0) = DFFE(\u_fft|bot_cpx[0]~6_combout\ & \u_fft|bot_cpx[0]~7_combout\ & (\u_fft|st.IDLE~regout\) # !\u_fft|bot_cpx[0]~6_combout\ & (\u_fft|bot_cpx\(0)), GLOBAL(\clk~combout\), , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ac0c",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|bot_cpx[0]~7_combout\,
	datab => \u_fft|bot_cpx\(0),
	datac => \u_fft|bot_cpx[0]~6_combout\,
	datad => \u_fft|st.IDLE~regout\,
	clk => \clk~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|bot_cpx\(0));

\u_fft|Selector8~0\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector8~0_combout\ = !\u_fft|st.IDLE~regout\ & (!\u_in|start_fft~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0033",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|st.IDLE~regout\,
	datad => \u_in|start_fft~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector8~0_combout\);

\u_fft|top_cpx[0]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|top_cpx\(0) = DFFE(\u_fft|bot_cpx[0]~6_combout\ & \u_fft|st.IDLE~regout\ & !\u_fft|pair_idx\(0) # !\u_fft|bot_cpx[0]~6_combout\ & (\u_fft|top_cpx\(0)), GLOBAL(\clk~combout\), , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "5d08",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|bot_cpx[0]~6_combout\,
	datab => \u_fft|st.IDLE~regout\,
	datac => \u_fft|pair_idx\(0),
	datad => \u_fft|top_cpx\(0),
	clk => \clk~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|top_cpx\(0));

\u_fft|Selector10~0\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector10~0_combout\ = \u_fft|st.S0_WR_TOP_RE~regout\ # \u_fft|st.S0_CALC~regout\ # \u_fft|st.S0_RD_TOP_RE~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fffa",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_TOP_RE~regout\,
	datac => \u_fft|st.S0_CALC~regout\,
	datad => \u_fft|st.S0_RD_TOP_RE~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector10~0_combout\);

\u_fft|Selector10~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector10~1_combout\ = \u_fft|addr_int\(1) & (\u_fft|Selector8~0_combout\ # \u_fft|top_cpx\(0) & \u_fft|Selector10~0_combout\) # !\u_fft|addr_int\(1) & (\u_fft|top_cpx\(0) & \u_fft|Selector10~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f888",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|addr_int\(1),
	datab => \u_fft|Selector8~0_combout\,
	datac => \u_fft|top_cpx\(0),
	datad => \u_fft|Selector10~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector10~1_combout\);

\u_fft|Selector10~2\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector10~2_combout\ = \u_fft|Selector10~1_combout\ # \u_fft|WideOr1~0_combout\ & \u_fft|bot_cpx\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ffa0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|WideOr1~0_combout\,
	datac => \u_fft|bot_cpx\(0),
	datad => \u_fft|Selector10~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector10~2_combout\);

\u_fft|Selector10~3\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector10~3_combout\ = \u_fft|Selector10~2_combout\ # !\u_fft|pair_idx\(0) & \u_fft|st.S0_WR_BOT_IM~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff50",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|pair_idx\(0),
	datac => \u_fft|st.S0_WR_BOT_IM~regout\,
	datad => \u_fft|Selector10~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector10~3_combout\);

\u_fft|addr_int[1]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|addr_int\(1) = DFFE(\u_fft|Selector10~3_combout\ # \u_fft|WideOr5~combout\ & \u_fft|addr_int\(1), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ffc0",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|WideOr5~combout\,
	datac => \u_fft|addr_int\(1),
	datad => \u_fft|Selector10~3_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|addr_int\(1));

\ram_addr[1]~5\ : apex20ke_lcell
-- Equation(s):
-- \ram_addr[1]~5_combout\ = \phase.PH_FFT~regout\ & (\u_fft|addr_int\(1)) # !\phase.PH_FFT~regout\ & \u_in|addr_int\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fc30",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \phase.PH_FFT~regout\,
	datac => \u_in|addr_int\(1),
	datad => \u_fft|addr_int\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_addr[1]~5_combout\);

\u_in|addr_int[2]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|addr_int\(2) = DFFE(\u_in|wr_ptr\(2), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \u_in|wr_ptr\(2),
	clk => \clk~combout\,
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|addr_int\(2));

\u_fft|Selector0~0\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector0~0_combout\ = \u_fft|st.IDLE~regout\ & (\u_fft|pair_idx\(0) $ \u_fft|pair_idx\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "5a00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|pair_idx\(0),
	datac => \u_fft|pair_idx\(1),
	datad => \u_fft|st.IDLE~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector0~0_combout\);

\u_fft|top_cpx[1]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|top_cpx\(1) = DFFE(\u_fft|bot_cpx[0]~6_combout\ & (\u_fft|Selector0~0_combout\) # !\u_fft|bot_cpx[0]~6_combout\ & \u_fft|top_cpx\(1), GLOBAL(\clk~combout\), , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fc0c",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|top_cpx\(1),
	datac => \u_fft|bot_cpx[0]~6_combout\,
	datad => \u_fft|Selector0~0_combout\,
	clk => \clk~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|top_cpx\(1));

\u_fft|bot_cpx[1]~9\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|bot_cpx[1]~9_combout\ = \u_fft|top_cpx\(1) # \u_fft|pair_idx\(1) & \u_fft|pair_idx\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ffa0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|pair_idx\(1),
	datac => \u_fft|pair_idx\(0),
	datad => \u_fft|top_cpx\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|bot_cpx[1]~9_combout\);

\u_fft|bot_cpx[1]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|bot_cpx\(1) = DFFE(\u_fft|bot_cpx[0]~6_combout\ & (\u_fft|st.IDLE~regout\ & \u_fft|bot_cpx[1]~9_combout\) # !\u_fft|bot_cpx[0]~6_combout\ & \u_fft|bot_cpx\(1), GLOBAL(\clk~combout\), , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ca0a",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|bot_cpx\(1),
	datab => \u_fft|st.IDLE~regout\,
	datac => \u_fft|bot_cpx[0]~6_combout\,
	datad => \u_fft|bot_cpx[1]~9_combout\,
	clk => \clk~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|bot_cpx\(1));

\u_fft|Selector9~0\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector9~0_combout\ = \u_fft|addr_int\(2) & (\u_fft|Selector8~0_combout\ # \u_fft|top_cpx\(1) & \u_fft|Selector10~0_combout\) # !\u_fft|addr_int\(2) & (\u_fft|top_cpx\(1) & \u_fft|Selector10~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f888",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|addr_int\(2),
	datab => \u_fft|Selector8~0_combout\,
	datac => \u_fft|top_cpx\(1),
	datad => \u_fft|Selector10~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector9~0_combout\);

\u_fft|Selector9~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector9~1_combout\ = \u_fft|Selector9~0_combout\ # \u_fft|WideOr1~0_combout\ & \u_fft|bot_cpx\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ffa0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|WideOr1~0_combout\,
	datac => \u_fft|bot_cpx\(1),
	datad => \u_fft|Selector9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector9~1_combout\);

\u_fft|Selector9~2\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector9~2_combout\ = \u_fft|Selector9~1_combout\ # \u_fft|st.S0_WR_BOT_IM~regout\ & (\u_fft|pair_idx\(1) $ \u_fft|pair_idx\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff28",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_BOT_IM~regout\,
	datab => \u_fft|pair_idx\(1),
	datac => \u_fft|pair_idx\(0),
	datad => \u_fft|Selector9~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector9~2_combout\);

\u_fft|addr_int[2]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|addr_int\(2) = DFFE(\u_fft|Selector9~2_combout\ # \u_fft|WideOr5~combout\ & \u_fft|addr_int\(2), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ffc0",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|WideOr5~combout\,
	datac => \u_fft|addr_int\(2),
	datad => \u_fft|Selector9~2_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|addr_int\(2));

\ram_addr[2]~6\ : apex20ke_lcell
-- Equation(s):
-- \ram_addr[2]~6_combout\ = \phase.PH_FFT~regout\ & (\u_fft|addr_int\(2)) # !\phase.PH_FFT~regout\ & (\u_in|addr_int\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fa50",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \phase.PH_FFT~regout\,
	datac => \u_in|addr_int\(2),
	datad => \u_fft|addr_int\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_addr[2]~6_combout\);

\u_fft|bot_cpx[2]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|bot_cpx\(2) = DFFE(\u_fft|bot_cpx[0]~6_combout\ & (!\u_fft|st.IDLE~regout\ # !\u_fft|Equal0~0_combout\) # !\u_fft|bot_cpx[0]~6_combout\ & (\u_fft|bot_cpx\(2)), GLOBAL(\clk~combout\), , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "5cfc",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|Equal0~0_combout\,
	datab => \u_fft|bot_cpx\(2),
	datac => \u_fft|bot_cpx[0]~6_combout\,
	datad => \u_fft|st.IDLE~regout\,
	clk => \clk~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|bot_cpx\(2));

\u_fft|WideOr1~0\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|WideOr1~0_combout\ = \u_fft|st.S0_RD_BOT_RE~regout\ # \u_fft|st.S0_WR_BOT_RE~regout\ # \u_fft|st.S0_RD_TOP_IM~regout\ # \u_fft|st.S0_WR_TOP_IM~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fffe",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_RD_BOT_RE~regout\,
	datab => \u_fft|st.S0_WR_BOT_RE~regout\,
	datac => \u_fft|st.S0_RD_TOP_IM~regout\,
	datad => \u_fft|st.S0_WR_TOP_IM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|WideOr1~0_combout\);

\u_fft|Selector8~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector8~1_combout\ = \u_fft|bot_cpx\(2) & (\u_fft|WideOr1~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cc00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|bot_cpx\(2),
	datad => \u_fft|WideOr1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector8~1_combout\);

\u_fft|addr_int[3]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|addr_int\(3) = DFFE(\u_fft|Selector8~1_combout\ # \u_fft|addr_int\(3) & (\u_fft|Selector8~0_combout\ # \u_fft|WideOr5~combout\), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ffc8",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|Selector8~0_combout\,
	datab => \u_fft|addr_int\(3),
	datac => \u_fft|WideOr5~combout\,
	datad => \u_fft|Selector8~1_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|addr_int\(3));

\u_in|addr_int[3]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|addr_int\(3) = DFFE(\u_in|wr_ptr\(1), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datad => \u_in|wr_ptr\(1),
	clk => \clk~combout\,
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|addr_int\(3));

\ram_addr[3]~7\ : apex20ke_lcell
-- Equation(s):
-- \ram_addr[3]~7_combout\ = \phase.PH_FFT~regout\ & \u_fft|addr_int\(3) # !\phase.PH_FFT~regout\ & (\u_in|addr_int\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cfc0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|addr_int\(3),
	datac => \phase.PH_FFT~regout\,
	datad => \u_in|addr_int\(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_addr[3]~7_combout\);

\ram_inst|mem_rtl_0|segment[0][0]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	address_width => 4,
	bit_number => 0,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "db/SpectAnalyzer.ram0_ram_sp_ed4f5dd0.hdl.mif",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_sp:ram_inst|altdpram:mem_rtl_0|content",
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
	datain => \ram_dout[0]~16_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we~4_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][0]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][0]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][0]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][0]~dataout\);

\u_fft|b_re[0]~18\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_re[0]~18_combout\ = \u_fft|st.S0_RD_BOT_RE~regout\ & (\rst_n~combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aa00",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_RD_BOT_RE~regout\,
	datad => \rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|b_re[0]~18_combout\);

\u_fft|b_re[1]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_re\(1) = DFFE(\ram_inst|mem_rtl_0|segment[0][1]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_re[0]~18_combout\)

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
	ena => \u_fft|b_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_re\(1));

\u_fft|dn_re[1]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_re\(1) = DFFE(\u_fft|a_re\(1) $ \u_fft|b_re\(1) $ !\u_fft|dn_re[0]~16\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_re[1]~18\ = CARRY(\u_fft|a_re\(1) & \u_fft|b_re\(1) & !\u_fft|dn_re[0]~16\ # !\u_fft|a_re\(1) & (\u_fft|b_re\(1) # !\u_fft|dn_re[0]~16\))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "694d",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_re\(1),
	datab => \u_fft|b_re\(1),
	cin => \u_fft|dn_re[0]~16\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_re\(1),
	cout => \u_fft|dn_re[1]~18\);

\u_fft|a_re[1]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_re\(1) = DFFE(\ram_inst|mem_rtl_0|segment[0][1]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_re[0]~18_combout\)

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
	ena => \u_fft|a_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_re\(1));

\u_fft|b_re[0]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_re\(0) = DFFE(\ram_inst|mem_rtl_0|segment[0][0]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_re[0]~18_combout\)

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
	ena => \u_fft|b_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_re\(0));

\u_fft|up_re[1]~48\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_re[1]~48_cout\ = CARRY(\u_fft|a_re\(0) & \u_fft|b_re\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0088",
	operation_mode => "arithmetic",
	output_mode => "none",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_re\(0),
	datab => \u_fft|b_re\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|up_re[1]~47COMB\,
	cout => \u_fft|up_re[1]~48_cout\);

\u_fft|up_re[1]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_re\(1) = DFFE(\u_fft|b_re\(1) $ \u_fft|a_re\(1) $ \u_fft|up_re[1]~48_cout\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_re[1]~16\ = CARRY(\u_fft|b_re\(1) & !\u_fft|a_re\(1) & !\u_fft|up_re[1]~48_cout\ # !\u_fft|b_re\(1) & (!\u_fft|up_re[1]~48_cout\ # !\u_fft|a_re\(1)))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_re\(1),
	datab => \u_fft|a_re\(1),
	cin => \u_fft|up_re[1]~48_cout\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_re\(1),
	cout => \u_fft|up_re[1]~16\);

\u_fft|Selector40~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector40~1_combout\ = \u_fft|st.S0_WR_TOP_IM~regout\ & (\u_fft|dn_re\(1) # \u_fft|st.S0_CALC~regout\ & \u_fft|up_re\(1)) # !\u_fft|st.S0_WR_TOP_IM~regout\ & \u_fft|st.S0_CALC~regout\ & (\u_fft|up_re\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eca0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_TOP_IM~regout\,
	datab => \u_fft|st.S0_CALC~regout\,
	datac => \u_fft|dn_re\(1),
	datad => \u_fft|up_re\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector40~1_combout\);

\u_fft|dout_int[1]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dout_int\(1) = DFFE(\u_fft|Selector40~2_combout\ # \u_fft|Selector40~1_combout\ # \u_fft|dout_int\(1) & \u_fft|WideOr17~combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fefa",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|Selector40~2_combout\,
	datab => \u_fft|dout_int\(1),
	datac => \u_fft|Selector40~1_combout\,
	datad => \u_fft|WideOr17~combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dout_int\(1));

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

\u_in|dout_int[1]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int\(1) = DFFE(\adc_sample~combout\(1), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0f0",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \adc_sample~combout\(1),
	clk => \clk~combout\,
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|dout_int\(1));

\ram_dout[1]~17\ : apex20ke_lcell
-- Equation(s):
-- \ram_dout[1]~17_combout\ = \phase.PH_FFT~regout\ & \u_fft|dout_int\(1) # !\phase.PH_FFT~regout\ & (\u_in|dout_int\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccf0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|dout_int\(1),
	datac => \u_in|dout_int\(1),
	datad => \phase.PH_FFT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_dout[1]~17_combout\);

\ram_inst|mem_rtl_0|segment[0][1]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	address_width => 4,
	bit_number => 1,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "db/SpectAnalyzer.ram0_ram_sp_ed4f5dd0.hdl.mif",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_sp:ram_inst|altdpram:mem_rtl_0|content",
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
	datain => \ram_dout[1]~17_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we~4_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][1]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][1]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][1]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][1]~dataout\);

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

\u_in|dout_int[2]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int\(2) = DFFE(\adc_sample~combout\(2), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

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
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|dout_int\(2));

\u_fft|a_re[2]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_re\(2) = DFFE(\ram_inst|mem_rtl_0|segment[0][2]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_re[0]~18_combout\)

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
	ena => \u_fft|a_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_re\(2));

\u_fft|dn_re[2]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_re\(2) = DFFE(\u_fft|b_re\(2) $ \u_fft|a_re\(2) $ \u_fft|dn_re[1]~18\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_re[2]~20\ = CARRY(\u_fft|b_re\(2) & \u_fft|a_re\(2) & !\u_fft|dn_re[1]~18\ # !\u_fft|b_re\(2) & (\u_fft|a_re\(2) # !\u_fft|dn_re[1]~18\))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "964d",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_re\(2),
	datab => \u_fft|a_re\(2),
	cin => \u_fft|dn_re[1]~18\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_re\(2),
	cout => \u_fft|dn_re[2]~20\);

\u_fft|Selector39~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector39~1_combout\ = \u_fft|up_re\(2) & (\u_fft|st.S0_CALC~regout\ # \u_fft|dn_re\(2) & \u_fft|st.S0_WR_TOP_IM~regout\) # !\u_fft|up_re\(2) & \u_fft|dn_re\(2) & (\u_fft|st.S0_WR_TOP_IM~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eca0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|up_re\(2),
	datab => \u_fft|dn_re\(2),
	datac => \u_fft|st.S0_CALC~regout\,
	datad => \u_fft|st.S0_WR_TOP_IM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector39~1_combout\);

\u_fft|dout_int[2]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dout_int\(2) = DFFE(\u_fft|Selector39~2_combout\ # \u_fft|Selector39~1_combout\ # \u_fft|dout_int\(2) & \u_fft|WideOr17~combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fefa",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|Selector39~2_combout\,
	datab => \u_fft|dout_int\(2),
	datac => \u_fft|Selector39~1_combout\,
	datad => \u_fft|WideOr17~combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dout_int\(2));

\ram_dout[2]~18\ : apex20ke_lcell
-- Equation(s):
-- \ram_dout[2]~18_combout\ = \phase.PH_FFT~regout\ & (\u_fft|dout_int\(2)) # !\phase.PH_FFT~regout\ & (\u_in|dout_int\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fa50",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \phase.PH_FFT~regout\,
	datac => \u_in|dout_int\(2),
	datad => \u_fft|dout_int\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_dout[2]~18_combout\);

\ram_inst|mem_rtl_0|segment[0][2]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	address_width => 4,
	bit_number => 2,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "db/SpectAnalyzer.ram0_ram_sp_ed4f5dd0.hdl.mif",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_sp:ram_inst|altdpram:mem_rtl_0|content",
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
	datain => \ram_dout[2]~18_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we~4_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][2]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][2]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][2]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][2]~dataout\);

\u_fft|a_re[3]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_re\(3) = DFFE(\ram_inst|mem_rtl_0|segment[0][3]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_re[0]~18_combout\)

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
	ena => \u_fft|a_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_re\(3));

\u_fft|dn_re[3]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_re\(3) = DFFE(\u_fft|b_re\(3) $ \u_fft|a_re\(3) $ !\u_fft|dn_re[2]~20\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_re[3]~22\ = CARRY(\u_fft|b_re\(3) & (!\u_fft|dn_re[2]~20\ # !\u_fft|a_re\(3)) # !\u_fft|b_re\(3) & !\u_fft|a_re\(3) & !\u_fft|dn_re[2]~20\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "692b",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_re\(3),
	datab => \u_fft|a_re\(3),
	cin => \u_fft|dn_re[2]~20\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_re\(3),
	cout => \u_fft|dn_re[3]~22\);

\u_fft|Selector38~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector38~1_combout\ = \u_fft|up_re\(3) & (\u_fft|st.S0_CALC~regout\ # \u_fft|dn_re\(3) & \u_fft|st.S0_WR_TOP_IM~regout\) # !\u_fft|up_re\(3) & \u_fft|dn_re\(3) & \u_fft|st.S0_WR_TOP_IM~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eac0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|up_re\(3),
	datab => \u_fft|dn_re\(3),
	datac => \u_fft|st.S0_WR_TOP_IM~regout\,
	datad => \u_fft|st.S0_CALC~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector38~1_combout\);

\u_fft|dout_int[3]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dout_int\(3) = DFFE(\u_fft|Selector38~2_combout\ # \u_fft|Selector38~1_combout\ # \u_fft|dout_int\(3) & \u_fft|WideOr17~combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fefa",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|Selector38~2_combout\,
	datab => \u_fft|dout_int\(3),
	datac => \u_fft|Selector38~1_combout\,
	datad => \u_fft|WideOr17~combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dout_int\(3));

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

\u_in|dout_int[3]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int\(3) = DFFE(\adc_sample~combout\(3), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

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
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|dout_int\(3));

\ram_dout[3]~19\ : apex20ke_lcell
-- Equation(s):
-- \ram_dout[3]~19_combout\ = \phase.PH_FFT~regout\ & \u_fft|dout_int\(3) # !\phase.PH_FFT~regout\ & (\u_in|dout_int\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccf0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|dout_int\(3),
	datac => \u_in|dout_int\(3),
	datad => \phase.PH_FFT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_dout[3]~19_combout\);

\ram_inst|mem_rtl_0|segment[0][3]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	address_width => 4,
	bit_number => 3,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "db/SpectAnalyzer.ram0_ram_sp_ed4f5dd0.hdl.mif",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_sp:ram_inst|altdpram:mem_rtl_0|content",
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
	datain => \ram_dout[3]~19_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we~4_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][3]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][3]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][3]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][3]~dataout\);

\u_fft|b_im[4]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_im\(4) = DFFE(\ram_inst|mem_rtl_0|segment[0][4]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_im[0]~18_combout\)

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
	ena => \u_fft|b_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_im\(4));

\u_fft|b_im[3]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_im\(3) = DFFE(\ram_inst|mem_rtl_0|segment[0][3]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_im[0]~18_combout\)

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
	ena => \u_fft|b_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_im\(3));

\u_fft|b_im[2]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_im\(2) = DFFE(\ram_inst|mem_rtl_0|segment[0][2]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_im[0]~18_combout\)

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
	ena => \u_fft|b_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_im\(2));

\u_fft|b_im[1]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_im\(1) = DFFE(\ram_inst|mem_rtl_0|segment[0][1]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_im[0]~18_combout\)

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
	ena => \u_fft|b_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_im\(1));

\u_fft|dn_im[4]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_im\(4) = DFFE(\u_fft|a_im\(4) $ \u_fft|b_im\(4) $ \u_fft|dn_im[3]~22\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_im[4]~24\ = CARRY(\u_fft|a_im\(4) & (!\u_fft|dn_im[3]~22\ # !\u_fft|b_im\(4)) # !\u_fft|a_im\(4) & !\u_fft|b_im\(4) & !\u_fft|dn_im[3]~22\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "962b",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(4),
	datab => \u_fft|b_im\(4),
	cin => \u_fft|dn_im[3]~22\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_im\(4),
	cout => \u_fft|dn_im[4]~24\);

\u_fft|up_im[1]~47\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_im[1]~47_cout\ = CARRY(\u_fft|a_im\(0) & \u_fft|b_im\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0088",
	operation_mode => "arithmetic",
	output_mode => "none",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(0),
	datab => \u_fft|b_im\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|up_im[1]~46COMB\,
	cout => \u_fft|up_im[1]~47_cout\);

\u_fft|up_im[4]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_im\(4) = DFFE(\u_fft|a_im\(4) $ \u_fft|b_im\(4) $ !\u_fft|up_im[3]~20\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_im[4]~22\ = CARRY(\u_fft|a_im\(4) & (\u_fft|b_im\(4) # !\u_fft|up_im[3]~20\) # !\u_fft|a_im\(4) & \u_fft|b_im\(4) & !\u_fft|up_im[3]~20\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "698e",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(4),
	datab => \u_fft|b_im\(4),
	cin => \u_fft|up_im[3]~20\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_im\(4),
	cout => \u_fft|up_im[4]~22\);

\u_fft|Selector37~2\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector37~2_combout\ = \u_fft|st.S0_WR_TOP_RE~regout\ & (\u_fft|up_im\(4) # \u_fft|st.S0_WR_BOT_RE~regout\ & \u_fft|dn_im\(4)) # !\u_fft|st.S0_WR_TOP_RE~regout\ & \u_fft|st.S0_WR_BOT_RE~regout\ & \u_fft|dn_im\(4)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eac0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_TOP_RE~regout\,
	datab => \u_fft|st.S0_WR_BOT_RE~regout\,
	datac => \u_fft|dn_im\(4),
	datad => \u_fft|up_im\(4),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector37~2_combout\);

\u_fft|b_re[4]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_re\(4) = DFFE(\ram_inst|mem_rtl_0|segment[0][4]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_re[0]~18_combout\)

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
	ena => \u_fft|b_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_re\(4));

\u_fft|dn_re[4]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_re\(4) = DFFE(\u_fft|a_re\(4) $ \u_fft|b_re\(4) $ \u_fft|dn_re[3]~22\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_re[4]~24\ = CARRY(\u_fft|a_re\(4) & (!\u_fft|dn_re[3]~22\ # !\u_fft|b_re\(4)) # !\u_fft|a_re\(4) & !\u_fft|b_re\(4) & !\u_fft|dn_re[3]~22\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "962b",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_re\(4),
	datab => \u_fft|b_re\(4),
	cin => \u_fft|dn_re[3]~22\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_re\(4),
	cout => \u_fft|dn_re[4]~24\);

\u_fft|Selector37~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector37~1_combout\ = \u_fft|up_re\(4) & (\u_fft|st.S0_CALC~regout\ # \u_fft|dn_re\(4) & \u_fft|st.S0_WR_TOP_IM~regout\) # !\u_fft|up_re\(4) & \u_fft|dn_re\(4) & (\u_fft|st.S0_WR_TOP_IM~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eca0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|up_re\(4),
	datab => \u_fft|dn_re\(4),
	datac => \u_fft|st.S0_CALC~regout\,
	datad => \u_fft|st.S0_WR_TOP_IM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector37~1_combout\);

\u_fft|dout_int[4]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dout_int\(4) = DFFE(\u_fft|Selector37~2_combout\ # \u_fft|Selector37~1_combout\ # \u_fft|dout_int\(4) & \u_fft|WideOr17~combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fff8",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|dout_int\(4),
	datab => \u_fft|WideOr17~combout\,
	datac => \u_fft|Selector37~2_combout\,
	datad => \u_fft|Selector37~1_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dout_int\(4));

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

\u_in|dout_int[4]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int\(4) = DFFE(\adc_sample~combout\(4), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

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
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|dout_int\(4));

\ram_dout[4]~20\ : apex20ke_lcell
-- Equation(s):
-- \ram_dout[4]~20_combout\ = \phase.PH_FFT~regout\ & (\u_fft|dout_int\(4)) # !\phase.PH_FFT~regout\ & (\u_in|dout_int\(4))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f5a0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \phase.PH_FFT~regout\,
	datac => \u_fft|dout_int\(4),
	datad => \u_in|dout_int\(4),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_dout[4]~20_combout\);

\ram_inst|mem_rtl_0|segment[0][4]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	address_width => 4,
	bit_number => 4,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "db/SpectAnalyzer.ram0_ram_sp_ed4f5dd0.hdl.mif",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_sp:ram_inst|altdpram:mem_rtl_0|content",
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
	datain => \ram_dout[4]~20_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we~4_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][4]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][4]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][4]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][4]~dataout\);

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

\u_in|dout_int[5]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int\(5) = DFFE(\adc_sample~combout\(5), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

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
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|dout_int\(5));

\u_fft|a_im[0]~18\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_im[0]~18_combout\ = \rst_n~combout\ & \u_fft|st.S0_RD_TOP_IM~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c0c0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \rst_n~combout\,
	datac => \u_fft|st.S0_RD_TOP_IM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|a_im[0]~18_combout\);

\u_fft|a_im[5]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_im\(5) = DFFE(\ram_inst|mem_rtl_0|segment[0][5]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_im[0]~18_combout\)

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
	ena => \u_fft|a_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_im\(5));

\u_fft|dn_im[5]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_im\(5) = DFFE(\u_fft|b_im\(5) $ \u_fft|a_im\(5) $ !\u_fft|dn_im[4]~24\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_im[5]~26\ = CARRY(\u_fft|b_im\(5) & (!\u_fft|dn_im[4]~24\ # !\u_fft|a_im\(5)) # !\u_fft|b_im\(5) & !\u_fft|a_im\(5) & !\u_fft|dn_im[4]~24\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "692b",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_im\(5),
	datab => \u_fft|a_im\(5),
	cin => \u_fft|dn_im[4]~24\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_im\(5),
	cout => \u_fft|dn_im[5]~26\);

\u_fft|b_im[5]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_im\(5) = DFFE(\ram_inst|mem_rtl_0|segment[0][5]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_im[0]~18_combout\)

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
	ena => \u_fft|b_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_im\(5));

\u_fft|up_im[5]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_im\(5) = DFFE(\u_fft|a_im\(5) $ \u_fft|b_im\(5) $ \u_fft|up_im[4]~22\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_im[5]~24\ = CARRY(\u_fft|a_im\(5) & !\u_fft|b_im\(5) & !\u_fft|up_im[4]~22\ # !\u_fft|a_im\(5) & (!\u_fft|up_im[4]~22\ # !\u_fft|b_im\(5)))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(5),
	datab => \u_fft|b_im\(5),
	cin => \u_fft|up_im[4]~22\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_im\(5),
	cout => \u_fft|up_im[5]~24\);

\u_fft|Selector36~2\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector36~2_combout\ = \u_fft|st.S0_WR_TOP_RE~regout\ & (\u_fft|up_im\(5) # \u_fft|st.S0_WR_BOT_RE~regout\ & \u_fft|dn_im\(5)) # !\u_fft|st.S0_WR_TOP_RE~regout\ & \u_fft|st.S0_WR_BOT_RE~regout\ & \u_fft|dn_im\(5)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eac0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_TOP_RE~regout\,
	datab => \u_fft|st.S0_WR_BOT_RE~regout\,
	datac => \u_fft|dn_im\(5),
	datad => \u_fft|up_im\(5),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector36~2_combout\);

\u_fft|b_re[5]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_re\(5) = DFFE(\ram_inst|mem_rtl_0|segment[0][5]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_re[0]~18_combout\)

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
	ena => \u_fft|b_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_re\(5));

\u_fft|dn_re[5]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_re\(5) = DFFE(\u_fft|a_re\(5) $ \u_fft|b_re\(5) $ !\u_fft|dn_re[4]~24\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_re[5]~26\ = CARRY(\u_fft|a_re\(5) & \u_fft|b_re\(5) & !\u_fft|dn_re[4]~24\ # !\u_fft|a_re\(5) & (\u_fft|b_re\(5) # !\u_fft|dn_re[4]~24\))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "694d",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_re\(5),
	datab => \u_fft|b_re\(5),
	cin => \u_fft|dn_re[4]~24\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_re\(5),
	cout => \u_fft|dn_re[5]~26\);

\u_fft|Selector36~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector36~1_combout\ = \u_fft|up_re\(5) & (\u_fft|st.S0_CALC~regout\ # \u_fft|dn_re\(5) & \u_fft|st.S0_WR_TOP_IM~regout\) # !\u_fft|up_re\(5) & \u_fft|dn_re\(5) & (\u_fft|st.S0_WR_TOP_IM~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eca0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|up_re\(5),
	datab => \u_fft|dn_re\(5),
	datac => \u_fft|st.S0_CALC~regout\,
	datad => \u_fft|st.S0_WR_TOP_IM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector36~1_combout\);

\u_fft|dout_int[5]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dout_int\(5) = DFFE(\u_fft|Selector36~2_combout\ # \u_fft|Selector36~1_combout\ # \u_fft|dout_int\(5) & \u_fft|WideOr17~combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fff8",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|dout_int\(5),
	datab => \u_fft|WideOr17~combout\,
	datac => \u_fft|Selector36~2_combout\,
	datad => \u_fft|Selector36~1_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dout_int\(5));

\ram_dout[5]~21\ : apex20ke_lcell
-- Equation(s):
-- \ram_dout[5]~21_combout\ = \phase.PH_FFT~regout\ & (\u_fft|dout_int\(5)) # !\phase.PH_FFT~regout\ & (\u_in|dout_int\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fa50",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \phase.PH_FFT~regout\,
	datac => \u_in|dout_int\(5),
	datad => \u_fft|dout_int\(5),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_dout[5]~21_combout\);

\ram_inst|mem_rtl_0|segment[0][5]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	address_width => 4,
	bit_number => 5,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "db/SpectAnalyzer.ram0_ram_sp_ed4f5dd0.hdl.mif",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_sp:ram_inst|altdpram:mem_rtl_0|content",
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
	datain => \ram_dout[5]~21_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we~4_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][5]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][5]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][5]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][5]~dataout\);

\u_fft|a_re[6]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_re\(6) = DFFE(\ram_inst|mem_rtl_0|segment[0][6]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_re[0]~18_combout\)

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
	ena => \u_fft|a_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_re\(6));

\u_fft|a_re[5]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_re\(5) = DFFE(\ram_inst|mem_rtl_0|segment[0][5]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_re[0]~18_combout\)

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
	ena => \u_fft|a_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_re\(5));

\u_fft|a_re[4]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_re\(4) = DFFE(\ram_inst|mem_rtl_0|segment[0][4]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_re[0]~18_combout\)

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
	ena => \u_fft|a_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_re\(4));

\u_fft|up_re[6]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_re\(6) = DFFE(\u_fft|b_re\(6) $ \u_fft|a_re\(6) $ !\u_fft|up_re[5]~24\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_re[6]~26\ = CARRY(\u_fft|b_re\(6) & (\u_fft|a_re\(6) # !\u_fft|up_re[5]~24\) # !\u_fft|b_re\(6) & \u_fft|a_re\(6) & !\u_fft|up_re[5]~24\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "698e",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_re\(6),
	datab => \u_fft|a_re\(6),
	cin => \u_fft|up_re[5]~24\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_re\(6),
	cout => \u_fft|up_re[6]~26\);

\u_fft|b_re[6]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_re\(6) = DFFE(\ram_inst|mem_rtl_0|segment[0][6]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_re[0]~18_combout\)

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
	ena => \u_fft|b_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_re\(6));

\u_fft|dn_re[6]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_re\(6) = DFFE(\u_fft|a_re\(6) $ \u_fft|b_re\(6) $ \u_fft|dn_re[5]~26\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_re[6]~28\ = CARRY(\u_fft|a_re\(6) & (!\u_fft|dn_re[5]~26\ # !\u_fft|b_re\(6)) # !\u_fft|a_re\(6) & !\u_fft|b_re\(6) & !\u_fft|dn_re[5]~26\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "962b",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_re\(6),
	datab => \u_fft|b_re\(6),
	cin => \u_fft|dn_re[5]~26\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_re\(6),
	cout => \u_fft|dn_re[6]~28\);

\u_fft|Selector35~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector35~1_combout\ = \u_fft|st.S0_WR_TOP_IM~regout\ & (\u_fft|dn_re\(6) # \u_fft|st.S0_CALC~regout\ & \u_fft|up_re\(6)) # !\u_fft|st.S0_WR_TOP_IM~regout\ & \u_fft|st.S0_CALC~regout\ & \u_fft|up_re\(6)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eac0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_TOP_IM~regout\,
	datab => \u_fft|st.S0_CALC~regout\,
	datac => \u_fft|up_re\(6),
	datad => \u_fft|dn_re\(6),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector35~1_combout\);

\u_fft|b_im[6]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_im\(6) = DFFE(\ram_inst|mem_rtl_0|segment[0][6]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_im[0]~18_combout\)

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
	ena => \u_fft|b_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_im\(6));

\u_fft|up_im[6]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_im\(6) = DFFE(\u_fft|a_im\(6) $ \u_fft|b_im\(6) $ !\u_fft|up_im[5]~24\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_im[6]~26\ = CARRY(\u_fft|a_im\(6) & (\u_fft|b_im\(6) # !\u_fft|up_im[5]~24\) # !\u_fft|a_im\(6) & \u_fft|b_im\(6) & !\u_fft|up_im[5]~24\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "698e",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(6),
	datab => \u_fft|b_im\(6),
	cin => \u_fft|up_im[5]~24\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_im\(6),
	cout => \u_fft|up_im[6]~26\);

\u_fft|Selector35~2\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector35~2_combout\ = \u_fft|st.S0_WR_BOT_RE~regout\ & (\u_fft|dn_im\(6) # \u_fft|up_im\(6) & \u_fft|st.S0_WR_TOP_RE~regout\) # !\u_fft|st.S0_WR_BOT_RE~regout\ & \u_fft|up_im\(6) & (\u_fft|st.S0_WR_TOP_RE~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eca0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_BOT_RE~regout\,
	datab => \u_fft|up_im\(6),
	datac => \u_fft|dn_im\(6),
	datad => \u_fft|st.S0_WR_TOP_RE~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector35~2_combout\);

\u_fft|dout_int[6]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dout_int\(6) = DFFE(\u_fft|Selector35~1_combout\ # \u_fft|Selector35~2_combout\ # \u_fft|WideOr17~combout\ & \u_fft|dout_int\(6), GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fff8",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|WideOr17~combout\,
	datab => \u_fft|dout_int\(6),
	datac => \u_fft|Selector35~1_combout\,
	datad => \u_fft|Selector35~2_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dout_int\(6));

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

\u_in|dout_int[6]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int\(6) = DFFE(\adc_sample~combout\(6), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

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
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|dout_int\(6));

\ram_dout[6]~22\ : apex20ke_lcell
-- Equation(s):
-- \ram_dout[6]~22_combout\ = \phase.PH_FFT~regout\ & (\u_fft|dout_int\(6)) # !\phase.PH_FFT~regout\ & (\u_in|dout_int\(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f5a0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \phase.PH_FFT~regout\,
	datac => \u_fft|dout_int\(6),
	datad => \u_in|dout_int\(6),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_dout[6]~22_combout\);

\ram_inst|mem_rtl_0|segment[0][6]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	address_width => 4,
	bit_number => 6,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "db/SpectAnalyzer.ram0_ram_sp_ed4f5dd0.hdl.mif",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_sp:ram_inst|altdpram:mem_rtl_0|content",
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
	datain => \ram_dout[6]~22_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we~4_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][6]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][6]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][6]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][6]~dataout\);

\u_fft|b_re[7]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_re\(7) = DFFE(\ram_inst|mem_rtl_0|segment[0][7]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_re[0]~18_combout\)

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
	ena => \u_fft|b_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_re\(7));

\u_fft|dn_re[7]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_re\(7) = DFFE(\u_fft|a_re\(7) $ \u_fft|b_re\(7) $ !\u_fft|dn_re[6]~28\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_re[7]~30\ = CARRY(\u_fft|a_re\(7) & \u_fft|b_re\(7) & !\u_fft|dn_re[6]~28\ # !\u_fft|a_re\(7) & (\u_fft|b_re\(7) # !\u_fft|dn_re[6]~28\))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "694d",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_re\(7),
	datab => \u_fft|b_re\(7),
	cin => \u_fft|dn_re[6]~28\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_re\(7),
	cout => \u_fft|dn_re[7]~30\);

\u_fft|a_re[7]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_re\(7) = DFFE(\ram_inst|mem_rtl_0|segment[0][7]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_re[0]~18_combout\)

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
	ena => \u_fft|a_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_re\(7));

\u_fft|up_re[7]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_re\(7) = DFFE(\u_fft|b_re\(7) $ \u_fft|a_re\(7) $ \u_fft|up_re[6]~26\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_re[7]~28\ = CARRY(\u_fft|b_re\(7) & !\u_fft|a_re\(7) & !\u_fft|up_re[6]~26\ # !\u_fft|b_re\(7) & (!\u_fft|up_re[6]~26\ # !\u_fft|a_re\(7)))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_re\(7),
	datab => \u_fft|a_re\(7),
	cin => \u_fft|up_re[6]~26\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_re\(7),
	cout => \u_fft|up_re[7]~28\);

\u_fft|Selector34~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector34~1_combout\ = \u_fft|st.S0_CALC~regout\ & (\u_fft|up_re\(7) # \u_fft|dn_re\(7) & \u_fft|st.S0_WR_TOP_IM~regout\) # !\u_fft|st.S0_CALC~regout\ & \u_fft|dn_re\(7) & (\u_fft|st.S0_WR_TOP_IM~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eca0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_CALC~regout\,
	datab => \u_fft|dn_re\(7),
	datac => \u_fft|up_re\(7),
	datad => \u_fft|st.S0_WR_TOP_IM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector34~1_combout\);

\u_fft|b_im[7]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_im\(7) = DFFE(\ram_inst|mem_rtl_0|segment[0][7]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_im[0]~18_combout\)

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
	ena => \u_fft|b_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_im\(7));

\u_fft|up_im[7]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_im\(7) = DFFE(\u_fft|a_im\(7) $ \u_fft|b_im\(7) $ \u_fft|up_im[6]~26\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_im[7]~28\ = CARRY(\u_fft|a_im\(7) & !\u_fft|b_im\(7) & !\u_fft|up_im[6]~26\ # !\u_fft|a_im\(7) & (!\u_fft|up_im[6]~26\ # !\u_fft|b_im\(7)))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_im\(7),
	datab => \u_fft|b_im\(7),
	cin => \u_fft|up_im[6]~26\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_im\(7),
	cout => \u_fft|up_im[7]~28\);

\u_fft|Selector34~2\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector34~2_combout\ = \u_fft|dn_im\(7) & (\u_fft|st.S0_WR_BOT_RE~regout\ # \u_fft|up_im\(7) & \u_fft|st.S0_WR_TOP_RE~regout\) # !\u_fft|dn_im\(7) & (\u_fft|up_im\(7) & \u_fft|st.S0_WR_TOP_RE~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f888",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|dn_im\(7),
	datab => \u_fft|st.S0_WR_BOT_RE~regout\,
	datac => \u_fft|up_im\(7),
	datad => \u_fft|st.S0_WR_TOP_RE~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector34~2_combout\);

\u_fft|dout_int[7]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dout_int\(7) = DFFE(\u_fft|Selector34~1_combout\ # \u_fft|Selector34~2_combout\ # \u_fft|dout_int\(7) & \u_fft|WideOr17~combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fff8",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|dout_int\(7),
	datab => \u_fft|WideOr17~combout\,
	datac => \u_fft|Selector34~1_combout\,
	datad => \u_fft|Selector34~2_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dout_int\(7));

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

\u_in|dout_int[7]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int\(7) = DFFE(\adc_sample~combout\(7), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0f0",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datac => \adc_sample~combout\(7),
	clk => \clk~combout\,
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|dout_int\(7));

\ram_dout[7]~23\ : apex20ke_lcell
-- Equation(s):
-- \ram_dout[7]~23_combout\ = \phase.PH_FFT~regout\ & (\u_fft|dout_int\(7)) # !\phase.PH_FFT~regout\ & (\u_in|dout_int\(7))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f5a0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \phase.PH_FFT~regout\,
	datac => \u_fft|dout_int\(7),
	datad => \u_in|dout_int\(7),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_dout[7]~23_combout\);

\ram_inst|mem_rtl_0|segment[0][7]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	address_width => 4,
	bit_number => 7,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "db/SpectAnalyzer.ram0_ram_sp_ed4f5dd0.hdl.mif",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_sp:ram_inst|altdpram:mem_rtl_0|content",
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
	datain => \ram_dout[7]~23_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we~4_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][7]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][7]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][7]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][7]~dataout\);

\u_fft|b_re[8]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_re\(8) = DFFE(\ram_inst|mem_rtl_0|segment[0][8]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_re[0]~18_combout\)

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
	ena => \u_fft|b_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_re\(8));

\u_fft|dn_re[8]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_re\(8) = DFFE(\u_fft|a_re\(8) $ \u_fft|b_re\(8) $ \u_fft|dn_re[7]~30\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_re[8]~32\ = CARRY(\u_fft|a_re\(8) & (!\u_fft|dn_re[7]~30\ # !\u_fft|b_re\(8)) # !\u_fft|a_re\(8) & !\u_fft|b_re\(8) & !\u_fft|dn_re[7]~30\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "962b",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_re\(8),
	datab => \u_fft|b_re\(8),
	cin => \u_fft|dn_re[7]~30\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_re\(8),
	cout => \u_fft|dn_re[8]~32\);

\u_fft|a_re[8]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_re\(8) = DFFE(\ram_inst|mem_rtl_0|segment[0][8]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_re[0]~18_combout\)

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
	ena => \u_fft|a_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_re\(8));

\u_fft|up_re[8]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_re\(8) = DFFE(\u_fft|b_re\(8) $ \u_fft|a_re\(8) $ !\u_fft|up_re[7]~28\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_re[8]~30\ = CARRY(\u_fft|b_re\(8) & (\u_fft|a_re\(8) # !\u_fft|up_re[7]~28\) # !\u_fft|b_re\(8) & \u_fft|a_re\(8) & !\u_fft|up_re[7]~28\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "698e",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_re\(8),
	datab => \u_fft|a_re\(8),
	cin => \u_fft|up_re[7]~28\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_re\(8),
	cout => \u_fft|up_re[8]~30\);

\u_fft|Selector33~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector33~1_combout\ = \u_fft|st.S0_CALC~regout\ & (\u_fft|up_re\(8) # \u_fft|dn_re\(8) & \u_fft|st.S0_WR_TOP_IM~regout\) # !\u_fft|st.S0_CALC~regout\ & \u_fft|dn_re\(8) & \u_fft|st.S0_WR_TOP_IM~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eac0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_CALC~regout\,
	datab => \u_fft|dn_re\(8),
	datac => \u_fft|st.S0_WR_TOP_IM~regout\,
	datad => \u_fft|up_re\(8),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector33~1_combout\);

\u_fft|dout_int[8]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dout_int\(8) = DFFE(\u_fft|Selector33~2_combout\ # \u_fft|Selector33~1_combout\ # \u_fft|dout_int\(8) & \u_fft|WideOr17~combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fefa",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|Selector33~2_combout\,
	datab => \u_fft|dout_int\(8),
	datac => \u_fft|Selector33~1_combout\,
	datad => \u_fft|WideOr17~combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dout_int\(8));

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

\u_in|dout_int[8]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int\(8) = DFFE(\adc_sample~combout\(8), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

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
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|dout_int\(8));

\ram_dout[8]~24\ : apex20ke_lcell
-- Equation(s):
-- \ram_dout[8]~24_combout\ = \phase.PH_FFT~regout\ & \u_fft|dout_int\(8) # !\phase.PH_FFT~regout\ & (\u_in|dout_int\(8))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccf0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|dout_int\(8),
	datac => \u_in|dout_int\(8),
	datad => \phase.PH_FFT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_dout[8]~24_combout\);

\ram_inst|mem_rtl_0|segment[0][8]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	address_width => 4,
	bit_number => 8,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "db/SpectAnalyzer.ram0_ram_sp_ed4f5dd0.hdl.mif",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_sp:ram_inst|altdpram:mem_rtl_0|content",
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
	datain => \ram_dout[8]~24_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we~4_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][8]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][8]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][8]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][8]~dataout\);

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

\u_in|dout_int[9]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int\(9) = DFFE(\adc_sample~combout\(9), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

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
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|dout_int\(9));

\u_fft|a_re[9]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_re\(9) = DFFE(\ram_inst|mem_rtl_0|segment[0][9]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_re[0]~18_combout\)

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
	ena => \u_fft|a_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_re\(9));

\u_fft|up_re[9]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_re\(9) = DFFE(\u_fft|b_re\(9) $ \u_fft|a_re\(9) $ \u_fft|up_re[8]~30\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_re[9]~32\ = CARRY(\u_fft|b_re\(9) & !\u_fft|a_re\(9) & !\u_fft|up_re[8]~30\ # !\u_fft|b_re\(9) & (!\u_fft|up_re[8]~30\ # !\u_fft|a_re\(9)))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_re\(9),
	datab => \u_fft|a_re\(9),
	cin => \u_fft|up_re[8]~30\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_re\(9),
	cout => \u_fft|up_re[9]~32\);

\u_fft|Selector32~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector32~1_combout\ = \u_fft|dn_re\(9) & (\u_fft|st.S0_WR_TOP_IM~regout\ # \u_fft|st.S0_CALC~regout\ & \u_fft|up_re\(9)) # !\u_fft|dn_re\(9) & (\u_fft|st.S0_CALC~regout\ & \u_fft|up_re\(9))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f888",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|dn_re\(9),
	datab => \u_fft|st.S0_WR_TOP_IM~regout\,
	datac => \u_fft|st.S0_CALC~regout\,
	datad => \u_fft|up_re\(9),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector32~1_combout\);

\u_fft|dout_int[9]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dout_int\(9) = DFFE(\u_fft|Selector32~2_combout\ # \u_fft|Selector32~1_combout\ # \u_fft|dout_int\(9) & \u_fft|WideOr17~combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fefa",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|Selector32~2_combout\,
	datab => \u_fft|dout_int\(9),
	datac => \u_fft|Selector32~1_combout\,
	datad => \u_fft|WideOr17~combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dout_int\(9));

\ram_dout[9]~25\ : apex20ke_lcell
-- Equation(s):
-- \ram_dout[9]~25_combout\ = \phase.PH_FFT~regout\ & (\u_fft|dout_int\(9)) # !\phase.PH_FFT~regout\ & (\u_in|dout_int\(9))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fa50",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \phase.PH_FFT~regout\,
	datac => \u_in|dout_int\(9),
	datad => \u_fft|dout_int\(9),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_dout[9]~25_combout\);

\ram_inst|mem_rtl_0|segment[0][9]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	address_width => 4,
	bit_number => 9,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "db/SpectAnalyzer.ram0_ram_sp_ed4f5dd0.hdl.mif",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_sp:ram_inst|altdpram:mem_rtl_0|content",
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
	datain => \ram_dout[9]~25_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we~4_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][9]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][9]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][9]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][9]~dataout\);

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

\u_in|dout_int[10]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int\(10) = DFFE(\adc_sample~combout\(10), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

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
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|dout_int\(10));

\u_fft|b_re[10]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_re\(10) = DFFE(\ram_inst|mem_rtl_0|segment[0][10]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_re[0]~18_combout\)

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
	ena => \u_fft|b_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_re\(10));

\u_fft|b_re[9]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_re\(9) = DFFE(\ram_inst|mem_rtl_0|segment[0][9]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_re[0]~18_combout\)

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
	ena => \u_fft|b_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_re\(9));

\u_fft|dn_re[10]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_re\(10) = DFFE(\u_fft|a_re\(10) $ \u_fft|b_re\(10) $ \u_fft|dn_re[9]~34\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_re[10]~36\ = CARRY(\u_fft|a_re\(10) & (!\u_fft|dn_re[9]~34\ # !\u_fft|b_re\(10)) # !\u_fft|a_re\(10) & !\u_fft|b_re\(10) & !\u_fft|dn_re[9]~34\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "962b",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_re\(10),
	datab => \u_fft|b_re\(10),
	cin => \u_fft|dn_re[9]~34\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_re\(10),
	cout => \u_fft|dn_re[10]~36\);

\u_fft|Selector31~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector31~1_combout\ = \u_fft|up_re\(10) & (\u_fft|st.S0_CALC~regout\ # \u_fft|dn_re\(10) & \u_fft|st.S0_WR_TOP_IM~regout\) # !\u_fft|up_re\(10) & \u_fft|dn_re\(10) & \u_fft|st.S0_WR_TOP_IM~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eac0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|up_re\(10),
	datab => \u_fft|dn_re\(10),
	datac => \u_fft|st.S0_WR_TOP_IM~regout\,
	datad => \u_fft|st.S0_CALC~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector31~1_combout\);

\u_fft|a_im[10]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_im\(10) = DFFE(\ram_inst|mem_rtl_0|segment[0][10]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_im[0]~18_combout\)

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
	ena => \u_fft|a_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_im\(10));

\u_fft|b_im[9]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_im\(9) = DFFE(\ram_inst|mem_rtl_0|segment[0][9]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_im[0]~18_combout\)

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
	ena => \u_fft|b_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_im\(9));

\u_fft|b_im[8]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_im\(8) = DFFE(\ram_inst|mem_rtl_0|segment[0][8]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_im[0]~18_combout\)

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
	ena => \u_fft|b_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_im\(8));

\u_fft|up_im[10]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_im\(10) = DFFE(\u_fft|b_im\(10) $ \u_fft|a_im\(10) $ !\u_fft|up_im[9]~32\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_im[10]~34\ = CARRY(\u_fft|b_im\(10) & (\u_fft|a_im\(10) # !\u_fft|up_im[9]~32\) # !\u_fft|b_im\(10) & \u_fft|a_im\(10) & !\u_fft|up_im[9]~32\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "698e",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_im\(10),
	datab => \u_fft|a_im\(10),
	cin => \u_fft|up_im[9]~32\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_im\(10),
	cout => \u_fft|up_im[10]~34\);

\u_fft|Selector31~2\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector31~2_combout\ = \u_fft|dn_im\(10) & (\u_fft|st.S0_WR_BOT_RE~regout\ # \u_fft|up_im\(10) & \u_fft|st.S0_WR_TOP_RE~regout\) # !\u_fft|dn_im\(10) & \u_fft|up_im\(10) & (\u_fft|st.S0_WR_TOP_RE~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eca0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|dn_im\(10),
	datab => \u_fft|up_im\(10),
	datac => \u_fft|st.S0_WR_BOT_RE~regout\,
	datad => \u_fft|st.S0_WR_TOP_RE~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector31~2_combout\);

\u_fft|dout_int[10]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dout_int\(10) = DFFE(\u_fft|Selector31~1_combout\ # \u_fft|Selector31~2_combout\ # \u_fft|dout_int\(10) & \u_fft|WideOr17~combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ffec",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|dout_int\(10),
	datab => \u_fft|Selector31~1_combout\,
	datac => \u_fft|WideOr17~combout\,
	datad => \u_fft|Selector31~2_combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dout_int\(10));

\ram_dout[10]~26\ : apex20ke_lcell
-- Equation(s):
-- \ram_dout[10]~26_combout\ = \phase.PH_FFT~regout\ & (\u_fft|dout_int\(10)) # !\phase.PH_FFT~regout\ & \u_in|dout_int\(10)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fc30",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \phase.PH_FFT~regout\,
	datac => \u_in|dout_int\(10),
	datad => \u_fft|dout_int\(10),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_dout[10]~26_combout\);

\ram_inst|mem_rtl_0|segment[0][10]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	address_width => 4,
	bit_number => 10,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "db/SpectAnalyzer.ram0_ram_sp_ed4f5dd0.hdl.mif",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_sp:ram_inst|altdpram:mem_rtl_0|content",
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
	datain => \ram_dout[10]~26_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we~4_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][10]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][10]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][10]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][10]~dataout\);

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

\u_in|dout_int[11]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int\(11) = DFFE(\adc_sample~combout\(11), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

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
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|dout_int\(11));

\u_fft|b_re[11]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_re\(11) = DFFE(\ram_inst|mem_rtl_0|segment[0][11]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_re[0]~18_combout\)

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
	ena => \u_fft|b_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_re\(11));

\u_fft|dn_re[11]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_re\(11) = DFFE(\u_fft|a_re\(11) $ \u_fft|b_re\(11) $ !\u_fft|dn_re[10]~36\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_re[11]~38\ = CARRY(\u_fft|a_re\(11) & \u_fft|b_re\(11) & !\u_fft|dn_re[10]~36\ # !\u_fft|a_re\(11) & (\u_fft|b_re\(11) # !\u_fft|dn_re[10]~36\))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "694d",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_re\(11),
	datab => \u_fft|b_re\(11),
	cin => \u_fft|dn_re[10]~36\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_re\(11),
	cout => \u_fft|dn_re[11]~38\);

\u_fft|Selector30~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector30~1_combout\ = \u_fft|up_re\(11) & (\u_fft|st.S0_CALC~regout\ # \u_fft|dn_re\(11) & \u_fft|st.S0_WR_TOP_IM~regout\) # !\u_fft|up_re\(11) & \u_fft|dn_re\(11) & (\u_fft|st.S0_WR_TOP_IM~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eca0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|up_re\(11),
	datab => \u_fft|dn_re\(11),
	datac => \u_fft|st.S0_CALC~regout\,
	datad => \u_fft|st.S0_WR_TOP_IM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector30~1_combout\);

\u_fft|dout_int[11]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dout_int\(11) = DFFE(\u_fft|Selector30~2_combout\ # \u_fft|Selector30~1_combout\ # \u_fft|dout_int\(11) & \u_fft|WideOr17~combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fefa",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|Selector30~2_combout\,
	datab => \u_fft|dout_int\(11),
	datac => \u_fft|Selector30~1_combout\,
	datad => \u_fft|WideOr17~combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dout_int\(11));

\ram_dout[11]~27\ : apex20ke_lcell
-- Equation(s):
-- \ram_dout[11]~27_combout\ = \phase.PH_FFT~regout\ & (\u_fft|dout_int\(11)) # !\phase.PH_FFT~regout\ & \u_in|dout_int\(11)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fc30",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \phase.PH_FFT~regout\,
	datac => \u_in|dout_int\(11),
	datad => \u_fft|dout_int\(11),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_dout[11]~27_combout\);

\ram_inst|mem_rtl_0|segment[0][11]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	address_width => 4,
	bit_number => 11,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "db/SpectAnalyzer.ram0_ram_sp_ed4f5dd0.hdl.mif",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_sp:ram_inst|altdpram:mem_rtl_0|content",
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
	datain => \ram_dout[11]~27_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we~4_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][11]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][11]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][11]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][11]~dataout\);

\u_fft|b_re[12]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_re\(12) = DFFE(\ram_inst|mem_rtl_0|segment[0][12]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_re[0]~18_combout\)

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
	ena => \u_fft|b_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_re\(12));

\u_fft|a_re[11]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_re\(11) = DFFE(\ram_inst|mem_rtl_0|segment[0][11]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_re[0]~18_combout\)

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
	ena => \u_fft|a_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_re\(11));

\u_fft|a_re[10]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_re\(10) = DFFE(\ram_inst|mem_rtl_0|segment[0][10]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_re[0]~18_combout\)

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
	ena => \u_fft|a_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_re\(10));

\u_fft|up_re[12]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_re\(12) = DFFE(\u_fft|a_re\(12) $ \u_fft|b_re\(12) $ !\u_fft|up_re[11]~36\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_re[12]~38\ = CARRY(\u_fft|a_re\(12) & (\u_fft|b_re\(12) # !\u_fft|up_re[11]~36\) # !\u_fft|a_re\(12) & \u_fft|b_re\(12) & !\u_fft|up_re[11]~36\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "698e",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_re\(12),
	datab => \u_fft|b_re\(12),
	cin => \u_fft|up_re[11]~36\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_re\(12),
	cout => \u_fft|up_re[12]~38\);

\u_fft|dn_re[12]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_re\(12) = DFFE(\u_fft|a_re\(12) $ \u_fft|b_re\(12) $ \u_fft|dn_re[11]~38\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_re[12]~40\ = CARRY(\u_fft|a_re\(12) & (!\u_fft|dn_re[11]~38\ # !\u_fft|b_re\(12)) # !\u_fft|a_re\(12) & !\u_fft|b_re\(12) & !\u_fft|dn_re[11]~38\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "962b",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_re\(12),
	datab => \u_fft|b_re\(12),
	cin => \u_fft|dn_re[11]~38\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_re\(12),
	cout => \u_fft|dn_re[12]~40\);

\u_fft|Selector29~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector29~1_combout\ = \u_fft|st.S0_CALC~regout\ & (\u_fft|up_re\(12) # \u_fft|dn_re\(12) & \u_fft|st.S0_WR_TOP_IM~regout\) # !\u_fft|st.S0_CALC~regout\ & (\u_fft|dn_re\(12) & \u_fft|st.S0_WR_TOP_IM~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f888",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_CALC~regout\,
	datab => \u_fft|up_re\(12),
	datac => \u_fft|dn_re\(12),
	datad => \u_fft|st.S0_WR_TOP_IM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector29~1_combout\);

\u_fft|dout_int[12]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dout_int\(12) = DFFE(\u_fft|Selector29~2_combout\ # \u_fft|Selector29~1_combout\ # \u_fft|dout_int\(12) & \u_fft|WideOr17~combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fefa",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|Selector29~2_combout\,
	datab => \u_fft|dout_int\(12),
	datac => \u_fft|Selector29~1_combout\,
	datad => \u_fft|WideOr17~combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dout_int\(12));

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

\u_in|dout_int[12]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int\(12) = DFFE(\adc_sample~combout\(12), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

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
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|dout_int\(12));

\ram_dout[12]~28\ : apex20ke_lcell
-- Equation(s):
-- \ram_dout[12]~28_combout\ = \phase.PH_FFT~regout\ & \u_fft|dout_int\(12) # !\phase.PH_FFT~regout\ & (\u_in|dout_int\(12))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccf0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|dout_int\(12),
	datac => \u_in|dout_int\(12),
	datad => \phase.PH_FFT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_dout[12]~28_combout\);

\ram_inst|mem_rtl_0|segment[0][12]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	address_width => 4,
	bit_number => 12,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "db/SpectAnalyzer.ram0_ram_sp_ed4f5dd0.hdl.mif",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_sp:ram_inst|altdpram:mem_rtl_0|content",
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
	datain => \ram_dout[12]~28_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we~4_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][12]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][12]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][12]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][12]~dataout\);

\u_fft|b_re[13]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_re\(13) = DFFE(\ram_inst|mem_rtl_0|segment[0][13]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_re[0]~18_combout\)

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
	ena => \u_fft|b_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_re\(13));

\u_fft|dn_re[13]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_re\(13) = DFFE(\u_fft|a_re\(13) $ \u_fft|b_re\(13) $ !\u_fft|dn_re[12]~40\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_re[13]~42\ = CARRY(\u_fft|a_re\(13) & \u_fft|b_re\(13) & !\u_fft|dn_re[12]~40\ # !\u_fft|a_re\(13) & (\u_fft|b_re\(13) # !\u_fft|dn_re[12]~40\))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "694d",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_re\(13),
	datab => \u_fft|b_re\(13),
	cin => \u_fft|dn_re[12]~40\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_re\(13),
	cout => \u_fft|dn_re[13]~42\);

\u_fft|a_re[13]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_re\(13) = DFFE(\ram_inst|mem_rtl_0|segment[0][13]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_re[0]~18_combout\)

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
	ena => \u_fft|a_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_re\(13));

\u_fft|up_re[13]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_re\(13) = DFFE(\u_fft|b_re\(13) $ \u_fft|a_re\(13) $ \u_fft|up_re[12]~38\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_re[13]~40\ = CARRY(\u_fft|b_re\(13) & !\u_fft|a_re\(13) & !\u_fft|up_re[12]~38\ # !\u_fft|b_re\(13) & (!\u_fft|up_re[12]~38\ # !\u_fft|a_re\(13)))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_re\(13),
	datab => \u_fft|a_re\(13),
	cin => \u_fft|up_re[12]~38\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_re\(13),
	cout => \u_fft|up_re[13]~40\);

\u_fft|Selector28~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector28~1_combout\ = \u_fft|st.S0_CALC~regout\ & (\u_fft|up_re\(13) # \u_fft|dn_re\(13) & \u_fft|st.S0_WR_TOP_IM~regout\) # !\u_fft|st.S0_CALC~regout\ & \u_fft|dn_re\(13) & (\u_fft|st.S0_WR_TOP_IM~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eca0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_CALC~regout\,
	datab => \u_fft|dn_re\(13),
	datac => \u_fft|up_re\(13),
	datad => \u_fft|st.S0_WR_TOP_IM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector28~1_combout\);

\u_fft|dout_int[13]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dout_int\(13) = DFFE(\u_fft|Selector28~2_combout\ # \u_fft|Selector28~1_combout\ # \u_fft|dout_int\(13) & \u_fft|WideOr17~combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fefa",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|Selector28~2_combout\,
	datab => \u_fft|dout_int\(13),
	datac => \u_fft|Selector28~1_combout\,
	datad => \u_fft|WideOr17~combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dout_int\(13));

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

\u_in|dout_int[13]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int\(13) = DFFE(\adc_sample~combout\(13), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

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
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|dout_int\(13));

\ram_dout[13]~29\ : apex20ke_lcell
-- Equation(s):
-- \ram_dout[13]~29_combout\ = \phase.PH_FFT~regout\ & \u_fft|dout_int\(13) # !\phase.PH_FFT~regout\ & (\u_in|dout_int\(13))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccf0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|dout_int\(13),
	datac => \u_in|dout_int\(13),
	datad => \phase.PH_FFT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_dout[13]~29_combout\);

\ram_inst|mem_rtl_0|segment[0][13]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	address_width => 4,
	bit_number => 13,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "db/SpectAnalyzer.ram0_ram_sp_ed4f5dd0.hdl.mif",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_sp:ram_inst|altdpram:mem_rtl_0|content",
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
	datain => \ram_dout[13]~29_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we~4_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][13]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][13]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][13]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][13]~dataout\);

\u_fft|a_im[14]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_im\(14) = DFFE(\ram_inst|mem_rtl_0|segment[0][14]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_im[0]~18_combout\)

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
	ena => \u_fft|a_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_im\(14));

\u_fft|a_im[13]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_im\(13) = DFFE(\ram_inst|mem_rtl_0|segment[0][13]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_im[0]~18_combout\)

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
	ena => \u_fft|a_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_im\(13));

\u_fft|b_im[12]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_im\(12) = DFFE(\ram_inst|mem_rtl_0|segment[0][12]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_im[0]~18_combout\)

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
	ena => \u_fft|b_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_im\(12));

\u_fft|a_im[11]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_im\(11) = DFFE(\ram_inst|mem_rtl_0|segment[0][11]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_im[0]~18_combout\)

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
	ena => \u_fft|a_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_im\(11));

\u_fft|up_im[14]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_im\(14) = DFFE(\u_fft|b_im\(14) $ \u_fft|a_im\(14) $ !\u_fft|up_im[13]~40\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_im[14]~42\ = CARRY(\u_fft|b_im\(14) & (\u_fft|a_im\(14) # !\u_fft|up_im[13]~40\) # !\u_fft|b_im\(14) & \u_fft|a_im\(14) & !\u_fft|up_im[13]~40\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "698e",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_im\(14),
	datab => \u_fft|a_im\(14),
	cin => \u_fft|up_im[13]~40\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_im\(14),
	cout => \u_fft|up_im[14]~42\);

\u_fft|Selector27~2\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector27~2_combout\ = \u_fft|dn_im\(14) & (\u_fft|st.S0_WR_BOT_RE~regout\ # \u_fft|up_im\(14) & \u_fft|st.S0_WR_TOP_RE~regout\) # !\u_fft|dn_im\(14) & \u_fft|up_im\(14) & (\u_fft|st.S0_WR_TOP_RE~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eca0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|dn_im\(14),
	datab => \u_fft|up_im\(14),
	datac => \u_fft|st.S0_WR_BOT_RE~regout\,
	datad => \u_fft|st.S0_WR_TOP_RE~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector27~2_combout\);

\u_fft|b_re[14]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_re\(14) = DFFE(\ram_inst|mem_rtl_0|segment[0][14]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_re[0]~18_combout\)

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
	ena => \u_fft|b_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_re\(14));

\u_fft|dn_re[14]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_re\(14) = DFFE(\u_fft|a_re\(14) $ \u_fft|b_re\(14) $ \u_fft|dn_re[13]~42\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|dn_re[14]~44\ = CARRY(\u_fft|a_re\(14) & (!\u_fft|dn_re[13]~42\ # !\u_fft|b_re\(14)) # !\u_fft|a_re\(14) & !\u_fft|b_re\(14) & !\u_fft|dn_re[13]~42\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "962b",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_re\(14),
	datab => \u_fft|b_re\(14),
	cin => \u_fft|dn_re[13]~42\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_re\(14),
	cout => \u_fft|dn_re[14]~44\);

\u_fft|a_re[14]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_re\(14) = DFFE(\ram_inst|mem_rtl_0|segment[0][14]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_re[0]~18_combout\)

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
	ena => \u_fft|a_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_re\(14));

\u_fft|up_re[14]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_re\(14) = DFFE(\u_fft|b_re\(14) $ \u_fft|a_re\(14) $ !\u_fft|up_re[13]~40\, GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)
-- \u_fft|up_re[14]~42\ = CARRY(\u_fft|b_re\(14) & (\u_fft|a_re\(14) # !\u_fft|up_re[13]~40\) # !\u_fft|b_re\(14) & \u_fft|a_re\(14) & !\u_fft|up_re[13]~40\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "698e",
	operation_mode => "arithmetic",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_re\(14),
	datab => \u_fft|a_re\(14),
	cin => \u_fft|up_re[13]~40\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_re\(14),
	cout => \u_fft|up_re[14]~42\);

\u_fft|Selector27~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector27~1_combout\ = \u_fft|st.S0_WR_TOP_IM~regout\ & (\u_fft|dn_re\(14) # \u_fft|st.S0_CALC~regout\ & \u_fft|up_re\(14)) # !\u_fft|st.S0_WR_TOP_IM~regout\ & \u_fft|st.S0_CALC~regout\ & (\u_fft|up_re\(14))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eca0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_TOP_IM~regout\,
	datab => \u_fft|st.S0_CALC~regout\,
	datac => \u_fft|dn_re\(14),
	datad => \u_fft|up_re\(14),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector27~1_combout\);

\u_fft|dout_int[14]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dout_int\(14) = DFFE(\u_fft|Selector27~2_combout\ # \u_fft|Selector27~1_combout\ # \u_fft|dout_int\(14) & \u_fft|WideOr17~combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fefc",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|dout_int\(14),
	datab => \u_fft|Selector27~2_combout\,
	datac => \u_fft|Selector27~1_combout\,
	datad => \u_fft|WideOr17~combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dout_int\(14));

\ram_dout[14]~30\ : apex20ke_lcell
-- Equation(s):
-- \ram_dout[14]~30_combout\ = \phase.PH_FFT~regout\ & (\u_fft|dout_int\(14)) # !\phase.PH_FFT~regout\ & \u_in|dout_int\(14)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0aa",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_in|dout_int\(14),
	datac => \u_fft|dout_int\(14),
	datad => \phase.PH_FFT~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_dout[14]~30_combout\);

\ram_inst|mem_rtl_0|segment[0][14]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	address_width => 4,
	bit_number => 14,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "db/SpectAnalyzer.ram0_ram_sp_ed4f5dd0.hdl.mif",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_sp:ram_inst|altdpram:mem_rtl_0|content",
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
	datain => \ram_dout[14]~30_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we~4_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][14]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][14]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][14]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][14]~dataout\);

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

\u_in|dout_int[15]\ : apex20ke_lcell
-- Equation(s):
-- \u_in|dout_int\(15) = DFFE(\adc_sample~combout\(15), GLOBAL(\clk~combout\), , , \u_in|dout_int[0]~17_combout\)

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
	ena => \u_in|dout_int[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_in|dout_int\(15));

\u_fft|b_re[15]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|b_re\(15) = DFFE(\ram_inst|mem_rtl_0|segment[0][15]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|b_re[0]~18_combout\)

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
	ena => \u_fft|b_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|b_re\(15));

\u_fft|dn_re[15]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dn_re\(15) = DFFE(\u_fft|a_re\(15) $ (\u_fft|dn_re[14]~44\ $ !\u_fft|b_re\(15)), GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "5aa5",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|a_re\(15),
	datad => \u_fft|b_re\(15),
	cin => \u_fft|dn_re[14]~44\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dn_re\(15));

\u_fft|a_re[15]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_re\(15) = DFFE(\ram_inst|mem_rtl_0|segment[0][15]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_re[0]~18_combout\)

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
	ena => \u_fft|a_re[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_re\(15));

\u_fft|up_re[15]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_re\(15) = DFFE(\u_fft|b_re\(15) $ \u_fft|up_re[14]~42\ $ \u_fft|a_re\(15), GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "c33c",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \u_fft|b_re\(15),
	datad => \u_fft|a_re\(15),
	cin => \u_fft|up_re[14]~42\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_re\(15));

\u_fft|Selector26~0\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector26~0_combout\ = \u_fft|st.S0_WR_TOP_IM~regout\ & (\u_fft|dn_re\(15) # \u_fft|up_re\(15) & \u_fft|st.S0_CALC~regout\) # !\u_fft|st.S0_WR_TOP_IM~regout\ & (\u_fft|up_re\(15) & \u_fft|st.S0_CALC~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f888",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|st.S0_WR_TOP_IM~regout\,
	datab => \u_fft|dn_re\(15),
	datac => \u_fft|up_re\(15),
	datad => \u_fft|st.S0_CALC~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector26~0_combout\);

\u_fft|a_im[15]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|a_im\(15) = DFFE(\ram_inst|mem_rtl_0|segment[0][15]~dataout\, GLOBAL(\clk~combout\), , , \u_fft|a_im[0]~18_combout\)

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
	ena => \u_fft|a_im[0]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|a_im\(15));

\u_fft|up_im[15]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|up_im\(15) = DFFE(\u_fft|b_im\(15) $ (\u_fft|up_im[14]~42\ $ \u_fft|a_im\(15)), GLOBAL(\clk~combout\), , , \u_fft|up_re[0]~46_combout\)

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "a55a",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|b_im\(15),
	datad => \u_fft|a_im\(15),
	cin => \u_fft|up_im[14]~42\,
	clk => \clk~combout\,
	ena => \u_fft|up_re[0]~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|up_im\(15));

\u_fft|Selector26~1\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|Selector26~1_combout\ = \u_fft|dn_im\(15) & (\u_fft|st.S0_WR_BOT_RE~regout\ # \u_fft|up_im\(15) & \u_fft|st.S0_WR_TOP_RE~regout\) # !\u_fft|dn_im\(15) & \u_fft|up_im\(15) & \u_fft|st.S0_WR_TOP_RE~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eac0",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|dn_im\(15),
	datab => \u_fft|up_im\(15),
	datac => \u_fft|st.S0_WR_TOP_RE~regout\,
	datad => \u_fft|st.S0_WR_BOT_RE~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \u_fft|Selector26~1_combout\);

\u_fft|dout_int[15]\ : apex20ke_lcell
-- Equation(s):
-- \u_fft|dout_int\(15) = DFFE(\u_fft|Selector26~0_combout\ # \u_fft|Selector26~1_combout\ # \u_fft|dout_int\(15) & \u_fft|WideOr17~combout\, GLOBAL(\clk~combout\), GLOBAL(\rst_n~combout\), , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fefc",
	operation_mode => "normal",
	output_mode => "reg_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	dataa => \u_fft|dout_int\(15),
	datab => \u_fft|Selector26~0_combout\,
	datac => \u_fft|Selector26~1_combout\,
	datad => \u_fft|WideOr17~combout\,
	clk => \clk~combout\,
	aclr => \ALT_INV_rst_n~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \u_fft|dout_int\(15));

\ram_dout[15]~31\ : apex20ke_lcell
-- Equation(s):
-- \ram_dout[15]~31_combout\ = \phase.PH_FFT~regout\ & (\u_fft|dout_int\(15)) # !\phase.PH_FFT~regout\ & \u_in|dout_int\(15)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fc30",
	operation_mode => "normal",
	output_mode => "comb_only",
	packed_mode => "false")
-- pragma translate_on
PORT MAP (
	datab => \phase.PH_FFT~regout\,
	datac => \u_in|dout_int\(15),
	datad => \u_fft|dout_int\(15),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ram_dout[15]~31_combout\);

\ram_inst|mem_rtl_0|segment[0][15]\ : apex20ke_ram_slice
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	address_width => 4,
	bit_number => 15,
	data_in_clear => "none",
	data_in_clock => "clock0",
	data_out_clear => "none",
	data_out_clock => "clock1",
	deep_ram_mode => "off",
	first_address => 0,
	init_file => "db/SpectAnalyzer.ram0_ram_sp_ed4f5dd0.hdl.mif",
	last_address => 15,
	logical_ram_depth => 16,
	logical_ram_name => "ram_sp:ram_inst|altdpram:mem_rtl_0|content",
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
	datain => \ram_dout[15]~31_combout\,
	clk0 => \clk~combout\,
	clk1 => \clk~combout\,
	we => \ram_we~4_combout\,
	re => VCC,
	waddr => \ram_inst|mem_rtl_0|segment[0][15]_WADDR_bus\,
	raddr => \ram_inst|mem_rtl_0|segment[0][15]_RADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	modesel => \ram_inst|mem_rtl_0|segment[0][15]_modesel\,
	dataout => \ram_inst|mem_rtl_0|segment[0][15]~dataout\);

\adc_ready~I\ : apex20ke_io
-- pragma translate_off
GENERIC MAP (
	feedback_mode => "none",
	operation_mode => "output",
	power_up => "low",
	reg_source_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => \u_in|din_ready~regout\,
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
	datain => \ram_inst|mem_rtl_0|segment[0][0]~dataout\,
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
	datain => \ram_inst|mem_rtl_0|segment[0][1]~dataout\,
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
	datain => \ram_inst|mem_rtl_0|segment[0][2]~dataout\,
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
	datain => \ram_inst|mem_rtl_0|segment[0][3]~dataout\,
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
	datain => \ram_inst|mem_rtl_0|segment[0][4]~dataout\,
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
	datain => \ram_inst|mem_rtl_0|segment[0][5]~dataout\,
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
	datain => \ram_inst|mem_rtl_0|segment[0][6]~dataout\,
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
	datain => \ram_inst|mem_rtl_0|segment[0][7]~dataout\,
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
	datain => \ram_inst|mem_rtl_0|segment[0][8]~dataout\,
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
	datain => \ram_inst|mem_rtl_0|segment[0][9]~dataout\,
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
	datain => \ram_inst|mem_rtl_0|segment[0][10]~dataout\,
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
	datain => \ram_inst|mem_rtl_0|segment[0][11]~dataout\,
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
	datain => \ram_inst|mem_rtl_0|segment[0][12]~dataout\,
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
	datain => \ram_inst|mem_rtl_0|segment[0][13]~dataout\,
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
	datain => \ram_inst|mem_rtl_0|segment[0][14]~dataout\,
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
	datain => \ram_inst|mem_rtl_0|segment[0][15]~dataout\,
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
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_dout_valid);
END structure;


