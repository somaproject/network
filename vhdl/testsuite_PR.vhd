-- Xilinx Vhdl netlist produced by netgen application (version G.25a)
-- Command       : -intstyle ise -fn -rpw 100 -tpw 0 -ar Structure -xon false -w -ofmt vhdl -sim txinput.ngd testsuite_PR.vhd 
-- Input file    : txinput.ngd
-- Output file   : testsuite_PR.vhd
-- Design name   : txinput
-- # of Entities : 1
-- Xilinx        : C:/Xilinx
-- Device        : 2s200epq208-6

-- This vhdl netlist is a simulation model and uses simulation 
-- primitives which may not represent the true implementation of the 
-- device, however the netlist is functionally correct and should not 
-- be modified. This file cannot be synthesized and should only be used 
-- with supported simulation tools.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library SIMPRIM;
use SIMPRIM.VCOMPONENTS.ALL;
use SIMPRIM.VPACKAGE.ALL;

entity txinput is
  port (
    CLK : in STD_LOGIC := 'X'; 
    RESET : in STD_LOGIC := 'X'; 
    CLKIO : in STD_LOGIC := 'X'; 
    NEWFRAME : in STD_LOGIC := 'X'; 
    FIFOFULL : in STD_LOGIC := 'X'; 
    TXFIFOWERR : out STD_LOGIC; 
    MWEN : out STD_LOGIC; 
    DONE : out STD_LOGIC; 
    DIN : in STD_LOGIC_VECTOR ( 15 downto 0 ); 
    MA : out STD_LOGIC_VECTOR ( 15 downto 0 ); 
    MD : out STD_LOGIC_VECTOR ( 31 downto 0 ); 
    BPOUT : out STD_LOGIC_VECTOR ( 15 downto 0 ) 
  );
end txinput;

architecture Structure of txinput is
  signal CLK_BUFGP : STD_LOGIC; 
  signal cs_FFd3 : STD_LOGIC; 
  signal RESET_IBUF : STD_LOGIC; 
  signal CLKIO_BUFGP : STD_LOGIC; 
  signal NEWFRAME_IBUF : STD_LOGIC; 
  signal MWEN_OBUF : STD_LOGIC; 
  signal FIFOFULL_IBUF : STD_LOGIC; 
  signal cs_FFd1 : STD_LOGIC; 
  signal den : STD_LOGIC; 
  signal enableint : STD_LOGIC; 
  signal addr_inst_cy_19 : STD_LOGIC; 
  signal addr_inst_lut3_2 : STD_LOGIC; 
  signal lden : STD_LOGIC; 
  signal lnewfint : STD_LOGIC; 
  signal cs_FFd2 : STD_LOGIC; 
  signal fifofulll : STD_LOGIC; 
  signal N3428 : STD_LOGIC; 
  signal N3456 : STD_LOGIC; 
  signal cs_FFd12 : STD_LOGIC; 
  signal Q_n0030 : STD_LOGIC; 
  signal addr_inst_sum_18 : STD_LOGIC; 
  signal newfint : STD_LOGIC; 
  signal mrw : STD_LOGIC; 
  signal Q_n0027 : STD_LOGIC; 
  signal Q_n0028 : STD_LOGIC; 
  signal addr_inst_sum_17 : STD_LOGIC; 
  signal Q_n0040 : STD_LOGIC; 
  signal enable : STD_LOGIC; 
  signal den_N142 : STD_LOGIC; 
  signal enableintl : STD_LOGIC; 
  signal N140 : STD_LOGIC; 
  signal N138 : STD_LOGIC; 
  signal newframel : STD_LOGIC; 
  signal MA_15 : STD_LOGIC; 
  signal MA_14 : STD_LOGIC; 
  signal MA_13 : STD_LOGIC; 
  signal MA_12 : STD_LOGIC; 
  signal MA_11 : STD_LOGIC; 
  signal MA_10 : STD_LOGIC; 
  signal MA_9 : STD_LOGIC; 
  signal MA_8 : STD_LOGIC; 
  signal MA_7 : STD_LOGIC; 
  signal MA_6 : STD_LOGIC; 
  signal MA_5 : STD_LOGIC; 
  signal MA_4 : STD_LOGIC; 
  signal MA_3 : STD_LOGIC; 
  signal MA_2 : STD_LOGIC; 
  signal MA_1 : STD_LOGIC; 
  signal MA_0 : STD_LOGIC; 
  signal MD_31 : STD_LOGIC; 
  signal MD_30 : STD_LOGIC; 
  signal MD_29 : STD_LOGIC; 
  signal MD_28 : STD_LOGIC; 
  signal MD_27 : STD_LOGIC; 
  signal MD_26 : STD_LOGIC; 
  signal MD_25 : STD_LOGIC; 
  signal MD_24 : STD_LOGIC; 
  signal MD_23 : STD_LOGIC; 
  signal MD_22 : STD_LOGIC; 
  signal MD_21 : STD_LOGIC; 
  signal MD_20 : STD_LOGIC; 
  signal MD_19 : STD_LOGIC; 
  signal MD_18 : STD_LOGIC; 
  signal MD_17 : STD_LOGIC; 
  signal MD_16 : STD_LOGIC; 
  signal MD_15 : STD_LOGIC; 
  signal MD_14 : STD_LOGIC; 
  signal MD_13 : STD_LOGIC; 
  signal MD_12 : STD_LOGIC; 
  signal MD_11 : STD_LOGIC; 
  signal MD_10 : STD_LOGIC; 
  signal MD_9 : STD_LOGIC; 
  signal MD_8 : STD_LOGIC; 
  signal MD_7 : STD_LOGIC; 
  signal MD_6 : STD_LOGIC; 
  signal MD_5 : STD_LOGIC; 
  signal MD_4 : STD_LOGIC; 
  signal MD_3 : STD_LOGIC; 
  signal MD_2 : STD_LOGIC; 
  signal MD_1 : STD_LOGIC; 
  signal MD_0 : STD_LOGIC; 
  signal DIN_15_IBUF : STD_LOGIC; 
  signal DIN_14_IBUF : STD_LOGIC; 
  signal DIN_13_IBUF : STD_LOGIC; 
  signal DIN_12_IBUF : STD_LOGIC; 
  signal DIN_11_IBUF : STD_LOGIC; 
  signal DIN_10_IBUF : STD_LOGIC; 
  signal DIN_9_IBUF : STD_LOGIC; 
  signal DIN_8_IBUF : STD_LOGIC; 
  signal DIN_7_IBUF : STD_LOGIC; 
  signal DIN_6_IBUF : STD_LOGIC; 
  signal DIN_5_IBUF : STD_LOGIC; 
  signal DIN_4_IBUF : STD_LOGIC; 
  signal DIN_3_IBUF : STD_LOGIC; 
  signal DIN_2_IBUF : STD_LOGIC; 
  signal DIN_1_IBUF : STD_LOGIC; 
  signal DIN_0_IBUF : STD_LOGIC; 
  signal cs_FFd9_In : STD_LOGIC; 
  signal cs_FFd10_In : STD_LOGIC; 
  signal cs_FFd8_In : STD_LOGIC; 
  signal cs_FFd4 : STD_LOGIC; 
  signal cs_FFd5 : STD_LOGIC; 
  signal cs_FFd6 : STD_LOGIC; 
  signal cs_FFd7 : STD_LOGIC; 
  signal cs_FFd8 : STD_LOGIC; 
  signal cs_FFd9 : STD_LOGIC; 
  signal cs_FFd10 : STD_LOGIC; 
  signal cs_FFd11 : STD_LOGIC; 
  signal cs_FFd11_In : STD_LOGIC; 
  signal cs_FFd7_In : STD_LOGIC; 
  signal cs_FFd6_In : STD_LOGIC; 
  signal cs_FFd5_In : STD_LOGIC; 
  signal cs_FFd4_In : STD_LOGIC; 
  signal cs_FFd3_In : STD_LOGIC; 
  signal cs_FFd2_In : STD_LOGIC; 
  signal cs_FFd12_In : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_10 : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_12 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_9 : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_9 : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_13 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_8 : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_8 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_13 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_7 : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_7 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_11 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_6 : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_6 : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_14 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_5 : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_5 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_14 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_4 : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_4 : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_11 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_3 : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_3 : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_15 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_2 : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_2 : STD_LOGIC; 
  signal addr_inst_cy_20 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_1 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_10 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_12 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_0 : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_0 : STD_LOGIC; 
  signal addr_inst_sum_19 : STD_LOGIC; 
  signal addr_inst_lut3_4 : STD_LOGIC; 
  signal addr_inst_sum_30 : STD_LOGIC; 
  signal addr_inst_cy_31 : STD_LOGIC; 
  signal addr_inst_lut3_14 : STD_LOGIC; 
  signal addr_inst_sum_29 : STD_LOGIC; 
  signal addr_inst_cy_30 : STD_LOGIC; 
  signal addr_inst_lut3_13 : STD_LOGIC; 
  signal addr_inst_sum_28 : STD_LOGIC; 
  signal addr_inst_cy_29 : STD_LOGIC; 
  signal addr_inst_lut3_12 : STD_LOGIC; 
  signal addr_inst_sum_27 : STD_LOGIC; 
  signal addr_inst_cy_28 : STD_LOGIC; 
  signal addr_inst_lut3_11 : STD_LOGIC; 
  signal addr_inst_sum_26 : STD_LOGIC; 
  signal addr_inst_cy_27 : STD_LOGIC; 
  signal addr_inst_lut3_10 : STD_LOGIC; 
  signal addr_inst_sum_25 : STD_LOGIC; 
  signal addr_inst_cy_26 : STD_LOGIC; 
  signal addr_inst_lut3_9 : STD_LOGIC; 
  signal addr_inst_sum_24 : STD_LOGIC; 
  signal addr_inst_cy_25 : STD_LOGIC; 
  signal addr_inst_lut3_8 : STD_LOGIC; 
  signal addr_inst_sum_23 : STD_LOGIC; 
  signal addr_inst_cy_24 : STD_LOGIC; 
  signal addr_inst_lut3_7 : STD_LOGIC; 
  signal addr_inst_sum_22 : STD_LOGIC; 
  signal addr_inst_cy_23 : STD_LOGIC; 
  signal addr_inst_lut3_6 : STD_LOGIC; 
  signal addr_inst_sum_21 : STD_LOGIC; 
  signal addr_inst_cy_22 : STD_LOGIC; 
  signal addr_inst_lut3_5 : STD_LOGIC; 
  signal addr_inst_sum_20 : STD_LOGIC; 
  signal addr_inst_cy_21 : STD_LOGIC; 
  signal addr_inst_sum_31 : STD_LOGIC; 
  signal addr_inst_lut3_3 : STD_LOGIC; 
  signal addr_inst_lut3_15 : STD_LOGIC; 
  signal addr_inst_cy_16 : STD_LOGIC; 
  signal addr_inst_lut3_0 : STD_LOGIC; 
  signal addr_inst_cy_17 : STD_LOGIC; 
  signal addr_inst_sum_16 : STD_LOGIC; 
  signal addr_inst_lut3_1 : STD_LOGIC; 
  signal addr_inst_cy_18 : STD_LOGIC; 
  signal N3553 : STD_LOGIC; 
  signal N3593 : STD_LOGIC; 
  signal CHOICE25 : STD_LOGIC; 
  signal CHOICE18 : STD_LOGIC; 
  signal CHOICE15 : STD_LOGIC; 
  signal CHOICE32 : STD_LOGIC; 
  signal CHOICE72 : STD_LOGIC; 
  signal CHOICE55 : STD_LOGIC; 
  signal Q_n0016_rt : STD_LOGIC; 
  signal CHOICE29 : STD_LOGIC; 
  signal CHOICE48 : STD_LOGIC; 
  signal CHOICE40 : STD_LOGIC; 
  signal CHOICE63 : STD_LOGIC; 
  signal CHOICE39 : STD_LOGIC; 
  signal CHOICE70 : STD_LOGIC; 
  signal CHOICE36 : STD_LOGIC; 
  signal CNT_1_rt : STD_LOGIC; 
  signal cs_FFd12_1 : STD_LOGIC; 
  signal cs_Out51_1 : STD_LOGIC; 
  signal cs_FFd3_1 : STD_LOGIC; 
  signal cs_FFd1_1 : STD_LOGIC; 
  signal bp_15_1 : STD_LOGIC; 
  signal bp_14_1 : STD_LOGIC; 
  signal bp_13_1 : STD_LOGIC; 
  signal bp_12_1 : STD_LOGIC; 
  signal bp_11_1 : STD_LOGIC; 
  signal bp_10_1 : STD_LOGIC; 
  signal bp_9_1 : STD_LOGIC; 
  signal bp_8_1 : STD_LOGIC; 
  signal bp_7_1 : STD_LOGIC; 
  signal bp_6_1 : STD_LOGIC; 
  signal bp_5_1 : STD_LOGIC; 
  signal bp_4_1 : STD_LOGIC; 
  signal bp_3_1 : STD_LOGIC; 
  signal bp_2_1 : STD_LOGIC; 
  signal bp_1_1 : STD_LOGIC; 
  signal bp_0_1 : STD_LOGIC; 
  signal N4095 : STD_LOGIC; 
  signal Ker342621_O : STD_LOGIC; 
  signal cs_FFd7_In_O : STD_LOGIC; 
  signal addr_inst_lut3_41_O : STD_LOGIC; 
  signal addr_inst_lut3_31_O : STD_LOGIC; 
  signal cs_FFd10_In_O : STD_LOGIC; 
  signal cs_FFd8_In1_O : STD_LOGIC; 
  signal cs_FFd5_In1_O : STD_LOGIC; 
  signal Ker3426120_O : STD_LOGIC; 
  signal srl16_enable_CE : STD_LOGIC; 
  signal srl16_newframe_CE : STD_LOGIC; 
  signal srl16_din_bit0_CE : STD_LOGIC; 
  signal srl16_din_bit1_CE : STD_LOGIC; 
  signal srl16_din_bit2_CE : STD_LOGIC; 
  signal srl16_din_bit3_CE : STD_LOGIC; 
  signal srl16_din_bit4_CE : STD_LOGIC; 
  signal srl16_din_bit5_CE : STD_LOGIC; 
  signal srl16_din_bit6_CE : STD_LOGIC; 
  signal srl16_din_bit7_CE : STD_LOGIC; 
  signal srl16_din_bit8_CE : STD_LOGIC; 
  signal srl16_din_bit9_CE : STD_LOGIC; 
  signal srl16_din_bit10_CE : STD_LOGIC; 
  signal srl16_din_bit11_CE : STD_LOGIC; 
  signal srl16_din_bit12_CE : STD_LOGIC; 
  signal srl16_din_bit13_CE : STD_LOGIC; 
  signal srl16_din_bit14_CE : STD_LOGIC; 
  signal srl16_din_bit15_CE : STD_LOGIC; 
  signal CLK_BUFGP_IBUFG : STD_LOGIC; 
  signal CLKIO_BUFGP_IBUFG : STD_LOGIC; 
  signal GSR : STD_LOGIC; 
  signal MD_25_GSR_OR : STD_LOGIC; 
  signal MD_24_GSR_OR : STD_LOGIC; 
  signal MD_26_GSR_OR : STD_LOGIC; 
  signal MD_23_GSR_OR : STD_LOGIC; 
  signal MA_15_GSR_OR : STD_LOGIC; 
  signal MD_31_GSR_OR : STD_LOGIC; 
  signal MWEN_GSR_OR : STD_LOGIC; 
  signal MD_27_GSR_OR : STD_LOGIC; 
  signal MD_28_GSR_OR : STD_LOGIC; 
  signal MD_29_GSR_OR : STD_LOGIC; 
  signal MD_30_GSR_OR : STD_LOGIC; 
  signal MA_0_GSR_OR : STD_LOGIC; 
  signal MA_1_GSR_OR : STD_LOGIC; 
  signal MA_2_GSR_OR : STD_LOGIC; 
  signal MA_3_GSR_OR : STD_LOGIC; 
  signal MA_4_GSR_OR : STD_LOGIC; 
  signal MA_5_GSR_OR : STD_LOGIC; 
  signal MA_6_GSR_OR : STD_LOGIC; 
  signal MA_7_GSR_OR : STD_LOGIC; 
  signal MA_8_GSR_OR : STD_LOGIC; 
  signal MA_9_GSR_OR : STD_LOGIC; 
  signal MA_10_GSR_OR : STD_LOGIC; 
  signal MA_11_GSR_OR : STD_LOGIC; 
  signal MA_12_GSR_OR : STD_LOGIC; 
  signal MA_13_GSR_OR : STD_LOGIC; 
  signal MA_14_GSR_OR : STD_LOGIC; 
  signal MD_0_GSR_OR : STD_LOGIC; 
  signal MD_1_GSR_OR : STD_LOGIC; 
  signal MD_2_GSR_OR : STD_LOGIC; 
  signal MD_3_GSR_OR : STD_LOGIC; 
  signal MD_4_GSR_OR : STD_LOGIC; 
  signal MD_5_GSR_OR : STD_LOGIC; 
  signal MD_6_GSR_OR : STD_LOGIC; 
  signal MD_7_GSR_OR : STD_LOGIC; 
  signal MD_8_GSR_OR : STD_LOGIC; 
  signal MD_9_GSR_OR : STD_LOGIC; 
  signal MD_10_GSR_OR : STD_LOGIC; 
  signal MD_11_GSR_OR : STD_LOGIC; 
  signal MD_12_GSR_OR : STD_LOGIC; 
  signal MD_13_GSR_OR : STD_LOGIC; 
  signal MD_14_GSR_OR : STD_LOGIC; 
  signal MD_15_GSR_OR : STD_LOGIC; 
  signal MD_16_GSR_OR : STD_LOGIC; 
  signal MD_17_GSR_OR : STD_LOGIC; 
  signal MD_18_GSR_OR : STD_LOGIC; 
  signal MD_19_GSR_OR : STD_LOGIC; 
  signal MD_20_GSR_OR : STD_LOGIC; 
  signal MD_21_GSR_OR : STD_LOGIC; 
  signal MD_22_GSR_OR : STD_LOGIC; 
  signal cs_FFd1_GSR_OR : STD_LOGIC; 
  signal cs_FFd2_GSR_OR : STD_LOGIC; 
  signal cs_FFd3_GSR_OR : STD_LOGIC; 
  signal cs_FFd4_GSR_OR : STD_LOGIC; 
  signal cs_FFd5_GSR_OR : STD_LOGIC; 
  signal cs_FFd6_GSR_OR : STD_LOGIC; 
  signal cs_FFd7_GSR_OR : STD_LOGIC; 
  signal cs_FFd8_GSR_OR : STD_LOGIC; 
  signal cs_FFd9_GSR_OR : STD_LOGIC; 
  signal cs_FFd10_GSR_OR : STD_LOGIC; 
  signal cs_FFd11_GSR_OR : STD_LOGIC; 
  signal cs_FFd12_GSR_OR : STD_LOGIC; 
  signal cs_FFd12_1_GSR_OR : STD_LOGIC; 
  signal cs_FFd3_1_GSR_OR : STD_LOGIC; 
  signal cs_FFd1_1_GSR_OR : STD_LOGIC; 
  signal BPOUT_0_OBUF_GTS_TRI : STD_LOGIC; 
  signal GTS : STD_LOGIC; 
  signal TXFIFOWERR_OBUF_GTS_TRI : STD_LOGIC; 
  signal MWEN_OBUF_GTS_TRI : STD_LOGIC; 
  signal DONE_OBUF_GTS_TRI : STD_LOGIC; 
  signal MA_15_OBUF_GTS_TRI : STD_LOGIC; 
  signal MA_14_OBUF_GTS_TRI : STD_LOGIC; 
  signal MA_13_OBUF_GTS_TRI : STD_LOGIC; 
  signal MA_12_OBUF_GTS_TRI : STD_LOGIC; 
  signal MA_11_OBUF_GTS_TRI : STD_LOGIC; 
  signal MA_10_OBUF_GTS_TRI : STD_LOGIC; 
  signal MA_9_OBUF_GTS_TRI : STD_LOGIC; 
  signal MA_8_OBUF_GTS_TRI : STD_LOGIC; 
  signal MA_7_OBUF_GTS_TRI : STD_LOGIC; 
  signal MA_6_OBUF_GTS_TRI : STD_LOGIC; 
  signal MA_5_OBUF_GTS_TRI : STD_LOGIC; 
  signal MA_4_OBUF_GTS_TRI : STD_LOGIC; 
  signal MA_3_OBUF_GTS_TRI : STD_LOGIC; 
  signal MA_2_OBUF_GTS_TRI : STD_LOGIC; 
  signal MA_1_OBUF_GTS_TRI : STD_LOGIC; 
  signal MA_0_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_31_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_30_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_29_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_28_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_27_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_26_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_25_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_24_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_23_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_22_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_21_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_20_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_19_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_18_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_17_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_16_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_15_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_14_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_13_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_12_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_11_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_10_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_9_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_8_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_7_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_6_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_5_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_4_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_3_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_2_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_1_OBUF_GTS_TRI : STD_LOGIC; 
  signal MD_0_OBUF_GTS_TRI : STD_LOGIC; 
  signal BPOUT_15_OBUF_GTS_TRI : STD_LOGIC; 
  signal BPOUT_14_OBUF_GTS_TRI : STD_LOGIC; 
  signal BPOUT_13_OBUF_GTS_TRI : STD_LOGIC; 
  signal BPOUT_12_OBUF_GTS_TRI : STD_LOGIC; 
  signal BPOUT_11_OBUF_GTS_TRI : STD_LOGIC; 
  signal BPOUT_10_OBUF_GTS_TRI : STD_LOGIC; 
  signal BPOUT_9_OBUF_GTS_TRI : STD_LOGIC; 
  signal BPOUT_8_OBUF_GTS_TRI : STD_LOGIC; 
  signal BPOUT_7_OBUF_GTS_TRI : STD_LOGIC; 
  signal BPOUT_6_OBUF_GTS_TRI : STD_LOGIC; 
  signal BPOUT_5_OBUF_GTS_TRI : STD_LOGIC; 
  signal BPOUT_4_OBUF_GTS_TRI : STD_LOGIC; 
  signal BPOUT_3_OBUF_GTS_TRI : STD_LOGIC; 
  signal BPOUT_2_OBUF_GTS_TRI : STD_LOGIC; 
  signal BPOUT_1_OBUF_GTS_TRI : STD_LOGIC; 
  signal GND : STD_LOGIC; 
  signal VCC : STD_LOGIC; 
  signal NlwInverterSignal_BPOUT_0_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_TXFIFOWERR_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MWEN_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_DONE_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MA_15_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MA_14_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MA_13_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MA_12_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MA_11_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MA_10_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MA_9_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MA_8_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MA_7_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MA_6_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MA_5_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MA_4_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MA_3_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MA_2_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MA_1_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MA_0_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_31_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_30_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_29_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_28_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_27_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_26_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_25_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_24_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_23_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_22_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_21_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_20_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_19_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_18_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_17_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_16_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_15_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_14_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_13_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_12_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_11_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_10_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_9_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_8_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_7_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_6_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_5_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_4_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_3_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_2_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_1_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_MD_0_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_BPOUT_15_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_BPOUT_14_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_BPOUT_13_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_BPOUT_12_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_BPOUT_11_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_BPOUT_10_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_BPOUT_9_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_BPOUT_8_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_BPOUT_7_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_BPOUT_6_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_BPOUT_5_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_BPOUT_4_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_BPOUT_3_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_BPOUT_2_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_BPOUT_1_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal dinl : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal dl : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal dh : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal Q_n0039 : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal ldinint : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal bp : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal CNT : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal dinint : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal addr : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal Q_n0081 : STD_LOGIC_VECTOR ( 15 downto 0 ); 
