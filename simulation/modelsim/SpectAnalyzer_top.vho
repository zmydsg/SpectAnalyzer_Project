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

-- DATE "06/21/2025 18:50:43"

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
	mag2_out : OUT std_logic_vector(31 DOWNTO 0);
	valid_out : OUT std_logic;
	clk : IN std_logic;
	rst_n : IN std_logic;
	data_in : IN std_logic_vector(15 DOWNTO 0);
	valid_in : IN std_logic;
	done : OUT std_logic
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
SIGNAL ww_mag2_out : std_logic_vector(31 DOWNTO 0);
SIGNAL ww_valid_out : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_rst_n : std_logic;
SIGNAL ww_data_in : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_valid_in : std_logic;
SIGNAL ww_done : std_logic;

BEGIN

mag2_out <= ww_mag2_out;
valid_out <= ww_valid_out;
ww_clk <= clk;
ww_rst_n <= rst_n;
ww_data_in <= data_in;
ww_valid_in <= valid_in;
done <= ww_done;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

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
	padio => ww_clk);

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
	padio => ww_rst_n);

\data_in[0]~I\ : apex20ke_io
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
	padio => ww_data_in(0));

\data_in[1]~I\ : apex20ke_io
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
	padio => ww_data_in(1));

\data_in[2]~I\ : apex20ke_io
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
	padio => ww_data_in(2));

\data_in[3]~I\ : apex20ke_io
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
	padio => ww_data_in(3));

\data_in[4]~I\ : apex20ke_io
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
	padio => ww_data_in(4));

\data_in[5]~I\ : apex20ke_io
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
	padio => ww_data_in(5));

\data_in[6]~I\ : apex20ke_io
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
	padio => ww_data_in(6));

\data_in[7]~I\ : apex20ke_io
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
	padio => ww_data_in(7));

\data_in[8]~I\ : apex20ke_io
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
	padio => ww_data_in(8));

\data_in[9]~I\ : apex20ke_io
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
	padio => ww_data_in(9));

\data_in[10]~I\ : apex20ke_io
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
	padio => ww_data_in(10));

\data_in[11]~I\ : apex20ke_io
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
	padio => ww_data_in(11));

\data_in[12]~I\ : apex20ke_io
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
	padio => ww_data_in(12));

\data_in[13]~I\ : apex20ke_io
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
	padio => ww_data_in(13));

\data_in[14]~I\ : apex20ke_io
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
	padio => ww_data_in(14));

\data_in[15]~I\ : apex20ke_io
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
	padio => ww_data_in(15));

\valid_in~I\ : apex20ke_io
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
	padio => ww_valid_in);

\mag2_out[0]~I\ : apex20ke_io
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
	padio => ww_mag2_out(0));

\mag2_out[1]~I\ : apex20ke_io
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
	padio => ww_mag2_out(1));

\mag2_out[2]~I\ : apex20ke_io
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
	padio => ww_mag2_out(2));

\mag2_out[3]~I\ : apex20ke_io
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
	padio => ww_mag2_out(3));

\mag2_out[4]~I\ : apex20ke_io
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
	padio => ww_mag2_out(4));

\mag2_out[5]~I\ : apex20ke_io
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
	padio => ww_mag2_out(5));

\mag2_out[6]~I\ : apex20ke_io
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
	padio => ww_mag2_out(6));

\mag2_out[7]~I\ : apex20ke_io
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
	padio => ww_mag2_out(7));

\mag2_out[8]~I\ : apex20ke_io
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
	padio => ww_mag2_out(8));

\mag2_out[9]~I\ : apex20ke_io
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
	padio => ww_mag2_out(9));

\mag2_out[10]~I\ : apex20ke_io
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
	padio => ww_mag2_out(10));

\mag2_out[11]~I\ : apex20ke_io
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
	padio => ww_mag2_out(11));

\mag2_out[12]~I\ : apex20ke_io
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
	padio => ww_mag2_out(12));

\mag2_out[13]~I\ : apex20ke_io
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
	padio => ww_mag2_out(13));

\mag2_out[14]~I\ : apex20ke_io
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
	padio => ww_mag2_out(14));

\mag2_out[15]~I\ : apex20ke_io
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
	padio => ww_mag2_out(15));

\mag2_out[16]~I\ : apex20ke_io
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
	padio => ww_mag2_out(16));

\mag2_out[17]~I\ : apex20ke_io
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
	padio => ww_mag2_out(17));

\mag2_out[18]~I\ : apex20ke_io
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
	padio => ww_mag2_out(18));

\mag2_out[19]~I\ : apex20ke_io
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
	padio => ww_mag2_out(19));

\mag2_out[20]~I\ : apex20ke_io
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
	padio => ww_mag2_out(20));

\mag2_out[21]~I\ : apex20ke_io
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
	padio => ww_mag2_out(21));

\mag2_out[22]~I\ : apex20ke_io
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
	padio => ww_mag2_out(22));

\mag2_out[23]~I\ : apex20ke_io
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
	padio => ww_mag2_out(23));

\mag2_out[24]~I\ : apex20ke_io
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
	padio => ww_mag2_out(24));

\mag2_out[25]~I\ : apex20ke_io
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
	padio => ww_mag2_out(25));

\mag2_out[26]~I\ : apex20ke_io
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
	padio => ww_mag2_out(26));

\mag2_out[27]~I\ : apex20ke_io
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
	padio => ww_mag2_out(27));

\mag2_out[28]~I\ : apex20ke_io
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
	padio => ww_mag2_out(28));

\mag2_out[29]~I\ : apex20ke_io
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
	padio => ww_mag2_out(29));

\mag2_out[30]~I\ : apex20ke_io
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
	padio => ww_mag2_out(30));

\mag2_out[31]~I\ : apex20ke_io
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
	padio => ww_mag2_out(31));

\valid_out~I\ : apex20ke_io
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
	padio => ww_valid_out);

\done~I\ : apex20ke_io
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
	padio => ww_done);
END structure;


