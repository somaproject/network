-- Xilinx Vhdl netlist produced by netgen application (version G.25a)
-- Command       : -intstyle ise -s 6 -pcf txinput.pcf -ngm txinput.ngm -fn -rpw 100 -tpw 0 -ar Structure -xon false -w -ofmt vhdl -sim txinput_map.ncd network_PR.vhd 
-- Input file    : txinput_map.ncd
-- Output file   : network_PR.vhd
-- Design name   : txinput
-- # of Entities : 1
-- Xilinx        : C:/Xilinx
-- Device        : 2s200epq208-6 (PRODUCTION 1.17 2003-09-30)

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
    DONE : out STD_LOGIC; 
    MWEN : out STD_LOGIC; 
    TXFIFOWERR : out STD_LOGIC; 
    FIFOFULL : in STD_LOGIC := 'X'; 
    NEWFRAME : in STD_LOGIC := 'X'; 
    CLKIO : in STD_LOGIC := 'X'; 
    RESET : in STD_LOGIC := 'X'; 
    CLK : in STD_LOGIC := 'X'; 
    BPOUT : out STD_LOGIC_VECTOR ( 15 downto 0 ); 
    MD : out STD_LOGIC_VECTOR ( 31 downto 0 ); 
    MA : out STD_LOGIC_VECTOR ( 15 downto 0 ); 
    DIN : in STD_LOGIC_VECTOR ( 15 downto 0 ) 
  );
end txinput;