begin
  BPOUT_0_OBUF : X_BUF
    port map (
      I => bp(0),
      O => BPOUT_0_OBUF_GTS_TRI
    );
  XST_VCC : X_ONE
    port map (
      O => N138
    );
  XST_GND : X_ZERO
    port map (
      O => N140
    );
  MD_25_0 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dh(9),
      CE => cs_Out51_1,
      RST => MD_25_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_25,
      SET => GND
    );
  MD_24_1 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dh(8),
      CE => cs_Out51_1,
      RST => MD_24_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_24,
      SET => GND
    );
  MD_26_2 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dh(10),
      CE => cs_Out51_1,
      RST => MD_26_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_26,
      SET => GND
    );
  Mxor_lden_Result1 : X_LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      ADR0 => enableint,
      ADR1 => enableintl,
      O => lden
    );
  Msub_n0041_inst_sum_14 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_lut2_14,
      I1 => Msub_n0041_inst_cy_13,
      O => Q_n0081(14)
    );
  Mmux_n0039_Result_15_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(15),
      ADR2 => Q_n0081(15),
      O => Q_n0039(15)
    );
  den_3 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lden,
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => den,
      SET => GND,
      RST => GSR
    );
  newfint_4 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lnewfint,
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => newfint,
      SET => GND,
      RST => GSR
    );
  dinint_15 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(15),
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => dinint(15),
      SET => GND,
      RST => GSR
    );
  fifofulll_5 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => FIFOFULL_IBUF,
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => fifofulll,
      SET => GND,
      RST => GSR
    );
  bp_15 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(15),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp(15),
      SET => GND,
      RST => GSR
    );
  MD_23_6 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dh(7),
      CE => cs_Out51_1,
      RST => MD_23_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_23,
      SET => GND
    );
  Q_n00401 : X_LUT4
    generic map(
      INIT => X"5554"
    )
    port map (
      ADR0 => RESET_IBUF,
      ADR1 => cs_FFd9,
      ADR2 => cs_FFd12,
      ADR3 => cs_FFd5,
      O => Q_n0040
    );
  Ker3426137 : X_LUT4
    generic map(
      INIT => X"FF80"
    )
    port map (
      ADR0 => CHOICE29,
      ADR1 => CHOICE32,
      ADR2 => CHOICE40,
      ADR3 => CHOICE72,
      O => N3428
    );
  Q_n00271 : X_LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      ADR0 => N4095,
      ADR1 => cs_FFd12,
      ADR2 => cs_FFd10,
      ADR3 => cs_FFd11,
      O => Q_n0027
    );
  cs_FFd11_In1 : X_LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      ADR0 => newfint,
      ADR1 => cs_FFd12_1,
      ADR2 => den,
      O => cs_FFd11_In
    );
  Q_n00301 : X_LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      ADR0 => RESET_IBUF,
      ADR1 => cs_FFd2,
      O => Q_n0030
    );
  addr_13 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr_inst_sum_29,
      CE => Q_n0040,
      CLK => CLK_BUFGP,
      O => addr(13),
      SET => GND,
      RST => GSR
    );
  CNT_15 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => Q_n0039(15),
      CE => N3456,
      CLK => CLK_BUFGP,
      O => CNT(15),
      SET => GND,
      RST => GSR
    );
  dh_15 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(15),
      CE => Q_n0028,
      CLK => CLK_BUFGP,
      O => dh(15),
      SET => GND,
      RST => GSR
    );
  dl_15 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(15),
      CE => Q_n0027,
      CLK => CLK_BUFGP,
      O => dl(15),
      SET => GND,
      RST => GSR
    );
  enableintl_7 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => enableint,
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => enableintl,
      SET => GND,
      RST => GSR
    );
  MA_15_8 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(15),
      CE => mrw,
      RST => MA_15_GSR_OR,
      CLK => CLK_BUFGP,
      O => MA_15,
      SET => GND
    );
  addr_10 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr_inst_sum_26,
      CE => Q_n0040,
      CLK => CLK_BUFGP,
      O => addr(10),
      SET => GND,
      RST => GSR
    );
  enable_9 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => N138,
      SRST => enable,
      CLK => CLKIO_BUFGP,
      O => enable,
      CE => VCC,
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  dinl_15 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_15_IBUF,
      CLK => CLKIO_BUFGP,
      O => dinl(15),
      CE => VCC,
      SET => GND,
      RST => GSR
    );
  newframel_10 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => NEWFRAME_IBUF,
      CLK => CLKIO_BUFGP,
      O => newframel,
      CE => VCC,
      SET => GND,
      RST => GSR
    );
  MD_31_11 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dh(15),
      CE => cs_Out51_1,
      RST => MD_31_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_31,
      SET => GND
    );
  MWEN_12 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_Out51_1,
      RST => MWEN_GSR_OR,
      CLK => CLK_BUFGP,
      O => MWEN_OBUF,
      CE => VCC,
      SET => GND
    );
  den_N1421 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => RESET_IBUF,
      O => den_N142,
      ADR1 => GND
    );
  MD_27_13 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dh(11),
      CE => cs_Out51_1,
      RST => MD_27_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_27,
      SET => GND
    );
  MD_28_14 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dh(12),
      CE => cs_Out51_1,
      RST => MD_28_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_28,
      SET => GND
    );
  dinint_0 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(0),
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => dinint(0),
      SET => GND,
      RST => GSR
    );
  dinint_1 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(1),
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => dinint(1),
      SET => GND,
      RST => GSR
    );
  dinint_2 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(2),
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => dinint(2),
      SET => GND,
      RST => GSR
    );
  dinint_3 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(3),
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => dinint(3),
      SET => GND,
      RST => GSR
    );
  dinint_4 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(4),
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => dinint(4),
      SET => GND,
      RST => GSR
    );
  dinint_5 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(5),
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => dinint(5),
      SET => GND,
      RST => GSR
    );
  dinint_6 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(6),
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => dinint(6),
      SET => GND,
      RST => GSR
    );
  dinint_7 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(7),
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => dinint(7),
      SET => GND,
      RST => GSR
    );
  dinint_8 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(8),
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => dinint(8),
      SET => GND,
      RST => GSR
    );
  dinint_9 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(9),
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => dinint(9),
      SET => GND,
      RST => GSR
    );
  dinint_10 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(10),
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => dinint(10),
      SET => GND,
      RST => GSR
    );
  dinint_11 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(11),
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => dinint(11),
      SET => GND,
      RST => GSR
    );
  dinint_12 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(12),
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => dinint(12),
      SET => GND,
      RST => GSR
    );
  dinint_13 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(13),
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => dinint(13),
      SET => GND,
      RST => GSR
    );
  dinint_14 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(14),
      CE => den_N142,
      CLK => CLK_BUFGP,
      O => dinint(14),
      SET => GND,
      RST => GSR
    );
  MD_29_15 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dh(13),
      CE => cs_Out51_1,
      RST => MD_29_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_29,
      SET => GND
    );
  bp_0 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(0),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp(0),
      SET => GND,
      RST => GSR
    );
  bp_1 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(1),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp(1),
      SET => GND,
      RST => GSR
    );
  bp_2 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(2),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp(2),
      SET => GND,
      RST => GSR
    );
  bp_3 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(3),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp(3),
      SET => GND,
      RST => GSR
    );
  bp_4 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(4),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp(4),
      SET => GND,
      RST => GSR
    );
  bp_5 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(5),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp(5),
      SET => GND,
      RST => GSR
    );
  bp_6 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(6),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp(6),
      SET => GND,
      RST => GSR
    );
  bp_7 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(7),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp(7),
      SET => GND,
      RST => GSR
    );
  bp_8 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(8),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp(8),
      SET => GND,
      RST => GSR
    );
  bp_9 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(9),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp(9),
      SET => GND,
      RST => GSR
    );
  bp_10 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(10),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp(10),
      SET => GND,
      RST => GSR
    );
  bp_11 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(11),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp(11),
      SET => GND,
      RST => GSR
    );
  bp_12 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(12),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp(12),
      SET => GND,
      RST => GSR
    );
  bp_13 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(13),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp(13),
      SET => GND,
      RST => GSR
    );
  bp_14 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(14),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp(14),
      SET => GND,
      RST => GSR
    );
  CNT_0 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => Q_n0039(0),
      CE => N3456,
      CLK => CLK_BUFGP,
      O => CNT(0),
      SET => GND,
      RST => GSR
    );
  CNT_1 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => Q_n0039(1),
      CE => N3456,
      CLK => CLK_BUFGP,
      O => CNT(1),
      SET => GND,
      RST => GSR
    );
  CNT_2 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => Q_n0039(2),
      CE => N3456,
      CLK => CLK_BUFGP,
      O => CNT(2),
      SET => GND,
      RST => GSR
    );
  CNT_3 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => Q_n0039(3),
      CE => N3456,
      CLK => CLK_BUFGP,
      O => CNT(3),
      SET => GND,
      RST => GSR
    );
  CNT_4 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => Q_n0039(4),
      CE => N3456,
      CLK => CLK_BUFGP,
      O => CNT(4),
      SET => GND,
      RST => GSR
    );
  CNT_5 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => Q_n0039(5),
      CE => N3456,
      CLK => CLK_BUFGP,
      O => CNT(5),
      SET => GND,
      RST => GSR
    );
  CNT_6 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => Q_n0039(6),
      CE => N3456,
      CLK => CLK_BUFGP,
      O => CNT(6),
      SET => GND,
      RST => GSR
    );
  CNT_7 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => Q_n0039(7),
      CE => N3456,
      CLK => CLK_BUFGP,
      O => CNT(7),
      SET => GND,
      RST => GSR
    );
  CNT_8 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => Q_n0039(8),
      CE => N3456,
      CLK => CLK_BUFGP,
      O => CNT(8),
      SET => GND,
      RST => GSR
    );
  CNT_9 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => Q_n0039(9),
      CE => N3456,
      CLK => CLK_BUFGP,
      O => CNT(9),
      SET => GND,
      RST => GSR
    );
  CNT_10 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => Q_n0039(10),
      CE => N3456,
      CLK => CLK_BUFGP,
      O => CNT(10),
      SET => GND,
      RST => GSR
    );
  CNT_11 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => Q_n0039(11),
      CE => N3456,
      CLK => CLK_BUFGP,
      O => CNT(11),
      SET => GND,
      RST => GSR
    );
  CNT_12 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => Q_n0039(12),
      CE => N3456,
      CLK => CLK_BUFGP,
      O => CNT(12),
      SET => GND,
      RST => GSR
    );
  CNT_13 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => Q_n0039(13),
      CE => N3456,
      CLK => CLK_BUFGP,
      O => CNT(13),
      SET => GND,
      RST => GSR
    );
  CNT_14 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => Q_n0039(14),
      CE => N3456,
      CLK => CLK_BUFGP,
      O => CNT(14),
      SET => GND,
      RST => GSR
    );
  dh_0 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(0),
      CE => Q_n0028,
      CLK => CLK_BUFGP,
      O => dh(0),
      SET => GND,
      RST => GSR
    );
  dh_1 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(1),
      CE => Q_n0028,
      CLK => CLK_BUFGP,
      O => dh(1),
      SET => GND,
      RST => GSR
    );
  dh_2 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(2),
      CE => Q_n0028,
      CLK => CLK_BUFGP,
      O => dh(2),
      SET => GND,
      RST => GSR
    );
  dh_3 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(3),
      CE => Q_n0028,
      CLK => CLK_BUFGP,
      O => dh(3),
      SET => GND,
      RST => GSR
    );
  dh_4 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(4),
      CE => Q_n0028,
      CLK => CLK_BUFGP,
      O => dh(4),
      SET => GND,
      RST => GSR
    );
  dh_5 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(5),
      CE => Q_n0028,
      CLK => CLK_BUFGP,
      O => dh(5),
      SET => GND,
      RST => GSR
    );
  dh_6 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(6),
      CE => Q_n0028,
      CLK => CLK_BUFGP,
      O => dh(6),
      SET => GND,
      RST => GSR
    );
  dh_7 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(7),
      CE => Q_n0028,
      CLK => CLK_BUFGP,
      O => dh(7),
      SET => GND,
      RST => GSR
    );
  dh_8 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(8),
      CE => Q_n0028,
      CLK => CLK_BUFGP,
      O => dh(8),
      SET => GND,
      RST => GSR
    );
  dh_9 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(9),
      CE => Q_n0028,
      CLK => CLK_BUFGP,
      O => dh(9),
      SET => GND,
      RST => GSR
    );
  dh_10 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(10),
      CE => Q_n0028,
      CLK => CLK_BUFGP,
      O => dh(10),
      SET => GND,
      RST => GSR
    );
  dh_11 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(11),
      CE => Q_n0028,
      CLK => CLK_BUFGP,
      O => dh(11),
      SET => GND,
      RST => GSR
    );
  dh_12 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(12),
      CE => Q_n0028,
      CLK => CLK_BUFGP,
      O => dh(12),
      SET => GND,
      RST => GSR
    );
  dh_13 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(13),
      CE => Q_n0028,
      CLK => CLK_BUFGP,
      O => dh(13),
      SET => GND,
      RST => GSR
    );
  dh_14 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(14),
      CE => Q_n0028,
      CLK => CLK_BUFGP,
      O => dh(14),
      SET => GND,
      RST => GSR
    );
  dl_0 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(0),
      CE => Q_n0027,
      CLK => CLK_BUFGP,
      O => dl(0),
      SET => GND,
      RST => GSR
    );
  dl_1 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(1),
      CE => Q_n0027,
      CLK => CLK_BUFGP,
      O => dl(1),
      SET => GND,
      RST => GSR
    );
  dl_2 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(2),
      CE => Q_n0027,
      CLK => CLK_BUFGP,
      O => dl(2),
      SET => GND,
      RST => GSR
    );
  dl_3 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(3),
      CE => Q_n0027,
      CLK => CLK_BUFGP,
      O => dl(3),
      SET => GND,
      RST => GSR
    );
  dl_4 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(4),
      CE => Q_n0027,
      CLK => CLK_BUFGP,
      O => dl(4),
      SET => GND,
      RST => GSR
    );
  dl_5 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(5),
      CE => Q_n0027,
      CLK => CLK_BUFGP,
      O => dl(5),
      SET => GND,
      RST => GSR
    );
  dl_6 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(6),
      CE => Q_n0027,
      CLK => CLK_BUFGP,
      O => dl(6),
      SET => GND,
      RST => GSR
    );
  dl_7 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(7),
      CE => Q_n0027,
      CLK => CLK_BUFGP,
      O => dl(7),
      SET => GND,
      RST => GSR
    );
  dl_8 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(8),
      CE => Q_n0027,
      CLK => CLK_BUFGP,
      O => dl(8),
      SET => GND,
      RST => GSR
    );
  dl_9 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(9),
      CE => Q_n0027,
      CLK => CLK_BUFGP,
      O => dl(9),
      SET => GND,
      RST => GSR
    );
  dl_10 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(10),
      CE => Q_n0027,
      CLK => CLK_BUFGP,
      O => dl(10),
      SET => GND,
      RST => GSR
    );
  dl_11 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(11),
      CE => Q_n0027,
      CLK => CLK_BUFGP,
      O => dl(11),
      SET => GND,
      RST => GSR
    );
  dl_12 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(12),
      CE => Q_n0027,
      CLK => CLK_BUFGP,
      O => dl(12),
      SET => GND,
      RST => GSR
    );
  dl_13 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(13),
      CE => Q_n0027,
      CLK => CLK_BUFGP,
      O => dl(13),
      SET => GND,
      RST => GSR
    );
  dl_14 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dinint(14),
      CE => Q_n0027,
      CLK => CLK_BUFGP,
      O => dl(14),
      SET => GND,
      RST => GSR
    );
  MD_30_16 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dh(14),
      CE => cs_Out51_1,
      RST => MD_30_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_30,
      SET => GND
    );
  MA_0_17 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(0),
      CE => mrw,
      RST => MA_0_GSR_OR,
      CLK => CLK_BUFGP,
      O => MA_0,
      SET => GND
    );
  MA_1_18 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(1),
      CE => mrw,
      RST => MA_1_GSR_OR,
      CLK => CLK_BUFGP,
      O => MA_1,
      SET => GND
    );
  MA_2_19 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(2),
      CE => mrw,
      RST => MA_2_GSR_OR,
      CLK => CLK_BUFGP,
      O => MA_2,
      SET => GND
    );
  MA_3_20 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(3),
      CE => mrw,
      RST => MA_3_GSR_OR,
      CLK => CLK_BUFGP,
      O => MA_3,
      SET => GND
    );
  MA_4_21 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(4),
      CE => mrw,
      RST => MA_4_GSR_OR,
      CLK => CLK_BUFGP,
      O => MA_4,
      SET => GND
    );
  MA_5_22 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(5),
      CE => mrw,
      RST => MA_5_GSR_OR,
      CLK => CLK_BUFGP,
      O => MA_5,
      SET => GND
    );
  MA_6_23 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(6),
      CE => mrw,
      RST => MA_6_GSR_OR,
      CLK => CLK_BUFGP,
      O => MA_6,
      SET => GND
    );
  MA_7_24 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(7),
      CE => mrw,
      RST => MA_7_GSR_OR,
      CLK => CLK_BUFGP,
      O => MA_7,
      SET => GND
    );
  MA_8_25 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(8),
      CE => mrw,
      RST => MA_8_GSR_OR,
      CLK => CLK_BUFGP,
      O => MA_8,
      SET => GND
    );
  MA_9_26 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(9),
      CE => mrw,
      RST => MA_9_GSR_OR,
      CLK => CLK_BUFGP,
      O => MA_9,
      SET => GND
    );
  MA_10_27 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(10),
      CE => mrw,
      RST => MA_10_GSR_OR,
      CLK => CLK_BUFGP,
      O => MA_10,
      SET => GND
    );
  MA_11_28 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(11),
      CE => mrw,
      RST => MA_11_GSR_OR,
      CLK => CLK_BUFGP,
      O => MA_11,
      SET => GND
    );
  MA_12_29 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(12),
      CE => mrw,
      RST => MA_12_GSR_OR,
      CLK => CLK_BUFGP,
      O => MA_12,
      SET => GND
    );
  MA_13_30 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(13),
      CE => mrw,
      RST => MA_13_GSR_OR,
      CLK => CLK_BUFGP,
      O => MA_13,
      SET => GND
    );
  MA_14_31 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(14),
      CE => mrw,
      RST => MA_14_GSR_OR,
      CLK => CLK_BUFGP,
      O => MA_14,
      SET => GND
    );
  dinl_0 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_0_IBUF,
      CLK => CLKIO_BUFGP,
      O => dinl(0),
      CE => VCC,
      SET => GND,
      RST => GSR
    );
  dinl_1 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_1_IBUF,
      CLK => CLKIO_BUFGP,
      O => dinl(1),
      CE => VCC,
      SET => GND,
      RST => GSR
    );
  dinl_2 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_2_IBUF,
      CLK => CLKIO_BUFGP,
      O => dinl(2),
      CE => VCC,
      SET => GND,
      RST => GSR
    );
  dinl_3 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_3_IBUF,
      CLK => CLKIO_BUFGP,
      O => dinl(3),
      CE => VCC,
      SET => GND,
      RST => GSR
    );
  dinl_4 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_4_IBUF,
      CLK => CLKIO_BUFGP,
      O => dinl(4),
      CE => VCC,
      SET => GND,
      RST => GSR
    );
  dinl_5 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_5_IBUF,
      CLK => CLKIO_BUFGP,
      O => dinl(5),
      CE => VCC,
      SET => GND,
      RST => GSR
    );
  dinl_6 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_6_IBUF,
      CLK => CLKIO_BUFGP,
      O => dinl(6),
      CE => VCC,
      SET => GND,
      RST => GSR
    );
  dinl_7 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_7_IBUF,
      CLK => CLKIO_BUFGP,
      O => dinl(7),
      CE => VCC,
      SET => GND,
      RST => GSR
    );
  dinl_8 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_8_IBUF,
      CLK => CLKIO_BUFGP,
      O => dinl(8),
      CE => VCC,
      SET => GND,
      RST => GSR
    );
  dinl_9 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_9_IBUF,
      CLK => CLKIO_BUFGP,
      O => dinl(9),
      CE => VCC,
      SET => GND,
      RST => GSR
    );
  dinl_10 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_10_IBUF,
      CLK => CLKIO_BUFGP,
      O => dinl(10),
      CE => VCC,
      SET => GND,
      RST => GSR
    );
  dinl_11 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_11_IBUF,
      CLK => CLKIO_BUFGP,
      O => dinl(11),
      CE => VCC,
      SET => GND,
      RST => GSR
    );
  dinl_12 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_12_IBUF,
      CLK => CLKIO_BUFGP,
      O => dinl(12),
      CE => VCC,
      SET => GND,
      RST => GSR
    );
  dinl_13 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_13_IBUF,
      CLK => CLKIO_BUFGP,
      O => dinl(13),
      CE => VCC,
      SET => GND,
      RST => GSR
    );
  dinl_14 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_14_IBUF,
      CLK => CLKIO_BUFGP,
      O => dinl(14),
      CE => VCC,
      SET => GND,
      RST => GSR
    );
  MD_0_32 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dl(0),
      CE => mrw,
      RST => MD_0_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_0,
      SET => GND
    );
  MD_1_33 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dl(1),
      CE => mrw,
      RST => MD_1_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_1,
      SET => GND
    );
  MD_2_34 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dl(2),
      CE => cs_Out51_1,
      RST => MD_2_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_2,
      SET => GND
    );
  MD_3_35 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dl(3),
      CE => cs_Out51_1,
      RST => MD_3_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_3,
      SET => GND
    );
  MD_4_36 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dl(4),
      CE => cs_Out51_1,
      RST => MD_4_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_4,
      SET => GND
    );
  MD_5_37 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dl(5),
      CE => cs_Out51_1,
      RST => MD_5_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_5,
      SET => GND
    );
  MD_6_38 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dl(6),
      CE => cs_Out51_1,
      RST => MD_6_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_6,
      SET => GND
    );
  MD_7_39 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dl(7),
      CE => cs_Out51_1,
      RST => MD_7_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_7,
      SET => GND
    );
  MD_8_40 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dl(8),
      CE => cs_Out51_1,
      RST => MD_8_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_8,
      SET => GND
    );
  MD_9_41 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dl(9),
      CE => cs_Out51_1,
      RST => MD_9_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_9,
      SET => GND
    );
  MD_10_42 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dl(10),
      CE => mrw,
      RST => MD_10_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_10,
      SET => GND
    );
  MD_11_43 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dl(11),
      CE => mrw,
      RST => MD_11_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_11,
      SET => GND
    );
  MD_12_44 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dl(12),
      CE => mrw,
      RST => MD_12_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_12,
      SET => GND
    );
  MD_13_45 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dl(13),
      CE => mrw,
      RST => MD_13_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_13,
      SET => GND
    );
  MD_14_46 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dl(14),
      CE => mrw,
      RST => MD_14_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_14,
      SET => GND
    );
  MD_15_47 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dl(15),
      CE => mrw,
      RST => MD_15_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_15,
      SET => GND
    );
  MD_16_48 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dh(0),
      CE => mrw,
      RST => MD_16_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_16,
      SET => GND
    );
  MD_17_49 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dh(1),
      CE => cs_Out51_1,
      RST => MD_17_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_17,
      SET => GND
    );
  MD_18_50 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dh(2),
      CE => cs_Out51_1,
      RST => MD_18_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_18,
      SET => GND
    );
  MD_19_51 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dh(3),
      CE => cs_Out51_1,
      RST => MD_19_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_19,
      SET => GND
    );
  MD_20_52 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dh(4),
      CE => cs_Out51_1,
      RST => MD_20_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_20,
      SET => GND
    );
  MD_21_53 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dh(5),
      CE => cs_Out51_1,
      RST => MD_21_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_21,
      SET => GND
    );
  MD_22_54 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => dh(6),
      CE => cs_Out51_1,
      RST => MD_22_GSR_OR,
      CLK => CLK_BUFGP,
      O => MD_22,
      SET => GND
    );
  addr_9 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr_inst_sum_25,
      CE => Q_n0040,
      CLK => CLK_BUFGP,
      O => addr(9),
      SET => GND,
      RST => GSR
    );
  cs_FFd2_In1 : X_LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      ADR0 => fifofulll,
      ADR1 => cs_FFd5,
      O => cs_FFd2_In
    );
  cs_FFd3_In1 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => fifofulll,
      ADR1 => cs_FFd5,
      O => cs_FFd3_In
    );
  cs_FFd4_In1 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => newfint,
      ADR1 => cs_FFd8,
      O => cs_FFd4_In
    );
  cs_FFd6_In1 : X_LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      ADR0 => newfint,
      ADR1 => cs_FFd7,
      ADR2 => den,
      O => cs_FFd6_In
    );
  cs_FFd10_In_SW0 : X_LUT3
    generic map(
      INIT => X"AE"
    )
    port map (
      ADR0 => cs_FFd11,
      ADR1 => cs_FFd10,
      ADR2 => den,
      O => N3593
    );
  cs_FFd9_In1 : X_LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      ADR0 => newfint,
      ADR1 => cs_FFd10,
      ADR2 => den,
      O => cs_FFd9_In
    );
  addr_7 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr_inst_sum_23,
      CE => Q_n0040,
      CLK => CLK_BUFGP,
      O => addr(7),
      SET => GND,
      RST => GSR
    );
  cs_FFd12_In38 : X_LUT4
    generic map(
      INIT => X"FF0E"
    )
    port map (
      ADR0 => CHOICE15,
      ADR1 => CHOICE18,
      ADR2 => newfint,
      ADR3 => CHOICE25,
      O => cs_FFd12_In
    );
  cs_FFd1_55 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd2,
      RST => cs_FFd1_GSR_OR,
      CLK => CLK_BUFGP,
      O => cs_FFd1,
      CE => VCC,
      SET => GND
    );
  cs_FFd2_56 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd2_In,
      RST => cs_FFd2_GSR_OR,
      CLK => CLK_BUFGP,
      O => cs_FFd2,
      CE => VCC,
      SET => GND
    );
  cs_FFd3_57 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd3_In,
      RST => cs_FFd3_GSR_OR,
      CLK => CLK_BUFGP,
      O => cs_FFd3,
      CE => VCC,
      SET => GND
    );
  cs_FFd4_58 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd4_In,
      RST => cs_FFd4_GSR_OR,
      CLK => CLK_BUFGP,
      O => cs_FFd4,
      CE => VCC,
      SET => GND
    );
  cs_FFd5_59 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd5_In,
      RST => cs_FFd5_GSR_OR,
      CLK => CLK_BUFGP,
      O => cs_FFd5,
      CE => VCC,
      SET => GND
    );
  cs_FFd6_60 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd6_In,
      RST => cs_FFd6_GSR_OR,
      CLK => CLK_BUFGP,
      O => cs_FFd6,
      CE => VCC,
      SET => GND
    );
  cs_FFd7_61 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd7_In,
      RST => cs_FFd7_GSR_OR,
      CLK => CLK_BUFGP,
      O => cs_FFd7,
      CE => VCC,
      SET => GND
    );
  cs_FFd8_62 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd8_In,
      RST => cs_FFd8_GSR_OR,
      CLK => CLK_BUFGP,
      O => cs_FFd8,
      CE => VCC,
      SET => GND
    );
  cs_FFd9_63 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd9_In,
      RST => cs_FFd9_GSR_OR,
      CLK => CLK_BUFGP,
      O => cs_FFd9,
      CE => VCC,
      SET => GND
    );
  cs_FFd10_64 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd10_In,
      RST => cs_FFd10_GSR_OR,
      CLK => CLK_BUFGP,
      O => cs_FFd10,
      CE => VCC,
      SET => GND
    );
  cs_FFd11_65 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd11_In,
      RST => cs_FFd11_GSR_OR,
      CLK => CLK_BUFGP,
      O => cs_FFd11,
      CE => VCC,
      SET => GND
    );
  cs_FFd12_66 : X_FF
    generic map(
      XON => FALSE,
      INIT => '1'
    )
    port map (
      I => cs_FFd12_In,
      SET => cs_FFd12_GSR_OR,
      CLK => CLK_BUFGP,
      O => cs_FFd12,
      CE => VCC,
      RST => GND
    );
  addr_8 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr_inst_sum_24,
      CE => Q_n0040,
      CLK => CLK_BUFGP,
      O => addr(8),
      SET => GND,
      RST => GSR
    );
  cs_Out51 : X_LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      ADR0 => cs_FFd6,
      ADR1 => cs_FFd4,
      ADR2 => cs_FFd11,
      O => mrw
    );
  Msub_n0041_inst_lut2_151 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => CNT(15),
      O => Msub_n0041_inst_lut2_15,
      ADR1 => GND
    );
  addr_12 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr_inst_sum_28,
      CE => Q_n0040,
      CLK => CLK_BUFGP,
      O => addr(12),
      SET => GND,
      RST => GSR
    );
  Msub_n0041_inst_lut2_01 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => CNT(0),
      O => Msub_n0041_inst_lut2_0,
      ADR1 => GND
    );
  Msub_n0041_inst_cy_0_67 : X_MUX2
    port map (
      IB => N138,
      IA => CNT(0),
      SEL => Msub_n0041_inst_lut2_0,
      O => Msub_n0041_inst_cy_0
    );
  Msub_n0041_inst_sum_0 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_lut2_0,
      I1 => N138,
      O => Q_n0081(0)
    );
  Msub_n0041_inst_sum_15 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_lut2_15,
      I1 => Msub_n0041_inst_cy_14,
      O => Q_n0081(15)
    );
  Msub_n0041_inst_cy_1_68 : X_MUX2
    port map (
      IB => Msub_n0041_inst_cy_0,
      IA => N140,
      SEL => CNT_1_rt,
      O => Msub_n0041_inst_cy_1
    );
  Msub_n0041_inst_sum_1 : X_XOR2
    port map (
      I0 => CNT_1_rt,
      I1 => Msub_n0041_inst_cy_0,
      O => Q_n0081(1)
    );
  Msub_n0041_inst_lut2_21 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => CNT(2),
      O => Msub_n0041_inst_lut2_2,
      ADR1 => GND
    );
  Msub_n0041_inst_cy_2_69 : X_MUX2
    port map (
      IB => Msub_n0041_inst_cy_1,
      IA => CNT(2),
      SEL => Msub_n0041_inst_lut2_2,
      O => Msub_n0041_inst_cy_2
    );
  Msub_n0041_inst_sum_2 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_lut2_2,
      I1 => Msub_n0041_inst_cy_1,
      O => Q_n0081(2)
    );
  Msub_n0041_inst_lut2_31 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => CNT(3),
      O => Msub_n0041_inst_lut2_3,
      ADR1 => GND
    );
  Msub_n0041_inst_cy_3_70 : X_MUX2
    port map (
      IB => Msub_n0041_inst_cy_2,
      IA => CNT(3),
      SEL => Msub_n0041_inst_lut2_3,
      O => Msub_n0041_inst_cy_3
    );
  Msub_n0041_inst_sum_3 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_lut2_3,
      I1 => Msub_n0041_inst_cy_2,
      O => Q_n0081(3)
    );
  Msub_n0041_inst_lut2_41 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => CNT(4),
      O => Msub_n0041_inst_lut2_4,
      ADR1 => GND
    );
  Msub_n0041_inst_cy_4_71 : X_MUX2
    port map (
      IB => Msub_n0041_inst_cy_3,
      IA => CNT(4),
      SEL => Msub_n0041_inst_lut2_4,
      O => Msub_n0041_inst_cy_4
    );
  Msub_n0041_inst_sum_4 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_lut2_4,
      I1 => Msub_n0041_inst_cy_3,
      O => Q_n0081(4)
    );
  Msub_n0041_inst_lut2_51 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => CNT(5),
      O => Msub_n0041_inst_lut2_5,
      ADR1 => GND
    );
  Msub_n0041_inst_cy_5_72 : X_MUX2
    port map (
      IB => Msub_n0041_inst_cy_4,
      IA => CNT(5),
      SEL => Msub_n0041_inst_lut2_5,
      O => Msub_n0041_inst_cy_5
    );
  Msub_n0041_inst_sum_5 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_lut2_5,
      I1 => Msub_n0041_inst_cy_4,
      O => Q_n0081(5)
    );
  Msub_n0041_inst_lut2_61 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => CNT(6),
      O => Msub_n0041_inst_lut2_6,
      ADR1 => GND
    );
  Msub_n0041_inst_cy_6_73 : X_MUX2
    port map (
      IB => Msub_n0041_inst_cy_5,
      IA => CNT(6),
      SEL => Msub_n0041_inst_lut2_6,
      O => Msub_n0041_inst_cy_6
    );
  Msub_n0041_inst_sum_6 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_lut2_6,
      I1 => Msub_n0041_inst_cy_5,
      O => Q_n0081(6)
    );
  Msub_n0041_inst_lut2_71 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => CNT(7),
      O => Msub_n0041_inst_lut2_7,
      ADR1 => GND
    );
  Msub_n0041_inst_cy_7_74 : X_MUX2
    port map (
      IB => Msub_n0041_inst_cy_6,
      IA => CNT(7),
      SEL => Msub_n0041_inst_lut2_7,
      O => Msub_n0041_inst_cy_7
    );
  Msub_n0041_inst_sum_7 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_lut2_7,
      I1 => Msub_n0041_inst_cy_6,
      O => Q_n0081(7)
    );
  Msub_n0041_inst_lut2_81 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => CNT(8),
      O => Msub_n0041_inst_lut2_8,
      ADR1 => GND
    );
  Msub_n0041_inst_cy_8_75 : X_MUX2
    port map (
      IB => Msub_n0041_inst_cy_7,
      IA => CNT(8),
      SEL => Msub_n0041_inst_lut2_8,
      O => Msub_n0041_inst_cy_8
    );
  Msub_n0041_inst_sum_8 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_lut2_8,
      I1 => Msub_n0041_inst_cy_7,
      O => Q_n0081(8)
    );
  Msub_n0041_inst_lut2_91 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => CNT(9),
      O => Msub_n0041_inst_lut2_9,
      ADR1 => GND
    );
  Msub_n0041_inst_cy_9_76 : X_MUX2
    port map (
      IB => Msub_n0041_inst_cy_8,
      IA => CNT(9),
      SEL => Msub_n0041_inst_lut2_9,
      O => Msub_n0041_inst_cy_9
    );
  Msub_n0041_inst_sum_9 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_lut2_9,
      I1 => Msub_n0041_inst_cy_8,
      O => Q_n0081(9)
    );
  Msub_n0041_inst_lut2_101 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => CNT(10),
      O => Msub_n0041_inst_lut2_10,
      ADR1 => GND
    );
  Msub_n0041_inst_cy_10_77 : X_MUX2
    port map (
      IB => Msub_n0041_inst_cy_9,
      IA => CNT(10),
      SEL => Msub_n0041_inst_lut2_10,
      O => Msub_n0041_inst_cy_10
    );
  Msub_n0041_inst_sum_10 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_lut2_10,
      I1 => Msub_n0041_inst_cy_9,
      O => Q_n0081(10)
    );
  Msub_n0041_inst_lut2_111 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => CNT(11),
      O => Msub_n0041_inst_lut2_11,
      ADR1 => GND
    );
  Msub_n0041_inst_cy_11_78 : X_MUX2
    port map (
      IB => Msub_n0041_inst_cy_10,
      IA => CNT(11),
      SEL => Msub_n0041_inst_lut2_11,
      O => Msub_n0041_inst_cy_11
    );
  Msub_n0041_inst_sum_11 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_lut2_11,
      I1 => Msub_n0041_inst_cy_10,
      O => Q_n0081(11)
    );
  Msub_n0041_inst_lut2_121 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => CNT(12),
      O => Msub_n0041_inst_lut2_12,
      ADR1 => GND
    );
  Msub_n0041_inst_cy_12_79 : X_MUX2
    port map (
      IB => Msub_n0041_inst_cy_11,
      IA => CNT(12),
      SEL => Msub_n0041_inst_lut2_12,
      O => Msub_n0041_inst_cy_12
    );
  Msub_n0041_inst_sum_12 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_lut2_12,
      I1 => Msub_n0041_inst_cy_11,
      O => Q_n0081(12)
    );
  Msub_n0041_inst_lut2_131 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => CNT(13),
      O => Msub_n0041_inst_lut2_13,
      ADR1 => GND
    );
  Msub_n0041_inst_cy_13_80 : X_MUX2
    port map (
      IB => Msub_n0041_inst_cy_12,
      IA => CNT(13),
      SEL => Msub_n0041_inst_lut2_13,
      O => Msub_n0041_inst_cy_13
    );
  Msub_n0041_inst_sum_13 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_lut2_13,
      I1 => Msub_n0041_inst_cy_12,
      O => Q_n0081(13)
    );
  Msub_n0041_inst_lut2_141 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => CNT(14),
      O => Msub_n0041_inst_lut2_14,
      ADR1 => GND
    );
  Msub_n0041_inst_cy_14_81 : X_MUX2
    port map (
      IB => Msub_n0041_inst_cy_13,
      IA => CNT(14),
      SEL => Msub_n0041_inst_lut2_14,
      O => Msub_n0041_inst_cy_14
    );
  Mmux_n0039_Result_0_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(0),
      ADR2 => Q_n0081(0),
      O => Q_n0039(0)
    );
  Mmux_n0039_Result_1_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(1),
      ADR2 => Q_n0081(1),
      O => Q_n0039(1)
    );
  Mmux_n0039_Result_2_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(2),
      ADR2 => Q_n0081(2),
      O => Q_n0039(2)
    );
  Mmux_n0039_Result_3_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(3),
      ADR2 => Q_n0081(3),
      O => Q_n0039(3)
    );
  Mmux_n0039_Result_4_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(4),
      ADR2 => Q_n0081(4),
      O => Q_n0039(4)
    );
  Mmux_n0039_Result_5_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(5),
      ADR2 => Q_n0081(5),
      O => Q_n0039(5)
    );
  Mmux_n0039_Result_6_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(6),
      ADR2 => Q_n0081(6),
      O => Q_n0039(6)
    );
  Mmux_n0039_Result_7_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(7),
      ADR2 => Q_n0081(7),
      O => Q_n0039(7)
    );
  Mmux_n0039_Result_8_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(8),
      ADR2 => Q_n0081(8),
      O => Q_n0039(8)
    );
  Mmux_n0039_Result_9_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(9),
      ADR2 => Q_n0081(9),
      O => Q_n0039(9)
    );
  Mmux_n0039_Result_10_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(10),
      ADR2 => Q_n0081(10),
      O => Q_n0039(10)
    );
  Mmux_n0039_Result_11_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(11),
      ADR2 => Q_n0081(11),
      O => Q_n0039(11)
    );
  Mmux_n0039_Result_12_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(12),
      ADR2 => Q_n0081(12),
      O => Q_n0039(12)
    );
  Mmux_n0039_Result_13_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(13),
      ADR2 => Q_n0081(13),
      O => Q_n0039(13)
    );
  Mmux_n0039_Result_14_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(14),
      ADR2 => Q_n0081(14),
      O => Q_n0039(14)
    );
  addr_14 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr_inst_sum_30,
      CE => Q_n0040,
      CLK => CLK_BUFGP,
      O => addr(14),
      SET => GND,
      RST => GSR
    );
  addr_15 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr_inst_sum_31,
      CE => Q_n0040,
      CLK => CLK_BUFGP,
      O => addr(15),
      SET => GND,
      RST => GSR
    );
  addr_inst_cy_16_82 : X_MUX2
    port map (
      IB => N140,
      IA => N138,
      SEL => Q_n0016_rt,
      O => addr_inst_cy_16
    );
  addr_inst_lut3_01 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12,
      ADR1 => bp_0_1,
      ADR2 => addr(0),
      O => addr_inst_lut3_0
    );
  addr_inst_cy_17_83 : X_MUX2
    port map (
      IB => addr_inst_cy_16,
      IA => N140,
      SEL => addr_inst_lut3_0,
      O => addr_inst_cy_17
    );
  addr_inst_sum_16_84 : X_XOR2
    port map (
      I0 => addr_inst_lut3_0,
      I1 => addr_inst_cy_16,
      O => addr_inst_sum_16
    );
  addr_inst_lut3_16 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12,
      ADR1 => bp_1_1,
      ADR2 => addr(1),
      O => addr_inst_lut3_1
    );
  addr_inst_cy_18_85 : X_MUX2
    port map (
      IB => addr_inst_cy_17,
      IA => N140,
      SEL => addr_inst_lut3_1,
      O => addr_inst_cy_18
    );
  addr_inst_sum_17_86 : X_XOR2
    port map (
      I0 => addr_inst_lut3_1,
      I1 => addr_inst_cy_17,
      O => addr_inst_sum_17
    );
  addr_inst_lut3_21 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12,
      ADR1 => bp_2_1,
      ADR2 => addr(2),
      O => addr_inst_lut3_2
    );
  addr_inst_cy_19_87 : X_MUX2
    port map (
      IB => addr_inst_cy_18,
      IA => N140,
      SEL => addr_inst_lut3_2,
      O => addr_inst_cy_19
    );
  addr_inst_sum_18_88 : X_XOR2
    port map (
      I0 => addr_inst_lut3_2,
      I1 => addr_inst_cy_18,
      O => addr_inst_sum_18
    );
  addr_inst_cy_20_89 : X_MUX2
    port map (
      IB => addr_inst_cy_19,
      IA => N140,
      SEL => addr_inst_lut3_3,
      O => addr_inst_cy_20
    );
  addr_inst_sum_19_90 : X_XOR2
    port map (
      I0 => addr_inst_lut3_3,
      I1 => addr_inst_cy_19,
      O => addr_inst_sum_19
    );
  addr_inst_cy_21_91 : X_MUX2
    port map (
      IB => addr_inst_cy_20,
      IA => N140,
      SEL => addr_inst_lut3_4,
      O => addr_inst_cy_21
    );
  addr_inst_sum_20_92 : X_XOR2
    port map (
      I0 => addr_inst_lut3_4,
      I1 => addr_inst_cy_20,
      O => addr_inst_sum_20
    );
  addr_inst_lut3_51 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_5_1,
      ADR2 => addr(5),
      O => addr_inst_lut3_5
    );
  addr_inst_cy_22_93 : X_MUX2
    port map (
      IB => addr_inst_cy_21,
      IA => N140,
      SEL => addr_inst_lut3_5,
      O => addr_inst_cy_22
    );
  addr_inst_sum_21_94 : X_XOR2
    port map (
      I0 => addr_inst_lut3_5,
      I1 => addr_inst_cy_21,
      O => addr_inst_sum_21
    );
  addr_inst_lut3_61 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_6_1,
      ADR2 => addr(6),
      O => addr_inst_lut3_6
    );
  addr_inst_cy_23_95 : X_MUX2
    port map (
      IB => addr_inst_cy_22,
      IA => N140,
      SEL => addr_inst_lut3_6,
      O => addr_inst_cy_23
    );
  addr_inst_sum_22_96 : X_XOR2
    port map (
      I0 => addr_inst_lut3_6,
      I1 => addr_inst_cy_22,
      O => addr_inst_sum_22
    );
  addr_inst_lut3_71 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_7_1,
      ADR2 => addr(7),
      O => addr_inst_lut3_7
    );
  addr_inst_cy_24_97 : X_MUX2
    port map (
      IB => addr_inst_cy_23,
      IA => N140,
      SEL => addr_inst_lut3_7,
      O => addr_inst_cy_24
    );
  addr_inst_sum_23_98 : X_XOR2
    port map (
      I0 => addr_inst_lut3_7,
      I1 => addr_inst_cy_23,
      O => addr_inst_sum_23
    );
  addr_inst_lut3_81 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_8_1,
      ADR2 => addr(8),
      O => addr_inst_lut3_8
    );
  addr_inst_cy_25_99 : X_MUX2
    port map (
      IB => addr_inst_cy_24,
      IA => N140,
      SEL => addr_inst_lut3_8,
      O => addr_inst_cy_25
    );
  addr_inst_sum_24_100 : X_XOR2
    port map (
      I0 => addr_inst_lut3_8,
      I1 => addr_inst_cy_24,
      O => addr_inst_sum_24
    );
  addr_inst_lut3_91 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_9_1,
      ADR2 => addr(9),
      O => addr_inst_lut3_9
    );
  addr_inst_cy_26_101 : X_MUX2
    port map (
      IB => addr_inst_cy_25,
      IA => N140,
      SEL => addr_inst_lut3_9,
      O => addr_inst_cy_26
    );
  addr_inst_sum_25_102 : X_XOR2
    port map (
      I0 => addr_inst_lut3_9,
      I1 => addr_inst_cy_25,
      O => addr_inst_sum_25
    );
  addr_inst_lut3_101 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_10_1,
      ADR2 => addr(10),
      O => addr_inst_lut3_10
    );
  addr_inst_cy_27_103 : X_MUX2
    port map (
      IB => addr_inst_cy_26,
      IA => N140,
      SEL => addr_inst_lut3_10,
      O => addr_inst_cy_27
    );
  addr_inst_sum_26_104 : X_XOR2
    port map (
      I0 => addr_inst_lut3_10,
      I1 => addr_inst_cy_26,
      O => addr_inst_sum_26
    );
  addr_inst_lut3_111 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_11_1,
      ADR2 => addr(11),
      O => addr_inst_lut3_11
    );
  addr_inst_cy_28_105 : X_MUX2
    port map (
      IB => addr_inst_cy_27,
      IA => N140,
      SEL => addr_inst_lut3_11,
      O => addr_inst_cy_28
    );
  addr_inst_sum_27_106 : X_XOR2
    port map (
      I0 => addr_inst_lut3_11,
      I1 => addr_inst_cy_27,
      O => addr_inst_sum_27
    );
  addr_inst_lut3_121 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_12_1,
      ADR2 => addr(12),
      O => addr_inst_lut3_12
    );
  addr_inst_cy_29_107 : X_MUX2
    port map (
      IB => addr_inst_cy_28,
      IA => N140,
      SEL => addr_inst_lut3_12,
      O => addr_inst_cy_29
    );
  addr_inst_sum_28_108 : X_XOR2
    port map (
      I0 => addr_inst_lut3_12,
      I1 => addr_inst_cy_28,
      O => addr_inst_sum_28
    );
  addr_inst_lut3_131 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_13_1,
      ADR2 => addr(13),
      O => addr_inst_lut3_13
    );
  addr_inst_cy_30_109 : X_MUX2
    port map (
      IB => addr_inst_cy_29,
      IA => N140,
      SEL => addr_inst_lut3_13,
      O => addr_inst_cy_30
    );
  addr_inst_sum_29_110 : X_XOR2
    port map (
      I0 => addr_inst_lut3_13,
      I1 => addr_inst_cy_29,
      O => addr_inst_sum_29
    );
  addr_inst_lut3_141 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_14_1,
      ADR2 => addr(14),
      O => addr_inst_lut3_14
    );
  addr_inst_cy_31_111 : X_MUX2
    port map (
      IB => addr_inst_cy_30,
      IA => N140,
      SEL => addr_inst_lut3_14,
      O => addr_inst_cy_31
    );
  addr_inst_sum_30_112 : X_XOR2
    port map (
      I0 => addr_inst_lut3_14,
      I1 => addr_inst_cy_30,
      O => addr_inst_sum_30
    );
  addr_inst_lut3_151 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_15_1,
      ADR2 => addr(15),
      O => addr_inst_lut3_15
    );
  addr_11 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr_inst_sum_27,
      CE => Q_n0040,
      CLK => CLK_BUFGP,
      O => addr(11),
      SET => GND,
      RST => GSR
    );
  addr_inst_sum_31_113 : X_XOR2
    port map (
      I0 => addr_inst_lut3_15,
      I1 => addr_inst_cy_31,
      O => addr_inst_sum_31
    );
  addr_0 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr_inst_sum_16,
      CE => Q_n0040,
      CLK => CLK_BUFGP,
      O => addr(0),
      SET => GND,
      RST => GSR
    );
  addr_1 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr_inst_sum_17,
      CE => Q_n0040,
      CLK => CLK_BUFGP,
      O => addr(1),
      SET => GND,
      RST => GSR
    );
  addr_2 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr_inst_sum_18,
      CE => Q_n0040,
      CLK => CLK_BUFGP,
      O => addr(2),
      SET => GND,
      RST => GSR
    );
  addr_3 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr_inst_sum_19,
      CE => Q_n0040,
      CLK => CLK_BUFGP,
      O => addr(3),
      SET => GND,
      RST => GSR
    );
  addr_4 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr_inst_sum_20,
      CE => Q_n0040,
      CLK => CLK_BUFGP,
      O => addr(4),
      SET => GND,
      RST => GSR
    );
  addr_5 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr_inst_sum_21,
      CE => Q_n0040,
      CLK => CLK_BUFGP,
      O => addr(5),
      SET => GND,
      RST => GSR
    );
  addr_6 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr_inst_sum_22,
      CE => Q_n0040,
      CLK => CLK_BUFGP,
      O => addr(6),
      SET => GND,
      RST => GSR
    );
  cs_FFd7_In_SW0 : X_LUT2
    generic map(
      INIT => X"D"
    )
    port map (
      ADR0 => cs_FFd7,
      ADR1 => den,
      O => N3553
    );
  cs_FFd12_In9 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => cs_FFd8,
      ADR1 => cs_FFd9,
      ADR2 => cs_FFd10,
      ADR3 => cs_FFd11,
      O => CHOICE18
    );
  cs_FFd12_In34 : X_LUT4
    generic map(
      INIT => X"EEFE"
    )
    port map (
      ADR0 => cs_FFd3_1,
      ADR1 => cs_FFd1_1,
      ADR2 => cs_FFd12_1,
      ADR3 => den,
      O => CHOICE25
    );
  cs_FFd12_In4 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => cs_FFd4,
      ADR2 => cs_FFd6,
      ADR3 => cs_FFd7,
      O => CHOICE15
    );
  CNT_1_rt_114 : X_LUT2
    generic map(
      INIT => X"A"
    )
    port map (
      ADR0 => CNT(1),
      O => CNT_1_rt,
      ADR1 => GND
    );
  Ker342627 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => CHOICE36,
      ADR1 => CHOICE39,
      O => CHOICE40
    );
  Ker3426107 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => CNT(12),
      ADR1 => CNT(13),
      ADR2 => CNT(14),
      ADR3 => CNT(15),
      O => CHOICE70
    );
  Q_n0016_rt_115 : X_LUT2
    generic map(
      INIT => X"A"
    )
    port map (
      ADR0 => cs_FFd12,
      O => Q_n0016_rt,
      ADR1 => GND
    );
  Ker34269 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => CNT(4),
      ADR1 => CNT(5),
      ADR2 => CNT(6),
      ADR3 => CNT(7),
      O => CHOICE32
    );
  Ker342670 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => CNT(4),
      ADR1 => CNT(5),
      ADR2 => CNT(6),
      ADR3 => CNT(7),
      O => CHOICE55
    );
  Ker34264 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => CNT(0),
      ADR1 => CNT(1),
      ADR2 => CNT(2),
      ADR3 => CNT(3),
      O => CHOICE29
    );
  Ker342657 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => CNT(0),
      ADR1 => CNT(1),
      ADR2 => CNT(2),
      ADR3 => CNT(3),
      O => CHOICE48
    );
  Ker342626 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => CNT(12),
      ADR1 => CNT(13),
      ADR2 => CNT(14),
      ADR3 => CNT(15),
      O => CHOICE39
    );
  Ker342694 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => CNT(8),
      ADR1 => CNT(9),
      ADR2 => CNT(10),
      ADR3 => CNT(11),
      O => CHOICE63
    );
  RESET_IBUF_116 : X_BUF
    port map (
      I => RESET,
      O => RESET_IBUF
    );
  NEWFRAME_IBUF_117 : X_BUF
    port map (
      I => NEWFRAME,
      O => NEWFRAME_IBUF
    );
  FIFOFULL_IBUF_118 : X_BUF
    port map (
      I => FIFOFULL,
      O => FIFOFULL_IBUF
    );
  DIN_15_IBUF_119 : X_BUF
    port map (
      I => DIN(15),
      O => DIN_15_IBUF
    );
  DIN_14_IBUF_120 : X_BUF
    port map (
      I => DIN(14),
      O => DIN_14_IBUF
    );
  DIN_13_IBUF_121 : X_BUF
    port map (
      I => DIN(13),
      O => DIN_13_IBUF
    );
  DIN_12_IBUF_122 : X_BUF
    port map (
      I => DIN(12),
      O => DIN_12_IBUF
    );
  DIN_11_IBUF_123 : X_BUF
    port map (
      I => DIN(11),
      O => DIN_11_IBUF
    );
  DIN_10_IBUF_124 : X_BUF
    port map (
      I => DIN(10),
      O => DIN_10_IBUF
    );
  DIN_9_IBUF_125 : X_BUF
    port map (
      I => DIN(9),
      O => DIN_9_IBUF
    );
  DIN_8_IBUF_126 : X_BUF
    port map (
      I => DIN(8),
      O => DIN_8_IBUF
    );
  DIN_7_IBUF_127 : X_BUF
    port map (
      I => DIN(7),
      O => DIN_7_IBUF
    );
  DIN_6_IBUF_128 : X_BUF
    port map (
      I => DIN(6),
      O => DIN_6_IBUF
    );
  DIN_5_IBUF_129 : X_BUF
    port map (
      I => DIN(5),
      O => DIN_5_IBUF
    );
  DIN_4_IBUF_130 : X_BUF
    port map (
      I => DIN(4),
      O => DIN_4_IBUF
    );
  DIN_3_IBUF_131 : X_BUF
    port map (
      I => DIN(3),
      O => DIN_3_IBUF
    );
  DIN_2_IBUF_132 : X_BUF
    port map (
      I => DIN(2),
      O => DIN_2_IBUF
    );
  DIN_1_IBUF_133 : X_BUF
    port map (
      I => DIN(1),
      O => DIN_1_IBUF
    );
  DIN_0_IBUF_134 : X_BUF
    port map (
      I => DIN(0),
      O => DIN_0_IBUF
    );
  TXFIFOWERR_OBUF : X_BUF
    port map (
      I => cs_FFd3,
      O => TXFIFOWERR_OBUF_GTS_TRI
    );
  MWEN_OBUF_135 : X_BUF
    port map (
      I => MWEN_OBUF,
      O => MWEN_OBUF_GTS_TRI
    );
  DONE_OBUF : X_BUF
    port map (
      I => cs_FFd1,
      O => DONE_OBUF_GTS_TRI
    );
  MA_15_OBUF : X_BUF
    port map (
      I => MA_15,
      O => MA_15_OBUF_GTS_TRI
    );
  MA_14_OBUF : X_BUF
    port map (
      I => MA_14,
      O => MA_14_OBUF_GTS_TRI
    );
  MA_13_OBUF : X_BUF
    port map (
      I => MA_13,
      O => MA_13_OBUF_GTS_TRI
    );
  MA_12_OBUF : X_BUF
    port map (
      I => MA_12,
      O => MA_12_OBUF_GTS_TRI
    );
  MA_11_OBUF : X_BUF
    port map (
      I => MA_11,
      O => MA_11_OBUF_GTS_TRI
    );
  MA_10_OBUF : X_BUF
    port map (
      I => MA_10,
      O => MA_10_OBUF_GTS_TRI
    );
  MA_9_OBUF : X_BUF
    port map (
      I => MA_9,
      O => MA_9_OBUF_GTS_TRI
    );
  MA_8_OBUF : X_BUF
    port map (
      I => MA_8,
      O => MA_8_OBUF_GTS_TRI
    );
  MA_7_OBUF : X_BUF
    port map (
      I => MA_7,
      O => MA_7_OBUF_GTS_TRI
    );
  MA_6_OBUF : X_BUF
    port map (
      I => MA_6,
      O => MA_6_OBUF_GTS_TRI
    );
  MA_5_OBUF : X_BUF
    port map (
      I => MA_5,
      O => MA_5_OBUF_GTS_TRI
    );
  MA_4_OBUF : X_BUF
    port map (
      I => MA_4,
      O => MA_4_OBUF_GTS_TRI
    );
  MA_3_OBUF : X_BUF
    port map (
      I => MA_3,
      O => MA_3_OBUF_GTS_TRI
    );
  MA_2_OBUF : X_BUF
    port map (
      I => MA_2,
      O => MA_2_OBUF_GTS_TRI
    );
  MA_1_OBUF : X_BUF
    port map (
      I => MA_1,
      O => MA_1_OBUF_GTS_TRI
    );
  MA_0_OBUF : X_BUF
    port map (
      I => MA_0,
      O => MA_0_OBUF_GTS_TRI
    );
  MD_31_OBUF : X_BUF
    port map (
      I => MD_31,
      O => MD_31_OBUF_GTS_TRI
    );
  MD_30_OBUF : X_BUF
    port map (
      I => MD_30,
      O => MD_30_OBUF_GTS_TRI
    );
  MD_29_OBUF : X_BUF
    port map (
      I => MD_29,
      O => MD_29_OBUF_GTS_TRI
    );
  MD_28_OBUF : X_BUF
    port map (
      I => MD_28,
      O => MD_28_OBUF_GTS_TRI
    );
  MD_27_OBUF : X_BUF
    port map (
      I => MD_27,
      O => MD_27_OBUF_GTS_TRI
    );
  MD_26_OBUF : X_BUF
    port map (
      I => MD_26,
      O => MD_26_OBUF_GTS_TRI
    );
  MD_25_OBUF : X_BUF
    port map (
      I => MD_25,
      O => MD_25_OBUF_GTS_TRI
    );
  MD_24_OBUF : X_BUF
    port map (
      I => MD_24,
      O => MD_24_OBUF_GTS_TRI
    );
  MD_23_OBUF : X_BUF
    port map (
      I => MD_23,
      O => MD_23_OBUF_GTS_TRI
    );
  MD_22_OBUF : X_BUF
    port map (
      I => MD_22,
      O => MD_22_OBUF_GTS_TRI
    );
  MD_21_OBUF : X_BUF
    port map (
      I => MD_21,
      O => MD_21_OBUF_GTS_TRI
    );
  MD_20_OBUF : X_BUF
    port map (
      I => MD_20,
      O => MD_20_OBUF_GTS_TRI
    );
  MD_19_OBUF : X_BUF
    port map (
      I => MD_19,
      O => MD_19_OBUF_GTS_TRI
    );
  MD_18_OBUF : X_BUF
    port map (
      I => MD_18,
      O => MD_18_OBUF_GTS_TRI
    );
  MD_17_OBUF : X_BUF
    port map (
      I => MD_17,
      O => MD_17_OBUF_GTS_TRI
    );
  MD_16_OBUF : X_BUF
    port map (
      I => MD_16,
      O => MD_16_OBUF_GTS_TRI
    );
  MD_15_OBUF : X_BUF
    port map (
      I => MD_15,
      O => MD_15_OBUF_GTS_TRI
    );
  MD_14_OBUF : X_BUF
    port map (
      I => MD_14,
      O => MD_14_OBUF_GTS_TRI
    );
  MD_13_OBUF : X_BUF
    port map (
      I => MD_13,
      O => MD_13_OBUF_GTS_TRI
    );
  MD_12_OBUF : X_BUF
    port map (
      I => MD_12,
      O => MD_12_OBUF_GTS_TRI
    );
  MD_11_OBUF : X_BUF
    port map (
      I => MD_11,
      O => MD_11_OBUF_GTS_TRI
    );
  MD_10_OBUF : X_BUF
    port map (
      I => MD_10,
      O => MD_10_OBUF_GTS_TRI
    );
  MD_9_OBUF : X_BUF
    port map (
      I => MD_9,
      O => MD_9_OBUF_GTS_TRI
    );
  MD_8_OBUF : X_BUF
    port map (
      I => MD_8,
      O => MD_8_OBUF_GTS_TRI
    );
  MD_7_OBUF : X_BUF
    port map (
      I => MD_7,
      O => MD_7_OBUF_GTS_TRI
    );
  MD_6_OBUF : X_BUF
    port map (
      I => MD_6,
      O => MD_6_OBUF_GTS_TRI
    );
  MD_5_OBUF : X_BUF
    port map (
      I => MD_5,
      O => MD_5_OBUF_GTS_TRI
    );
  MD_4_OBUF : X_BUF
    port map (
      I => MD_4,
      O => MD_4_OBUF_GTS_TRI
    );
  MD_3_OBUF : X_BUF
    port map (
      I => MD_3,
      O => MD_3_OBUF_GTS_TRI
    );
  MD_2_OBUF : X_BUF
    port map (
      I => MD_2,
      O => MD_2_OBUF_GTS_TRI
    );
  MD_1_OBUF : X_BUF
    port map (
      I => MD_1,
      O => MD_1_OBUF_GTS_TRI
    );
  MD_0_OBUF : X_BUF
    port map (
      I => MD_0,
      O => MD_0_OBUF_GTS_TRI
    );
  BPOUT_15_OBUF : X_BUF
    port map (
      I => bp(15),
      O => BPOUT_15_OBUF_GTS_TRI
    );
  BPOUT_14_OBUF : X_BUF
    port map (
      I => bp(14),
      O => BPOUT_14_OBUF_GTS_TRI
    );
  BPOUT_13_OBUF : X_BUF
    port map (
      I => bp(13),
      O => BPOUT_13_OBUF_GTS_TRI
    );
  BPOUT_12_OBUF : X_BUF
    port map (
      I => bp(12),
      O => BPOUT_12_OBUF_GTS_TRI
    );
  BPOUT_11_OBUF : X_BUF
    port map (
      I => bp(11),
      O => BPOUT_11_OBUF_GTS_TRI
    );
  BPOUT_10_OBUF : X_BUF
    port map (
      I => bp(10),
      O => BPOUT_10_OBUF_GTS_TRI
    );
  BPOUT_9_OBUF : X_BUF
    port map (
      I => bp(9),
      O => BPOUT_9_OBUF_GTS_TRI
    );
  BPOUT_8_OBUF : X_BUF
    port map (
      I => bp(8),
      O => BPOUT_8_OBUF_GTS_TRI
    );
  BPOUT_7_OBUF : X_BUF
    port map (
      I => bp(7),
      O => BPOUT_7_OBUF_GTS_TRI
    );
  BPOUT_6_OBUF : X_BUF
    port map (
      I => bp(6),
      O => BPOUT_6_OBUF_GTS_TRI
    );
  BPOUT_5_OBUF : X_BUF
    port map (
      I => bp(5),
      O => BPOUT_5_OBUF_GTS_TRI
    );
  BPOUT_4_OBUF : X_BUF
    port map (
      I => bp(4),
      O => BPOUT_4_OBUF_GTS_TRI
    );
  BPOUT_3_OBUF : X_BUF
    port map (
      I => bp(3),
      O => BPOUT_3_OBUF_GTS_TRI
    );
  BPOUT_2_OBUF : X_BUF
    port map (
      I => bp(2),
      O => BPOUT_2_OBUF_GTS_TRI
    );
  BPOUT_1_OBUF : X_BUF
    port map (
      I => bp(1),
      O => BPOUT_1_OBUF_GTS_TRI
    );
  Q_n00281 : X_LUT4
    generic map(
      INIT => X"0E00"
    )
    port map (
      ADR0 => cs_FFd6,
      ADR1 => cs_FFd7,
      ADR2 => RESET_IBUF,
      ADR3 => den,
      O => Q_n0028
    );
  cs_FFd12_1_136 : X_FF
    generic map(
      XON => FALSE,
      INIT => '1'
    )
    port map (
      I => cs_FFd12_In,
      SET => cs_FFd12_1_GSR_OR,
      CLK => CLK_BUFGP,
      O => cs_FFd12_1,
      CE => VCC,
      RST => GND
    );
  cs_Out51_1_137 : X_LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      ADR0 => cs_FFd6,
      ADR1 => cs_FFd4,
      ADR2 => cs_FFd11,
      O => cs_Out51_1
    );
  cs_FFd3_1_138 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd3_In,
      RST => cs_FFd3_1_GSR_OR,
      CLK => CLK_BUFGP,
      O => cs_FFd3_1,
      CE => VCC,
      SET => GND
    );
  cs_FFd1_1_139 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd2,
      RST => cs_FFd1_1_GSR_OR,
      CLK => CLK_BUFGP,
      O => cs_FFd1_1,
      CE => VCC,
      SET => GND
    );
  bp_15_1_140 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(15),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp_15_1,
      SET => GND,
      RST => GSR
    );
  bp_14_1_141 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(14),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp_14_1,
      SET => GND,
      RST => GSR
    );
  bp_13_1_142 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(13),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp_13_1,
      SET => GND,
      RST => GSR
    );
  bp_12_1_143 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(12),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp_12_1,
      SET => GND,
      RST => GSR
    );
  bp_11_1_144 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(11),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp_11_1,
      SET => GND,
      RST => GSR
    );
  bp_10_1_145 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(10),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp_10_1,
      SET => GND,
      RST => GSR
    );
  bp_9_1_146 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(9),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp_9_1,
      SET => GND,
      RST => GSR
    );
  bp_8_1_147 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(8),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp_8_1,
      SET => GND,
      RST => GSR
    );
  bp_7_1_148 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(7),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp_7_1,
      SET => GND,
      RST => GSR
    );
  bp_6_1_149 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(6),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp_6_1,
      SET => GND,
      RST => GSR
    );
  bp_5_1_150 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(5),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp_5_1,
      SET => GND,
      RST => GSR
    );
  bp_4_1_151 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(4),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp_4_1,
      SET => GND,
      RST => GSR
    );
  bp_3_1_152 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(3),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp_3_1,
      SET => GND,
      RST => GSR
    );
  bp_2_1_153 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(2),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp_2_1,
      SET => GND,
      RST => GSR
    );
  bp_1_1_154 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(1),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp_1_1,
      SET => GND,
      RST => GSR
    );
  bp_0_1_155 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(0),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      O => bp_0_1,
      SET => GND,
      RST => GSR
    );
  Ker342621_LUT4_L_BUF : X_BUF
    port map (
      I => Ker342621_O,
      O => CHOICE36
    );
  Ker342621 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => CNT(8),
      ADR1 => CNT(9),
      ADR2 => CNT(10),
      ADR3 => CNT(11),
      O => Ker342621_O
    );
  cs_FFd7_In_LUT4_L_BUF : X_BUF
    port map (
      I => cs_FFd7_In_O,
      O => cs_FFd7_In
    );
  cs_FFd7_In_163 : X_LUT4
    generic map(
      INIT => X"4C0C"
    )
    port map (
      ADR0 => N3428,
      ADR1 => newfint,
      ADR2 => N3553,
      ADR3 => cs_FFd9,
      O => cs_FFd7_In_O
    );
  addr_inst_lut3_41_LUT3_L_BUF : X_BUF
    port map (
      I => addr_inst_lut3_41_O,
      O => addr_inst_lut3_4
    );
  addr_inst_lut3_41 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_4_1,
      ADR2 => addr(4),
      O => addr_inst_lut3_41_O
    );
  addr_inst_lut3_31_LUT3_L_BUF : X_BUF
    port map (
      I => addr_inst_lut3_31_O,
      O => addr_inst_lut3_3
    );
  addr_inst_lut3_31 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_3_1,
      ADR2 => addr(3),
      O => addr_inst_lut3_31_O
    );
  cs_FFd10_In_LUT4_L_BUF : X_BUF
    port map (
      I => cs_FFd10_In_O,
      O => cs_FFd10_In
    );
  cs_FFd10_In_164 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => newfint,
      ADR1 => N3593,
      ADR2 => cs_FFd6,
      ADR3 => N3428,
      O => cs_FFd10_In_O
    );
  cs_FFd8_In1_LUT3_L_BUF : X_BUF
    port map (
      I => cs_FFd8_In1_O,
      O => cs_FFd8_In
    );
  cs_FFd8_In1 : X_LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      ADR0 => N3428,
      ADR1 => cs_FFd9,
      ADR2 => newfint,
      O => cs_FFd8_In1_O
    );
  cs_FFd5_In1_LUT4_L_BUF : X_BUF
    port map (
      I => cs_FFd5_In1_O,
      O => cs_FFd5_In
    );
  cs_FFd5_In1 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => newfint,
      ADR1 => cs_FFd4,
      ADR2 => cs_FFd6,
      ADR3 => N3428,
      O => cs_FFd5_In1_O
    );
  Ker3426120_LUT4_L_BUF : X_BUF
    port map (
      I => Ker3426120_O,
      O => CHOICE72
    );
  Ker3426120 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => CHOICE48,
      ADR1 => CHOICE55,
      ADR2 => CHOICE63,
      ADR3 => CHOICE70,
      O => Ker3426120_O
    );
  Ker34541_LUT2_D_BUF : X_BUF
    port map (
      I => N3456,
      O => N4095
    );
  Ker34541 : X_LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      ADR0 => RESET_IBUF,
      ADR1 => den,
      O => N3456
    );
  srl16_enable_VCC : X_ONE
    port map (
      O => srl16_enable_CE
    );
  srl16_enable_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => enable,
      CE => srl16_enable_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => enableint
    );
  srl16_newframe_VCC : X_ONE
    port map (
      O => srl16_newframe_CE
    );
  srl16_newframe_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => newframel,
      CE => srl16_newframe_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => lnewfint
    );
  srl16_din_bit0_VCC : X_ONE
    port map (
      O => srl16_din_bit0_CE
    );
  srl16_din_bit0_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => dinl(0),
      CE => srl16_din_bit0_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => ldinint(0)
    );
  srl16_din_bit1_VCC : X_ONE
    port map (
      O => srl16_din_bit1_CE
    );
  srl16_din_bit1_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => dinl(1),
      CE => srl16_din_bit1_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => ldinint(1)
    );
  srl16_din_bit2_VCC : X_ONE
    port map (
      O => srl16_din_bit2_CE
    );
  srl16_din_bit2_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => dinl(2),
      CE => srl16_din_bit2_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => ldinint(2)
    );
  srl16_din_bit3_VCC : X_ONE
    port map (
      O => srl16_din_bit3_CE
    );
  srl16_din_bit3_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => dinl(3),
      CE => srl16_din_bit3_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => ldinint(3)
    );
  srl16_din_bit4_VCC : X_ONE
    port map (
      O => srl16_din_bit4_CE
    );
  srl16_din_bit4_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => dinl(4),
      CE => srl16_din_bit4_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => ldinint(4)
    );
  srl16_din_bit5_VCC : X_ONE
    port map (
      O => srl16_din_bit5_CE
    );
  srl16_din_bit5_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => dinl(5),
      CE => srl16_din_bit5_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => ldinint(5)
    );
  srl16_din_bit6_VCC : X_ONE
    port map (
      O => srl16_din_bit6_CE
    );
  srl16_din_bit6_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => dinl(6),
      CE => srl16_din_bit6_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => ldinint(6)
    );
  srl16_din_bit7_VCC : X_ONE
    port map (
      O => srl16_din_bit7_CE
    );
  srl16_din_bit7_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => dinl(7),
      CE => srl16_din_bit7_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => ldinint(7)
    );
  srl16_din_bit8_VCC : X_ONE
    port map (
      O => srl16_din_bit8_CE
    );
  srl16_din_bit8_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => dinl(8),
      CE => srl16_din_bit8_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => ldinint(8)
    );
  srl16_din_bit9_VCC : X_ONE
    port map (
      O => srl16_din_bit9_CE
    );
  srl16_din_bit9_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => dinl(9),
      CE => srl16_din_bit9_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => ldinint(9)
    );
  srl16_din_bit10_VCC : X_ONE
    port map (
      O => srl16_din_bit10_CE
    );
  srl16_din_bit10_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => dinl(10),
      CE => srl16_din_bit10_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => ldinint(10)
    );
  srl16_din_bit11_VCC : X_ONE
    port map (
      O => srl16_din_bit11_CE
    );
  srl16_din_bit11_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => dinl(11),
      CE => srl16_din_bit11_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => ldinint(11)
    );
  srl16_din_bit12_VCC : X_ONE
    port map (
      O => srl16_din_bit12_CE
    );
  srl16_din_bit12_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => dinl(12),
      CE => srl16_din_bit12_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => ldinint(12)
    );
  srl16_din_bit13_VCC : X_ONE
    port map (
      O => srl16_din_bit13_CE
    );
  srl16_din_bit13_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => dinl(13),
      CE => srl16_din_bit13_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => ldinint(13)
    );
  srl16_din_bit14_VCC : X_ONE
    port map (
      O => srl16_din_bit14_CE
    );
  srl16_din_bit14_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => dinl(14),
      CE => srl16_din_bit14_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => ldinint(14)
    );
  srl16_din_bit15_VCC : X_ONE
    port map (
      O => srl16_din_bit15_CE
    );
  srl16_din_bit15_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      D => dinl(15),
      CE => srl16_din_bit15_CE,
      CLK => CLK_BUFGP,
      A3 => N140,
      A2 => N138,
      A1 => N140,
      A0 => N140,
      Q => ldinint(15)
    );
  CLK_BUFGP_BUFG : X_CKBUF
    port map (
      I => CLK_BUFGP_IBUFG,
      O => CLK_BUFGP
    );
  CLK_BUFGP_IBUFG_165 : X_CKBUF
    port map (
      I => CLK,
      O => CLK_BUFGP_IBUFG
    );
  CLKIO_BUFGP_BUFG : X_CKBUF
    port map (
      I => CLKIO_BUFGP_IBUFG,
      O => CLKIO_BUFGP
    );
  CLKIO_BUFGP_IBUFG_166 : X_CKBUF
    port map (
      I => CLKIO,
      O => CLKIO_BUFGP_IBUFG
    );
  MD_25_GSR_OR_167 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_25_GSR_OR
    );
  MD_24_GSR_OR_168 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_24_GSR_OR
    );
  MD_26_GSR_OR_169 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_26_GSR_OR
    );
  MD_23_GSR_OR_170 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_23_GSR_OR
    );
  MA_15_GSR_OR_171 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_15_GSR_OR
    );
  MD_31_GSR_OR_172 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_31_GSR_OR
    );
  MWEN_GSR_OR_173 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MWEN_GSR_OR
    );
  MD_27_GSR_OR_174 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_27_GSR_OR
    );
  MD_28_GSR_OR_175 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_28_GSR_OR
    );
  MD_29_GSR_OR_176 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_29_GSR_OR
    );
  MD_30_GSR_OR_177 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_30_GSR_OR
    );
  MA_0_GSR_OR_178 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_0_GSR_OR
    );
  MA_1_GSR_OR_179 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_1_GSR_OR
    );
  MA_2_GSR_OR_180 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_2_GSR_OR
    );
  MA_3_GSR_OR_181 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_3_GSR_OR
    );
  MA_4_GSR_OR_182 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_4_GSR_OR
    );
  MA_5_GSR_OR_183 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_5_GSR_OR
    );
  MA_6_GSR_OR_184 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_6_GSR_OR
    );
  MA_7_GSR_OR_185 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_7_GSR_OR
    );
  MA_8_GSR_OR_186 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_8_GSR_OR
    );
  MA_9_GSR_OR_187 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_9_GSR_OR
    );
  MA_10_GSR_OR_188 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_10_GSR_OR
    );
  MA_11_GSR_OR_189 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_11_GSR_OR
    );
  MA_12_GSR_OR_190 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_12_GSR_OR
    );
  MA_13_GSR_OR_191 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_13_GSR_OR
    );
  MA_14_GSR_OR_192 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_14_GSR_OR
    );
  MD_0_GSR_OR_193 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_0_GSR_OR
    );
  MD_1_GSR_OR_194 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_1_GSR_OR
    );
  MD_2_GSR_OR_195 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_2_GSR_OR
    );
  MD_3_GSR_OR_196 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_3_GSR_OR
    );
  MD_4_GSR_OR_197 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_4_GSR_OR
    );
  MD_5_GSR_OR_198 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_5_GSR_OR
    );
  MD_6_GSR_OR_199 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_6_GSR_OR
    );
  MD_7_GSR_OR_200 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_7_GSR_OR
    );
  MD_8_GSR_OR_201 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_8_GSR_OR
    );
  MD_9_GSR_OR_202 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_9_GSR_OR
    );
  MD_10_GSR_OR_203 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_10_GSR_OR
    );
  MD_11_GSR_OR_204 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_11_GSR_OR
    );
  MD_12_GSR_OR_205 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_12_GSR_OR
    );
  MD_13_GSR_OR_206 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_13_GSR_OR
    );
  MD_14_GSR_OR_207 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_14_GSR_OR
    );
  MD_15_GSR_OR_208 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_15_GSR_OR
    );
  MD_16_GSR_OR_209 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_16_GSR_OR
    );
  MD_17_GSR_OR_210 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_17_GSR_OR
    );
  MD_18_GSR_OR_211 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_18_GSR_OR
    );
  MD_19_GSR_OR_212 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_19_GSR_OR
    );
  MD_20_GSR_OR_213 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_20_GSR_OR
    );
  MD_21_GSR_OR_214 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_21_GSR_OR
    );
  MD_22_GSR_OR_215 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_22_GSR_OR
    );
  cs_FFd1_GSR_OR_216 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd1_GSR_OR
    );
  cs_FFd2_GSR_OR_217 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd2_GSR_OR
    );
  cs_FFd3_GSR_OR_218 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd3_GSR_OR
    );
  cs_FFd4_GSR_OR_219 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd4_GSR_OR
    );
  cs_FFd5_GSR_OR_220 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd5_GSR_OR
    );
  cs_FFd6_GSR_OR_221 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd6_GSR_OR
    );
  cs_FFd7_GSR_OR_222 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd7_GSR_OR
    );
  cs_FFd8_GSR_OR_223 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd8_GSR_OR
    );
  cs_FFd9_GSR_OR_224 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd9_GSR_OR
    );
  cs_FFd10_GSR_OR_225 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd10_GSR_OR
    );
  cs_FFd11_GSR_OR_226 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd11_GSR_OR
    );
  cs_FFd12_GSR_OR_227 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd12_GSR_OR
    );
  cs_FFd12_1_GSR_OR_228 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd12_1_GSR_OR
    );
  cs_FFd3_1_GSR_OR_229 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd3_1_GSR_OR
    );
  cs_FFd1_1_GSR_OR_230 : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd1_1_GSR_OR
    );
  BPOUT_0_OBUF_GTS_TRI_231 : X_TRI
    port map (
      I => BPOUT_0_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_BPOUT_0_OBUF_GTS_TRI_CTL,
      O => BPOUT(0)
    );
  TXFIFOWERR_OBUF_GTS_TRI_232 : X_TRI
    port map (
      I => TXFIFOWERR_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_TXFIFOWERR_OBUF_GTS_TRI_CTL,
      O => TXFIFOWERR
    );
  MWEN_OBUF_GTS_TRI_233 : X_TRI
    port map (
      I => MWEN_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MWEN_OBUF_GTS_TRI_CTL,
      O => MWEN
    );
  DONE_OBUF_GTS_TRI_234 : X_TRI
    port map (
      I => DONE_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_DONE_OBUF_GTS_TRI_CTL,
      O => DONE
    );
  MA_15_OBUF_GTS_TRI_235 : X_TRI
    port map (
      I => MA_15_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MA_15_OBUF_GTS_TRI_CTL,
      O => MA(15)
    );
  MA_14_OBUF_GTS_TRI_236 : X_TRI
    port map (
      I => MA_14_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MA_14_OBUF_GTS_TRI_CTL,
      O => MA(14)
    );
  MA_13_OBUF_GTS_TRI_237 : X_TRI
    port map (
      I => MA_13_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MA_13_OBUF_GTS_TRI_CTL,
      O => MA(13)
    );
  MA_12_OBUF_GTS_TRI_238 : X_TRI
    port map (
      I => MA_12_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MA_12_OBUF_GTS_TRI_CTL,
      O => MA(12)
    );
  MA_11_OBUF_GTS_TRI_239 : X_TRI
    port map (
      I => MA_11_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MA_11_OBUF_GTS_TRI_CTL,
      O => MA(11)
    );
  MA_10_OBUF_GTS_TRI_240 : X_TRI
    port map (
      I => MA_10_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MA_10_OBUF_GTS_TRI_CTL,
      O => MA(10)
    );
  MA_9_OBUF_GTS_TRI_241 : X_TRI
    port map (
      I => MA_9_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MA_9_OBUF_GTS_TRI_CTL,
      O => MA(9)
    );
  MA_8_OBUF_GTS_TRI_242 : X_TRI
    port map (
      I => MA_8_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MA_8_OBUF_GTS_TRI_CTL,
      O => MA(8)
    );
  MA_7_OBUF_GTS_TRI_243 : X_TRI
    port map (
      I => MA_7_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MA_7_OBUF_GTS_TRI_CTL,
      O => MA(7)
    );
  MA_6_OBUF_GTS_TRI_244 : X_TRI
    port map (
      I => MA_6_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MA_6_OBUF_GTS_TRI_CTL,
      O => MA(6)
    );
  MA_5_OBUF_GTS_TRI_245 : X_TRI
    port map (
      I => MA_5_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MA_5_OBUF_GTS_TRI_CTL,
      O => MA(5)
    );
  MA_4_OBUF_GTS_TRI_246 : X_TRI
    port map (
      I => MA_4_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MA_4_OBUF_GTS_TRI_CTL,
      O => MA(4)
    );
  MA_3_OBUF_GTS_TRI_247 : X_TRI
    port map (
      I => MA_3_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MA_3_OBUF_GTS_TRI_CTL,
      O => MA(3)
    );
  MA_2_OBUF_GTS_TRI_248 : X_TRI
    port map (
      I => MA_2_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MA_2_OBUF_GTS_TRI_CTL,
      O => MA(2)
    );
  MA_1_OBUF_GTS_TRI_249 : X_TRI
    port map (
      I => MA_1_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MA_1_OBUF_GTS_TRI_CTL,
      O => MA(1)
    );
  MA_0_OBUF_GTS_TRI_250 : X_TRI
    port map (
      I => MA_0_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MA_0_OBUF_GTS_TRI_CTL,
      O => MA(0)
    );
  MD_31_OBUF_GTS_TRI_251 : X_TRI
    port map (
      I => MD_31_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_31_OBUF_GTS_TRI_CTL,
      O => MD(31)
    );
  MD_30_OBUF_GTS_TRI_252 : X_TRI
    port map (
      I => MD_30_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_30_OBUF_GTS_TRI_CTL,
      O => MD(30)
    );
  MD_29_OBUF_GTS_TRI_253 : X_TRI
    port map (
      I => MD_29_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_29_OBUF_GTS_TRI_CTL,
      O => MD(29)
    );
  MD_28_OBUF_GTS_TRI_254 : X_TRI
    port map (
      I => MD_28_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_28_OBUF_GTS_TRI_CTL,
      O => MD(28)
    );
  MD_27_OBUF_GTS_TRI_255 : X_TRI
    port map (
      I => MD_27_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_27_OBUF_GTS_TRI_CTL,
      O => MD(27)
    );
  MD_26_OBUF_GTS_TRI_256 : X_TRI
    port map (
      I => MD_26_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_26_OBUF_GTS_TRI_CTL,
      O => MD(26)
    );
  MD_25_OBUF_GTS_TRI_257 : X_TRI
    port map (
      I => MD_25_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_25_OBUF_GTS_TRI_CTL,
      O => MD(25)
    );
  MD_24_OBUF_GTS_TRI_258 : X_TRI
    port map (
      I => MD_24_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_24_OBUF_GTS_TRI_CTL,
      O => MD(24)
    );
  MD_23_OBUF_GTS_TRI_259 : X_TRI
    port map (
      I => MD_23_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_23_OBUF_GTS_TRI_CTL,
      O => MD(23)
    );
  MD_22_OBUF_GTS_TRI_260 : X_TRI
    port map (
      I => MD_22_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_22_OBUF_GTS_TRI_CTL,
      O => MD(22)
    );
  MD_21_OBUF_GTS_TRI_261 : X_TRI
    port map (
      I => MD_21_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_21_OBUF_GTS_TRI_CTL,
      O => MD(21)
    );
  MD_20_OBUF_GTS_TRI_262 : X_TRI
    port map (
      I => MD_20_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_20_OBUF_GTS_TRI_CTL,
      O => MD(20)
    );
  MD_19_OBUF_GTS_TRI_263 : X_TRI
    port map (
      I => MD_19_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_19_OBUF_GTS_TRI_CTL,
      O => MD(19)
    );
  MD_18_OBUF_GTS_TRI_264 : X_TRI
    port map (
      I => MD_18_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_18_OBUF_GTS_TRI_CTL,
      O => MD(18)
    );
  MD_17_OBUF_GTS_TRI_265 : X_TRI
    port map (
      I => MD_17_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_17_OBUF_GTS_TRI_CTL,
      O => MD(17)
    );
  MD_16_OBUF_GTS_TRI_266 : X_TRI
    port map (
      I => MD_16_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_16_OBUF_GTS_TRI_CTL,
      O => MD(16)
    );
  MD_15_OBUF_GTS_TRI_267 : X_TRI
    port map (
      I => MD_15_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_15_OBUF_GTS_TRI_CTL,
      O => MD(15)
    );
  MD_14_OBUF_GTS_TRI_268 : X_TRI
    port map (
      I => MD_14_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_14_OBUF_GTS_TRI_CTL,
      O => MD(14)
    );
  MD_13_OBUF_GTS_TRI_269 : X_TRI
    port map (
      I => MD_13_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_13_OBUF_GTS_TRI_CTL,
      O => MD(13)
    );
  MD_12_OBUF_GTS_TRI_270 : X_TRI
    port map (
      I => MD_12_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_12_OBUF_GTS_TRI_CTL,
      O => MD(12)
    );
  MD_11_OBUF_GTS_TRI_271 : X_TRI
    port map (
      I => MD_11_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_11_OBUF_GTS_TRI_CTL,
      O => MD(11)
    );
  MD_10_OBUF_GTS_TRI_272 : X_TRI
    port map (
      I => MD_10_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_10_OBUF_GTS_TRI_CTL,
      O => MD(10)
    );
  MD_9_OBUF_GTS_TRI_273 : X_TRI
    port map (
      I => MD_9_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_9_OBUF_GTS_TRI_CTL,
      O => MD(9)
    );
  MD_8_OBUF_GTS_TRI_274 : X_TRI
    port map (
      I => MD_8_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_8_OBUF_GTS_TRI_CTL,
      O => MD(8)
    );
  MD_7_OBUF_GTS_TRI_275 : X_TRI
    port map (
      I => MD_7_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_7_OBUF_GTS_TRI_CTL,
      O => MD(7)
    );
  MD_6_OBUF_GTS_TRI_276 : X_TRI
    port map (
      I => MD_6_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_6_OBUF_GTS_TRI_CTL,
      O => MD(6)
    );
  MD_5_OBUF_GTS_TRI_277 : X_TRI
    port map (
      I => MD_5_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_5_OBUF_GTS_TRI_CTL,
      O => MD(5)
    );
  MD_4_OBUF_GTS_TRI_278 : X_TRI
    port map (
      I => MD_4_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_4_OBUF_GTS_TRI_CTL,
      O => MD(4)
    );
  MD_3_OBUF_GTS_TRI_279 : X_TRI
    port map (
      I => MD_3_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_3_OBUF_GTS_TRI_CTL,
      O => MD(3)
    );
  MD_2_OBUF_GTS_TRI_280 : X_TRI
    port map (
      I => MD_2_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_2_OBUF_GTS_TRI_CTL,
      O => MD(2)
    );
  MD_1_OBUF_GTS_TRI_281 : X_TRI
    port map (
      I => MD_1_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_1_OBUF_GTS_TRI_CTL,
      O => MD(1)
    );
  MD_0_OBUF_GTS_TRI_282 : X_TRI
    port map (
      I => MD_0_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_MD_0_OBUF_GTS_TRI_CTL,
      O => MD(0)
    );
  BPOUT_15_OBUF_GTS_TRI_283 : X_TRI
    port map (
      I => BPOUT_15_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_BPOUT_15_OBUF_GTS_TRI_CTL,
      O => BPOUT(15)
    );
  BPOUT_14_OBUF_GTS_TRI_284 : X_TRI
    port map (
      I => BPOUT_14_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_BPOUT_14_OBUF_GTS_TRI_CTL,
      O => BPOUT(14)
    );
  BPOUT_13_OBUF_GTS_TRI_285 : X_TRI
    port map (
      I => BPOUT_13_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_BPOUT_13_OBUF_GTS_TRI_CTL,
      O => BPOUT(13)
    );
  BPOUT_12_OBUF_GTS_TRI_286 : X_TRI
    port map (
      I => BPOUT_12_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_BPOUT_12_OBUF_GTS_TRI_CTL,
      O => BPOUT(12)
    );
  BPOUT_11_OBUF_GTS_TRI_287 : X_TRI
    port map (
      I => BPOUT_11_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_BPOUT_11_OBUF_GTS_TRI_CTL,
      O => BPOUT(11)
    );
  BPOUT_10_OBUF_GTS_TRI_288 : X_TRI
    port map (
      I => BPOUT_10_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_BPOUT_10_OBUF_GTS_TRI_CTL,
      O => BPOUT(10)
    );
  BPOUT_9_OBUF_GTS_TRI_289 : X_TRI
    port map (
      I => BPOUT_9_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_BPOUT_9_OBUF_GTS_TRI_CTL,
      O => BPOUT(9)
    );
  BPOUT_8_OBUF_GTS_TRI_290 : X_TRI
    port map (
      I => BPOUT_8_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_BPOUT_8_OBUF_GTS_TRI_CTL,
      O => BPOUT(8)
    );
  BPOUT_7_OBUF_GTS_TRI_291 : X_TRI
    port map (
      I => BPOUT_7_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_BPOUT_7_OBUF_GTS_TRI_CTL,
      O => BPOUT(7)
    );
  BPOUT_6_OBUF_GTS_TRI_292 : X_TRI
    port map (
      I => BPOUT_6_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_BPOUT_6_OBUF_GTS_TRI_CTL,
      O => BPOUT(6)
    );
  BPOUT_5_OBUF_GTS_TRI_293 : X_TRI
    port map (
      I => BPOUT_5_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_BPOUT_5_OBUF_GTS_TRI_CTL,
      O => BPOUT(5)
    );
  BPOUT_4_OBUF_GTS_TRI_294 : X_TRI
    port map (
      I => BPOUT_4_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_BPOUT_4_OBUF_GTS_TRI_CTL,
      O => BPOUT(4)
    );
  BPOUT_3_OBUF_GTS_TRI_295 : X_TRI
    port map (
      I => BPOUT_3_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_BPOUT_3_OBUF_GTS_TRI_CTL,
      O => BPOUT(3)
    );
  BPOUT_2_OBUF_GTS_TRI_296 : X_TRI
    port map (
      I => BPOUT_2_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_BPOUT_2_OBUF_GTS_TRI_CTL,
      O => BPOUT(2)
    );
  BPOUT_1_OBUF_GTS_TRI_297 : X_TRI
    port map (
      I => BPOUT_1_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_BPOUT_1_OBUF_GTS_TRI_CTL,
      O => BPOUT(1)
    );
  NlwBlock_txinput_GND : X_ZERO
    port map (
      O => GND
    );
  NlwBlock_txinput_VCC : X_ONE
    port map (
      O => VCC
    );
  NlwInverterBlock_BPOUT_0_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_BPOUT_0_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_TXFIFOWERR_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_TXFIFOWERR_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MWEN_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MWEN_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_DONE_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_DONE_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MA_15_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MA_15_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MA_14_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MA_14_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MA_13_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MA_13_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MA_12_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MA_12_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MA_11_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MA_11_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MA_10_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MA_10_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MA_9_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MA_9_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MA_8_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MA_8_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MA_7_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MA_7_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MA_6_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MA_6_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MA_5_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MA_5_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MA_4_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MA_4_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MA_3_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MA_3_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MA_2_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MA_2_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MA_1_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MA_1_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MA_0_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MA_0_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_31_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_31_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_30_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_30_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_29_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_29_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_28_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_28_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_27_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_27_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_26_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_26_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_25_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_25_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_24_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_24_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_23_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_23_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_22_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_22_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_21_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_21_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_20_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_20_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_19_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_19_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_18_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_18_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_17_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_17_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_16_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_16_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_15_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_15_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_14_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_14_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_13_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_13_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_12_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_12_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_11_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_11_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_10_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_10_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_9_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_9_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_8_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_8_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_7_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_7_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_6_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_6_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_5_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_5_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_4_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_4_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_3_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_3_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_2_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_2_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_1_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_1_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_MD_0_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_MD_0_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_BPOUT_15_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_BPOUT_15_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_BPOUT_14_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_BPOUT_14_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_BPOUT_13_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_BPOUT_13_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_BPOUT_12_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_BPOUT_12_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_BPOUT_11_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_BPOUT_11_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_BPOUT_10_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_BPOUT_10_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_BPOUT_9_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_BPOUT_9_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_BPOUT_8_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_BPOUT_8_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_BPOUT_7_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_BPOUT_7_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_BPOUT_6_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_BPOUT_6_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_BPOUT_5_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_BPOUT_5_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_BPOUT_4_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_BPOUT_4_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_BPOUT_3_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_BPOUT_3_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_BPOUT_2_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_BPOUT_2_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_BPOUT_1_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_BPOUT_1_OBUF_GTS_TRI_CTL
    );
  NlwBlockROC : X_ROC
    generic map (ROC_WIDTH => 100 ns)
    port map (O => GSR);
  NlwBlockTOC : X_TOC
    port map (O => GTS);

end Structure;

