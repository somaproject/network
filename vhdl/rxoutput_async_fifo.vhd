--------------------------------------------------------------------------------
--     This file is owned and controlled by Xilinx and must be used           --
--     solely for design, simulation, implementation and creation of          --
--     design files limited to Xilinx devices or technologies. Use            --
--     with non-Xilinx devices or technologies is expressly prohibited        --
--     and immediately terminates your license.                               --
--                                                                            --
--     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"          --
--     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                --
--     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION        --
--     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION            --
--     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS              --
--     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                --
--     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE       --
--     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY               --
--     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                --
--     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR         --
--     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF        --
--     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS        --
--     FOR A PARTICULAR PURPOSE.                                              --
--                                                                            --
--     Xilinx products are not intended for use in life support               --
--     appliances, devices, or systems. Use in such applications are          --
--     expressly prohibited.                                                  --
--                                                                            --
--     (c) Copyright 1995-2002 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file rxoutput_async_fifo.vhd when simulating
-- the core, rxoutput_async_fifo. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "Coregen Users Guide".

-- The synopsys directives "translate_off/translate_on" specified
-- below are supported by XST, FPGA Express, Exemplar and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

-- synopsys translate_off
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Library XilinxCoreLib;
ENTITY rxoutput_async_fifo IS
	port (
	din: IN std_logic_VECTOR(15 downto 0);
	wr_en: IN std_logic;
	wr_clk: IN std_logic;
	rd_en: IN std_logic;
	rd_clk: IN std_logic;
	ainit: IN std_logic;
	dout: OUT std_logic_VECTOR(15 downto 0);
	full: OUT std_logic;
	empty: OUT std_logic;
	wr_count: OUT std_logic_VECTOR(1 downto 0);
	rd_err: OUT std_logic);
END rxoutput_async_fifo;

ARCHITECTURE rxoutput_async_fifo_a OF rxoutput_async_fifo IS

component wrapped_rxoutput_async_fifo
	port (
	din: IN std_logic_VECTOR(15 downto 0);
	wr_en: IN std_logic;
	wr_clk: IN std_logic;
	rd_en: IN std_logic;
	rd_clk: IN std_logic;
	ainit: IN std_logic;
	dout: OUT std_logic_VECTOR(15 downto 0);
	full: OUT std_logic;
	empty: OUT std_logic;
	wr_count: OUT std_logic_VECTOR(1 downto 0);
	rd_err: OUT std_logic);
end component;

-- Configuration specification 
	for all : wrapped_rxoutput_async_fifo use entity XilinxCoreLib.async_fifo_v5_1(behavioral)
		generic map(
			c_use_blockmem => 1,
			c_rd_count_width => 2,
			c_has_wr_ack => 0,
			c_has_almost_full => 0,
			c_has_wr_err => 0,
			c_wr_err_low => 0,
			c_wr_ack_low => 0,
			c_data_width => 16,
			c_enable_rlocs => 0,
			c_rd_err_low => 0,
			c_wr_count_width => 2,
			c_rd_ack_low => 0,
			c_has_rd_count => 0,
			c_has_almost_empty => 0,
			c_has_rd_ack => 0,
			c_has_wr_count => 1,
			c_fifo_depth => 255,
			c_has_rd_err => 1);
BEGIN

U0 : wrapped_rxoutput_async_fifo
		port map (
			din => din,
			wr_en => wr_en,
			wr_clk => wr_clk,
			rd_en => rd_en,
			rd_clk => rd_clk,
			ainit => ainit,
			dout => dout,
			full => full,
			empty => empty,
			wr_count => wr_count,
			rd_err => rd_err);
END rxoutput_async_fifo_a;

-- synopsys translate_on