architecture Structure of txinput is
  signal CLK_BUFGP : STD_LOGIC; 
  signal cs_Out51_1 : STD_LOGIC; 
  signal RESET_IBUF : STD_LOGIC; 
  signal CLKIO_BUFGP_IBUFG : STD_LOGIC; 
  signal CLKIO_BUFGP : STD_LOGIC; 
  signal newframel : STD_LOGIC; 
  signal mrw : STD_LOGIC; 
  signal Q_n0030 : STD_LOGIC; 
  signal CLK_BUFGP_IBUFG : STD_LOGIC; 
  signal Msub_n0041_inst_cy_1 : STD_LOGIC; 
  signal GLOBAL_LOGIC0 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_3 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_5 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_7 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_9 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_11 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_13 : STD_LOGIC; 
  signal Q_n0040 : STD_LOGIC; 
  signal addr_inst_cy_17 : STD_LOGIC; 
  signal GLOBAL_LOGIC1 : STD_LOGIC; 
  signal cs_FFd12 : STD_LOGIC; 
  signal bp_0_1 : STD_LOGIC; 
  signal addr_inst_cy_19 : STD_LOGIC; 
  signal bp_1_1 : STD_LOGIC; 
  signal bp_2_1 : STD_LOGIC; 
  signal addr_inst_cy_21 : STD_LOGIC; 
  signal cs_FFd12_1 : STD_LOGIC; 
  signal bp_3_1 : STD_LOGIC; 
  signal bp_4_1 : STD_LOGIC; 
  signal addr_inst_cy_23 : STD_LOGIC; 
  signal bp_5_1 : STD_LOGIC; 
  signal bp_6_1 : STD_LOGIC; 
  signal addr_inst_cy_25 : STD_LOGIC; 
  signal bp_7_1 : STD_LOGIC; 
  signal bp_8_1 : STD_LOGIC; 
  signal addr_inst_cy_27 : STD_LOGIC; 
  signal bp_9_1 : STD_LOGIC; 
  signal bp_10_1 : STD_LOGIC; 
  signal addr_inst_cy_29 : STD_LOGIC; 
  signal bp_11_1 : STD_LOGIC; 
  signal bp_12_1 : STD_LOGIC; 
  signal addr_inst_cy_31 : STD_LOGIC; 
  signal bp_13_1 : STD_LOGIC; 
  signal bp_14_1 : STD_LOGIC; 
  signal bp_15_1 : STD_LOGIC; 
  signal cs_FFd4 : STD_LOGIC; 
  signal cs_FFd6 : STD_LOGIC; 
  signal cs_FFd7 : STD_LOGIC; 
  signal CHOICE15 : STD_LOGIC; 
  signal den : STD_LOGIC; 
  signal N3456 : STD_LOGIC; 
  signal cs_FFd11 : STD_LOGIC; 
  signal cs_FFd10 : STD_LOGIC; 
  signal Q_n0027 : STD_LOGIC; 
  signal newfint : STD_LOGIC; 
  signal N3428 : STD_LOGIC; 
  signal cs_FFd5 : STD_LOGIC; 
  signal cs_FFd9 : STD_LOGIC; 
  signal Ker3426137_2 : STD_LOGIC; 
  signal Ker3426120_O : STD_LOGIC; 
  signal N3553 : STD_LOGIC; 
  signal cs_FFd8 : STD_LOGIC; 
  signal CHOICE48 : STD_LOGIC; 
  signal CHOICE55 : STD_LOGIC; 
  signal CHOICE63 : STD_LOGIC; 
  signal CHOICE70 : STD_LOGIC; 
  signal Ker342621_O : STD_LOGIC; 
  signal CHOICE39 : STD_LOGIC; 
  signal CHOICE29 : STD_LOGIC; 
  signal CHOICE32 : STD_LOGIC; 
  signal fifofulll : STD_LOGIC; 
  signal cs_FFd3_In : STD_LOGIC; 
  signal cs_FFd3_1 : STD_LOGIC; 
  signal enable : STD_LOGIC; 
  signal enableint : STD_LOGIC; 
  signal enableintl : STD_LOGIC; 
  signal cs_FFd2 : STD_LOGIC; 
  signal N3593 : STD_LOGIC; 
  signal Q_n0028 : STD_LOGIC; 
  signal CHOICE18 : STD_LOGIC; 
  signal cs_FFd12_In : STD_LOGIC; 
  signal cs_FFd1_1 : STD_LOGIC; 
  signal CHOICE25 : STD_LOGIC; 
  signal GSR : STD_LOGIC; 
  signal GTS : STD_LOGIC; 
  signal MD_7_OFF_RST : STD_LOGIC; 
  signal MD_7_ENABLE : STD_LOGIC; 
  signal MD_7_TORGTS : STD_LOGIC; 
  signal MD_7_OUTMUX : STD_LOGIC; 
  signal MD_7 : STD_LOGIC; 
  signal MD_7_OD : STD_LOGIC; 
  signal MD_8_OFF_RST : STD_LOGIC; 
  signal MD_8_ENABLE : STD_LOGIC; 
  signal MD_8_TORGTS : STD_LOGIC; 
  signal MD_8_OUTMUX : STD_LOGIC; 
  signal MD_8 : STD_LOGIC; 
  signal MD_8_OD : STD_LOGIC; 
  signal MD_9_OFF_RST : STD_LOGIC; 
  signal MD_9_ENABLE : STD_LOGIC; 
  signal MD_9_TORGTS : STD_LOGIC; 
  signal MD_9_OUTMUX : STD_LOGIC; 
  signal MD_9 : STD_LOGIC; 
  signal MD_9_OD : STD_LOGIC; 
  signal NEWFRAME_IFF_RST : STD_LOGIC; 
  signal NEWFRAME_IDELAY : STD_LOGIC; 
  signal NEWFRAME_IBUF : STD_LOGIC; 
  signal MA_10_OFF_RST : STD_LOGIC; 
  signal MA_10_ENABLE : STD_LOGIC; 
  signal MA_10_TORGTS : STD_LOGIC; 
  signal MA_10_OUTMUX : STD_LOGIC; 
  signal MA_10 : STD_LOGIC; 
  signal MA_10_OD : STD_LOGIC; 
  signal MA_11_OFF_RST : STD_LOGIC; 
  signal MA_11_ENABLE : STD_LOGIC; 
  signal MA_11_TORGTS : STD_LOGIC; 
  signal MA_11_OUTMUX : STD_LOGIC; 
  signal MA_11 : STD_LOGIC; 
  signal MA_11_OD : STD_LOGIC; 
  signal MA_12_ENABLE : STD_LOGIC; 
  signal MA_12_TORGTS : STD_LOGIC; 
  signal MA_12_OUTMUX : STD_LOGIC; 
  signal MA_12 : STD_LOGIC; 
  signal MA_12_OD : STD_LOGIC; 
  signal MA_13_ENABLE : STD_LOGIC; 
  signal MA_13_TORGTS : STD_LOGIC; 
  signal MA_13_OUTMUX : STD_LOGIC; 
  signal MA_13 : STD_LOGIC; 
  signal MA_13_OD : STD_LOGIC; 
  signal MA_14_ENABLE : STD_LOGIC; 
  signal MA_14_TORGTS : STD_LOGIC; 
  signal MA_14_OUTMUX : STD_LOGIC; 
  signal MA_14 : STD_LOGIC; 
  signal MA_14_OD : STD_LOGIC; 
  signal MA_15_ENABLE : STD_LOGIC; 
  signal MA_15_TORGTS : STD_LOGIC; 
  signal MA_15_OUTMUX : STD_LOGIC; 
  signal MA_15 : STD_LOGIC; 
  signal MA_15_OD : STD_LOGIC; 
  signal DIN_0_IDELAY : STD_LOGIC; 
  signal DIN_0_IBUF : STD_LOGIC; 
  signal MA_12_OFF_RST : STD_LOGIC; 
  signal DIN_1_IDELAY : STD_LOGIC; 
  signal DIN_1_IBUF : STD_LOGIC; 
  signal DIN_2_IDELAY : STD_LOGIC; 
  signal DIN_2_IBUF : STD_LOGIC; 
  signal DIN_3_IDELAY : STD_LOGIC; 
  signal DIN_3_IBUF : STD_LOGIC; 
  signal DIN_4_IDELAY : STD_LOGIC; 
  signal DIN_4_IBUF : STD_LOGIC; 
  signal DIN_5_IDELAY : STD_LOGIC; 
  signal DIN_5_IBUF : STD_LOGIC; 
  signal DIN_6_IDELAY : STD_LOGIC; 
  signal DIN_6_IBUF : STD_LOGIC; 
  signal DIN_7_IDELAY : STD_LOGIC; 
  signal DIN_7_IBUF : STD_LOGIC; 
  signal DIN_8_IDELAY : STD_LOGIC; 
  signal DIN_8_IBUF : STD_LOGIC; 
  signal DIN_9_IDELAY : STD_LOGIC; 
  signal DIN_9_IBUF : STD_LOGIC; 
  signal MD_10_ENABLE : STD_LOGIC; 
  signal MD_10_TORGTS : STD_LOGIC; 
  signal MD_10_OUTMUX : STD_LOGIC; 
  signal MD_10 : STD_LOGIC; 
  signal MD_10_OD : STD_LOGIC; 
  signal MD_11_ENABLE : STD_LOGIC; 
  signal MD_11_TORGTS : STD_LOGIC; 
  signal MD_11_OUTMUX : STD_LOGIC; 
  signal MD_11 : STD_LOGIC; 
  signal MD_11_OD : STD_LOGIC; 
  signal MD_12_ENABLE : STD_LOGIC; 
  signal MD_12_TORGTS : STD_LOGIC; 
  signal MD_12_OUTMUX : STD_LOGIC; 
  signal MD_12 : STD_LOGIC; 
  signal MD_12_OD : STD_LOGIC; 
  signal MD_20_ENABLE : STD_LOGIC; 
  signal MD_20_TORGTS : STD_LOGIC; 
  signal MD_20_OUTMUX : STD_LOGIC; 
  signal MD_20 : STD_LOGIC; 
  signal MD_20_OD : STD_LOGIC; 
  signal MD_13_ENABLE : STD_LOGIC; 
  signal MD_13_TORGTS : STD_LOGIC; 
  signal MD_13_OUTMUX : STD_LOGIC; 
  signal MD_13 : STD_LOGIC; 
  signal MD_13_OD : STD_LOGIC; 
  signal MD_21_ENABLE : STD_LOGIC; 
  signal MD_21_TORGTS : STD_LOGIC; 
  signal MD_21_OUTMUX : STD_LOGIC; 
  signal MD_21 : STD_LOGIC; 
  signal MD_21_OD : STD_LOGIC; 
  signal MD_14_ENABLE : STD_LOGIC; 
  signal MD_14_TORGTS : STD_LOGIC; 
  signal MD_14_OUTMUX : STD_LOGIC; 
  signal MD_14 : STD_LOGIC; 
  signal MD_14_OD : STD_LOGIC; 
  signal MD_22_ENABLE : STD_LOGIC; 
  signal MD_22_TORGTS : STD_LOGIC; 
  signal MD_22_OUTMUX : STD_LOGIC; 
  signal MD_22 : STD_LOGIC; 
  signal MD_22_OD : STD_LOGIC; 
  signal MA_13_OFF_RST : STD_LOGIC; 
  signal MD_30_ENABLE : STD_LOGIC; 
  signal MD_30_TORGTS : STD_LOGIC; 
  signal MD_30_OUTMUX : STD_LOGIC; 
  signal MD_30 : STD_LOGIC; 
  signal MD_30_OD : STD_LOGIC; 
  signal MD_15_ENABLE : STD_LOGIC; 
  signal MD_15_TORGTS : STD_LOGIC; 
  signal MD_15_OUTMUX : STD_LOGIC; 
  signal MD_15 : STD_LOGIC; 
  signal MD_15_OD : STD_LOGIC; 
  signal MD_23_ENABLE : STD_LOGIC; 
  signal MD_23_TORGTS : STD_LOGIC; 
  signal MD_23_OUTMUX : STD_LOGIC; 
  signal MD_23 : STD_LOGIC; 
  signal MD_23_OD : STD_LOGIC; 
  signal MD_31_ENABLE : STD_LOGIC; 
  signal MD_31_TORGTS : STD_LOGIC; 
  signal MD_31_OUTMUX : STD_LOGIC; 
  signal MD_31 : STD_LOGIC; 
  signal MD_31_OD : STD_LOGIC; 
  signal MD_16_ENABLE : STD_LOGIC; 
  signal MD_16_TORGTS : STD_LOGIC; 
  signal MD_16_OUTMUX : STD_LOGIC; 
  signal MD_16 : STD_LOGIC; 
  signal MD_16_OD : STD_LOGIC; 
  signal MD_24_ENABLE : STD_LOGIC; 
  signal MD_24_TORGTS : STD_LOGIC; 
  signal MD_24_OUTMUX : STD_LOGIC; 
  signal MD_24 : STD_LOGIC; 
  signal MD_24_OD : STD_LOGIC; 
  signal MD_17_ENABLE : STD_LOGIC; 
  signal MD_17_TORGTS : STD_LOGIC; 
  signal MD_17_OUTMUX : STD_LOGIC; 
  signal MD_17 : STD_LOGIC; 
  signal MD_17_OD : STD_LOGIC; 
  signal DIN_4_IFF_RST : STD_LOGIC; 
  signal N3593_FROM : STD_LOGIC; 
  signal N3593_GROM : STD_LOGIC; 
  signal CHOICE48_FROM : STD_LOGIC; 
  signal CHOICE48_GROM : STD_LOGIC; 
  signal CHOICE55_FROM : STD_LOGIC; 
  signal CHOICE55_GROM : STD_LOGIC; 
  signal cs_FFd12_1_FROM : STD_LOGIC; 
  signal cs_FFd12_1_GROM : STD_LOGIC; 
  signal CHOICE70_FROM : STD_LOGIC; 
  signal CHOICE70_GROM : STD_LOGIC; 
  signal CHOICE63_GROM : STD_LOGIC; 
  signal enable_LOGIC_ONE : STD_LOGIC; 
  signal DIN_5_IFF_RST : STD_LOGIC; 
  signal dl_3_FFY_RST : STD_LOGIC; 
  signal dl_5_FFY_RST : STD_LOGIC; 
  signal dl_7_FFY_RST : STD_LOGIC; 
  signal cs_Out51_1_FROM : STD_LOGIC; 
  signal cs_Out51_1_GROM : STD_LOGIC; 
  signal DIN_6_IFF_RST : STD_LOGIC; 
  signal DONE_ENABLE : STD_LOGIC; 
  signal DONE_TORGTS : STD_LOGIC; 
  signal DONE_OUTMUX : STD_LOGIC; 
  signal cs_FFd1 : STD_LOGIC; 
  signal DONE_OD : STD_LOGIC; 
  signal FIFOFULL_ICEMUXNOT : STD_LOGIC; 
  signal FIFOFULL_IDELAY : STD_LOGIC; 
  signal FIFOFULL_IBUF : STD_LOGIC; 
  signal MA_0_ENABLE : STD_LOGIC; 
  signal MA_0_TORGTS : STD_LOGIC; 
  signal MA_0_OUTMUX : STD_LOGIC; 
  signal MA_0 : STD_LOGIC; 
  signal MA_0_OD : STD_LOGIC; 
  signal MA_1_ENABLE : STD_LOGIC; 
  signal MA_1_TORGTS : STD_LOGIC; 
  signal MA_1_OUTMUX : STD_LOGIC; 
  signal MA_1 : STD_LOGIC; 
  signal MA_1_OD : STD_LOGIC; 
  signal MA_2_ENABLE : STD_LOGIC; 
  signal MA_2_TORGTS : STD_LOGIC; 
  signal MA_2_OUTMUX : STD_LOGIC; 
  signal MA_2 : STD_LOGIC; 
  signal MA_2_OD : STD_LOGIC; 
  signal MA_3_ENABLE : STD_LOGIC; 
  signal MA_3_TORGTS : STD_LOGIC; 
  signal MA_3_OUTMUX : STD_LOGIC; 
  signal MA_3 : STD_LOGIC; 
  signal MA_3_OD : STD_LOGIC; 
  signal DIN_7_IFF_RST : STD_LOGIC; 
  signal MA_4_ENABLE : STD_LOGIC; 
  signal MA_4_TORGTS : STD_LOGIC; 
  signal MA_4_OUTMUX : STD_LOGIC; 
  signal MA_4 : STD_LOGIC; 
  signal MA_4_OD : STD_LOGIC; 
  signal MA_5_ENABLE : STD_LOGIC; 
  signal MA_5_TORGTS : STD_LOGIC; 
  signal MA_5_OUTMUX : STD_LOGIC; 
  signal MA_5 : STD_LOGIC; 
  signal MA_5_OD : STD_LOGIC; 
  signal TXFIFOWERR_ENABLE : STD_LOGIC; 
  signal TXFIFOWERR_TORGTS : STD_LOGIC; 
  signal TXFIFOWERR_OUTMUX : STD_LOGIC; 
  signal cs_FFd3 : STD_LOGIC; 
  signal TXFIFOWERR_OD : STD_LOGIC; 
  signal MA_6_ENABLE : STD_LOGIC; 
  signal MA_6_TORGTS : STD_LOGIC; 
  signal MA_6_OUTMUX : STD_LOGIC; 
  signal MA_6 : STD_LOGIC; 
  signal MA_6_OD : STD_LOGIC; 
  signal MA_7_ENABLE : STD_LOGIC; 
  signal MA_7_TORGTS : STD_LOGIC; 
  signal MA_7_OUTMUX : STD_LOGIC; 
  signal MA_7 : STD_LOGIC; 
  signal MA_7_OD : STD_LOGIC; 
  signal MA_8_ENABLE : STD_LOGIC; 
  signal MA_8_TORGTS : STD_LOGIC; 
  signal MA_8_OUTMUX : STD_LOGIC; 
  signal MA_8 : STD_LOGIC; 
  signal MA_8_OD : STD_LOGIC; 
  signal MA_9_ENABLE : STD_LOGIC; 
  signal MA_9_TORGTS : STD_LOGIC; 
  signal MA_9_OUTMUX : STD_LOGIC; 
  signal MA_9 : STD_LOGIC; 
  signal MA_9_OD : STD_LOGIC; 
  signal MD_0_ENABLE : STD_LOGIC; 
  signal MD_0_TORGTS : STD_LOGIC; 
  signal MD_0_OUTMUX : STD_LOGIC; 
  signal MD_0 : STD_LOGIC; 
  signal MD_0_OD : STD_LOGIC; 
  signal MD_25_ENABLE : STD_LOGIC; 
  signal MD_25_TORGTS : STD_LOGIC; 
  signal MD_25_OUTMUX : STD_LOGIC; 
  signal MD_25 : STD_LOGIC; 
  signal MD_25_OD : STD_LOGIC; 
  signal BPOUT_0_ENABLE : STD_LOGIC; 
  signal BPOUT_0_TORGTS : STD_LOGIC; 
  signal BPOUT_0_OUTMUX : STD_LOGIC; 
  signal BPOUT_0_OD : STD_LOGIC; 
  signal BPOUT_1_ENABLE : STD_LOGIC; 
  signal BPOUT_1_TORGTS : STD_LOGIC; 
  signal BPOUT_1_OUTMUX : STD_LOGIC; 
  signal BPOUT_1_OD : STD_LOGIC; 
  signal MD_18_ENABLE : STD_LOGIC; 
  signal MD_18_TORGTS : STD_LOGIC; 
  signal MD_18_OUTMUX : STD_LOGIC; 
  signal MD_18 : STD_LOGIC; 
  signal MD_18_OD : STD_LOGIC; 
  signal MD_26_ENABLE : STD_LOGIC; 
  signal MD_26_TORGTS : STD_LOGIC; 
  signal MD_26_OUTMUX : STD_LOGIC; 
  signal MD_26 : STD_LOGIC; 
  signal MD_26_OD : STD_LOGIC; 
  signal BPOUT_2_ENABLE : STD_LOGIC; 
  signal BPOUT_2_TORGTS : STD_LOGIC; 
  signal BPOUT_2_OUTMUX : STD_LOGIC; 
  signal BPOUT_2_OD : STD_LOGIC; 
  signal MD_19_ENABLE : STD_LOGIC; 
  signal MD_19_TORGTS : STD_LOGIC; 
  signal MD_19_OUTMUX : STD_LOGIC; 
  signal MD_19 : STD_LOGIC; 
  signal MD_19_OD : STD_LOGIC; 
  signal MD_27_ENABLE : STD_LOGIC; 
  signal MD_27_TORGTS : STD_LOGIC; 
  signal MD_27_OUTMUX : STD_LOGIC; 
  signal MD_27 : STD_LOGIC; 
  signal MD_27_OD : STD_LOGIC; 
  signal BPOUT_3_ENABLE : STD_LOGIC; 
  signal BPOUT_3_TORGTS : STD_LOGIC; 
  signal BPOUT_3_OUTMUX : STD_LOGIC; 
  signal BPOUT_3_OD : STD_LOGIC; 
  signal MD_28_ENABLE : STD_LOGIC; 
  signal MD_28_TORGTS : STD_LOGIC; 
  signal MD_28_OUTMUX : STD_LOGIC; 
  signal MD_28 : STD_LOGIC; 
  signal MD_28_OD : STD_LOGIC; 
  signal MA_14_OFF_RST : STD_LOGIC; 
  signal BPOUT_4_ENABLE : STD_LOGIC; 
  signal BPOUT_4_TORGTS : STD_LOGIC; 
  signal BPOUT_4_OUTMUX : STD_LOGIC; 
  signal BPOUT_4_OD : STD_LOGIC; 
  signal MD_29_ENABLE : STD_LOGIC; 
  signal MD_29_TORGTS : STD_LOGIC; 
  signal MD_29_OUTMUX : STD_LOGIC; 
  signal MD_29 : STD_LOGIC; 
  signal MD_29_OD : STD_LOGIC; 
  signal BPOUT_5_ENABLE : STD_LOGIC; 
  signal BPOUT_5_TORGTS : STD_LOGIC; 
  signal BPOUT_5_OUTMUX : STD_LOGIC; 
  signal BPOUT_5_OD : STD_LOGIC; 
  signal BPOUT_6_ENABLE : STD_LOGIC; 
  signal BPOUT_6_TORGTS : STD_LOGIC; 
  signal BPOUT_6_OUTMUX : STD_LOGIC; 
  signal BPOUT_6_OD : STD_LOGIC; 
  signal BPOUT_7_ENABLE : STD_LOGIC; 
  signal BPOUT_7_TORGTS : STD_LOGIC; 
  signal BPOUT_7_OUTMUX : STD_LOGIC; 
  signal BPOUT_7_OD : STD_LOGIC; 
  signal BPOUT_8_ENABLE : STD_LOGIC; 
  signal BPOUT_8_TORGTS : STD_LOGIC; 
  signal BPOUT_8_OUTMUX : STD_LOGIC; 
  signal BPOUT_8_OD : STD_LOGIC; 
  signal BPOUT_9_ENABLE : STD_LOGIC; 
  signal BPOUT_9_TORGTS : STD_LOGIC; 
  signal BPOUT_9_OUTMUX : STD_LOGIC; 
  signal BPOUT_9_OD : STD_LOGIC; 
  signal RESET_IBUF_0 : STD_LOGIC; 
  signal MWEN_ENABLE : STD_LOGIC; 
  signal MWEN_TORGTS : STD_LOGIC; 
  signal MWEN_OUTMUX : STD_LOGIC; 
  signal MWEN_OBUF : STD_LOGIC; 
  signal MWEN_OD : STD_LOGIC; 
  signal DIN_10_IDELAY : STD_LOGIC; 
  signal DIN_10_IBUF : STD_LOGIC; 
  signal DIN_11_IDELAY : STD_LOGIC; 
  signal DIN_11_IBUF : STD_LOGIC; 
  signal DIN_12_IDELAY : STD_LOGIC; 
  signal DIN_12_IBUF : STD_LOGIC; 
  signal DIN_13_IDELAY : STD_LOGIC; 
  signal DIN_13_IBUF : STD_LOGIC; 
  signal DIN_14_IDELAY : STD_LOGIC; 
  signal DIN_14_IBUF : STD_LOGIC; 
  signal DIN_15_IDELAY : STD_LOGIC; 
  signal DIN_15_IBUF : STD_LOGIC; 
  signal BPOUT_10_ENABLE : STD_LOGIC; 
  signal BPOUT_10_TORGTS : STD_LOGIC; 
  signal BPOUT_10_OUTMUX : STD_LOGIC; 
  signal BPOUT_10_OD : STD_LOGIC; 
  signal MA_15_OFF_RST : STD_LOGIC; 
  signal BPOUT_11_ENABLE : STD_LOGIC; 
  signal BPOUT_11_TORGTS : STD_LOGIC; 
  signal BPOUT_11_OUTMUX : STD_LOGIC; 
  signal BPOUT_11_OD : STD_LOGIC; 
  signal BPOUT_12_ENABLE : STD_LOGIC; 
  signal BPOUT_12_TORGTS : STD_LOGIC; 
  signal BPOUT_12_OUTMUX : STD_LOGIC; 
  signal BPOUT_12_OD : STD_LOGIC; 
  signal BPOUT_13_ENABLE : STD_LOGIC; 
  signal BPOUT_13_TORGTS : STD_LOGIC; 
  signal BPOUT_13_OUTMUX : STD_LOGIC; 
  signal BPOUT_13_OD : STD_LOGIC; 
  signal BPOUT_14_ENABLE : STD_LOGIC; 
  signal BPOUT_14_TORGTS : STD_LOGIC; 
  signal BPOUT_14_OUTMUX : STD_LOGIC; 
  signal BPOUT_14_OD : STD_LOGIC; 
  signal BPOUT_15_ENABLE : STD_LOGIC; 
  signal BPOUT_15_TORGTS : STD_LOGIC; 
  signal BPOUT_15_OUTMUX : STD_LOGIC; 
  signal BPOUT_15_OD : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_0 : STD_LOGIC; 
  signal Q_n0081_0_XORF : STD_LOGIC; 
  signal Q_n0081_0_CYMUXG : STD_LOGIC; 
  signal Q_n0081_0_XORG : STD_LOGIC; 
  signal Q_n0081_0_GROM : STD_LOGIC; 
  signal Msub_n0041_inst_cy_0 : STD_LOGIC; 
  signal Q_n0081_0_CYINIT : STD_LOGIC; 
  signal Q_n0081_0_LOGIC_ONE : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_2 : STD_LOGIC; 
  signal Q_n0081_2_XORF : STD_LOGIC; 
  signal Q_n0081_2_CYMUXG : STD_LOGIC; 
  signal Q_n0081_2_XORG : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_3 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_2 : STD_LOGIC; 
  signal Q_n0081_2_CYINIT : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_4 : STD_LOGIC; 
  signal Q_n0081_4_XORF : STD_LOGIC; 
  signal Q_n0081_4_CYMUXG : STD_LOGIC; 
  signal Q_n0081_4_XORG : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_5 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_4 : STD_LOGIC; 
  signal Q_n0081_4_CYINIT : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_6 : STD_LOGIC; 
  signal Q_n0081_6_XORF : STD_LOGIC; 
  signal Q_n0081_6_CYMUXG : STD_LOGIC; 
  signal Q_n0081_6_XORG : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_7 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_6 : STD_LOGIC; 
  signal Q_n0081_6_CYINIT : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_8 : STD_LOGIC; 
  signal Q_n0081_8_XORF : STD_LOGIC; 
  signal Q_n0081_8_CYMUXG : STD_LOGIC; 
  signal Q_n0081_8_XORG : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_9 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_8 : STD_LOGIC; 
  signal Q_n0081_8_CYINIT : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_10 : STD_LOGIC; 
  signal Q_n0081_10_XORF : STD_LOGIC; 
  signal Q_n0081_10_CYMUXG : STD_LOGIC; 
  signal Q_n0081_10_XORG : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_11 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_10 : STD_LOGIC; 
  signal Q_n0081_10_CYINIT : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_12 : STD_LOGIC; 
  signal Q_n0081_12_XORF : STD_LOGIC; 
  signal Q_n0081_12_CYMUXG : STD_LOGIC; 
  signal Q_n0081_12_XORG : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_13 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_12 : STD_LOGIC; 
  signal Q_n0081_12_CYINIT : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_14 : STD_LOGIC; 
  signal Q_n0081_14_XORF : STD_LOGIC; 
  signal Q_n0081_14_XORG : STD_LOGIC; 
  signal Msub_n0041_inst_lut2_15 : STD_LOGIC; 
  signal Msub_n0041_inst_cy_14 : STD_LOGIC; 
  signal Q_n0081_14_CYINIT : STD_LOGIC; 
  signal cs_FFd12_rt : STD_LOGIC; 
  signal addr_0_CYMUXG : STD_LOGIC; 
  signal addr_inst_lut3_0 : STD_LOGIC; 
  signal addr_inst_cy_16 : STD_LOGIC; 
  signal addr_0_LOGIC_ZERO : STD_LOGIC; 
  signal addr_inst_sum_16 : STD_LOGIC; 
  signal addr_inst_lut3_1 : STD_LOGIC; 
  signal addr_inst_sum_17 : STD_LOGIC; 
  signal addr_1_CYMUXG : STD_LOGIC; 
  signal addr_1_LOGIC_ZERO : STD_LOGIC; 
  signal addr_inst_lut3_2 : STD_LOGIC; 
  signal addr_inst_cy_18 : STD_LOGIC; 
  signal addr_1_CYINIT : STD_LOGIC; 
  signal addr_inst_sum_18 : STD_LOGIC; 
  signal addr_inst_lut3_31_O : STD_LOGIC; 
  signal addr_inst_sum_19 : STD_LOGIC; 
  signal addr_3_CYMUXG : STD_LOGIC; 
  signal addr_3_LOGIC_ZERO : STD_LOGIC; 
  signal addr_inst_lut3_41_O : STD_LOGIC; 
  signal addr_inst_cy_20 : STD_LOGIC; 
  signal addr_3_CYINIT : STD_LOGIC; 
  signal addr_inst_sum_20 : STD_LOGIC; 
  signal addr_inst_lut3_5 : STD_LOGIC; 
  signal addr_inst_sum_21 : STD_LOGIC; 
  signal addr_5_CYMUXG : STD_LOGIC; 
  signal addr_5_LOGIC_ZERO : STD_LOGIC; 
  signal addr_inst_lut3_6 : STD_LOGIC; 
  signal addr_inst_cy_22 : STD_LOGIC; 
  signal addr_5_CYINIT : STD_LOGIC; 
  signal addr_inst_sum_22 : STD_LOGIC; 
  signal addr_inst_lut3_7 : STD_LOGIC; 
  signal addr_inst_sum_23 : STD_LOGIC; 
  signal addr_7_CYMUXG : STD_LOGIC; 
  signal addr_7_LOGIC_ZERO : STD_LOGIC; 
  signal addr_inst_lut3_8 : STD_LOGIC; 
  signal addr_inst_cy_24 : STD_LOGIC; 
  signal addr_7_CYINIT : STD_LOGIC; 
  signal addr_inst_sum_24 : STD_LOGIC; 
  signal addr_inst_lut3_9 : STD_LOGIC; 
  signal addr_inst_sum_25 : STD_LOGIC; 
  signal addr_9_CYMUXG : STD_LOGIC; 
  signal addr_9_LOGIC_ZERO : STD_LOGIC; 
  signal addr_inst_lut3_10 : STD_LOGIC; 
  signal addr_inst_cy_26 : STD_LOGIC; 
  signal addr_9_CYINIT : STD_LOGIC; 
  signal addr_inst_sum_26 : STD_LOGIC; 
  signal addr_inst_lut3_11 : STD_LOGIC; 
  signal addr_inst_sum_27 : STD_LOGIC; 
  signal addr_11_CYMUXG : STD_LOGIC; 
  signal addr_11_LOGIC_ZERO : STD_LOGIC; 
  signal addr_inst_lut3_12 : STD_LOGIC; 
  signal addr_inst_cy_28 : STD_LOGIC; 
  signal addr_11_CYINIT : STD_LOGIC; 
  signal addr_inst_sum_28 : STD_LOGIC; 
  signal DIN_0_IFF_RST : STD_LOGIC; 
  signal addr_inst_lut3_13 : STD_LOGIC; 
  signal addr_inst_sum_29 : STD_LOGIC; 
  signal addr_13_CYMUXG : STD_LOGIC; 
  signal addr_13_LOGIC_ZERO : STD_LOGIC; 
  signal addr_inst_lut3_14 : STD_LOGIC; 
  signal addr_inst_cy_30 : STD_LOGIC; 
  signal addr_13_CYINIT : STD_LOGIC; 
  signal addr_inst_sum_30 : STD_LOGIC; 
  signal addr_inst_lut3_15 : STD_LOGIC; 
  signal addr_inst_sum_31 : STD_LOGIC; 
  signal addr_15_GROM : STD_LOGIC; 
  signal addr_15_CYINIT : STD_LOGIC; 
  signal N3456_FROM : STD_LOGIC; 
  signal N3456_GROM : STD_LOGIC; 
  signal cs_FFd6_In : STD_LOGIC; 
  signal cs_FFd5_In1_O : STD_LOGIC; 
  signal cs_FFd8_In1_O : STD_LOGIC; 
  signal cs_FFd7_In_O : STD_LOGIC; 
  signal Ker3426120_O_FROM : STD_LOGIC; 
  signal Ker3426120_O_GROM : STD_LOGIC; 
  signal Ker342621_O_FROM : STD_LOGIC; 
  signal Ker342621_O_GROM : STD_LOGIC; 
  signal dinint_1_LOGIC_ONE : STD_LOGIC; 
  signal dinint_1_CEMUXNOT : STD_LOGIC; 
  signal dinint_3_FFY_RST : STD_LOGIC; 
  signal dinint_3_LOGIC_ONE : STD_LOGIC; 
  signal dinint_3_CEMUXNOT : STD_LOGIC; 
  signal dinint_5_FFY_RST : STD_LOGIC; 
  signal dinint_5_LOGIC_ONE : STD_LOGIC; 
  signal dinint_5_CEMUXNOT : STD_LOGIC; 
  signal cs_FFd11_FFY_RST : STD_LOGIC; 
  signal cs_FFd11_FROM : STD_LOGIC; 
  signal cs_FFd11_In : STD_LOGIC; 
  signal dinint_7_LOGIC_ONE : STD_LOGIC; 
  signal dinint_7_CEMUXNOT : STD_LOGIC; 
  signal DIN_1_IFF_RST : STD_LOGIC; 
  signal dinint_9_FFY_RST : STD_LOGIC; 
  signal dinint_9_LOGIC_ONE : STD_LOGIC; 
  signal dinint_9_CEMUXNOT : STD_LOGIC; 
  signal dinint_11_FFY_RST : STD_LOGIC; 
  signal dinint_11_LOGIC_ONE : STD_LOGIC; 
  signal dinint_11_CEMUXNOT : STD_LOGIC; 
  signal dinint_13_FFY_RST : STD_LOGIC; 
  signal dinint_13_LOGIC_ONE : STD_LOGIC; 
  signal dinint_13_CEMUXNOT : STD_LOGIC; 
  signal dinint_15_FFY_RST : STD_LOGIC; 
  signal dinint_15_LOGIC_ONE : STD_LOGIC; 
  signal dinint_15_CEMUXNOT : STD_LOGIC; 
  signal CNT_1_FFY_RST : STD_LOGIC; 
  signal cs_FFd3_1_FROM : STD_LOGIC; 
  signal cs_FFd3_1_GROM : STD_LOGIC; 
  signal enableintl_LOGIC_ONE : STD_LOGIC; 
  signal enableintl_GSHIFT : STD_LOGIC; 
  signal enableintl_CEMUXNOT : STD_LOGIC; 
  signal DIN_2_IFF_RST : STD_LOGIC; 
  signal cs_FFd4_In : STD_LOGIC; 
  signal cs_FFd2_In : STD_LOGIC; 
  signal cs_FFd10_In_O : STD_LOGIC; 
  signal cs_FFd9_In : STD_LOGIC; 
  signal newfint_LOGIC_ONE : STD_LOGIC; 
  signal lnewfint : STD_LOGIC; 
  signal newfint_CEMUXNOT : STD_LOGIC; 
  signal lden : STD_LOGIC; 
  signal den_CEMUXNOT : STD_LOGIC; 
  signal Q_n0028_FROM : STD_LOGIC; 
  signal Q_n0028_GROM : STD_LOGIC; 
  signal DIN_3_IFF_RST : STD_LOGIC; 
  signal MD_1_ENABLE : STD_LOGIC; 
  signal MD_1_TORGTS : STD_LOGIC; 
  signal MD_1_OUTMUX : STD_LOGIC; 
  signal MD_1 : STD_LOGIC; 
  signal MD_1_OD : STD_LOGIC; 
  signal MD_2_ENABLE : STD_LOGIC; 
  signal MD_2_TORGTS : STD_LOGIC; 
  signal MD_2_OUTMUX : STD_LOGIC; 
  signal MD_2 : STD_LOGIC; 
  signal MD_2_OD : STD_LOGIC; 
  signal MD_3_ENABLE : STD_LOGIC; 
  signal MD_3_TORGTS : STD_LOGIC; 
  signal MD_3_OUTMUX : STD_LOGIC; 
  signal MD_3 : STD_LOGIC; 
  signal MD_3_OD : STD_LOGIC; 
  signal DIN_8_IFF_RST : STD_LOGIC; 
  signal MD_4_ENABLE : STD_LOGIC; 
  signal MD_4_TORGTS : STD_LOGIC; 
  signal MD_4_OUTMUX : STD_LOGIC; 
  signal MD_4 : STD_LOGIC; 
  signal MD_4_OD : STD_LOGIC; 
  signal MD_5_ENABLE : STD_LOGIC; 
  signal MD_5_TORGTS : STD_LOGIC; 
  signal MD_5_OUTMUX : STD_LOGIC; 
  signal MD_5 : STD_LOGIC; 
  signal MD_5_OD : STD_LOGIC; 
  signal MD_6_ENABLE : STD_LOGIC; 
  signal MD_6_TORGTS : STD_LOGIC; 
  signal MD_6_OUTMUX : STD_LOGIC; 
  signal MD_6 : STD_LOGIC; 
  signal MD_6_OD : STD_LOGIC; 
  signal DIN_9_IFF_RST : STD_LOGIC; 
  signal MD_10_OFF_RST : STD_LOGIC; 
  signal MD_11_OFF_RST : STD_LOGIC; 
  signal MD_12_OFF_RST : STD_LOGIC; 
  signal MD_20_OFF_RST : STD_LOGIC; 
  signal addr_7_FFX_RST : STD_LOGIC; 
  signal addr_9_FFX_RST : STD_LOGIC; 
  signal addr_11_FFY_RST : STD_LOGIC; 
  signal addr_11_FFX_RST : STD_LOGIC; 
  signal addr_13_FFY_RST : STD_LOGIC; 
  signal BPOUT_14_OFF_RST : STD_LOGIC; 
  signal BPOUT_15_OFF_RST : STD_LOGIC; 
  signal dl_1_FFX_RST : STD_LOGIC; 
  signal dl_3_FFX_RST : STD_LOGIC; 
  signal dl_5_FFX_RST : STD_LOGIC; 
  signal dl_7_FFX_RST : STD_LOGIC; 
  signal dl_9_FFY_RST : STD_LOGIC; 
  signal dl_9_FFX_RST : STD_LOGIC; 
  signal dh_11_FFY_RST : STD_LOGIC; 
  signal dh_11_FFX_RST : STD_LOGIC; 
  signal dh_13_FFY_RST : STD_LOGIC; 
  signal dh_13_FFX_RST : STD_LOGIC; 
  signal dh_15_FFY_RST : STD_LOGIC; 
  signal dl_11_FFY_RST : STD_LOGIC; 
  signal BPOUT_2_OFF_RST : STD_LOGIC; 
  signal MD_19_OFF_RST : STD_LOGIC; 
  signal MD_27_OFF_RST : STD_LOGIC; 
  signal BPOUT_3_OFF_RST : STD_LOGIC; 
  signal MD_28_OFF_RST : STD_LOGIC; 
  signal BPOUT_4_OFF_RST : STD_LOGIC; 
  signal MD_25_OFF_RST : STD_LOGIC; 
  signal BPOUT_0_OFF_RST : STD_LOGIC; 
  signal BPOUT_1_OFF_RST : STD_LOGIC; 
  signal MD_18_OFF_RST : STD_LOGIC; 
  signal MD_26_OFF_RST : STD_LOGIC; 
  signal dinint_1_FFY_RST : STD_LOGIC; 
  signal dinint_1_FFX_RST : STD_LOGIC; 
  signal dinint_3_FFX_RST : STD_LOGIC; 
  signal dinint_5_FFX_RST : STD_LOGIC; 
  signal dinint_7_FFY_RST : STD_LOGIC; 
  signal MD_13_OFF_RST : STD_LOGIC; 
  signal MD_21_OFF_RST : STD_LOGIC; 
  signal MD_14_OFF_RST : STD_LOGIC; 
  signal MD_22_OFF_RST : STD_LOGIC; 
  signal MD_30_OFF_RST : STD_LOGIC; 
  signal MD_15_OFF_RST : STD_LOGIC; 
  signal MD_23_OFF_RST : STD_LOGIC; 
  signal MD_31_OFF_RST : STD_LOGIC; 
  signal MD_16_OFF_RST : STD_LOGIC; 
  signal MD_24_OFF_RST : STD_LOGIC; 
  signal MD_17_OFF_RST : STD_LOGIC; 
  signal MD_29_OFF_RST : STD_LOGIC; 
  signal BPOUT_5_OFF_RST : STD_LOGIC; 
  signal BPOUT_6_OFF_RST : STD_LOGIC; 
  signal BPOUT_7_OFF_RST : STD_LOGIC; 
  signal BPOUT_8_OFF_RST : STD_LOGIC; 
  signal BPOUT_9_OFF_RST : STD_LOGIC; 
  signal MWEN_OFF_RST : STD_LOGIC; 
  signal DIN_10_IFF_RST : STD_LOGIC; 
  signal DIN_11_IFF_RST : STD_LOGIC; 
  signal DIN_12_IFF_RST : STD_LOGIC; 
  signal addr_0_FFY_RST : STD_LOGIC; 
  signal addr_1_FFY_RST : STD_LOGIC; 
  signal addr_3_FFY_RST : STD_LOGIC; 
  signal DIN_13_IFF_RST : STD_LOGIC; 
  signal DIN_14_IFF_RST : STD_LOGIC; 
  signal DIN_15_IFF_RST : STD_LOGIC; 
  signal BPOUT_10_OFF_RST : STD_LOGIC; 
  signal BPOUT_11_OFF_RST : STD_LOGIC; 
  signal BPOUT_12_OFF_RST : STD_LOGIC; 
  signal BPOUT_13_OFF_RST : STD_LOGIC; 
  signal cs_FFd4_FFY_RST : STD_LOGIC; 
  signal cs_FFd4_FFX_RST : STD_LOGIC; 
  signal cs_FFd10_FFY_RST : STD_LOGIC; 
  signal cs_FFd10_FFX_RST : STD_LOGIC; 
  signal CNT_13_FFX_RST : STD_LOGIC; 
  signal CNT_11_FFY_RST : STD_LOGIC; 
  signal CNT_11_FFX_RST : STD_LOGIC; 
  signal CNT_13_FFY_RST : STD_LOGIC; 
  signal CNT_15_FFY_RST : STD_LOGIC; 
  signal addr_1_FFX_RST : STD_LOGIC; 
  signal addr_3_FFX_RST : STD_LOGIC; 
  signal addr_5_FFY_RST : STD_LOGIC; 
  signal addr_9_FFY_RST : STD_LOGIC; 
  signal addr_5_FFX_RST : STD_LOGIC; 
  signal addr_7_FFY_RST : STD_LOGIC; 
  signal dinint_7_FFX_RST : STD_LOGIC; 
  signal dinint_9_FFX_RST : STD_LOGIC; 
  signal dinint_11_FFX_RST : STD_LOGIC; 
  signal dinint_13_FFX_RST : STD_LOGIC; 
  signal dinint_15_FFX_RST : STD_LOGIC; 
  signal CNT_3_FFX_RST : STD_LOGIC; 
  signal CNT_1_FFX_RST : STD_LOGIC; 
  signal CNT_3_FFY_RST : STD_LOGIC; 
  signal CNT_5_FFX_RST : STD_LOGIC; 
  signal CNT_5_FFY_RST : STD_LOGIC; 
  signal CNT_7_FFX_RST : STD_LOGIC; 
  signal CNT_7_FFY_RST : STD_LOGIC; 
  signal CNT_9_FFX_RST : STD_LOGIC; 
  signal CNT_9_FFY_RST : STD_LOGIC; 
  signal cs_FFd3_1_FFY_RST : STD_LOGIC; 
  signal enableintl_FFY_RST : STD_LOGIC; 
  signal cs_FFd1_1_FFY_RST : STD_LOGIC; 
  signal cs_FFd12_1_FFX_SET : STD_LOGIC; 
  signal dh_1_FFY_RST : STD_LOGIC; 
  signal dh_3_FFY_RST : STD_LOGIC; 
  signal dh_1_FFX_RST : STD_LOGIC; 
  signal dh_3_FFX_RST : STD_LOGIC; 
  signal dh_5_FFY_RST : STD_LOGIC; 
  signal dh_5_FFX_RST : STD_LOGIC; 
  signal dh_7_FFY_RST : STD_LOGIC; 
  signal dh_7_FFX_RST : STD_LOGIC; 
  signal dh_9_FFY_RST : STD_LOGIC; 
  signal dh_9_FFX_RST : STD_LOGIC; 
  signal dl_1_FFY_RST : STD_LOGIC; 
  signal addr_13_FFX_RST : STD_LOGIC; 
  signal addr_15_FFX_RST : STD_LOGIC; 
  signal cs_FFd6_FFY_RST : STD_LOGIC; 
  signal cs_FFd6_FFX_RST : STD_LOGIC; 
  signal cs_FFd8_FFY_RST : STD_LOGIC; 
  signal cs_FFd8_FFX_RST : STD_LOGIC; 
  signal CNT_15_FFX_RST : STD_LOGIC; 
  signal newfint_FFY_RST : STD_LOGIC; 
  signal den_FFY_RST : STD_LOGIC; 
  signal bp_0_1_FFY_RST : STD_LOGIC; 
  signal bp_1_1_FFY_RST : STD_LOGIC; 
  signal bp_2_1_FFY_RST : STD_LOGIC; 
  signal bp_3_1_FFY_RST : STD_LOGIC; 
  signal bp_4_1_FFY_RST : STD_LOGIC; 
  signal bp_5_1_FFY_RST : STD_LOGIC; 
  signal bp_6_1_FFY_RST : STD_LOGIC; 
  signal MA_2_OFF_RST : STD_LOGIC; 
  signal MA_3_OFF_RST : STD_LOGIC; 
  signal MA_4_OFF_RST : STD_LOGIC; 
  signal MA_5_OFF_RST : STD_LOGIC; 
  signal TXFIFOWERR_OFF_RST : STD_LOGIC; 
  signal bp_10_1_FFY_RST : STD_LOGIC; 
  signal bp_7_1_FFY_RST : STD_LOGIC; 
  signal bp_11_1_FFY_RST : STD_LOGIC; 
  signal bp_8_1_FFY_RST : STD_LOGIC; 
  signal bp_12_1_FFY_RST : STD_LOGIC; 
  signal bp_9_1_FFY_RST : STD_LOGIC; 
  signal bp_13_1_FFY_RST : STD_LOGIC; 
  signal bp_14_1_FFY_RST : STD_LOGIC; 
  signal bp_15_1_FFY_RST : STD_LOGIC; 
  signal cs_FFd12_1_FFY_SET : STD_LOGIC; 
  signal MD_2_OFF_RST : STD_LOGIC; 
  signal MD_3_OFF_RST : STD_LOGIC; 
  signal MD_4_OFF_RST : STD_LOGIC; 
  signal MD_5_OFF_RST : STD_LOGIC; 
  signal MD_6_OFF_RST : STD_LOGIC; 
  signal MA_6_OFF_RST : STD_LOGIC; 
  signal MA_7_OFF_RST : STD_LOGIC; 
  signal MA_8_OFF_RST : STD_LOGIC; 
  signal MA_9_OFF_RST : STD_LOGIC; 
  signal MD_0_OFF_RST : STD_LOGIC; 
  signal MD_1_OFF_RST : STD_LOGIC; 
  signal dh_15_FFX_RST : STD_LOGIC; 
  signal dl_11_FFX_RST : STD_LOGIC; 
  signal dl_13_FFY_RST : STD_LOGIC; 
  signal dl_13_FFX_RST : STD_LOGIC; 
  signal dl_15_FFY_RST : STD_LOGIC; 
  signal dl_15_FFX_RST : STD_LOGIC; 
  signal DONE_OFF_RST : STD_LOGIC; 
  signal FIFOFULL_IFF_RST : STD_LOGIC; 
  signal MA_0_OFF_RST : STD_LOGIC; 
  signal MA_1_OFF_RST : STD_LOGIC; 
  signal CLKIO_BUFGP_BUFG_CE : STD_LOGIC; 
  signal CLK_BUFGP_BUFG_CE : STD_LOGIC; 
  signal GND : STD_LOGIC; 
  signal VCC : STD_LOGIC; 
  signal dl : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal addr : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal dinl : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal dh : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal CNT : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal Q_n0081 : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal dinint : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal bp : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal ldinint : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal Q_n0039 : STD_LOGIC_VECTOR ( 15 downto 0 ); 
begin
  GLOBAL_LOGIC0_ZERO : X_ZERO
    port map (
      O => GLOBAL_LOGIC0
    );
  GLOBAL_LOGIC1_ONE : X_ONE
    port map (
      O => GLOBAL_LOGIC1
    );
  MD_7_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_7_OFF_RST
    );
  MD_7_1 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_7_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_7_OFF_RST,
      O => MD_7
    );
  MD_7_OBUF : X_TRI
    port map (
      I => MD_7_OUTMUX,
      CTL => MD_7_ENABLE,
      O => MD(7)
    );
  MD_7_ENABLEINV : X_INV
    port map (
      I => MD_7_TORGTS,
      O => MD_7_ENABLE
    );
  MD_7_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_7_TORGTS
    );
  MD_7_OUTMUX_2 : X_BUF
    port map (
      I => MD_7,
      O => MD_7_OUTMUX
    );
  MD_7_OMUX : X_BUF
    port map (
      I => dl(7),
      O => MD_7_OD
    );
  MD_8_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_8_OFF_RST
    );
  MD_8_3 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_8_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_8_OFF_RST,
      O => MD_8
    );
  MD_8_OBUF : X_TRI
    port map (
      I => MD_8_OUTMUX,
      CTL => MD_8_ENABLE,
      O => MD(8)
    );
  MD_8_ENABLEINV : X_INV
    port map (
      I => MD_8_TORGTS,
      O => MD_8_ENABLE
    );
  MD_8_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_8_TORGTS
    );
  MD_8_OUTMUX_4 : X_BUF
    port map (
      I => MD_8,
      O => MD_8_OUTMUX
    );
  MD_8_OMUX : X_BUF
    port map (
      I => dl(8),
      O => MD_8_OD
    );
  MD_9_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_9_OFF_RST
    );
  MD_9_5 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_9_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_9_OFF_RST,
      O => MD_9
    );
  MD_9_OBUF : X_TRI
    port map (
      I => MD_9_OUTMUX,
      CTL => MD_9_ENABLE,
      O => MD(9)
    );
  MD_9_ENABLEINV : X_INV
    port map (
      I => MD_9_TORGTS,
      O => MD_9_ENABLE
    );
  MD_9_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_9_TORGTS
    );
  MD_9_OUTMUX_6 : X_BUF
    port map (
      I => MD_9,
      O => MD_9_OUTMUX
    );
  MD_9_OMUX : X_BUF
    port map (
      I => dl(9),
      O => MD_9_OD
    );
  NEWFRAME_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => NEWFRAME_IFF_RST
    );
  newframel_7 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => NEWFRAME_IDELAY,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => NEWFRAME_IFF_RST,
      O => newframel
    );
  NEWFRAME_IBUF_8 : X_BUF
    port map (
      I => NEWFRAME,
      O => NEWFRAME_IBUF
    );
  NEWFRAME_DELAY : X_BUF
    port map (
      I => NEWFRAME_IBUF,
      O => NEWFRAME_IDELAY
    );
  MA_10_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_10_OFF_RST
    );
  MA_10_9 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MA_10_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MA_10_OFF_RST,
      O => MA_10
    );
  MA_10_OBUF : X_TRI
    port map (
      I => MA_10_OUTMUX,
      CTL => MA_10_ENABLE,
      O => MA(10)
    );
  MA_10_ENABLEINV : X_INV
    port map (
      I => MA_10_TORGTS,
      O => MA_10_ENABLE
    );
  MA_10_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MA_10_TORGTS
    );
  MA_10_OUTMUX_10 : X_BUF
    port map (
      I => MA_10,
      O => MA_10_OUTMUX
    );
  MA_10_OMUX : X_BUF
    port map (
      I => addr(10),
      O => MA_10_OD
    );
  MA_11_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_11_OFF_RST
    );
  MA_11_11 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MA_11_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MA_11_OFF_RST,
      O => MA_11
    );
  MA_11_OBUF : X_TRI
    port map (
      I => MA_11_OUTMUX,
      CTL => MA_11_ENABLE,
      O => MA(11)
    );
  MA_11_ENABLEINV : X_INV
    port map (
      I => MA_11_TORGTS,
      O => MA_11_ENABLE
    );
  MA_11_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MA_11_TORGTS
    );
  MA_11_OUTMUX_12 : X_BUF
    port map (
      I => MA_11,
      O => MA_11_OUTMUX
    );
  MA_11_OMUX : X_BUF
    port map (
      I => addr(11),
      O => MA_11_OD
    );
  MA_12_OBUF : X_TRI
    port map (
      I => MA_12_OUTMUX,
      CTL => MA_12_ENABLE,
      O => MA(12)
    );
  MA_12_ENABLEINV : X_INV
    port map (
      I => MA_12_TORGTS,
      O => MA_12_ENABLE
    );
  MA_12_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MA_12_TORGTS
    );
  MA_12_OUTMUX_13 : X_BUF
    port map (
      I => MA_12,
      O => MA_12_OUTMUX
    );
  MA_12_OMUX : X_BUF
    port map (
      I => addr(12),
      O => MA_12_OD
    );
  MA_13_OBUF : X_TRI
    port map (
      I => MA_13_OUTMUX,
      CTL => MA_13_ENABLE,
      O => MA(13)
    );
  MA_13_ENABLEINV : X_INV
    port map (
      I => MA_13_TORGTS,
      O => MA_13_ENABLE
    );
  MA_13_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MA_13_TORGTS
    );
  MA_13_OUTMUX_14 : X_BUF
    port map (
      I => MA_13,
      O => MA_13_OUTMUX
    );
  MA_13_OMUX : X_BUF
    port map (
      I => addr(13),
      O => MA_13_OD
    );
  MA_14_OBUF : X_TRI
    port map (
      I => MA_14_OUTMUX,
      CTL => MA_14_ENABLE,
      O => MA(14)
    );
  MA_14_ENABLEINV : X_INV
    port map (
      I => MA_14_TORGTS,
      O => MA_14_ENABLE
    );
  MA_14_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MA_14_TORGTS
    );
  MA_14_OUTMUX_15 : X_BUF
    port map (
      I => MA_14,
      O => MA_14_OUTMUX
    );
  MA_14_OMUX : X_BUF
    port map (
      I => addr(14),
      O => MA_14_OD
    );
  MA_15_OBUF : X_TRI
    port map (
      I => MA_15_OUTMUX,
      CTL => MA_15_ENABLE,
      O => MA(15)
    );
  MA_15_ENABLEINV : X_INV
    port map (
      I => MA_15_TORGTS,
      O => MA_15_ENABLE
    );
  MA_15_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MA_15_TORGTS
    );
  MA_15_OUTMUX_16 : X_BUF
    port map (
      I => MA_15,
      O => MA_15_OUTMUX
    );
  MA_15_OMUX : X_BUF
    port map (
      I => addr(15),
      O => MA_15_OD
    );
  DIN_0_IBUF_17 : X_BUF
    port map (
      I => DIN(0),
      O => DIN_0_IBUF
    );
  DIN_0_DELAY : X_BUF
    port map (
      I => DIN_0_IBUF,
      O => DIN_0_IDELAY
    );
  MA_12_18 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MA_12_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MA_12_OFF_RST,
      O => MA_12
    );
  MA_12_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_12_OFF_RST
    );
  DIN_1_IBUF_19 : X_BUF
    port map (
      I => DIN(1),
      O => DIN_1_IBUF
    );
  DIN_1_DELAY : X_BUF
    port map (
      I => DIN_1_IBUF,
      O => DIN_1_IDELAY
    );
  DIN_2_IBUF_20 : X_BUF
    port map (
      I => DIN(2),
      O => DIN_2_IBUF
    );
  DIN_2_DELAY : X_BUF
    port map (
      I => DIN_2_IBUF,
      O => DIN_2_IDELAY
    );
  DIN_3_IBUF_21 : X_BUF
    port map (
      I => DIN(3),
      O => DIN_3_IBUF
    );
  DIN_3_DELAY : X_BUF
    port map (
      I => DIN_3_IBUF,
      O => DIN_3_IDELAY
    );
  DIN_4_IBUF_22 : X_BUF
    port map (
      I => DIN(4),
      O => DIN_4_IBUF
    );
  DIN_4_DELAY : X_BUF
    port map (
      I => DIN_4_IBUF,
      O => DIN_4_IDELAY
    );
  DIN_5_IBUF_23 : X_BUF
    port map (
      I => DIN(5),
      O => DIN_5_IBUF
    );
  DIN_5_DELAY : X_BUF
    port map (
      I => DIN_5_IBUF,
      O => DIN_5_IDELAY
    );
  DIN_6_IBUF_24 : X_BUF
    port map (
      I => DIN(6),
      O => DIN_6_IBUF
    );
  DIN_6_DELAY : X_BUF
    port map (
      I => DIN_6_IBUF,
      O => DIN_6_IDELAY
    );
  DIN_7_IBUF_25 : X_BUF
    port map (
      I => DIN(7),
      O => DIN_7_IBUF
    );
  DIN_7_DELAY : X_BUF
    port map (
      I => DIN_7_IBUF,
      O => DIN_7_IDELAY
    );
  DIN_8_IBUF_26 : X_BUF
    port map (
      I => DIN(8),
      O => DIN_8_IBUF
    );
  DIN_8_DELAY : X_BUF
    port map (
      I => DIN_8_IBUF,
      O => DIN_8_IDELAY
    );
  DIN_9_IBUF_27 : X_BUF
    port map (
      I => DIN(9),
      O => DIN_9_IBUF
    );
  DIN_9_DELAY : X_BUF
    port map (
      I => DIN_9_IBUF,
      O => DIN_9_IDELAY
    );
  MD_10_OBUF : X_TRI
    port map (
      I => MD_10_OUTMUX,
      CTL => MD_10_ENABLE,
      O => MD(10)
    );
  MD_10_ENABLEINV : X_INV
    port map (
      I => MD_10_TORGTS,
      O => MD_10_ENABLE
    );
  MD_10_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_10_TORGTS
    );
  MD_10_OUTMUX_28 : X_BUF
    port map (
      I => MD_10,
      O => MD_10_OUTMUX
    );
  MD_10_OMUX : X_BUF
    port map (
      I => dl(10),
      O => MD_10_OD
    );
  MD_11_OBUF : X_TRI
    port map (
      I => MD_11_OUTMUX,
      CTL => MD_11_ENABLE,
      O => MD(11)
    );
  MD_11_ENABLEINV : X_INV
    port map (
      I => MD_11_TORGTS,
      O => MD_11_ENABLE
    );
  MD_11_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_11_TORGTS
    );
  MD_11_OUTMUX_29 : X_BUF
    port map (
      I => MD_11,
      O => MD_11_OUTMUX
    );
  MD_11_OMUX : X_BUF
    port map (
      I => dl(11),
      O => MD_11_OD
    );
  MD_12_OBUF : X_TRI
    port map (
      I => MD_12_OUTMUX,
      CTL => MD_12_ENABLE,
      O => MD(12)
    );
  MD_12_ENABLEINV : X_INV
    port map (
      I => MD_12_TORGTS,
      O => MD_12_ENABLE
    );
  MD_12_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_12_TORGTS
    );
  MD_12_OUTMUX_30 : X_BUF
    port map (
      I => MD_12,
      O => MD_12_OUTMUX
    );
  MD_12_OMUX : X_BUF
    port map (
      I => dl(12),
      O => MD_12_OD
    );
  MD_20_OBUF : X_TRI
    port map (
      I => MD_20_OUTMUX,
      CTL => MD_20_ENABLE,
      O => MD(20)
    );
  MD_20_ENABLEINV : X_INV
    port map (
      I => MD_20_TORGTS,
      O => MD_20_ENABLE
    );
  MD_20_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_20_TORGTS
    );
  MD_20_OUTMUX_31 : X_BUF
    port map (
      I => MD_20,
      O => MD_20_OUTMUX
    );
  MD_20_OMUX : X_BUF
    port map (
      I => dh(4),
      O => MD_20_OD
    );
  MD_13_OBUF : X_TRI
    port map (
      I => MD_13_OUTMUX,
      CTL => MD_13_ENABLE,
      O => MD(13)
    );
  MD_13_ENABLEINV : X_INV
    port map (
      I => MD_13_TORGTS,
      O => MD_13_ENABLE
    );
  MD_13_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_13_TORGTS
    );
  MD_13_OUTMUX_32 : X_BUF
    port map (
      I => MD_13,
      O => MD_13_OUTMUX
    );
  MD_13_OMUX : X_BUF
    port map (
      I => dl(13),
      O => MD_13_OD
    );
  MD_21_OBUF : X_TRI
    port map (
      I => MD_21_OUTMUX,
      CTL => MD_21_ENABLE,
      O => MD(21)
    );
  MD_21_ENABLEINV : X_INV
    port map (
      I => MD_21_TORGTS,
      O => MD_21_ENABLE
    );
  MD_21_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_21_TORGTS
    );
  MD_21_OUTMUX_33 : X_BUF
    port map (
      I => MD_21,
      O => MD_21_OUTMUX
    );
  MD_21_OMUX : X_BUF
    port map (
      I => dh(5),
      O => MD_21_OD
    );
  MD_14_OBUF : X_TRI
    port map (
      I => MD_14_OUTMUX,
      CTL => MD_14_ENABLE,
      O => MD(14)
    );
  MD_14_ENABLEINV : X_INV
    port map (
      I => MD_14_TORGTS,
      O => MD_14_ENABLE
    );
  MD_14_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_14_TORGTS
    );
  MD_14_OUTMUX_34 : X_BUF
    port map (
      I => MD_14,
      O => MD_14_OUTMUX
    );
  MD_14_OMUX : X_BUF
    port map (
      I => dl(14),
      O => MD_14_OD
    );
  MD_22_OBUF : X_TRI
    port map (
      I => MD_22_OUTMUX,
      CTL => MD_22_ENABLE,
      O => MD(22)
    );
  MD_22_ENABLEINV : X_INV
    port map (
      I => MD_22_TORGTS,
      O => MD_22_ENABLE
    );
  MD_22_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_22_TORGTS
    );
  MD_22_OUTMUX_35 : X_BUF
    port map (
      I => MD_22,
      O => MD_22_OUTMUX
    );
  MD_22_OMUX : X_BUF
    port map (
      I => dh(6),
      O => MD_22_OD
    );
  MA_13_36 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MA_13_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MA_13_OFF_RST,
      O => MA_13
    );
  MA_13_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_13_OFF_RST
    );
  MD_30_OBUF : X_TRI
    port map (
      I => MD_30_OUTMUX,
      CTL => MD_30_ENABLE,
      O => MD(30)
    );
  MD_30_ENABLEINV : X_INV
    port map (
      I => MD_30_TORGTS,
      O => MD_30_ENABLE
    );
  MD_30_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_30_TORGTS
    );
  MD_30_OUTMUX_37 : X_BUF
    port map (
      I => MD_30,
      O => MD_30_OUTMUX
    );
  MD_30_OMUX : X_BUF
    port map (
      I => dh(14),
      O => MD_30_OD
    );
  MD_15_OBUF : X_TRI
    port map (
      I => MD_15_OUTMUX,
      CTL => MD_15_ENABLE,
      O => MD(15)
    );
  MD_15_ENABLEINV : X_INV
    port map (
      I => MD_15_TORGTS,
      O => MD_15_ENABLE
    );
  MD_15_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_15_TORGTS
    );
  MD_15_OUTMUX_38 : X_BUF
    port map (
      I => MD_15,
      O => MD_15_OUTMUX
    );
  MD_15_OMUX : X_BUF
    port map (
      I => dl(15),
      O => MD_15_OD
    );
  MD_23_OBUF : X_TRI
    port map (
      I => MD_23_OUTMUX,
      CTL => MD_23_ENABLE,
      O => MD(23)
    );
  MD_23_ENABLEINV : X_INV
    port map (
      I => MD_23_TORGTS,
      O => MD_23_ENABLE
    );
  MD_23_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_23_TORGTS
    );
  MD_23_OUTMUX_39 : X_BUF
    port map (
      I => MD_23,
      O => MD_23_OUTMUX
    );
  MD_23_OMUX : X_BUF
    port map (
      I => dh(7),
      O => MD_23_OD
    );
  MD_31_OBUF : X_TRI
    port map (
      I => MD_31_OUTMUX,
      CTL => MD_31_ENABLE,
      O => MD(31)
    );
  MD_31_ENABLEINV : X_INV
    port map (
      I => MD_31_TORGTS,
      O => MD_31_ENABLE
    );
  MD_31_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_31_TORGTS
    );
  MD_31_OUTMUX_40 : X_BUF
    port map (
      I => MD_31,
      O => MD_31_OUTMUX
    );
  MD_31_OMUX : X_BUF
    port map (
      I => dh(15),
      O => MD_31_OD
    );
  MD_16_OBUF : X_TRI
    port map (
      I => MD_16_OUTMUX,
      CTL => MD_16_ENABLE,
      O => MD(16)
    );
  MD_16_ENABLEINV : X_INV
    port map (
      I => MD_16_TORGTS,
      O => MD_16_ENABLE
    );
  MD_16_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_16_TORGTS
    );
  MD_16_OUTMUX_41 : X_BUF
    port map (
      I => MD_16,
      O => MD_16_OUTMUX
    );
  MD_16_OMUX : X_BUF
    port map (
      I => dh(0),
      O => MD_16_OD
    );
  MD_24_OBUF : X_TRI
    port map (
      I => MD_24_OUTMUX,
      CTL => MD_24_ENABLE,
      O => MD(24)
    );
  MD_24_ENABLEINV : X_INV
    port map (
      I => MD_24_TORGTS,
      O => MD_24_ENABLE
    );
  MD_24_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_24_TORGTS
    );
  MD_24_OUTMUX_42 : X_BUF
    port map (
      I => MD_24,
      O => MD_24_OUTMUX
    );
  MD_24_OMUX : X_BUF
    port map (
      I => dh(8),
      O => MD_24_OD
    );
  MD_17_OBUF : X_TRI
    port map (
      I => MD_17_OUTMUX,
      CTL => MD_17_ENABLE,
      O => MD(17)
    );
  MD_17_ENABLEINV : X_INV
    port map (
      I => MD_17_TORGTS,
      O => MD_17_ENABLE
    );
  MD_17_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_17_TORGTS
    );
  MD_17_OUTMUX_43 : X_BUF
    port map (
      I => MD_17,
      O => MD_17_OUTMUX
    );
  MD_17_OMUX : X_BUF
    port map (
      I => dh(1),
      O => MD_17_OD
    );
  dinl_4 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_4_IDELAY,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => DIN_4_IFF_RST,
      O => dinl(4)
    );
  DIN_4_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_4_IFF_RST
    );
  cs_FFd10_In_SW0 : X_LUT4
    generic map(
      INIT => X"AEAE"
    )
    port map (
      ADR0 => cs_FFd11,
      ADR1 => cs_FFd10,
      ADR2 => den,
      ADR3 => VCC,
      O => N3593_FROM
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
      O => N3593_GROM
    );
  N3593_XUSED : X_BUF
    port map (
      I => N3593_FROM,
      O => N3593
    );
  N3593_YUSED : X_BUF
    port map (
      I => N3593_GROM,
      O => CHOICE18
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
      O => CHOICE48_FROM
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
      O => CHOICE48_GROM
    );
  CHOICE48_XUSED : X_BUF
    port map (
      I => CHOICE48_FROM,
      O => CHOICE48
    );
  CHOICE48_YUSED : X_BUF
    port map (
      I => CHOICE48_GROM,
      O => CHOICE29
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
      O => CHOICE55_FROM
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
      O => CHOICE55_GROM
    );
  CHOICE55_XUSED : X_BUF
    port map (
      I => CHOICE55_FROM,
      O => CHOICE55
    );
  CHOICE55_YUSED : X_BUF
    port map (
      I => CHOICE55_GROM,
      O => CHOICE32
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
      O => cs_FFd12_1_FROM
    );
  cs_FFd12_In38 : X_LUT4
    generic map(
      INIT => X"FF54"
    )
    port map (
      ADR0 => newfint,
      ADR1 => CHOICE15,
      ADR2 => CHOICE18,
      ADR3 => CHOICE25,
      O => cs_FFd12_1_GROM
    );
  cs_FFd12_1_XUSED : X_BUF
    port map (
      I => cs_FFd12_1_FROM,
      O => CHOICE25
    );
  cs_FFd12_1_YUSED : X_BUF
    port map (
      I => cs_FFd12_1_GROM,
      O => cs_FFd12_In
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
      O => CHOICE70_FROM
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
      O => CHOICE70_GROM
    );
  CHOICE70_XUSED : X_BUF
    port map (
      I => CHOICE70_FROM,
      O => CHOICE70
    );
  CHOICE70_YUSED : X_BUF
    port map (
      I => CHOICE70_GROM,
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
      O => CHOICE63_GROM
    );
  CHOICE63_YUSED : X_BUF
    port map (
      I => CHOICE63_GROM,
      O => CHOICE63
    );
  enable_LOGIC_ONE_44 : X_ONE
    port map (
      O => enable_LOGIC_ONE
    );
  dinl_5 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_5_IDELAY,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => DIN_5_IFF_RST,
      O => dinl(5)
    );
  DIN_5_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_5_IFF_RST
    );
  dl_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dl_3_FFY_RST
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
      SET => GND,
      RST => dl_3_FFY_RST,
      O => dl(2)
    );
  dl_5_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dl_5_FFY_RST
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
      SET => GND,
      RST => dl_5_FFY_RST,
      O => dl(4)
    );
  dl_7_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dl_7_FFY_RST
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
      SET => GND,
      RST => dl_7_FFY_RST,
      O => dl(6)
    );
  cs_Out51_1_45 : X_LUT4
    generic map(
      INIT => X"FEFE"
    )
    port map (
      ADR0 => cs_FFd11,
      ADR1 => cs_FFd6,
      ADR2 => cs_FFd4,
      ADR3 => VCC,
      O => cs_Out51_1_FROM
    );
  cs_Out51 : X_LUT4
    generic map(
      INIT => X"FEFE"
    )
    port map (
      ADR0 => cs_FFd11,
      ADR1 => cs_FFd6,
      ADR2 => cs_FFd4,
      ADR3 => VCC,
      O => cs_Out51_1_GROM
    );
  cs_Out51_1_XUSED : X_BUF
    port map (
      I => cs_Out51_1_FROM,
      O => cs_Out51_1
    );
  cs_Out51_1_YUSED : X_BUF
    port map (
      I => cs_Out51_1_GROM,
      O => mrw
    );
  dinl_6 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_6_IDELAY,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => DIN_6_IFF_RST,
      O => dinl(6)
    );
  DIN_6_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_6_IFF_RST
    );
  DONE_OBUF : X_TRI
    port map (
      I => DONE_OUTMUX,
      CTL => DONE_ENABLE,
      O => DONE
    );
  DONE_ENABLEINV : X_INV
    port map (
      I => DONE_TORGTS,
      O => DONE_ENABLE
    );
  DONE_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => DONE_TORGTS
    );
  DONE_OUTMUX_46 : X_BUF
    port map (
      I => cs_FFd1,
      O => DONE_OUTMUX
    );
  DONE_OMUX : X_BUF
    port map (
      I => cs_FFd2,
      O => DONE_OD
    );
  FIFOFULL_ICEMUX : X_INV
    port map (
      I => RESET_IBUF,
      O => FIFOFULL_ICEMUXNOT
    );
  FIFOFULL_IBUF_47 : X_BUF
    port map (
      I => FIFOFULL,
      O => FIFOFULL_IBUF
    );
  FIFOFULL_DELAY : X_BUF
    port map (
      I => FIFOFULL_IBUF,
      O => FIFOFULL_IDELAY
    );
  MA_0_OBUF : X_TRI
    port map (
      I => MA_0_OUTMUX,
      CTL => MA_0_ENABLE,
      O => MA(0)
    );
  MA_0_ENABLEINV : X_INV
    port map (
      I => MA_0_TORGTS,
      O => MA_0_ENABLE
    );
  MA_0_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MA_0_TORGTS
    );
  MA_0_OUTMUX_48 : X_BUF
    port map (
      I => MA_0,
      O => MA_0_OUTMUX
    );
  MA_0_OMUX : X_BUF
    port map (
      I => addr(0),
      O => MA_0_OD
    );
  MA_1_OBUF : X_TRI
    port map (
      I => MA_1_OUTMUX,
      CTL => MA_1_ENABLE,
      O => MA(1)
    );
  MA_1_ENABLEINV : X_INV
    port map (
      I => MA_1_TORGTS,
      O => MA_1_ENABLE
    );
  MA_1_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MA_1_TORGTS
    );
  MA_1_OUTMUX_49 : X_BUF
    port map (
      I => MA_1,
      O => MA_1_OUTMUX
    );
  MA_1_OMUX : X_BUF
    port map (
      I => addr(1),
      O => MA_1_OD
    );
  MA_2_OBUF : X_TRI
    port map (
      I => MA_2_OUTMUX,
      CTL => MA_2_ENABLE,
      O => MA(2)
    );
  MA_2_ENABLEINV : X_INV
    port map (
      I => MA_2_TORGTS,
      O => MA_2_ENABLE
    );
  MA_2_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MA_2_TORGTS
    );
  MA_2_OUTMUX_50 : X_BUF
    port map (
      I => MA_2,
      O => MA_2_OUTMUX
    );
  MA_2_OMUX : X_BUF
    port map (
      I => addr(2),
      O => MA_2_OD
    );
  MA_3_OBUF : X_TRI
    port map (
      I => MA_3_OUTMUX,
      CTL => MA_3_ENABLE,
      O => MA(3)
    );
  MA_3_ENABLEINV : X_INV
    port map (
      I => MA_3_TORGTS,
      O => MA_3_ENABLE
    );
  MA_3_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MA_3_TORGTS
    );
  MA_3_OUTMUX_51 : X_BUF
    port map (
      I => MA_3,
      O => MA_3_OUTMUX
    );
  MA_3_OMUX : X_BUF
    port map (
      I => addr(3),
      O => MA_3_OD
    );
  dinl_7 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_7_IDELAY,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => DIN_7_IFF_RST,
      O => dinl(7)
    );
  DIN_7_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_7_IFF_RST
    );
  MA_4_OBUF : X_TRI
    port map (
      I => MA_4_OUTMUX,
      CTL => MA_4_ENABLE,
      O => MA(4)
    );
  MA_4_ENABLEINV : X_INV
    port map (
      I => MA_4_TORGTS,
      O => MA_4_ENABLE
    );
  MA_4_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MA_4_TORGTS
    );
  MA_4_OUTMUX_52 : X_BUF
    port map (
      I => MA_4,
      O => MA_4_OUTMUX
    );
  MA_4_OMUX : X_BUF
    port map (
      I => addr(4),
      O => MA_4_OD
    );
  MA_5_OBUF : X_TRI
    port map (
      I => MA_5_OUTMUX,
      CTL => MA_5_ENABLE,
      O => MA(5)
    );
  MA_5_ENABLEINV : X_INV
    port map (
      I => MA_5_TORGTS,
      O => MA_5_ENABLE
    );
  MA_5_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MA_5_TORGTS
    );
  MA_5_OUTMUX_53 : X_BUF
    port map (
      I => MA_5,
      O => MA_5_OUTMUX
    );
  MA_5_OMUX : X_BUF
    port map (
      I => addr(5),
      O => MA_5_OD
    );
  TXFIFOWERR_OBUF : X_TRI
    port map (
      I => TXFIFOWERR_OUTMUX,
      CTL => TXFIFOWERR_ENABLE,
      O => TXFIFOWERR
    );
  TXFIFOWERR_ENABLEINV : X_INV
    port map (
      I => TXFIFOWERR_TORGTS,
      O => TXFIFOWERR_ENABLE
    );
  TXFIFOWERR_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => TXFIFOWERR_TORGTS
    );
  TXFIFOWERR_OUTMUX_54 : X_BUF
    port map (
      I => cs_FFd3,
      O => TXFIFOWERR_OUTMUX
    );
  TXFIFOWERR_OMUX : X_BUF
    port map (
      I => cs_FFd3_In,
      O => TXFIFOWERR_OD
    );
  MA_6_OBUF : X_TRI
    port map (
      I => MA_6_OUTMUX,
      CTL => MA_6_ENABLE,
      O => MA(6)
    );
  MA_6_ENABLEINV : X_INV
    port map (
      I => MA_6_TORGTS,
      O => MA_6_ENABLE
    );
  MA_6_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MA_6_TORGTS
    );
  MA_6_OUTMUX_55 : X_BUF
    port map (
      I => MA_6,
      O => MA_6_OUTMUX
    );
  MA_6_OMUX : X_BUF
    port map (
      I => addr(6),
      O => MA_6_OD
    );
  MA_7_OBUF : X_TRI
    port map (
      I => MA_7_OUTMUX,
      CTL => MA_7_ENABLE,
      O => MA(7)
    );
  MA_7_ENABLEINV : X_INV
    port map (
      I => MA_7_TORGTS,
      O => MA_7_ENABLE
    );
  MA_7_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MA_7_TORGTS
    );
  MA_7_OUTMUX_56 : X_BUF
    port map (
      I => MA_7,
      O => MA_7_OUTMUX
    );
  MA_7_OMUX : X_BUF
    port map (
      I => addr(7),
      O => MA_7_OD
    );
  MA_8_OBUF : X_TRI
    port map (
      I => MA_8_OUTMUX,
      CTL => MA_8_ENABLE,
      O => MA(8)
    );
  MA_8_ENABLEINV : X_INV
    port map (
      I => MA_8_TORGTS,
      O => MA_8_ENABLE
    );
  MA_8_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MA_8_TORGTS
    );
  MA_8_OUTMUX_57 : X_BUF
    port map (
      I => MA_8,
      O => MA_8_OUTMUX
    );
  MA_8_OMUX : X_BUF
    port map (
      I => addr(8),
      O => MA_8_OD
    );
  MA_9_OBUF : X_TRI
    port map (
      I => MA_9_OUTMUX,
      CTL => MA_9_ENABLE,
      O => MA(9)
    );
  MA_9_ENABLEINV : X_INV
    port map (
      I => MA_9_TORGTS,
      O => MA_9_ENABLE
    );
  MA_9_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MA_9_TORGTS
    );
  MA_9_OUTMUX_58 : X_BUF
    port map (
      I => MA_9,
      O => MA_9_OUTMUX
    );
  MA_9_OMUX : X_BUF
    port map (
      I => addr(9),
      O => MA_9_OD
    );
  MD_0_OBUF : X_TRI
    port map (
      I => MD_0_OUTMUX,
      CTL => MD_0_ENABLE,
      O => MD(0)
    );
  MD_0_ENABLEINV : X_INV
    port map (
      I => MD_0_TORGTS,
      O => MD_0_ENABLE
    );
  MD_0_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_0_TORGTS
    );
  MD_0_OUTMUX_59 : X_BUF
    port map (
      I => MD_0,
      O => MD_0_OUTMUX
    );
  MD_0_OMUX : X_BUF
    port map (
      I => dl(0),
      O => MD_0_OD
    );
  MD_25_OBUF : X_TRI
    port map (
      I => MD_25_OUTMUX,
      CTL => MD_25_ENABLE,
      O => MD(25)
    );
  MD_25_ENABLEINV : X_INV
    port map (
      I => MD_25_TORGTS,
      O => MD_25_ENABLE
    );
  MD_25_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_25_TORGTS
    );
  MD_25_OUTMUX_60 : X_BUF
    port map (
      I => MD_25,
      O => MD_25_OUTMUX
    );
  MD_25_OMUX : X_BUF
    port map (
      I => dh(9),
      O => MD_25_OD
    );
  BPOUT_0_OBUF : X_TRI
    port map (
      I => BPOUT_0_OUTMUX,
      CTL => BPOUT_0_ENABLE,
      O => BPOUT(0)
    );
  BPOUT_0_ENABLEINV : X_INV
    port map (
      I => BPOUT_0_TORGTS,
      O => BPOUT_0_ENABLE
    );
  BPOUT_0_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => BPOUT_0_TORGTS
    );
  BPOUT_0_OUTMUX_61 : X_BUF
    port map (
      I => bp(0),
      O => BPOUT_0_OUTMUX
    );
  BPOUT_0_OMUX : X_BUF
    port map (
      I => addr(0),
      O => BPOUT_0_OD
    );
  BPOUT_1_OBUF : X_TRI
    port map (
      I => BPOUT_1_OUTMUX,
      CTL => BPOUT_1_ENABLE,
      O => BPOUT(1)
    );
  BPOUT_1_ENABLEINV : X_INV
    port map (
      I => BPOUT_1_TORGTS,
      O => BPOUT_1_ENABLE
    );
  BPOUT_1_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => BPOUT_1_TORGTS
    );
  BPOUT_1_OUTMUX_62 : X_BUF
    port map (
      I => bp(1),
      O => BPOUT_1_OUTMUX
    );
  BPOUT_1_OMUX : X_BUF
    port map (
      I => addr(1),
      O => BPOUT_1_OD
    );
  MD_18_OBUF : X_TRI
    port map (
      I => MD_18_OUTMUX,
      CTL => MD_18_ENABLE,
      O => MD(18)
    );
  MD_18_ENABLEINV : X_INV
    port map (
      I => MD_18_TORGTS,
      O => MD_18_ENABLE
    );
  MD_18_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_18_TORGTS
    );
  MD_18_OUTMUX_63 : X_BUF
    port map (
      I => MD_18,
      O => MD_18_OUTMUX
    );
  MD_18_OMUX : X_BUF
    port map (
      I => dh(2),
      O => MD_18_OD
    );
  MD_26_OBUF : X_TRI
    port map (
      I => MD_26_OUTMUX,
      CTL => MD_26_ENABLE,
      O => MD(26)
    );
  MD_26_ENABLEINV : X_INV
    port map (
      I => MD_26_TORGTS,
      O => MD_26_ENABLE
    );
  MD_26_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_26_TORGTS
    );
  MD_26_OUTMUX_64 : X_BUF
    port map (
      I => MD_26,
      O => MD_26_OUTMUX
    );
  MD_26_OMUX : X_BUF
    port map (
      I => dh(10),
      O => MD_26_OD
    );
  BPOUT_2_OBUF : X_TRI
    port map (
      I => BPOUT_2_OUTMUX,
      CTL => BPOUT_2_ENABLE,
      O => BPOUT(2)
    );
  BPOUT_2_ENABLEINV : X_INV
    port map (
      I => BPOUT_2_TORGTS,
      O => BPOUT_2_ENABLE
    );
  BPOUT_2_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => BPOUT_2_TORGTS
    );
  BPOUT_2_OUTMUX_65 : X_BUF
    port map (
      I => bp(2),
      O => BPOUT_2_OUTMUX
    );
  BPOUT_2_OMUX : X_BUF
    port map (
      I => addr(2),
      O => BPOUT_2_OD
    );
  MD_19_OBUF : X_TRI
    port map (
      I => MD_19_OUTMUX,
      CTL => MD_19_ENABLE,
      O => MD(19)
    );
  MD_19_ENABLEINV : X_INV
    port map (
      I => MD_19_TORGTS,
      O => MD_19_ENABLE
    );
  MD_19_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_19_TORGTS
    );
  MD_19_OUTMUX_66 : X_BUF
    port map (
      I => MD_19,
      O => MD_19_OUTMUX
    );
  MD_19_OMUX : X_BUF
    port map (
      I => dh(3),
      O => MD_19_OD
    );
  MD_27_OBUF : X_TRI
    port map (
      I => MD_27_OUTMUX,
      CTL => MD_27_ENABLE,
      O => MD(27)
    );
  MD_27_ENABLEINV : X_INV
    port map (
      I => MD_27_TORGTS,
      O => MD_27_ENABLE
    );
  MD_27_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_27_TORGTS
    );
  MD_27_OUTMUX_67 : X_BUF
    port map (
      I => MD_27,
      O => MD_27_OUTMUX
    );
  MD_27_OMUX : X_BUF
    port map (
      I => dh(11),
      O => MD_27_OD
    );
  BPOUT_3_OBUF : X_TRI
    port map (
      I => BPOUT_3_OUTMUX,
      CTL => BPOUT_3_ENABLE,
      O => BPOUT(3)
    );
  BPOUT_3_ENABLEINV : X_INV
    port map (
      I => BPOUT_3_TORGTS,
      O => BPOUT_3_ENABLE
    );
  BPOUT_3_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => BPOUT_3_TORGTS
    );
  BPOUT_3_OUTMUX_68 : X_BUF
    port map (
      I => bp(3),
      O => BPOUT_3_OUTMUX
    );
  BPOUT_3_OMUX : X_BUF
    port map (
      I => addr(3),
      O => BPOUT_3_OD
    );
  MD_28_OBUF : X_TRI
    port map (
      I => MD_28_OUTMUX,
      CTL => MD_28_ENABLE,
      O => MD(28)
    );
  MD_28_ENABLEINV : X_INV
    port map (
      I => MD_28_TORGTS,
      O => MD_28_ENABLE
    );
  MD_28_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_28_TORGTS
    );
  MD_28_OUTMUX_69 : X_BUF
    port map (
      I => MD_28,
      O => MD_28_OUTMUX
    );
  MD_28_OMUX : X_BUF
    port map (
      I => dh(12),
      O => MD_28_OD
    );
  MA_14_70 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MA_14_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MA_14_OFF_RST,
      O => MA_14
    );
  MA_14_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_14_OFF_RST
    );
  BPOUT_4_OBUF : X_TRI
    port map (
      I => BPOUT_4_OUTMUX,
      CTL => BPOUT_4_ENABLE,
      O => BPOUT(4)
    );
  BPOUT_4_ENABLEINV : X_INV
    port map (
      I => BPOUT_4_TORGTS,
      O => BPOUT_4_ENABLE
    );
  BPOUT_4_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => BPOUT_4_TORGTS
    );
  BPOUT_4_OUTMUX_71 : X_BUF
    port map (
      I => bp(4),
      O => BPOUT_4_OUTMUX
    );
  BPOUT_4_OMUX : X_BUF
    port map (
      I => addr(4),
      O => BPOUT_4_OD
    );
  MD_29_OBUF : X_TRI
    port map (
      I => MD_29_OUTMUX,
      CTL => MD_29_ENABLE,
      O => MD(29)
    );
  MD_29_ENABLEINV : X_INV
    port map (
      I => MD_29_TORGTS,
      O => MD_29_ENABLE
    );
  MD_29_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_29_TORGTS
    );
  MD_29_OUTMUX_72 : X_BUF
    port map (
      I => MD_29,
      O => MD_29_OUTMUX
    );
  MD_29_OMUX : X_BUF
    port map (
      I => dh(13),
      O => MD_29_OD
    );
  BPOUT_5_OBUF : X_TRI
    port map (
      I => BPOUT_5_OUTMUX,
      CTL => BPOUT_5_ENABLE,
      O => BPOUT(5)
    );
  BPOUT_5_ENABLEINV : X_INV
    port map (
      I => BPOUT_5_TORGTS,
      O => BPOUT_5_ENABLE
    );
  BPOUT_5_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => BPOUT_5_TORGTS
    );
  BPOUT_5_OUTMUX_73 : X_BUF
    port map (
      I => bp(5),
      O => BPOUT_5_OUTMUX
    );
  BPOUT_5_OMUX : X_BUF
    port map (
      I => addr(5),
      O => BPOUT_5_OD
    );
  BPOUT_6_OBUF : X_TRI
    port map (
      I => BPOUT_6_OUTMUX,
      CTL => BPOUT_6_ENABLE,
      O => BPOUT(6)
    );
  BPOUT_6_ENABLEINV : X_INV
    port map (
      I => BPOUT_6_TORGTS,
      O => BPOUT_6_ENABLE
    );
  BPOUT_6_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => BPOUT_6_TORGTS
    );
  BPOUT_6_OUTMUX_74 : X_BUF
    port map (
      I => bp(6),
      O => BPOUT_6_OUTMUX
    );
  BPOUT_6_OMUX : X_BUF
    port map (
      I => addr(6),
      O => BPOUT_6_OD
    );
  BPOUT_7_OBUF : X_TRI
    port map (
      I => BPOUT_7_OUTMUX,
      CTL => BPOUT_7_ENABLE,
      O => BPOUT(7)
    );
  BPOUT_7_ENABLEINV : X_INV
    port map (
      I => BPOUT_7_TORGTS,
      O => BPOUT_7_ENABLE
    );
  BPOUT_7_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => BPOUT_7_TORGTS
    );
  BPOUT_7_OUTMUX_75 : X_BUF
    port map (
      I => bp(7),
      O => BPOUT_7_OUTMUX
    );
  BPOUT_7_OMUX : X_BUF
    port map (
      I => addr(7),
      O => BPOUT_7_OD
    );
  BPOUT_8_OBUF : X_TRI
    port map (
      I => BPOUT_8_OUTMUX,
      CTL => BPOUT_8_ENABLE,
      O => BPOUT(8)
    );
  BPOUT_8_ENABLEINV : X_INV
    port map (
      I => BPOUT_8_TORGTS,
      O => BPOUT_8_ENABLE
    );
  BPOUT_8_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => BPOUT_8_TORGTS
    );
  BPOUT_8_OUTMUX_76 : X_BUF
    port map (
      I => bp(8),
      O => BPOUT_8_OUTMUX
    );
  BPOUT_8_OMUX : X_BUF
    port map (
      I => addr(8),
      O => BPOUT_8_OD
    );
  BPOUT_9_OBUF : X_TRI
    port map (
      I => BPOUT_9_OUTMUX,
      CTL => BPOUT_9_ENABLE,
      O => BPOUT(9)
    );
  BPOUT_9_ENABLEINV : X_INV
    port map (
      I => BPOUT_9_TORGTS,
      O => BPOUT_9_ENABLE
    );
  BPOUT_9_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => BPOUT_9_TORGTS
    );
  BPOUT_9_OUTMUX_77 : X_BUF
    port map (
      I => bp(9),
      O => BPOUT_9_OUTMUX
    );
  BPOUT_9_OMUX : X_BUF
    port map (
      I => addr(9),
      O => BPOUT_9_OD
    );
  RESET_IMUX : X_BUF
    port map (
      I => RESET_IBUF_0,
      O => RESET_IBUF
    );
  RESET_IBUF_78 : X_BUF
    port map (
      I => RESET,
      O => RESET_IBUF_0
    );
  MWEN_OBUF_79 : X_TRI
    port map (
      I => MWEN_OUTMUX,
      CTL => MWEN_ENABLE,
      O => MWEN
    );
  MWEN_ENABLEINV : X_INV
    port map (
      I => MWEN_TORGTS,
      O => MWEN_ENABLE
    );
  MWEN_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MWEN_TORGTS
    );
  MWEN_OUTMUX_80 : X_BUF
    port map (
      I => MWEN_OBUF,
      O => MWEN_OUTMUX
    );
  MWEN_OMUX : X_BUF
    port map (
      I => cs_Out51_1,
      O => MWEN_OD
    );
  DIN_10_IBUF_81 : X_BUF
    port map (
      I => DIN(10),
      O => DIN_10_IBUF
    );
  DIN_10_DELAY : X_BUF
    port map (
      I => DIN_10_IBUF,
      O => DIN_10_IDELAY
    );
  DIN_11_IBUF_82 : X_BUF
    port map (
      I => DIN(11),
      O => DIN_11_IBUF
    );
  DIN_11_DELAY : X_BUF
    port map (
      I => DIN_11_IBUF,
      O => DIN_11_IDELAY
    );
  DIN_12_IBUF_83 : X_BUF
    port map (
      I => DIN(12),
      O => DIN_12_IBUF
    );
  DIN_12_DELAY : X_BUF
    port map (
      I => DIN_12_IBUF,
      O => DIN_12_IDELAY
    );
  DIN_13_IBUF_84 : X_BUF
    port map (
      I => DIN(13),
      O => DIN_13_IBUF
    );
  DIN_13_DELAY : X_BUF
    port map (
      I => DIN_13_IBUF,
      O => DIN_13_IDELAY
    );
  DIN_14_IBUF_85 : X_BUF
    port map (
      I => DIN(14),
      O => DIN_14_IBUF
    );
  DIN_14_DELAY : X_BUF
    port map (
      I => DIN_14_IBUF,
      O => DIN_14_IDELAY
    );
  DIN_15_IBUF_86 : X_BUF
    port map (
      I => DIN(15),
      O => DIN_15_IBUF
    );
  DIN_15_DELAY : X_BUF
    port map (
      I => DIN_15_IBUF,
      O => DIN_15_IDELAY
    );
  BPOUT_10_OBUF : X_TRI
    port map (
      I => BPOUT_10_OUTMUX,
      CTL => BPOUT_10_ENABLE,
      O => BPOUT(10)
    );
  BPOUT_10_ENABLEINV : X_INV
    port map (
      I => BPOUT_10_TORGTS,
      O => BPOUT_10_ENABLE
    );
  BPOUT_10_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => BPOUT_10_TORGTS
    );
  BPOUT_10_OUTMUX_87 : X_BUF
    port map (
      I => bp(10),
      O => BPOUT_10_OUTMUX
    );
  BPOUT_10_OMUX : X_BUF
    port map (
      I => addr(10),
      O => BPOUT_10_OD
    );
  MA_15_88 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MA_15_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MA_15_OFF_RST,
      O => MA_15
    );
  MA_15_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_15_OFF_RST
    );
  BPOUT_11_OBUF : X_TRI
    port map (
      I => BPOUT_11_OUTMUX,
      CTL => BPOUT_11_ENABLE,
      O => BPOUT(11)
    );
  BPOUT_11_ENABLEINV : X_INV
    port map (
      I => BPOUT_11_TORGTS,
      O => BPOUT_11_ENABLE
    );
  BPOUT_11_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => BPOUT_11_TORGTS
    );
  BPOUT_11_OUTMUX_89 : X_BUF
    port map (
      I => bp(11),
      O => BPOUT_11_OUTMUX
    );
  BPOUT_11_OMUX : X_BUF
    port map (
      I => addr(11),
      O => BPOUT_11_OD
    );
  BPOUT_12_OBUF : X_TRI
    port map (
      I => BPOUT_12_OUTMUX,
      CTL => BPOUT_12_ENABLE,
      O => BPOUT(12)
    );
  BPOUT_12_ENABLEINV : X_INV
    port map (
      I => BPOUT_12_TORGTS,
      O => BPOUT_12_ENABLE
    );
  BPOUT_12_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => BPOUT_12_TORGTS
    );
  BPOUT_12_OUTMUX_90 : X_BUF
    port map (
      I => bp(12),
      O => BPOUT_12_OUTMUX
    );
  BPOUT_12_OMUX : X_BUF
    port map (
      I => addr(12),
      O => BPOUT_12_OD
    );
  BPOUT_13_OBUF : X_TRI
    port map (
      I => BPOUT_13_OUTMUX,
      CTL => BPOUT_13_ENABLE,
      O => BPOUT(13)
    );
  BPOUT_13_ENABLEINV : X_INV
    port map (
      I => BPOUT_13_TORGTS,
      O => BPOUT_13_ENABLE
    );
  BPOUT_13_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => BPOUT_13_TORGTS
    );
  BPOUT_13_OUTMUX_91 : X_BUF
    port map (
      I => bp(13),
      O => BPOUT_13_OUTMUX
    );
  BPOUT_13_OMUX : X_BUF
    port map (
      I => addr(13),
      O => BPOUT_13_OD
    );
  BPOUT_14_OBUF : X_TRI
    port map (
      I => BPOUT_14_OUTMUX,
      CTL => BPOUT_14_ENABLE,
      O => BPOUT(14)
    );
  BPOUT_14_ENABLEINV : X_INV
    port map (
      I => BPOUT_14_TORGTS,
      O => BPOUT_14_ENABLE
    );
  BPOUT_14_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => BPOUT_14_TORGTS
    );
  BPOUT_14_OUTMUX_92 : X_BUF
    port map (
      I => bp(14),
      O => BPOUT_14_OUTMUX
    );
  BPOUT_14_OMUX : X_BUF
    port map (
      I => addr(14),
      O => BPOUT_14_OD
    );
  BPOUT_15_OBUF : X_TRI
    port map (
      I => BPOUT_15_OUTMUX,
      CTL => BPOUT_15_ENABLE,
      O => BPOUT(15)
    );
  BPOUT_15_ENABLEINV : X_INV
    port map (
      I => BPOUT_15_TORGTS,
      O => BPOUT_15_ENABLE
    );
  BPOUT_15_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => BPOUT_15_TORGTS
    );
  BPOUT_15_OUTMUX_93 : X_BUF
    port map (
      I => bp(15),
      O => BPOUT_15_OUTMUX
    );
  BPOUT_15_OMUX : X_BUF
    port map (
      I => addr(15),
      O => BPOUT_15_OD
    );
  Q_n0081_0_LOGIC_ONE_94 : X_ONE
    port map (
      O => Q_n0081_0_LOGIC_ONE
    );
  Msub_n0041_inst_cy_0_95 : X_MUX2
    port map (
      IA => CNT(0),
      IB => Q_n0081_0_CYINIT,
      SEL => Msub_n0041_inst_lut2_0,
      O => Msub_n0041_inst_cy_0
    );
  Msub_n0041_inst_sum_0 : X_XOR2
    port map (
      I0 => Q_n0081_0_CYINIT,
      I1 => Msub_n0041_inst_lut2_0,
      O => Q_n0081_0_XORF
    );
  Msub_n0041_inst_lut2_01 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => CNT(0),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Msub_n0041_inst_lut2_0
    );
  Q_n0081_0_G : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => GLOBAL_LOGIC0,
      ADR1 => CNT(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => Q_n0081_0_GROM
    );
  Q_n0081_0_COUTUSED : X_BUF
    port map (
      I => Q_n0081_0_CYMUXG,
      O => Msub_n0041_inst_cy_1
    );
  Q_n0081_0_XUSED : X_BUF
    port map (
      I => Q_n0081_0_XORF,
      O => Q_n0081(0)
    );
  Q_n0081_0_YUSED : X_BUF
    port map (
      I => Q_n0081_0_XORG,
      O => Q_n0081(1)
    );
  Msub_n0041_inst_cy_1_96 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC0,
      IB => Msub_n0041_inst_cy_0,
      SEL => Q_n0081_0_GROM,
      O => Q_n0081_0_CYMUXG
    );
  Msub_n0041_inst_sum_1 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_cy_0,
      I1 => Q_n0081_0_GROM,
      O => Q_n0081_0_XORG
    );
  Q_n0081_0_CYINIT_97 : X_BUF
    port map (
      I => Q_n0081_0_LOGIC_ONE,
      O => Q_n0081_0_CYINIT
    );
  Msub_n0041_inst_cy_2_98 : X_MUX2
    port map (
      IA => CNT(2),
      IB => Q_n0081_2_CYINIT,
      SEL => Msub_n0041_inst_lut2_2,
      O => Msub_n0041_inst_cy_2
    );
  Msub_n0041_inst_sum_2 : X_XOR2
    port map (
      I0 => Q_n0081_2_CYINIT,
      I1 => Msub_n0041_inst_lut2_2,
      O => Q_n0081_2_XORF
    );
  Msub_n0041_inst_lut2_21 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => CNT(2),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Msub_n0041_inst_lut2_2
    );
  Msub_n0041_inst_lut2_31 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => CNT(3),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Msub_n0041_inst_lut2_3
    );
  Q_n0081_2_COUTUSED : X_BUF
    port map (
      I => Q_n0081_2_CYMUXG,
      O => Msub_n0041_inst_cy_3
    );
  Q_n0081_2_XUSED : X_BUF
    port map (
      I => Q_n0081_2_XORF,
      O => Q_n0081(2)
    );
  Q_n0081_2_YUSED : X_BUF
    port map (
      I => Q_n0081_2_XORG,
      O => Q_n0081(3)
    );
  Msub_n0041_inst_cy_3_99 : X_MUX2
    port map (
      IA => CNT(3),
      IB => Msub_n0041_inst_cy_2,
      SEL => Msub_n0041_inst_lut2_3,
      O => Q_n0081_2_CYMUXG
    );
  Msub_n0041_inst_sum_3 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_cy_2,
      I1 => Msub_n0041_inst_lut2_3,
      O => Q_n0081_2_XORG
    );
  Q_n0081_2_CYINIT_100 : X_BUF
    port map (
      I => Msub_n0041_inst_cy_1,
      O => Q_n0081_2_CYINIT
    );
  Msub_n0041_inst_cy_4_101 : X_MUX2
    port map (
      IA => CNT(4),
      IB => Q_n0081_4_CYINIT,
      SEL => Msub_n0041_inst_lut2_4,
      O => Msub_n0041_inst_cy_4
    );
  Msub_n0041_inst_sum_4 : X_XOR2
    port map (
      I0 => Q_n0081_4_CYINIT,
      I1 => Msub_n0041_inst_lut2_4,
      O => Q_n0081_4_XORF
    );
  Msub_n0041_inst_lut2_41 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => CNT(4),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Msub_n0041_inst_lut2_4
    );
  Msub_n0041_inst_lut2_51 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => CNT(5),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Msub_n0041_inst_lut2_5
    );
  Q_n0081_4_COUTUSED : X_BUF
    port map (
      I => Q_n0081_4_CYMUXG,
      O => Msub_n0041_inst_cy_5
    );
  Q_n0081_4_XUSED : X_BUF
    port map (
      I => Q_n0081_4_XORF,
      O => Q_n0081(4)
    );
  Q_n0081_4_YUSED : X_BUF
    port map (
      I => Q_n0081_4_XORG,
      O => Q_n0081(5)
    );
  Msub_n0041_inst_cy_5_102 : X_MUX2
    port map (
      IA => CNT(5),
      IB => Msub_n0041_inst_cy_4,
      SEL => Msub_n0041_inst_lut2_5,
      O => Q_n0081_4_CYMUXG
    );
  Msub_n0041_inst_sum_5 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_cy_4,
      I1 => Msub_n0041_inst_lut2_5,
      O => Q_n0081_4_XORG
    );
  Q_n0081_4_CYINIT_103 : X_BUF
    port map (
      I => Msub_n0041_inst_cy_3,
      O => Q_n0081_4_CYINIT
    );
  Msub_n0041_inst_cy_6_104 : X_MUX2
    port map (
      IA => CNT(6),
      IB => Q_n0081_6_CYINIT,
      SEL => Msub_n0041_inst_lut2_6,
      O => Msub_n0041_inst_cy_6
    );
  Msub_n0041_inst_sum_6 : X_XOR2
    port map (
      I0 => Q_n0081_6_CYINIT,
      I1 => Msub_n0041_inst_lut2_6,
      O => Q_n0081_6_XORF
    );
  Msub_n0041_inst_lut2_61 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => CNT(6),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Msub_n0041_inst_lut2_6
    );
  Msub_n0041_inst_lut2_71 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => CNT(7),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Msub_n0041_inst_lut2_7
    );
  Q_n0081_6_COUTUSED : X_BUF
    port map (
      I => Q_n0081_6_CYMUXG,
      O => Msub_n0041_inst_cy_7
    );
  Q_n0081_6_XUSED : X_BUF
    port map (
      I => Q_n0081_6_XORF,
      O => Q_n0081(6)
    );
  Q_n0081_6_YUSED : X_BUF
    port map (
      I => Q_n0081_6_XORG,
      O => Q_n0081(7)
    );
  Msub_n0041_inst_cy_7_105 : X_MUX2
    port map (
      IA => CNT(7),
      IB => Msub_n0041_inst_cy_6,
      SEL => Msub_n0041_inst_lut2_7,
      O => Q_n0081_6_CYMUXG
    );
  Msub_n0041_inst_sum_7 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_cy_6,
      I1 => Msub_n0041_inst_lut2_7,
      O => Q_n0081_6_XORG
    );
  Q_n0081_6_CYINIT_106 : X_BUF
    port map (
      I => Msub_n0041_inst_cy_5,
      O => Q_n0081_6_CYINIT
    );
  Msub_n0041_inst_cy_8_107 : X_MUX2
    port map (
      IA => CNT(8),
      IB => Q_n0081_8_CYINIT,
      SEL => Msub_n0041_inst_lut2_8,
      O => Msub_n0041_inst_cy_8
    );
  Msub_n0041_inst_sum_8 : X_XOR2
    port map (
      I0 => Q_n0081_8_CYINIT,
      I1 => Msub_n0041_inst_lut2_8,
      O => Q_n0081_8_XORF
    );
  Msub_n0041_inst_lut2_81 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => CNT(8),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Msub_n0041_inst_lut2_8
    );
  Msub_n0041_inst_lut2_91 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => CNT(9),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Msub_n0041_inst_lut2_9
    );
  Q_n0081_8_COUTUSED : X_BUF
    port map (
      I => Q_n0081_8_CYMUXG,
      O => Msub_n0041_inst_cy_9
    );
  Q_n0081_8_XUSED : X_BUF
    port map (
      I => Q_n0081_8_XORF,
      O => Q_n0081(8)
    );
  Q_n0081_8_YUSED : X_BUF
    port map (
      I => Q_n0081_8_XORG,
      O => Q_n0081(9)
    );
  Msub_n0041_inst_cy_9_108 : X_MUX2
    port map (
      IA => CNT(9),
      IB => Msub_n0041_inst_cy_8,
      SEL => Msub_n0041_inst_lut2_9,
      O => Q_n0081_8_CYMUXG
    );
  Msub_n0041_inst_sum_9 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_cy_8,
      I1 => Msub_n0041_inst_lut2_9,
      O => Q_n0081_8_XORG
    );
  Q_n0081_8_CYINIT_109 : X_BUF
    port map (
      I => Msub_n0041_inst_cy_7,
      O => Q_n0081_8_CYINIT
    );
  Msub_n0041_inst_cy_10_110 : X_MUX2
    port map (
      IA => CNT(10),
      IB => Q_n0081_10_CYINIT,
      SEL => Msub_n0041_inst_lut2_10,
      O => Msub_n0041_inst_cy_10
    );
  Msub_n0041_inst_sum_10 : X_XOR2
    port map (
      I0 => Q_n0081_10_CYINIT,
      I1 => Msub_n0041_inst_lut2_10,
      O => Q_n0081_10_XORF
    );
  Msub_n0041_inst_lut2_101 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => CNT(10),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Msub_n0041_inst_lut2_10
    );
  Msub_n0041_inst_lut2_111 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => CNT(11),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Msub_n0041_inst_lut2_11
    );
  Q_n0081_10_COUTUSED : X_BUF
    port map (
      I => Q_n0081_10_CYMUXG,
      O => Msub_n0041_inst_cy_11
    );
  Q_n0081_10_XUSED : X_BUF
    port map (
      I => Q_n0081_10_XORF,
      O => Q_n0081(10)
    );
  Q_n0081_10_YUSED : X_BUF
    port map (
      I => Q_n0081_10_XORG,
      O => Q_n0081(11)
    );
  Msub_n0041_inst_cy_11_111 : X_MUX2
    port map (
      IA => CNT(11),
      IB => Msub_n0041_inst_cy_10,
      SEL => Msub_n0041_inst_lut2_11,
      O => Q_n0081_10_CYMUXG
    );
  Msub_n0041_inst_sum_11 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_cy_10,
      I1 => Msub_n0041_inst_lut2_11,
      O => Q_n0081_10_XORG
    );
  Q_n0081_10_CYINIT_112 : X_BUF
    port map (
      I => Msub_n0041_inst_cy_9,
      O => Q_n0081_10_CYINIT
    );
  Msub_n0041_inst_cy_12_113 : X_MUX2
    port map (
      IA => CNT(12),
      IB => Q_n0081_12_CYINIT,
      SEL => Msub_n0041_inst_lut2_12,
      O => Msub_n0041_inst_cy_12
    );
  Msub_n0041_inst_sum_12 : X_XOR2
    port map (
      I0 => Q_n0081_12_CYINIT,
      I1 => Msub_n0041_inst_lut2_12,
      O => Q_n0081_12_XORF
    );
  Msub_n0041_inst_lut2_121 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => CNT(12),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Msub_n0041_inst_lut2_12
    );
  Msub_n0041_inst_lut2_131 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => CNT(13),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Msub_n0041_inst_lut2_13
    );
  Q_n0081_12_COUTUSED : X_BUF
    port map (
      I => Q_n0081_12_CYMUXG,
      O => Msub_n0041_inst_cy_13
    );
  Q_n0081_12_XUSED : X_BUF
    port map (
      I => Q_n0081_12_XORF,
      O => Q_n0081(12)
    );
  Q_n0081_12_YUSED : X_BUF
    port map (
      I => Q_n0081_12_XORG,
      O => Q_n0081(13)
    );
  Msub_n0041_inst_cy_13_114 : X_MUX2
    port map (
      IA => CNT(13),
      IB => Msub_n0041_inst_cy_12,
      SEL => Msub_n0041_inst_lut2_13,
      O => Q_n0081_12_CYMUXG
    );
  Msub_n0041_inst_sum_13 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_cy_12,
      I1 => Msub_n0041_inst_lut2_13,
      O => Q_n0081_12_XORG
    );
  Q_n0081_12_CYINIT_115 : X_BUF
    port map (
      I => Msub_n0041_inst_cy_11,
      O => Q_n0081_12_CYINIT
    );
  Msub_n0041_inst_cy_14_116 : X_MUX2
    port map (
      IA => CNT(14),
      IB => Q_n0081_14_CYINIT,
      SEL => Msub_n0041_inst_lut2_14,
      O => Msub_n0041_inst_cy_14
    );
  Msub_n0041_inst_sum_14 : X_XOR2
    port map (
      I0 => Q_n0081_14_CYINIT,
      I1 => Msub_n0041_inst_lut2_14,
      O => Q_n0081_14_XORF
    );
  Msub_n0041_inst_lut2_141 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => CNT(14),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Msub_n0041_inst_lut2_14
    );
  Msub_n0041_inst_lut2_151 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => CNT(15),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Msub_n0041_inst_lut2_15
    );
  Q_n0081_14_XUSED : X_BUF
    port map (
      I => Q_n0081_14_XORF,
      O => Q_n0081(14)
    );
  Q_n0081_14_YUSED : X_BUF
    port map (
      I => Q_n0081_14_XORG,
      O => Q_n0081(15)
    );
  Msub_n0041_inst_sum_15 : X_XOR2
    port map (
      I0 => Msub_n0041_inst_cy_14,
      I1 => Msub_n0041_inst_lut2_15,
      O => Q_n0081_14_XORG
    );
  Q_n0081_14_CYINIT_117 : X_BUF
    port map (
      I => Msub_n0041_inst_cy_13,
      O => Q_n0081_14_CYINIT
    );
  addr_0_LOGIC_ZERO_118 : X_ZERO
    port map (
      O => addr_0_LOGIC_ZERO
    );
  addr_inst_cy_16_119 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC1,
      IB => addr_0_LOGIC_ZERO,
      SEL => cs_FFd12_rt,
      O => addr_inst_cy_16
    );
  cs_FFd12_rt_120 : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => GLOBAL_LOGIC1,
      ADR1 => cs_FFd12,
      ADR2 => VCC,
      ADR3 => VCC,
      O => cs_FFd12_rt
    );
  addr_inst_lut3_01 : X_LUT4
    generic map(
      INIT => X"F3C0"
    )
    port map (
      ADR0 => GLOBAL_LOGIC0,
      ADR1 => cs_FFd12,
      ADR2 => bp_0_1,
      ADR3 => addr(0),
      O => addr_inst_lut3_0
    );
  addr_0_COUTUSED : X_BUF
    port map (
      I => addr_0_CYMUXG,
      O => addr_inst_cy_17
    );
  addr_inst_cy_17_121 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC0,
      IB => addr_inst_cy_16,
      SEL => addr_inst_lut3_0,
      O => addr_0_CYMUXG
    );
  addr_inst_sum_16_122 : X_XOR2
    port map (
      I0 => addr_inst_cy_16,
      I1 => addr_inst_lut3_0,
      O => addr_inst_sum_16
    );
  addr_1_LOGIC_ZERO_123 : X_ZERO
    port map (
      O => addr_1_LOGIC_ZERO
    );
  addr_inst_cy_18_124 : X_MUX2
    port map (
      IA => addr_1_LOGIC_ZERO,
      IB => addr_1_CYINIT,
      SEL => addr_inst_lut3_1,
      O => addr_inst_cy_18
    );
  addr_inst_sum_17_125 : X_XOR2
    port map (
      I0 => addr_1_CYINIT,
      I1 => addr_inst_lut3_1,
      O => addr_inst_sum_17
    );
  addr_inst_lut3_16 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12,
      ADR1 => bp_1_1,
      ADR2 => addr(1),
      ADR3 => VCC,
      O => addr_inst_lut3_1
    );
  addr_inst_lut3_21 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12,
      ADR1 => bp_2_1,
      ADR2 => addr(2),
      ADR3 => VCC,
      O => addr_inst_lut3_2
    );
  addr_1_COUTUSED : X_BUF
    port map (
      I => addr_1_CYMUXG,
      O => addr_inst_cy_19
    );
  addr_inst_cy_19_126 : X_MUX2
    port map (
      IA => addr_1_LOGIC_ZERO,
      IB => addr_inst_cy_18,
      SEL => addr_inst_lut3_2,
      O => addr_1_CYMUXG
    );
  addr_inst_sum_18_127 : X_XOR2
    port map (
      I0 => addr_inst_cy_18,
      I1 => addr_inst_lut3_2,
      O => addr_inst_sum_18
    );
  addr_1_CYINIT_128 : X_BUF
    port map (
      I => addr_inst_cy_17,
      O => addr_1_CYINIT
    );
  addr_3_LOGIC_ZERO_129 : X_ZERO
    port map (
      O => addr_3_LOGIC_ZERO
    );
  addr_inst_cy_20_130 : X_MUX2
    port map (
      IA => addr_3_LOGIC_ZERO,
      IB => addr_3_CYINIT,
      SEL => addr_inst_lut3_31_O,
      O => addr_inst_cy_20
    );
  addr_inst_sum_19_131 : X_XOR2
    port map (
      I0 => addr_3_CYINIT,
      I1 => addr_inst_lut3_31_O,
      O => addr_inst_sum_19
    );
  addr_inst_lut3_31 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_3_1,
      ADR2 => addr(3),
      ADR3 => VCC,
      O => addr_inst_lut3_31_O
    );
  addr_inst_lut3_41 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_4_1,
      ADR2 => addr(4),
      ADR3 => VCC,
      O => addr_inst_lut3_41_O
    );
  addr_3_COUTUSED : X_BUF
    port map (
      I => addr_3_CYMUXG,
      O => addr_inst_cy_21
    );
  addr_inst_cy_21_132 : X_MUX2
    port map (
      IA => addr_3_LOGIC_ZERO,
      IB => addr_inst_cy_20,
      SEL => addr_inst_lut3_41_O,
      O => addr_3_CYMUXG
    );
  addr_inst_sum_20_133 : X_XOR2
    port map (
      I0 => addr_inst_cy_20,
      I1 => addr_inst_lut3_41_O,
      O => addr_inst_sum_20
    );
  addr_3_CYINIT_134 : X_BUF
    port map (
      I => addr_inst_cy_19,
      O => addr_3_CYINIT
    );
  addr_5_LOGIC_ZERO_135 : X_ZERO
    port map (
      O => addr_5_LOGIC_ZERO
    );
  addr_inst_cy_22_136 : X_MUX2
    port map (
      IA => addr_5_LOGIC_ZERO,
      IB => addr_5_CYINIT,
      SEL => addr_inst_lut3_5,
      O => addr_inst_cy_22
    );
  addr_inst_sum_21_137 : X_XOR2
    port map (
      I0 => addr_5_CYINIT,
      I1 => addr_inst_lut3_5,
      O => addr_inst_sum_21
    );
  addr_inst_lut3_51 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_5_1,
      ADR2 => addr(5),
      ADR3 => VCC,
      O => addr_inst_lut3_5
    );
  addr_inst_lut3_61 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_6_1,
      ADR2 => addr(6),
      ADR3 => VCC,
      O => addr_inst_lut3_6
    );
  addr_5_COUTUSED : X_BUF
    port map (
      I => addr_5_CYMUXG,
      O => addr_inst_cy_23
    );
  addr_inst_cy_23_138 : X_MUX2
    port map (
      IA => addr_5_LOGIC_ZERO,
      IB => addr_inst_cy_22,
      SEL => addr_inst_lut3_6,
      O => addr_5_CYMUXG
    );
  addr_inst_sum_22_139 : X_XOR2
    port map (
      I0 => addr_inst_cy_22,
      I1 => addr_inst_lut3_6,
      O => addr_inst_sum_22
    );
  addr_5_CYINIT_140 : X_BUF
    port map (
      I => addr_inst_cy_21,
      O => addr_5_CYINIT
    );
  addr_7_LOGIC_ZERO_141 : X_ZERO
    port map (
      O => addr_7_LOGIC_ZERO
    );
  addr_inst_cy_24_142 : X_MUX2
    port map (
      IA => addr_7_LOGIC_ZERO,
      IB => addr_7_CYINIT,
      SEL => addr_inst_lut3_7,
      O => addr_inst_cy_24
    );
  addr_inst_sum_23_143 : X_XOR2
    port map (
      I0 => addr_7_CYINIT,
      I1 => addr_inst_lut3_7,
      O => addr_inst_sum_23
    );
  addr_inst_lut3_71 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_7_1,
      ADR2 => addr(7),
      ADR3 => VCC,
      O => addr_inst_lut3_7
    );
  addr_inst_lut3_81 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_8_1,
      ADR2 => addr(8),
      ADR3 => VCC,
      O => addr_inst_lut3_8
    );
  addr_7_COUTUSED : X_BUF
    port map (
      I => addr_7_CYMUXG,
      O => addr_inst_cy_25
    );
  addr_inst_cy_25_144 : X_MUX2
    port map (
      IA => addr_7_LOGIC_ZERO,
      IB => addr_inst_cy_24,
      SEL => addr_inst_lut3_8,
      O => addr_7_CYMUXG
    );
  addr_inst_sum_24_145 : X_XOR2
    port map (
      I0 => addr_inst_cy_24,
      I1 => addr_inst_lut3_8,
      O => addr_inst_sum_24
    );
  addr_7_CYINIT_146 : X_BUF
    port map (
      I => addr_inst_cy_23,
      O => addr_7_CYINIT
    );
  addr_9_LOGIC_ZERO_147 : X_ZERO
    port map (
      O => addr_9_LOGIC_ZERO
    );
  addr_inst_cy_26_148 : X_MUX2
    port map (
      IA => addr_9_LOGIC_ZERO,
      IB => addr_9_CYINIT,
      SEL => addr_inst_lut3_9,
      O => addr_inst_cy_26
    );
  addr_inst_sum_25_149 : X_XOR2
    port map (
      I0 => addr_9_CYINIT,
      I1 => addr_inst_lut3_9,
      O => addr_inst_sum_25
    );
  addr_inst_lut3_91 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_9_1,
      ADR2 => addr(9),
      ADR3 => VCC,
      O => addr_inst_lut3_9
    );
  addr_inst_lut3_101 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_10_1,
      ADR2 => addr(10),
      ADR3 => VCC,
      O => addr_inst_lut3_10
    );
  addr_9_COUTUSED : X_BUF
    port map (
      I => addr_9_CYMUXG,
      O => addr_inst_cy_27
    );
  addr_inst_cy_27_150 : X_MUX2
    port map (
      IA => addr_9_LOGIC_ZERO,
      IB => addr_inst_cy_26,
      SEL => addr_inst_lut3_10,
      O => addr_9_CYMUXG
    );
  addr_inst_sum_26_151 : X_XOR2
    port map (
      I0 => addr_inst_cy_26,
      I1 => addr_inst_lut3_10,
      O => addr_inst_sum_26
    );
  addr_9_CYINIT_152 : X_BUF
    port map (
      I => addr_inst_cy_25,
      O => addr_9_CYINIT
    );
  addr_11_LOGIC_ZERO_153 : X_ZERO
    port map (
      O => addr_11_LOGIC_ZERO
    );
  addr_inst_cy_28_154 : X_MUX2
    port map (
      IA => addr_11_LOGIC_ZERO,
      IB => addr_11_CYINIT,
      SEL => addr_inst_lut3_11,
      O => addr_inst_cy_28
    );
  addr_inst_sum_27_155 : X_XOR2
    port map (
      I0 => addr_11_CYINIT,
      I1 => addr_inst_lut3_11,
      O => addr_inst_sum_27
    );
  addr_inst_lut3_111 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_11_1,
      ADR2 => addr(11),
      ADR3 => VCC,
      O => addr_inst_lut3_11
    );
  addr_inst_lut3_121 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_12_1,
      ADR2 => addr(12),
      ADR3 => VCC,
      O => addr_inst_lut3_12
    );
  addr_11_COUTUSED : X_BUF
    port map (
      I => addr_11_CYMUXG,
      O => addr_inst_cy_29
    );
  addr_inst_cy_29_156 : X_MUX2
    port map (
      IA => addr_11_LOGIC_ZERO,
      IB => addr_inst_cy_28,
      SEL => addr_inst_lut3_12,
      O => addr_11_CYMUXG
    );
  addr_inst_sum_28_157 : X_XOR2
    port map (
      I0 => addr_inst_cy_28,
      I1 => addr_inst_lut3_12,
      O => addr_inst_sum_28
    );
  addr_11_CYINIT_158 : X_BUF
    port map (
      I => addr_inst_cy_27,
      O => addr_11_CYINIT
    );
  dinl_0 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_0_IDELAY,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => DIN_0_IFF_RST,
      O => dinl(0)
    );
  DIN_0_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_0_IFF_RST
    );
  addr_13_LOGIC_ZERO_159 : X_ZERO
    port map (
      O => addr_13_LOGIC_ZERO
    );
  addr_inst_cy_30_160 : X_MUX2
    port map (
      IA => addr_13_LOGIC_ZERO,
      IB => addr_13_CYINIT,
      SEL => addr_inst_lut3_13,
      O => addr_inst_cy_30
    );
  addr_inst_sum_29_161 : X_XOR2
    port map (
      I0 => addr_13_CYINIT,
      I1 => addr_inst_lut3_13,
      O => addr_inst_sum_29
    );
  addr_inst_lut3_131 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_13_1,
      ADR2 => addr(13),
      ADR3 => VCC,
      O => addr_inst_lut3_13
    );
  addr_inst_lut3_141 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_14_1,
      ADR2 => addr(14),
      ADR3 => VCC,
      O => addr_inst_lut3_14
    );
  addr_13_COUTUSED : X_BUF
    port map (
      I => addr_13_CYMUXG,
      O => addr_inst_cy_31
    );
  addr_inst_cy_31_162 : X_MUX2
    port map (
      IA => addr_13_LOGIC_ZERO,
      IB => addr_inst_cy_30,
      SEL => addr_inst_lut3_14,
      O => addr_13_CYMUXG
    );
  addr_inst_sum_30_163 : X_XOR2
    port map (
      I0 => addr_inst_cy_30,
      I1 => addr_inst_lut3_14,
      O => addr_inst_sum_30
    );
  addr_13_CYINIT_164 : X_BUF
    port map (
      I => addr_inst_cy_29,
      O => addr_13_CYINIT
    );
  addr_inst_sum_31_165 : X_XOR2
    port map (
      I0 => addr_15_CYINIT,
      I1 => addr_inst_lut3_15,
      O => addr_inst_sum_31
    );
  addr_inst_lut3_151 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => bp_15_1,
      ADR2 => addr(15),
      ADR3 => VCC,
      O => addr_inst_lut3_15
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
      O => addr_15_GROM
    );
  addr_15_YUSED : X_BUF
    port map (
      I => addr_15_GROM,
      O => CHOICE15
    );
  addr_15_CYINIT_166 : X_BUF
    port map (
      I => addr_inst_cy_31,
      O => addr_15_CYINIT
    );
  Ker34541 : X_LUT4
    generic map(
      INIT => X"4444"
    )
    port map (
      ADR0 => RESET_IBUF,
      ADR1 => den,
      ADR2 => VCC,
      ADR3 => VCC,
      O => N3456_FROM
    );
  Q_n00271 : X_LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      ADR0 => N3456,
      ADR1 => cs_FFd11,
      ADR2 => cs_FFd12,
      ADR3 => cs_FFd10,
      O => N3456_GROM
    );
  N3456_XUSED : X_BUF
    port map (
      I => N3456_FROM,
      O => N3456
    );
  N3456_YUSED : X_BUF
    port map (
      I => N3456_GROM,
      O => Q_n0027
    );
  cs_FFd6_In1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => den,
      ADR1 => newfint,
      ADR2 => cs_FFd7,
      ADR3 => VCC,
      O => cs_FFd6_In
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
  cs_FFd8_In1 : X_LUT4
    generic map(
      INIT => X"8880"
    )
    port map (
      ADR0 => cs_FFd9,
      ADR1 => newfint,
      ADR2 => Ker3426137_2,
      ADR3 => Ker3426120_O,
      O => cs_FFd8_In1_O
    );
  cs_FFd7_In : X_LUT4
    generic map(
      INIT => X"0A8A"
    )
    port map (
      ADR0 => newfint,
      ADR1 => cs_FFd9,
      ADR2 => N3553,
      ADR3 => N3428,
      O => cs_FFd7_In_O
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
      O => Ker3426120_O_FROM
    );
  Ker3426137 : X_LUT4
    generic map(
      INIT => X"EEEE"
    )
    port map (
      ADR0 => Ker3426137_2,
      ADR1 => Ker3426120_O,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Ker3426120_O_GROM
    );
  Ker3426120_O_XUSED : X_BUF
    port map (
      I => Ker3426120_O_FROM,
      O => Ker3426120_O
    );
  Ker3426120_O_YUSED : X_BUF
    port map (
      I => Ker3426120_O_GROM,
      O => N3428
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
      O => Ker342621_O_FROM
    );
  Ker3426137_2_167 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => Ker342621_O,
      ADR1 => CHOICE39,
      ADR2 => CHOICE29,
      ADR3 => CHOICE32,
      O => Ker342621_O_GROM
    );
  Ker342621_O_XUSED : X_BUF
    port map (
      I => Ker342621_O_FROM,
      O => Ker342621_O
    );
  Ker342621_O_YUSED : X_BUF
    port map (
      I => Ker342621_O_GROM,
      O => Ker3426137_2
    );
  dinint_1_LOGIC_ONE_168 : X_ONE
    port map (
      O => dinint_1_LOGIC_ONE
    );
  srl16_din_bit1_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => dinl(1),
      CE => dinint_1_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => ldinint(1)
    );
  srl16_din_bit0_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => dinl(0),
      CE => dinint_1_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => ldinint(0)
    );
  dinint_1_CEMUX : X_INV
    port map (
      I => RESET_IBUF,
      O => dinint_1_CEMUXNOT
    );
  dinint_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dinint_3_FFY_RST
    );
  dinint_2 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(2),
      CE => dinint_3_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => dinint_3_FFY_RST,
      O => dinint(2)
    );
  dinint_3_LOGIC_ONE_169 : X_ONE
    port map (
      O => dinint_3_LOGIC_ONE
    );
  srl16_din_bit3_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => dinl(3),
      CE => dinint_3_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => ldinint(3)
    );
  srl16_din_bit2_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => dinl(2),
      CE => dinint_3_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => ldinint(2)
    );
  dinint_3_CEMUX : X_INV
    port map (
      I => RESET_IBUF,
      O => dinint_3_CEMUXNOT
    );
  dinint_5_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dinint_5_FFY_RST
    );
  dinint_4 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(4),
      CE => dinint_5_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => dinint_5_FFY_RST,
      O => dinint(4)
    );
  dinint_5_LOGIC_ONE_170 : X_ONE
    port map (
      O => dinint_5_LOGIC_ONE
    );
  srl16_din_bit5_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => dinl(5),
      CE => dinint_5_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => ldinint(5)
    );
  srl16_din_bit4_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => dinl(4),
      CE => dinint_5_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => ldinint(4)
    );
  dinint_5_CEMUX : X_INV
    port map (
      I => RESET_IBUF,
      O => dinint_5_CEMUXNOT
    );
  cs_FFd11_FFY_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd11_FFY_RST
    );
  cs_FFd11_171 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd11_In,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => cs_FFd11_FFY_RST,
      O => cs_FFd11
    );
  cs_FFd7_In_SW0 : X_LUT4
    generic map(
      INIT => X"DDDD"
    )
    port map (
      ADR0 => cs_FFd7,
      ADR1 => den,
      ADR2 => VCC,
      ADR3 => VCC,
      O => cs_FFd11_FROM
    );
  cs_FFd11_In1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => den,
      ADR1 => newfint,
      ADR2 => cs_FFd12_1,
      ADR3 => VCC,
      O => cs_FFd11_In
    );
  cs_FFd11_XUSED : X_BUF
    port map (
      I => cs_FFd11_FROM,
      O => N3553
    );
  dinint_7_LOGIC_ONE_172 : X_ONE
    port map (
      O => dinint_7_LOGIC_ONE
    );
  srl16_din_bit7_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => dinl(7),
      CE => dinint_7_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => ldinint(7)
    );
  srl16_din_bit6_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => dinl(6),
      CE => dinint_7_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => ldinint(6)
    );
  dinint_7_CEMUX : X_INV
    port map (
      I => RESET_IBUF,
      O => dinint_7_CEMUXNOT
    );
  dinl_1 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_1_IDELAY,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => DIN_1_IFF_RST,
      O => dinl(1)
    );
  DIN_1_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_1_IFF_RST
    );
  dinint_9_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dinint_9_FFY_RST
    );
  dinint_8 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(8),
      CE => dinint_9_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => dinint_9_FFY_RST,
      O => dinint(8)
    );
  dinint_9_LOGIC_ONE_173 : X_ONE
    port map (
      O => dinint_9_LOGIC_ONE
    );
  srl16_din_bit9_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => dinl(9),
      CE => dinint_9_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => ldinint(9)
    );
  srl16_din_bit8_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => dinl(8),
      CE => dinint_9_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => ldinint(8)
    );
  dinint_9_CEMUX : X_INV
    port map (
      I => RESET_IBUF,
      O => dinint_9_CEMUXNOT
    );
  dinint_11_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dinint_11_FFY_RST
    );
  dinint_10 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(10),
      CE => dinint_11_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => dinint_11_FFY_RST,
      O => dinint(10)
    );
  dinint_11_LOGIC_ONE_174 : X_ONE
    port map (
      O => dinint_11_LOGIC_ONE
    );
  srl16_din_bit11_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => dinl(11),
      CE => dinint_11_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => ldinint(11)
    );
  srl16_din_bit10_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => dinl(10),
      CE => dinint_11_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => ldinint(10)
    );
  dinint_11_CEMUX : X_INV
    port map (
      I => RESET_IBUF,
      O => dinint_11_CEMUXNOT
    );
  dinint_13_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dinint_13_FFY_RST
    );
  dinint_12 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(12),
      CE => dinint_13_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => dinint_13_FFY_RST,
      O => dinint(12)
    );
  dinint_13_LOGIC_ONE_175 : X_ONE
    port map (
      O => dinint_13_LOGIC_ONE
    );
  srl16_din_bit13_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => dinl(13),
      CE => dinint_13_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => ldinint(13)
    );
  srl16_din_bit12_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => dinl(12),
      CE => dinint_13_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => ldinint(12)
    );
  dinint_13_CEMUX : X_INV
    port map (
      I => RESET_IBUF,
      O => dinint_13_CEMUXNOT
    );
  dinint_15_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dinint_15_FFY_RST
    );
  dinint_14 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(14),
      CE => dinint_15_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => dinint_15_FFY_RST,
      O => dinint(14)
    );
  dinint_15_LOGIC_ONE_176 : X_ONE
    port map (
      O => dinint_15_LOGIC_ONE
    );
  srl16_din_bit15_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => dinl(15),
      CE => dinint_15_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => ldinint(15)
    );
  srl16_din_bit14_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => dinl(14),
      CE => dinint_15_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => ldinint(14)
    );
  dinint_15_CEMUX : X_INV
    port map (
      I => RESET_IBUF,
      O => dinint_15_CEMUXNOT
    );
  CNT_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => CNT_1_FFY_RST
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
      SET => GND,
      RST => CNT_1_FFY_RST,
      O => CNT(0)
    );
  Mmux_n0039_Result_1_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(1),
      ADR2 => Q_n0081(1),
      ADR3 => VCC,
      O => Q_n0039(1)
    );
  Mmux_n0039_Result_0_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(0),
      ADR2 => Q_n0081(0),
      ADR3 => VCC,
      O => Q_n0039(0)
    );
  Mmux_n0039_Result_3_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(3),
      ADR2 => Q_n0081(3),
      ADR3 => VCC,
      O => Q_n0039(3)
    );
  Mmux_n0039_Result_2_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(2),
      ADR2 => Q_n0081(2),
      ADR3 => VCC,
      O => Q_n0039(2)
    );
  Mmux_n0039_Result_5_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(5),
      ADR2 => Q_n0081(5),
      ADR3 => VCC,
      O => Q_n0039(5)
    );
  Mmux_n0039_Result_4_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(4),
      ADR2 => Q_n0081(4),
      ADR3 => VCC,
      O => Q_n0039(4)
    );
  Mmux_n0039_Result_7_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(7),
      ADR2 => Q_n0081(7),
      ADR3 => VCC,
      O => Q_n0039(7)
    );
  Mmux_n0039_Result_6_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(6),
      ADR2 => Q_n0081(6),
      ADR3 => VCC,
      O => Q_n0039(6)
    );
  Mmux_n0039_Result_9_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(9),
      ADR2 => Q_n0081(9),
      ADR3 => VCC,
      O => Q_n0039(9)
    );
  Mmux_n0039_Result_8_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(8),
      ADR2 => Q_n0081(8),
      ADR3 => VCC,
      O => Q_n0039(8)
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
      O => cs_FFd3_1_FROM
    );
  cs_FFd3_In1 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => fifofulll,
      ADR1 => cs_FFd5,
      ADR2 => VCC,
      ADR3 => VCC,
      O => cs_FFd3_1_GROM
    );
  cs_FFd3_1_XUSED : X_BUF
    port map (
      I => cs_FFd3_1_FROM,
      O => Q_n0040
    );
  cs_FFd3_1_YUSED : X_BUF
    port map (
      I => cs_FFd3_1_GROM,
      O => cs_FFd3_In
    );
  enableintl_LOGIC_ONE_177 : X_ONE
    port map (
      O => enableintl_LOGIC_ONE
    );
  srl16_enable_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => enable,
      CE => enableintl_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => enableintl_GSHIFT
    );
  enableintl_CEMUX : X_INV
    port map (
      I => RESET_IBUF,
      O => enableintl_CEMUXNOT
    );
  enableintl_YUSED : X_BUF
    port map (
      I => enableintl_GSHIFT,
      O => enableint
    );
  dinl_2 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_2_IDELAY,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => DIN_2_IFF_RST,
      O => dinl(2)
    );
  DIN_2_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_2_IFF_RST
    );
  cs_FFd4_In1 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => newfint,
      ADR1 => cs_FFd8,
      ADR2 => VCC,
      ADR3 => VCC,
      O => cs_FFd4_In
    );
  cs_FFd2_In1 : X_LUT4
    generic map(
      INIT => X"4444"
    )
    port map (
      ADR0 => fifofulll,
      ADR1 => cs_FFd5,
      ADR2 => VCC,
      ADR3 => VCC,
      O => cs_FFd2_In
    );
  cs_FFd10_In : X_LUT4
    generic map(
      INIT => X"A0A8"
    )
    port map (
      ADR0 => newfint,
      ADR1 => cs_FFd6,
      ADR2 => N3593,
      ADR3 => N3428,
      O => cs_FFd10_In_O
    );
  cs_FFd9_In1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => den,
      ADR1 => newfint,
      ADR2 => cs_FFd10,
      ADR3 => VCC,
      O => cs_FFd9_In
    );
  Mmux_n0039_Result_11_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(11),
      ADR2 => Q_n0081(11),
      ADR3 => VCC,
      O => Q_n0039(11)
    );
  Mmux_n0039_Result_10_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(10),
      ADR2 => Q_n0081(10),
      ADR3 => VCC,
      O => Q_n0039(10)
    );
  Mmux_n0039_Result_13_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(13),
      ADR2 => Q_n0081(13),
      ADR3 => VCC,
      O => Q_n0039(13)
    );
  Mmux_n0039_Result_12_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(12),
      ADR2 => Q_n0081(12),
      ADR3 => VCC,
      O => Q_n0039(12)
    );
  Mmux_n0039_Result_15_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(15),
      ADR2 => Q_n0081(15),
      ADR3 => VCC,
      O => Q_n0039(15)
    );
  Mmux_n0039_Result_14_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => cs_FFd12_1,
      ADR1 => dinint(14),
      ADR2 => Q_n0081(14),
      ADR3 => VCC,
      O => Q_n0039(14)
    );
  newfint_LOGIC_ONE_178 : X_ONE
    port map (
      O => newfint_LOGIC_ONE
    );
  srl16_newframe_SRL16E : X_SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => GLOBAL_LOGIC0,
      A1 => GLOBAL_LOGIC0,
      A2 => GLOBAL_LOGIC1,
      A3 => GLOBAL_LOGIC0,
      D => newframel,
      CE => newfint_LOGIC_ONE,
      CLK => CLK_BUFGP,
      Q => lnewfint
    );
  newfint_CEMUX : X_INV
    port map (
      I => RESET_IBUF,
      O => newfint_CEMUXNOT
    );
  Mxor_lden_Result1 : X_LUT4
    generic map(
      INIT => X"6666"
    )
    port map (
      ADR0 => enableint,
      ADR1 => enableintl,
      ADR2 => VCC,
      ADR3 => VCC,
      O => lden
    );
  den_CEMUX : X_INV
    port map (
      I => RESET_IBUF,
      O => den_CEMUXNOT
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
      O => Q_n0028_FROM
    );
  Q_n00301 : X_LUT4
    generic map(
      INIT => X"4444"
    )
    port map (
      ADR0 => RESET_IBUF,
      ADR1 => cs_FFd2,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Q_n0028_GROM
    );
  Q_n0028_XUSED : X_BUF
    port map (
      I => Q_n0028_FROM,
      O => Q_n0028
    );
  Q_n0028_YUSED : X_BUF
    port map (
      I => Q_n0028_GROM,
      O => Q_n0030
    );
  dinl_3 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_3_IDELAY,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => DIN_3_IFF_RST,
      O => dinl(3)
    );
  DIN_3_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_3_IFF_RST
    );
  MD_1_OBUF : X_TRI
    port map (
      I => MD_1_OUTMUX,
      CTL => MD_1_ENABLE,
      O => MD(1)
    );
  MD_1_ENABLEINV : X_INV
    port map (
      I => MD_1_TORGTS,
      O => MD_1_ENABLE
    );
  MD_1_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_1_TORGTS
    );
  MD_1_OUTMUX_179 : X_BUF
    port map (
      I => MD_1,
      O => MD_1_OUTMUX
    );
  MD_1_OMUX : X_BUF
    port map (
      I => dl(1),
      O => MD_1_OD
    );
  MD_2_OBUF : X_TRI
    port map (
      I => MD_2_OUTMUX,
      CTL => MD_2_ENABLE,
      O => MD(2)
    );
  MD_2_ENABLEINV : X_INV
    port map (
      I => MD_2_TORGTS,
      O => MD_2_ENABLE
    );
  MD_2_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_2_TORGTS
    );
  MD_2_OUTMUX_180 : X_BUF
    port map (
      I => MD_2,
      O => MD_2_OUTMUX
    );
  MD_2_OMUX : X_BUF
    port map (
      I => dl(2),
      O => MD_2_OD
    );
  MD_3_OBUF : X_TRI
    port map (
      I => MD_3_OUTMUX,
      CTL => MD_3_ENABLE,
      O => MD(3)
    );
  MD_3_ENABLEINV : X_INV
    port map (
      I => MD_3_TORGTS,
      O => MD_3_ENABLE
    );
  MD_3_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_3_TORGTS
    );
  MD_3_OUTMUX_181 : X_BUF
    port map (
      I => MD_3,
      O => MD_3_OUTMUX
    );
  MD_3_OMUX : X_BUF
    port map (
      I => dl(3),
      O => MD_3_OD
    );
  dinl_8 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_8_IDELAY,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => DIN_8_IFF_RST,
      O => dinl(8)
    );
  DIN_8_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_8_IFF_RST
    );
  MD_4_OBUF : X_TRI
    port map (
      I => MD_4_OUTMUX,
      CTL => MD_4_ENABLE,
      O => MD(4)
    );
  MD_4_ENABLEINV : X_INV
    port map (
      I => MD_4_TORGTS,
      O => MD_4_ENABLE
    );
  MD_4_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_4_TORGTS
    );
  MD_4_OUTMUX_182 : X_BUF
    port map (
      I => MD_4,
      O => MD_4_OUTMUX
    );
  MD_4_OMUX : X_BUF
    port map (
      I => dl(4),
      O => MD_4_OD
    );
  MD_5_OBUF : X_TRI
    port map (
      I => MD_5_OUTMUX,
      CTL => MD_5_ENABLE,
      O => MD(5)
    );
  MD_5_ENABLEINV : X_INV
    port map (
      I => MD_5_TORGTS,
      O => MD_5_ENABLE
    );
  MD_5_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_5_TORGTS
    );
  MD_5_OUTMUX_183 : X_BUF
    port map (
      I => MD_5,
      O => MD_5_OUTMUX
    );
  MD_5_OMUX : X_BUF
    port map (
      I => dl(5),
      O => MD_5_OD
    );
  MD_6_OBUF : X_TRI
    port map (
      I => MD_6_OUTMUX,
      CTL => MD_6_ENABLE,
      O => MD(6)
    );
  MD_6_ENABLEINV : X_INV
    port map (
      I => MD_6_TORGTS,
      O => MD_6_ENABLE
    );
  MD_6_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => MD_6_TORGTS
    );
  MD_6_OUTMUX_184 : X_BUF
    port map (
      I => MD_6,
      O => MD_6_OUTMUX
    );
  MD_6_OMUX : X_BUF
    port map (
      I => dl(6),
      O => MD_6_OD
    );
  dinl_9 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_9_IDELAY,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => DIN_9_IFF_RST,
      O => dinl(9)
    );
  DIN_9_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_9_IFF_RST
    );
  MD_10_185 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_10_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_10_OFF_RST,
      O => MD_10
    );
  MD_10_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_10_OFF_RST
    );
  MD_11_186 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_11_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_11_OFF_RST,
      O => MD_11
    );
  MD_11_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_11_OFF_RST
    );
  MD_12_187 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_12_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_12_OFF_RST,
      O => MD_12
    );
  MD_12_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_12_OFF_RST
    );
  MD_20_188 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_20_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_20_OFF_RST,
      O => MD_20
    );
  MD_20_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_20_OFF_RST
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
      SET => GND,
      RST => addr_7_FFX_RST,
      O => addr(7)
    );
  addr_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => addr_7_FFX_RST
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
      SET => GND,
      RST => addr_9_FFX_RST,
      O => addr(9)
    );
  addr_9_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => addr_9_FFX_RST
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
      SET => GND,
      RST => addr_11_FFY_RST,
      O => addr(12)
    );
  addr_11_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => addr_11_FFY_RST
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
      SET => GND,
      RST => addr_11_FFX_RST,
      O => addr(11)
    );
  addr_11_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => addr_11_FFX_RST
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
      SET => GND,
      RST => addr_13_FFY_RST,
      O => addr(14)
    );
  addr_13_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => addr_13_FFY_RST
    );
  bp_14 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => BPOUT_14_OD,
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => BPOUT_14_OFF_RST,
      O => bp(14)
    );
  BPOUT_14_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => BPOUT_14_OFF_RST
    );
  bp_15 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => BPOUT_15_OD,
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => BPOUT_15_OFF_RST,
      O => bp(15)
    );
  BPOUT_15_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => BPOUT_15_OFF_RST
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
      SET => GND,
      RST => dl_1_FFX_RST,
      O => dl(1)
    );
  dl_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dl_1_FFX_RST
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
      SET => GND,
      RST => dl_3_FFX_RST,
      O => dl(3)
    );
  dl_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dl_3_FFX_RST
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
      SET => GND,
      RST => dl_5_FFX_RST,
      O => dl(5)
    );
  dl_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dl_5_FFX_RST
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
      SET => GND,
      RST => dl_7_FFX_RST,
      O => dl(7)
    );
  dl_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dl_7_FFX_RST
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
      SET => GND,
      RST => dl_9_FFY_RST,
      O => dl(8)
    );
  dl_9_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dl_9_FFY_RST
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
      SET => GND,
      RST => dl_9_FFX_RST,
      O => dl(9)
    );
  dl_9_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dl_9_FFX_RST
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
      SET => GND,
      RST => dh_11_FFY_RST,
      O => dh(10)
    );
  dh_11_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dh_11_FFY_RST
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
      SET => GND,
      RST => dh_11_FFX_RST,
      O => dh(11)
    );
  dh_11_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dh_11_FFX_RST
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
      SET => GND,
      RST => dh_13_FFY_RST,
      O => dh(12)
    );
  dh_13_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dh_13_FFY_RST
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
      SET => GND,
      RST => dh_13_FFX_RST,
      O => dh(13)
    );
  dh_13_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dh_13_FFX_RST
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
      SET => GND,
      RST => dh_15_FFY_RST,
      O => dh(14)
    );
  dh_15_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dh_15_FFY_RST
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
      SET => GND,
      RST => dl_11_FFY_RST,
      O => dl(10)
    );
  dl_11_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dl_11_FFY_RST
    );
  bp_2 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => BPOUT_2_OD,
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => BPOUT_2_OFF_RST,
      O => bp(2)
    );
  BPOUT_2_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => BPOUT_2_OFF_RST
    );
  MD_19_189 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_19_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_19_OFF_RST,
      O => MD_19
    );
  MD_19_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_19_OFF_RST
    );
  MD_27_190 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_27_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_27_OFF_RST,
      O => MD_27
    );
  MD_27_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_27_OFF_RST
    );
  bp_3 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => BPOUT_3_OD,
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => BPOUT_3_OFF_RST,
      O => bp(3)
    );
  BPOUT_3_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => BPOUT_3_OFF_RST
    );
  MD_28_191 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_28_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_28_OFF_RST,
      O => MD_28
    );
  MD_28_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_28_OFF_RST
    );
  bp_4 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => BPOUT_4_OD,
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => BPOUT_4_OFF_RST,
      O => bp(4)
    );
  BPOUT_4_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => BPOUT_4_OFF_RST
    );
  MD_25_192 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_25_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_25_OFF_RST,
      O => MD_25
    );
  MD_25_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_25_OFF_RST
    );
  bp_0 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => BPOUT_0_OD,
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => BPOUT_0_OFF_RST,
      O => bp(0)
    );
  BPOUT_0_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => BPOUT_0_OFF_RST
    );
  bp_1 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => BPOUT_1_OD,
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => BPOUT_1_OFF_RST,
      O => bp(1)
    );
  BPOUT_1_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => BPOUT_1_OFF_RST
    );
  MD_18_193 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_18_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_18_OFF_RST,
      O => MD_18
    );
  MD_18_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_18_OFF_RST
    );
  MD_26_194 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_26_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_26_OFF_RST,
      O => MD_26
    );
  MD_26_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_26_OFF_RST
    );
  dinint_0 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(0),
      CE => dinint_1_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => dinint_1_FFY_RST,
      O => dinint(0)
    );
  dinint_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dinint_1_FFY_RST
    );
  dinint_1 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(1),
      CE => dinint_1_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => dinint_1_FFX_RST,
      O => dinint(1)
    );
  dinint_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dinint_1_FFX_RST
    );
  dinint_3 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(3),
      CE => dinint_3_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => dinint_3_FFX_RST,
      O => dinint(3)
    );
  dinint_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dinint_3_FFX_RST
    );
  dinint_5 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(5),
      CE => dinint_5_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => dinint_5_FFX_RST,
      O => dinint(5)
    );
  dinint_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dinint_5_FFX_RST
    );
  dinint_6 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(6),
      CE => dinint_7_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => dinint_7_FFY_RST,
      O => dinint(6)
    );
  dinint_7_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dinint_7_FFY_RST
    );
  MD_13_195 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_13_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_13_OFF_RST,
      O => MD_13
    );
  MD_13_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_13_OFF_RST
    );
  MD_21_196 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_21_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_21_OFF_RST,
      O => MD_21
    );
  MD_21_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_21_OFF_RST
    );
  MD_14_197 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_14_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_14_OFF_RST,
      O => MD_14
    );
  MD_14_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_14_OFF_RST
    );
  MD_22_198 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_22_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_22_OFF_RST,
      O => MD_22
    );
  MD_22_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_22_OFF_RST
    );
  MD_30_199 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_30_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_30_OFF_RST,
      O => MD_30
    );
  MD_30_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_30_OFF_RST
    );
  MD_15_200 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_15_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_15_OFF_RST,
      O => MD_15
    );
  MD_15_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_15_OFF_RST
    );
  MD_23_201 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_23_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_23_OFF_RST,
      O => MD_23
    );
  MD_23_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_23_OFF_RST
    );
  MD_31_202 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_31_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_31_OFF_RST,
      O => MD_31
    );
  MD_31_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_31_OFF_RST
    );
  MD_16_203 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_16_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_16_OFF_RST,
      O => MD_16
    );
  MD_16_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_16_OFF_RST
    );
  MD_24_204 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_24_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_24_OFF_RST,
      O => MD_24
    );
  MD_24_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_24_OFF_RST
    );
  MD_17_205 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_17_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_17_OFF_RST,
      O => MD_17
    );
  MD_17_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_17_OFF_RST
    );
  MD_29_206 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_29_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_29_OFF_RST,
      O => MD_29
    );
  MD_29_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_29_OFF_RST
    );
  bp_5 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => BPOUT_5_OD,
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => BPOUT_5_OFF_RST,
      O => bp(5)
    );
  BPOUT_5_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => BPOUT_5_OFF_RST
    );
  bp_6 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => BPOUT_6_OD,
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => BPOUT_6_OFF_RST,
      O => bp(6)
    );
  BPOUT_6_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => BPOUT_6_OFF_RST
    );
  bp_7 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => BPOUT_7_OD,
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => BPOUT_7_OFF_RST,
      O => bp(7)
    );
  BPOUT_7_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => BPOUT_7_OFF_RST
    );
  bp_8 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => BPOUT_8_OD,
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => BPOUT_8_OFF_RST,
      O => bp(8)
    );
  BPOUT_8_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => BPOUT_8_OFF_RST
    );
  bp_9 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => BPOUT_9_OD,
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => BPOUT_9_OFF_RST,
      O => bp(9)
    );
  BPOUT_9_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => BPOUT_9_OFF_RST
    );
  MWEN_207 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MWEN_OD,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MWEN_OFF_RST,
      O => MWEN_OBUF
    );
  MWEN_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MWEN_OFF_RST
    );
  dinl_10 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_10_IDELAY,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => DIN_10_IFF_RST,
      O => dinl(10)
    );
  DIN_10_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_10_IFF_RST
    );
  dinl_11 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_11_IDELAY,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => DIN_11_IFF_RST,
      O => dinl(11)
    );
  DIN_11_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_11_IFF_RST
    );
  dinl_12 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_12_IDELAY,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => DIN_12_IFF_RST,
      O => dinl(12)
    );
  DIN_12_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_12_IFF_RST
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
      SET => GND,
      RST => addr_0_FFY_RST,
      O => addr(0)
    );
  addr_0_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => addr_0_FFY_RST
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
      SET => GND,
      RST => addr_1_FFY_RST,
      O => addr(2)
    );
  addr_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => addr_1_FFY_RST
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
      SET => GND,
      RST => addr_3_FFY_RST,
      O => addr(4)
    );
  addr_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => addr_3_FFY_RST
    );
  dinl_13 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_13_IDELAY,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => DIN_13_IFF_RST,
      O => dinl(13)
    );
  DIN_13_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_13_IFF_RST
    );
  dinl_14 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_14_IDELAY,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => DIN_14_IFF_RST,
      O => dinl(14)
    );
  DIN_14_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_14_IFF_RST
    );
  dinl_15 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_15_IDELAY,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => DIN_15_IFF_RST,
      O => dinl(15)
    );
  DIN_15_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_15_IFF_RST
    );
  bp_10 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => BPOUT_10_OD,
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => BPOUT_10_OFF_RST,
      O => bp(10)
    );
  BPOUT_10_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => BPOUT_10_OFF_RST
    );
  bp_11 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => BPOUT_11_OD,
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => BPOUT_11_OFF_RST,
      O => bp(11)
    );
  BPOUT_11_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => BPOUT_11_OFF_RST
    );
  bp_12 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => BPOUT_12_OD,
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => BPOUT_12_OFF_RST,
      O => bp(12)
    );
  BPOUT_12_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => BPOUT_12_OFF_RST
    );
  bp_13 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => BPOUT_13_OD,
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => BPOUT_13_OFF_RST,
      O => bp(13)
    );
  BPOUT_13_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => BPOUT_13_OFF_RST
    );
  cs_FFd2_208 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd2_In,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => cs_FFd4_FFY_RST,
      O => cs_FFd2
    );
  cs_FFd4_FFY_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd4_FFY_RST
    );
  cs_FFd4_209 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd4_In,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => cs_FFd4_FFX_RST,
      O => cs_FFd4
    );
  cs_FFd4_FFX_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd4_FFX_RST
    );
  cs_FFd9_210 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd9_In,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => cs_FFd10_FFY_RST,
      O => cs_FFd9
    );
  cs_FFd10_FFY_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd10_FFY_RST
    );
  cs_FFd10_211 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd10_In_O,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => cs_FFd10_FFX_RST,
      O => cs_FFd10
    );
  cs_FFd10_FFX_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd10_FFX_RST
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
      SET => GND,
      RST => CNT_13_FFX_RST,
      O => CNT(13)
    );
  CNT_13_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => CNT_13_FFX_RST
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
      SET => GND,
      RST => CNT_11_FFY_RST,
      O => CNT(10)
    );
  CNT_11_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => CNT_11_FFY_RST
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
      SET => GND,
      RST => CNT_11_FFX_RST,
      O => CNT(11)
    );
  CNT_11_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => CNT_11_FFX_RST
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
      SET => GND,
      RST => CNT_13_FFY_RST,
      O => CNT(12)
    );
  CNT_13_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => CNT_13_FFY_RST
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
      SET => GND,
      RST => CNT_15_FFY_RST,
      O => CNT(14)
    );
  CNT_15_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => CNT_15_FFY_RST
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
      SET => GND,
      RST => addr_1_FFX_RST,
      O => addr(1)
    );
  addr_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => addr_1_FFX_RST
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
      SET => GND,
      RST => addr_3_FFX_RST,
      O => addr(3)
    );
  addr_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => addr_3_FFX_RST
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
      SET => GND,
      RST => addr_5_FFY_RST,
      O => addr(6)
    );
  addr_5_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => addr_5_FFY_RST
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
      SET => GND,
      RST => addr_9_FFY_RST,
      O => addr(10)
    );
  addr_9_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => addr_9_FFY_RST
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
      SET => GND,
      RST => addr_5_FFX_RST,
      O => addr(5)
    );
  addr_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => addr_5_FFX_RST
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
      SET => GND,
      RST => addr_7_FFY_RST,
      O => addr(8)
    );
  addr_7_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => addr_7_FFY_RST
    );
  dinint_7 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(7),
      CE => dinint_7_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => dinint_7_FFX_RST,
      O => dinint(7)
    );
  dinint_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dinint_7_FFX_RST
    );
  dinint_9 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(9),
      CE => dinint_9_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => dinint_9_FFX_RST,
      O => dinint(9)
    );
  dinint_9_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dinint_9_FFX_RST
    );
  dinint_11 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(11),
      CE => dinint_11_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => dinint_11_FFX_RST,
      O => dinint(11)
    );
  dinint_11_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dinint_11_FFX_RST
    );
  dinint_13 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(13),
      CE => dinint_13_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => dinint_13_FFX_RST,
      O => dinint(13)
    );
  dinint_13_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dinint_13_FFX_RST
    );
  dinint_15 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ldinint(15),
      CE => dinint_15_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => dinint_15_FFX_RST,
      O => dinint(15)
    );
  dinint_15_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dinint_15_FFX_RST
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
      SET => GND,
      RST => CNT_3_FFX_RST,
      O => CNT(3)
    );
  CNT_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => CNT_3_FFX_RST
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
      SET => GND,
      RST => CNT_1_FFX_RST,
      O => CNT(1)
    );
  CNT_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => CNT_1_FFX_RST
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
      SET => GND,
      RST => CNT_3_FFY_RST,
      O => CNT(2)
    );
  CNT_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => CNT_3_FFY_RST
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
      SET => GND,
      RST => CNT_5_FFX_RST,
      O => CNT(5)
    );
  CNT_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => CNT_5_FFX_RST
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
      SET => GND,
      RST => CNT_5_FFY_RST,
      O => CNT(4)
    );
  CNT_5_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => CNT_5_FFY_RST
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
      SET => GND,
      RST => CNT_7_FFX_RST,
      O => CNT(7)
    );
  CNT_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => CNT_7_FFX_RST
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
      SET => GND,
      RST => CNT_7_FFY_RST,
      O => CNT(6)
    );
  CNT_7_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => CNT_7_FFY_RST
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
      SET => GND,
      RST => CNT_9_FFX_RST,
      O => CNT(9)
    );
  CNT_9_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => CNT_9_FFX_RST
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
      SET => GND,
      RST => CNT_9_FFY_RST,
      O => CNT(8)
    );
  CNT_9_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => CNT_9_FFY_RST
    );
  cs_FFd3_1_212 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd3_1_GROM,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => cs_FFd3_1_FFY_RST,
      O => cs_FFd3_1
    );
  cs_FFd3_1_FFY_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd3_1_FFY_RST
    );
  enableintl_213 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => enableintl_GSHIFT,
      CE => enableintl_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => enableintl_FFY_RST,
      O => enableintl
    );
  enableintl_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => enableintl_FFY_RST
    );
  cs_FFd1_1_214 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd2,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => cs_FFd1_1_FFY_RST,
      O => cs_FFd1_1
    );
  cs_FFd1_1_FFY_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd1_1_FFY_RST
    );
  cs_FFd12_1_215 : X_FF
    generic map(
      XON => FALSE,
      INIT => '1'
    )
    port map (
      I => cs_FFd12_In,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => cs_FFd12_1_FFX_SET,
      RST => GND,
      O => cs_FFd12_1
    );
  cs_FFd12_1_FFX_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => RESET_IBUF,
      O => cs_FFd12_1_FFX_SET
    );
  enable_216 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => enable_LOGIC_ONE,
      CE => VCC,
      CLK => CLKIO_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => enable,
      O => enable
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
      SET => GND,
      RST => dh_1_FFY_RST,
      O => dh(0)
    );
  dh_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dh_1_FFY_RST
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
      SET => GND,
      RST => dh_3_FFY_RST,
      O => dh(2)
    );
  dh_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dh_3_FFY_RST
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
      SET => GND,
      RST => dh_1_FFX_RST,
      O => dh(1)
    );
  dh_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dh_1_FFX_RST
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
      SET => GND,
      RST => dh_3_FFX_RST,
      O => dh(3)
    );
  dh_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dh_3_FFX_RST
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
      SET => GND,
      RST => dh_5_FFY_RST,
      O => dh(4)
    );
  dh_5_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dh_5_FFY_RST
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
      SET => GND,
      RST => dh_5_FFX_RST,
      O => dh(5)
    );
  dh_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dh_5_FFX_RST
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
      SET => GND,
      RST => dh_7_FFY_RST,
      O => dh(6)
    );
  dh_7_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dh_7_FFY_RST
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
      SET => GND,
      RST => dh_7_FFX_RST,
      O => dh(7)
    );
  dh_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dh_7_FFX_RST
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
      SET => GND,
      RST => dh_9_FFY_RST,
      O => dh(8)
    );
  dh_9_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dh_9_FFY_RST
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
      SET => GND,
      RST => dh_9_FFX_RST,
      O => dh(9)
    );
  dh_9_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dh_9_FFX_RST
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
      SET => GND,
      RST => dl_1_FFY_RST,
      O => dl(0)
    );
  dl_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dl_1_FFY_RST
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
      SET => GND,
      RST => addr_13_FFX_RST,
      O => addr(13)
    );
  addr_13_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => addr_13_FFX_RST
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
      SET => GND,
      RST => addr_15_FFX_RST,
      O => addr(15)
    );
  addr_15_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => addr_15_FFX_RST
    );
  cs_FFd5_217 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd5_In1_O,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => cs_FFd6_FFY_RST,
      O => cs_FFd5
    );
  cs_FFd6_FFY_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd6_FFY_RST
    );
  cs_FFd6_218 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd6_In,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => cs_FFd6_FFX_RST,
      O => cs_FFd6
    );
  cs_FFd6_FFX_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd6_FFX_RST
    );
  cs_FFd7_219 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd7_In_O,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => cs_FFd8_FFY_RST,
      O => cs_FFd7
    );
  cs_FFd8_FFY_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd8_FFY_RST
    );
  cs_FFd8_220 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => cs_FFd8_In1_O,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => cs_FFd8_FFX_RST,
      O => cs_FFd8
    );
  cs_FFd8_FFX_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => cs_FFd8_FFX_RST
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
      SET => GND,
      RST => CNT_15_FFX_RST,
      O => CNT(15)
    );
  CNT_15_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => CNT_15_FFX_RST
    );
  newfint_221 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lnewfint,
      CE => newfint_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => newfint_FFY_RST,
      O => newfint
    );
  newfint_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => newfint_FFY_RST
    );
  den_222 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lden,
      CE => den_CEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => den_FFY_RST,
      O => den
    );
  den_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => den_FFY_RST
    );
  bp_0_1_223 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(0),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => bp_0_1_FFY_RST,
      O => bp_0_1
    );
  bp_0_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => bp_0_1_FFY_RST
    );
  bp_1_1_224 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(1),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => bp_1_1_FFY_RST,
      O => bp_1_1
    );
  bp_1_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => bp_1_1_FFY_RST
    );
  bp_2_1_225 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(2),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => bp_2_1_FFY_RST,
      O => bp_2_1
    );
  bp_2_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => bp_2_1_FFY_RST
    );
  bp_3_1_226 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(3),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => bp_3_1_FFY_RST,
      O => bp_3_1
    );
  bp_3_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => bp_3_1_FFY_RST
    );
  bp_4_1_227 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(4),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => bp_4_1_FFY_RST,
      O => bp_4_1
    );
  bp_4_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => bp_4_1_FFY_RST
    );
  bp_5_1_228 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(5),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => bp_5_1_FFY_RST,
      O => bp_5_1
    );
  bp_5_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => bp_5_1_FFY_RST
    );
  bp_6_1_229 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(6),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => bp_6_1_FFY_RST,
      O => bp_6_1
    );
  bp_6_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => bp_6_1_FFY_RST
    );
  MA_2_230 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MA_2_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MA_2_OFF_RST,
      O => MA_2
    );
  MA_2_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_2_OFF_RST
    );
  MA_3_231 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MA_3_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MA_3_OFF_RST,
      O => MA_3
    );
  MA_3_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_3_OFF_RST
    );
  MA_4_232 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MA_4_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MA_4_OFF_RST,
      O => MA_4
    );
  MA_4_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_4_OFF_RST
    );
  MA_5_233 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MA_5_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MA_5_OFF_RST,
      O => MA_5
    );
  MA_5_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_5_OFF_RST
    );
  cs_FFd3_234 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => TXFIFOWERR_OD,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => TXFIFOWERR_OFF_RST,
      O => cs_FFd3
    );
  TXFIFOWERR_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => TXFIFOWERR_OFF_RST
    );
  bp_10_1_235 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(10),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => bp_10_1_FFY_RST,
      O => bp_10_1
    );
  bp_10_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => bp_10_1_FFY_RST
    );
  bp_7_1_236 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(7),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => bp_7_1_FFY_RST,
      O => bp_7_1
    );
  bp_7_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => bp_7_1_FFY_RST
    );
  bp_11_1_237 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(11),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => bp_11_1_FFY_RST,
      O => bp_11_1
    );
  bp_11_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => bp_11_1_FFY_RST
    );
  bp_8_1_238 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(8),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => bp_8_1_FFY_RST,
      O => bp_8_1
    );
  bp_8_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => bp_8_1_FFY_RST
    );
  bp_12_1_239 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(12),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => bp_12_1_FFY_RST,
      O => bp_12_1
    );
  bp_12_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => bp_12_1_FFY_RST
    );
  bp_9_1_240 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(9),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => bp_9_1_FFY_RST,
      O => bp_9_1
    );
  bp_9_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => bp_9_1_FFY_RST
    );
  bp_13_1_241 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(13),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => bp_13_1_FFY_RST,
      O => bp_13_1
    );
  bp_13_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => bp_13_1_FFY_RST
    );
  bp_14_1_242 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(14),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => bp_14_1_FFY_RST,
      O => bp_14_1
    );
  bp_14_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => bp_14_1_FFY_RST
    );
  bp_15_1_243 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => addr(15),
      CE => Q_n0030,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => bp_15_1_FFY_RST,
      O => bp_15_1
    );
  bp_15_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => bp_15_1_FFY_RST
    );
  cs_FFd12_244 : X_FF
    generic map(
      XON => FALSE,
      INIT => '1'
    )
    port map (
      I => cs_FFd12_1_GROM,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => cs_FFd12_1_FFY_SET,
      RST => GND,
      O => cs_FFd12
    );
  cs_FFd12_1_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => RESET_IBUF,
      O => cs_FFd12_1_FFY_SET
    );
  MD_2_245 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_2_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_2_OFF_RST,
      O => MD_2
    );
  MD_2_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_2_OFF_RST
    );
  MD_3_246 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_3_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_3_OFF_RST,
      O => MD_3
    );
  MD_3_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_3_OFF_RST
    );
  MD_4_247 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_4_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_4_OFF_RST,
      O => MD_4
    );
  MD_4_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_4_OFF_RST
    );
  MD_5_248 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_5_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_5_OFF_RST,
      O => MD_5
    );
  MD_5_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_5_OFF_RST
    );
  MD_6_249 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_6_OD,
      CE => cs_Out51_1,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_6_OFF_RST,
      O => MD_6
    );
  MD_6_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_6_OFF_RST
    );
  MA_6_250 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MA_6_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MA_6_OFF_RST,
      O => MA_6
    );
  MA_6_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_6_OFF_RST
    );
  MA_7_251 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MA_7_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MA_7_OFF_RST,
      O => MA_7
    );
  MA_7_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_7_OFF_RST
    );
  MA_8_252 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MA_8_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MA_8_OFF_RST,
      O => MA_8
    );
  MA_8_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_8_OFF_RST
    );
  MA_9_253 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MA_9_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MA_9_OFF_RST,
      O => MA_9
    );
  MA_9_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_9_OFF_RST
    );
  MD_0_254 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_0_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_0_OFF_RST,
      O => MD_0
    );
  MD_0_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_0_OFF_RST
    );
  MD_1_255 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MD_1_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MD_1_OFF_RST,
      O => MD_1
    );
  MD_1_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MD_1_OFF_RST
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
      SET => GND,
      RST => dh_15_FFX_RST,
      O => dh(15)
    );
  dh_15_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dh_15_FFX_RST
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
      SET => GND,
      RST => dl_11_FFX_RST,
      O => dl(11)
    );
  dl_11_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dl_11_FFX_RST
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
      SET => GND,
      RST => dl_13_FFY_RST,
      O => dl(12)
    );
  dl_13_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dl_13_FFY_RST
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
      SET => GND,
      RST => dl_13_FFX_RST,
      O => dl(13)
    );
  dl_13_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dl_13_FFX_RST
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
      SET => GND,
      RST => dl_15_FFY_RST,
      O => dl(14)
    );
  dl_15_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dl_15_FFY_RST
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
      SET => GND,
      RST => dl_15_FFX_RST,
      O => dl(15)
    );
  dl_15_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => dl_15_FFX_RST
    );
  cs_FFd1_256 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DONE_OD,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => DONE_OFF_RST,
      O => cs_FFd1
    );
  DONE_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => DONE_OFF_RST
    );
  fifofulll_257 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => FIFOFULL_IDELAY,
      CE => FIFOFULL_ICEMUXNOT,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => FIFOFULL_IFF_RST,
      O => fifofulll
    );
  FIFOFULL_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => FIFOFULL_IFF_RST
    );
  MA_0_258 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MA_0_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MA_0_OFF_RST,
      O => MA_0
    );
  MA_0_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_0_OFF_RST
    );
  MA_1_259 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => MA_1_OD,
      CE => mrw,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => MA_1_OFF_RST,
      O => MA_1
    );
  MA_1_OFF_RSTOR : X_OR2
    port map (
      I0 => RESET_IBUF,
      I1 => GSR,
      O => MA_1_OFF_RST
    );
  CLKIO_BUF : X_CKBUF
    port map (
      I => CLKIO,
      O => CLKIO_BUFGP_IBUFG
    );
  CLK_BUF : X_CKBUF
    port map (
      I => CLK,
      O => CLK_BUFGP_IBUFG
    );
  CLKIO_BUFGP_BUFG_BUF : X_CKBUF
    port map (
      I => CLKIO_BUFGP_IBUFG,
      O => CLKIO_BUFGP
    );
  CLK_BUFGP_BUFG_BUF : X_CKBUF
    port map (
      I => CLK_BUFGP_IBUFG,
      O => CLK_BUFGP
    );
  NlwBlock_txinput_GND : X_ZERO
    port map (
      O => GND
    );
  NlwBlock_txinput_VCC : X_ONE
    port map (
      O => VCC
    );
  NlwBlockROC : X_ROC
    generic map (ROC_WIDTH => 100 ns)
    port map (O => GSR);
  NlwBlockTOC : X_TOC
    port map (O => GTS);

end Structure;

