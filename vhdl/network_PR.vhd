-- Xilinx Vhdl netlist produced by netgen application (version G.26)
-- Command       : -intstyle ise -s 6 -pcf testsuite_datain.pcf -ngm testsuite_datain.ngm -fn -rpw 100 -tpw 0 -ar Structure -xon false -w -ofmt vhdl -sim testsuite_datain.ncd network_PR.vhd 
-- Input file    : testsuite_datain.ncd
-- Output file   : network_PR.vhd
-- Design name   : testsuite_datain
-- # of Entities : 1
-- Xilinx        : C:/Xilinx
-- Device        : 2s200epq208-6 (PRODUCTION 1.17 2003-11-04)

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

entity testsuite_datain is
  port (
    ERR : out STD_LOGIC; 
    NEWFRAME : in STD_LOGIC := 'X'; 
    CLK : in STD_LOGIC := 'X'; 
    DIN : in STD_LOGIC_VECTOR ( 15 downto 0 ) 
  );
end testsuite_datain;

architecture Structure of testsuite_datain is
  signal CLK_BUFGP : STD_LOGIC; 
  signal NEWFRAME_IBUF : STD_LOGIC; 
  signal CLK_BUFGP_IBUFG : STD_LOGIC; 
  signal Mcompar_n0019_inst_cy_1 : STD_LOGIC; 
  signal Mcompar_n0019_inst_cy_3 : STD_LOGIC; 
  signal Mcompar_n0019_inst_cy_5 : STD_LOGIC; 
  signal Q_n0019 : STD_LOGIC; 
  signal Q_n00171_O : STD_LOGIC; 
  signal lnewframe : STD_LOGIC; 
  signal Q_n0016 : STD_LOGIC; 
  signal lerr : STD_LOGIC; 
  signal GSR : STD_LOGIC; 
  signal GTS : STD_LOGIC; 
  signal DIN_10_IFF_RST : STD_LOGIC; 
  signal DIN_10_IDELAY : STD_LOGIC; 
  signal DIN_10_IBUF : STD_LOGIC; 
  signal DIN_11_IFF_RST : STD_LOGIC; 
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
  signal Mcompar_n0019_inst_lut4_01_O : STD_LOGIC; 
  signal Mcompar_n0019_inst_cy_1_CYMUXG : STD_LOGIC; 
  signal Mcompar_n0019_inst_lut4_11_O : STD_LOGIC; 
  signal Mcompar_n0019_inst_cy_0 : STD_LOGIC; 
  signal Mcompar_n0019_inst_cy_1_LOGIC_ONE : STD_LOGIC; 
  signal Mcompar_n0019_inst_cy_1_LOGIC_ZERO : STD_LOGIC; 
  signal DIN_12_IFF_RST : STD_LOGIC; 
  signal Mcompar_n0019_inst_lut4_21_O : STD_LOGIC; 
  signal Mcompar_n0019_inst_cy_3_CYMUXG : STD_LOGIC; 
  signal Mcompar_n0019_inst_lut4_31_O : STD_LOGIC; 
  signal Mcompar_n0019_inst_cy_2 : STD_LOGIC; 
  signal Mcompar_n0019_inst_cy_3_LOGIC_ONE : STD_LOGIC; 
  signal Mcompar_n0019_inst_cy_3_CYINIT : STD_LOGIC; 
  signal Mcompar_n0019_inst_lut4_41_O : STD_LOGIC; 
  signal Mcompar_n0019_inst_cy_5_CYMUXG : STD_LOGIC; 
  signal Mcompar_n0019_inst_lut4_51_O : STD_LOGIC; 
  signal Mcompar_n0019_inst_cy_4 : STD_LOGIC; 
  signal Mcompar_n0019_inst_cy_5_LOGIC_ONE : STD_LOGIC; 
  signal Mcompar_n0019_inst_cy_5_CYINIT : STD_LOGIC; 
  signal Mcompar_n0019_inst_lut4_61_O : STD_LOGIC; 
  signal Q_n0019_CYMUXG : STD_LOGIC; 
  signal Mcompar_n0019_inst_lut4_71_O : STD_LOGIC; 
  signal Mcompar_n0019_inst_cy_6 : STD_LOGIC; 
  signal Q_n0019_LOGIC_ONE : STD_LOGIC; 
  signal Q_n0019_CYINIT : STD_LOGIC; 
  signal lerr_FROM : STD_LOGIC; 
  signal lerr_GROM : STD_LOGIC; 
  signal lerr_LOGIC_ONE : STD_LOGIC; 
  signal lfsr_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal Q_n0056 : STD_LOGIC; 
  signal lfsr_11_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal lfsr_13_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal lfsr_15_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal lfsr_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal lfsr_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal lfsr_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal DIN_13_IFF_RST : STD_LOGIC; 
  signal lfsr_9_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal DIN_0_IDELAY : STD_LOGIC; 
  signal DIN_0_IBUF : STD_LOGIC; 
  signal DIN_1_IDELAY : STD_LOGIC; 
  signal DIN_1_IBUF : STD_LOGIC; 
  signal DIN_2_IDELAY : STD_LOGIC; 
  signal DIN_2_IBUF : STD_LOGIC; 
  signal DIN_3_IDELAY : STD_LOGIC; 
  signal DIN_3_IBUF : STD_LOGIC; 
  signal DIN_4_IDELAY : STD_LOGIC; 
  signal DIN_4_IBUF : STD_LOGIC; 
  signal DIN_14_IFF_RST : STD_LOGIC; 
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
  signal ERR_ENABLE : STD_LOGIC; 
  signal ERR_TORGTS : STD_LOGIC; 
  signal ERR_OUTMUX : STD_LOGIC; 
  signal ERR_OBUF : STD_LOGIC; 
  signal ERR_OD : STD_LOGIC; 
  signal NEWFRAME_IDELAY : STD_LOGIC; 
  signal NEWFRAME_IBUF_0 : STD_LOGIC; 
  signal DIN_15_IFF_RST : STD_LOGIC; 
  signal DIN_0_IFF_RST : STD_LOGIC; 
  signal DIN_1_IFF_RST : STD_LOGIC; 
  signal DIN_2_IFF_RST : STD_LOGIC; 
  signal DIN_3_IFF_RST : STD_LOGIC; 
  signal DIN_4_IFF_RST : STD_LOGIC; 
  signal DIN_5_IFF_RST : STD_LOGIC; 
  signal DIN_6_IFF_RST : STD_LOGIC; 
  signal DIN_7_IFF_RST : STD_LOGIC; 
  signal DIN_8_IFF_RST : STD_LOGIC; 
  signal lfsrl_1_FFY_RST : STD_LOGIC; 
  signal lfsrl_1_FFX_RST : STD_LOGIC; 
  signal lfsrl_3_FFY_RST : STD_LOGIC; 
  signal lfsrl_3_FFX_RST : STD_LOGIC; 
  signal lfsrl_5_FFY_RST : STD_LOGIC; 
  signal lfsrl_5_FFX_RST : STD_LOGIC; 
  signal lfsrl_7_FFY_RST : STD_LOGIC; 
  signal lfsrl_7_FFX_RST : STD_LOGIC; 
  signal lfsrl_9_FFY_RST : STD_LOGIC; 
  signal lfsrl_9_FFX_RST : STD_LOGIC; 
  signal lfsrl_11_FFY_RST : STD_LOGIC; 
  signal lfsrl_11_FFX_RST : STD_LOGIC; 
  signal lfsrl_13_FFY_RST : STD_LOGIC; 
  signal lfsrl_13_FFX_RST : STD_LOGIC; 
  signal lfsrl_15_FFY_RST : STD_LOGIC; 
  signal lfsrl_15_FFX_RST : STD_LOGIC; 
  signal DIN_9_IFF_RST : STD_LOGIC; 
  signal ERR_OFF_RST : STD_LOGIC; 
  signal NEWFRAME_IFF_RST : STD_LOGIC; 
  signal CLK_BUFGP_BUFG_CE : STD_LOGIC; 
  signal GND : STD_LOGIC; 
  signal VCC : STD_LOGIC; 
  signal dinl : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal lfsrl : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal lfsr : STD_LOGIC_VECTOR ( 15 downto 0 ); 
begin
  DIN_10_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_10_IFF_RST
    );
  dinl_10 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_10_IDELAY,
      CE => NEWFRAME_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => DIN_10_IFF_RST,
      O => dinl(10)
    );
  DIN_10_IBUF_1 : X_BUF
    port map (
      I => DIN(10),
      O => DIN_10_IBUF
    );
  DIN_10_DELAY : X_BUF
    port map (
      I => DIN_10_IBUF,
      O => DIN_10_IDELAY
    );
  DIN_11_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_11_IFF_RST
    );
  dinl_11 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_11_IDELAY,
      CE => NEWFRAME_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => DIN_11_IFF_RST,
      O => dinl(11)
    );
  DIN_11_IBUF_2 : X_BUF
    port map (
      I => DIN(11),
      O => DIN_11_IBUF
    );
  DIN_11_DELAY : X_BUF
    port map (
      I => DIN_11_IBUF,
      O => DIN_11_IDELAY
    );
  DIN_12_IBUF_3 : X_BUF
    port map (
      I => DIN(12),
      O => DIN_12_IBUF
    );
  DIN_12_DELAY : X_BUF
    port map (
      I => DIN_12_IBUF,
      O => DIN_12_IDELAY
    );
  DIN_13_IBUF_4 : X_BUF
    port map (
      I => DIN(13),
      O => DIN_13_IBUF
    );
  DIN_13_DELAY : X_BUF
    port map (
      I => DIN_13_IBUF,
      O => DIN_13_IDELAY
    );
  DIN_14_IBUF_5 : X_BUF
    port map (
      I => DIN(14),
      O => DIN_14_IBUF
    );
  DIN_14_DELAY : X_BUF
    port map (
      I => DIN_14_IBUF,
      O => DIN_14_IDELAY
    );
  DIN_15_IBUF_6 : X_BUF
    port map (
      I => DIN(15),
      O => DIN_15_IBUF
    );
  DIN_15_DELAY : X_BUF
    port map (
      I => DIN_15_IBUF,
      O => DIN_15_IDELAY
    );
  Mcompar_n0019_inst_cy_1_LOGIC_ZERO_7 : X_ZERO
    port map (
      O => Mcompar_n0019_inst_cy_1_LOGIC_ZERO
    );
  Mcompar_n0019_inst_cy_1_LOGIC_ONE_8 : X_ONE
    port map (
      O => Mcompar_n0019_inst_cy_1_LOGIC_ONE
    );
  Mcompar_n0019_inst_cy_0_9 : X_MUX2
    port map (
      IA => Mcompar_n0019_inst_cy_1_LOGIC_ONE,
      IB => Mcompar_n0019_inst_cy_1_LOGIC_ZERO,
      SEL => Mcompar_n0019_inst_lut4_01_O,
      O => Mcompar_n0019_inst_cy_0
    );
  Mcompar_n0019_inst_lut4_01 : X_LUT4
    generic map(
      INIT => X"8241"
    )
    port map (
      ADR0 => dinl(0),
      ADR1 => dinl(1),
      ADR2 => lfsrl(1),
      ADR3 => lfsrl(0),
      O => Mcompar_n0019_inst_lut4_01_O
    );
  Mcompar_n0019_inst_lut4_11 : X_LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      ADR0 => dinl(2),
      ADR1 => lfsrl(2),
      ADR2 => dinl(3),
      ADR3 => lfsrl(3),
      O => Mcompar_n0019_inst_lut4_11_O
    );
  Mcompar_n0019_inst_cy_1_COUTUSED : X_BUF
    port map (
      I => Mcompar_n0019_inst_cy_1_CYMUXG,
      O => Mcompar_n0019_inst_cy_1
    );
  Mcompar_n0019_inst_cy_1_10 : X_MUX2
    port map (
      IA => Mcompar_n0019_inst_cy_1_LOGIC_ONE,
      IB => Mcompar_n0019_inst_cy_0,
      SEL => Mcompar_n0019_inst_lut4_11_O,
      O => Mcompar_n0019_inst_cy_1_CYMUXG
    );
  dinl_12 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_12_IDELAY,
      CE => NEWFRAME_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => DIN_12_IFF_RST,
      O => dinl(12)
    );
  DIN_12_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_12_IFF_RST
    );
  Mcompar_n0019_inst_cy_3_LOGIC_ONE_11 : X_ONE
    port map (
      O => Mcompar_n0019_inst_cy_3_LOGIC_ONE
    );
  Mcompar_n0019_inst_cy_2_12 : X_MUX2
    port map (
      IA => Mcompar_n0019_inst_cy_3_LOGIC_ONE,
      IB => Mcompar_n0019_inst_cy_3_CYINIT,
      SEL => Mcompar_n0019_inst_lut4_21_O,
      O => Mcompar_n0019_inst_cy_2
    );
  Mcompar_n0019_inst_lut4_21 : X_LUT4
    generic map(
      INIT => X"8421"
    )
    port map (
      ADR0 => dinl(5),
      ADR1 => lfsrl(4),
      ADR2 => lfsrl(5),
      ADR3 => dinl(4),
      O => Mcompar_n0019_inst_lut4_21_O
    );
  Mcompar_n0019_inst_lut4_31 : X_LUT4
    generic map(
      INIT => X"8421"
    )
    port map (
      ADR0 => lfsrl(6),
      ADR1 => lfsrl(7),
      ADR2 => dinl(6),
      ADR3 => dinl(7),
      O => Mcompar_n0019_inst_lut4_31_O
    );
  Mcompar_n0019_inst_cy_3_COUTUSED : X_BUF
    port map (
      I => Mcompar_n0019_inst_cy_3_CYMUXG,
      O => Mcompar_n0019_inst_cy_3
    );
  Mcompar_n0019_inst_cy_3_13 : X_MUX2
    port map (
      IA => Mcompar_n0019_inst_cy_3_LOGIC_ONE,
      IB => Mcompar_n0019_inst_cy_2,
      SEL => Mcompar_n0019_inst_lut4_31_O,
      O => Mcompar_n0019_inst_cy_3_CYMUXG
    );
  Mcompar_n0019_inst_cy_3_CYINIT_14 : X_BUF
    port map (
      I => Mcompar_n0019_inst_cy_1,
      O => Mcompar_n0019_inst_cy_3_CYINIT
    );
  Mcompar_n0019_inst_cy_5_LOGIC_ONE_15 : X_ONE
    port map (
      O => Mcompar_n0019_inst_cy_5_LOGIC_ONE
    );
  Mcompar_n0019_inst_cy_4_16 : X_MUX2
    port map (
      IA => Mcompar_n0019_inst_cy_5_LOGIC_ONE,
      IB => Mcompar_n0019_inst_cy_5_CYINIT,
      SEL => Mcompar_n0019_inst_lut4_41_O,
      O => Mcompar_n0019_inst_cy_4
    );
  Mcompar_n0019_inst_lut4_41 : X_LUT4
    generic map(
      INIT => X"8421"
    )
    port map (
      ADR0 => lfsrl(9),
      ADR1 => dinl(8),
      ADR2 => dinl(9),
      ADR3 => lfsrl(8),
      O => Mcompar_n0019_inst_lut4_41_O
    );
  Mcompar_n0019_inst_lut4_51 : X_LUT4
    generic map(
      INIT => X"8241"
    )
    port map (
      ADR0 => lfsrl(10),
      ADR1 => lfsrl(11),
      ADR2 => dinl(11),
      ADR3 => dinl(10),
      O => Mcompar_n0019_inst_lut4_51_O
    );
  Mcompar_n0019_inst_cy_5_COUTUSED : X_BUF
    port map (
      I => Mcompar_n0019_inst_cy_5_CYMUXG,
      O => Mcompar_n0019_inst_cy_5
    );
  Mcompar_n0019_inst_cy_5_17 : X_MUX2
    port map (
      IA => Mcompar_n0019_inst_cy_5_LOGIC_ONE,
      IB => Mcompar_n0019_inst_cy_4,
      SEL => Mcompar_n0019_inst_lut4_51_O,
      O => Mcompar_n0019_inst_cy_5_CYMUXG
    );
  Mcompar_n0019_inst_cy_5_CYINIT_18 : X_BUF
    port map (
      I => Mcompar_n0019_inst_cy_3,
      O => Mcompar_n0019_inst_cy_5_CYINIT
    );
  Q_n0019_LOGIC_ONE_19 : X_ONE
    port map (
      O => Q_n0019_LOGIC_ONE
    );
  Mcompar_n0019_inst_cy_6_20 : X_MUX2
    port map (
      IA => Q_n0019_LOGIC_ONE,
      IB => Q_n0019_CYINIT,
      SEL => Mcompar_n0019_inst_lut4_61_O,
      O => Mcompar_n0019_inst_cy_6
    );
  Mcompar_n0019_inst_lut4_61 : X_LUT4
    generic map(
      INIT => X"8421"
    )
    port map (
      ADR0 => dinl(13),
      ADR1 => lfsrl(12),
      ADR2 => lfsrl(13),
      ADR3 => dinl(12),
      O => Mcompar_n0019_inst_lut4_61_O
    );
  Mcompar_n0019_inst_lut4_71 : X_LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      ADR0 => dinl(15),
      ADR1 => lfsrl(15),
      ADR2 => dinl(14),
      ADR3 => lfsrl(14),
      O => Mcompar_n0019_inst_lut4_71_O
    );
  Q_n0019_COUTUSED : X_BUF
    port map (
      I => Q_n0019_CYMUXG,
      O => Q_n0019
    );
  Mcompar_n0019_inst_cy_7 : X_MUX2
    port map (
      IA => Q_n0019_LOGIC_ONE,
      IB => Mcompar_n0019_inst_cy_6,
      SEL => Mcompar_n0019_inst_lut4_71_O,
      O => Q_n0019_CYMUXG
    );
  Q_n0019_CYINIT_21 : X_BUF
    port map (
      I => Mcompar_n0019_inst_cy_5,
      O => Q_n0019_CYINIT
    );
  lerr_LOGIC_ONE_22 : X_ONE
    port map (
      O => lerr_LOGIC_ONE
    );
  Q_n00161 : X_LUT4
    generic map(
      INIT => X"3300"
    )
    port map (
      ADR0 => VCC,
      ADR1 => lnewframe,
      ADR2 => VCC,
      ADR3 => NEWFRAME_IBUF,
      O => lerr_FROM
    );
  Q_n00171 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Q_n0019,
      ADR2 => VCC,
      ADR3 => lnewframe,
      O => lerr_GROM
    );
  lerr_XUSED : X_BUF
    port map (
      I => lerr_FROM,
      O => Q_n0016
    );
  lerr_YUSED : X_BUF
    port map (
      I => lerr_GROM,
      O => Q_n00171_O
    );
  Q_n00561 : X_LUT4
    generic map(
      INIT => X"9669"
    )
    port map (
      ADR0 => lfsr(3),
      ADR1 => lfsr(14),
      ADR2 => lfsr(15),
      ADR3 => lfsr(12),
      O => Q_n0056
    );
  lfsr_1_SRMUX : X_INV
    port map (
      I => NEWFRAME_IBUF,
      O => lfsr_1_SRMUX_OUTPUTNOT
    );
  lfsr_10 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(9),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => lfsr_11_SRMUX_OUTPUTNOT,
      O => lfsr(10)
    );
  lfsr_11_SRMUX : X_INV
    port map (
      I => NEWFRAME_IBUF,
      O => lfsr_11_SRMUX_OUTPUTNOT
    );
  lfsr_12 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(11),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => lfsr_13_SRMUX_OUTPUTNOT,
      O => lfsr(12)
    );
  lfsr_13_SRMUX : X_INV
    port map (
      I => NEWFRAME_IBUF,
      O => lfsr_13_SRMUX_OUTPUTNOT
    );
  lfsr_15_SRMUX : X_INV
    port map (
      I => NEWFRAME_IBUF,
      O => lfsr_15_SRMUX_OUTPUTNOT
    );
  lfsr_3_SRMUX : X_INV
    port map (
      I => NEWFRAME_IBUF,
      O => lfsr_3_SRMUX_OUTPUTNOT
    );
  lfsr_5_SRMUX : X_INV
    port map (
      I => NEWFRAME_IBUF,
      O => lfsr_5_SRMUX_OUTPUTNOT
    );
  lfsr_6 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(5),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => lfsr_7_SRMUX_OUTPUTNOT,
      O => lfsr(6)
    );
  lfsr_7_SRMUX : X_INV
    port map (
      I => NEWFRAME_IBUF,
      O => lfsr_7_SRMUX_OUTPUTNOT
    );
  dinl_13 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_13_IDELAY,
      CE => NEWFRAME_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => DIN_13_IFF_RST,
      O => dinl(13)
    );
  DIN_13_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_13_IFF_RST
    );
  lfsr_8 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(7),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => lfsr_9_SRMUX_OUTPUTNOT,
      O => lfsr(8)
    );
  lfsr_9_SRMUX : X_INV
    port map (
      I => NEWFRAME_IBUF,
      O => lfsr_9_SRMUX_OUTPUTNOT
    );
  DIN_0_IBUF_23 : X_BUF
    port map (
      I => DIN(0),
      O => DIN_0_IBUF
    );
  DIN_0_DELAY : X_BUF
    port map (
      I => DIN_0_IBUF,
      O => DIN_0_IDELAY
    );
  DIN_1_IBUF_24 : X_BUF
    port map (
      I => DIN(1),
      O => DIN_1_IBUF
    );
  DIN_1_DELAY : X_BUF
    port map (
      I => DIN_1_IBUF,
      O => DIN_1_IDELAY
    );
  DIN_2_IBUF_25 : X_BUF
    port map (
      I => DIN(2),
      O => DIN_2_IBUF
    );
  DIN_2_DELAY : X_BUF
    port map (
      I => DIN_2_IBUF,
      O => DIN_2_IDELAY
    );
  DIN_3_IBUF_26 : X_BUF
    port map (
      I => DIN(3),
      O => DIN_3_IBUF
    );
  DIN_3_DELAY : X_BUF
    port map (
      I => DIN_3_IBUF,
      O => DIN_3_IDELAY
    );
  DIN_4_IBUF_27 : X_BUF
    port map (
      I => DIN(4),
      O => DIN_4_IBUF
    );
  DIN_4_DELAY : X_BUF
    port map (
      I => DIN_4_IBUF,
      O => DIN_4_IDELAY
    );
  dinl_14 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_14_IDELAY,
      CE => NEWFRAME_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => DIN_14_IFF_RST,
      O => dinl(14)
    );
  DIN_14_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_14_IFF_RST
    );
  DIN_5_IBUF_28 : X_BUF
    port map (
      I => DIN(5),
      O => DIN_5_IBUF
    );
  DIN_5_DELAY : X_BUF
    port map (
      I => DIN_5_IBUF,
      O => DIN_5_IDELAY
    );
  DIN_6_IBUF_29 : X_BUF
    port map (
      I => DIN(6),
      O => DIN_6_IBUF
    );
  DIN_6_DELAY : X_BUF
    port map (
      I => DIN_6_IBUF,
      O => DIN_6_IDELAY
    );
  DIN_7_IBUF_30 : X_BUF
    port map (
      I => DIN(7),
      O => DIN_7_IBUF
    );
  DIN_7_DELAY : X_BUF
    port map (
      I => DIN_7_IBUF,
      O => DIN_7_IDELAY
    );
  DIN_8_IBUF_31 : X_BUF
    port map (
      I => DIN(8),
      O => DIN_8_IBUF
    );
  DIN_8_DELAY : X_BUF
    port map (
      I => DIN_8_IBUF,
      O => DIN_8_IDELAY
    );
  DIN_9_IBUF_32 : X_BUF
    port map (
      I => DIN(9),
      O => DIN_9_IBUF
    );
  DIN_9_DELAY : X_BUF
    port map (
      I => DIN_9_IBUF,
      O => DIN_9_IDELAY
    );
  ERR_OBUF_33 : X_TRI
    port map (
      I => ERR_OUTMUX,
      CTL => ERR_ENABLE,
      O => ERR
    );
  ERR_ENABLEINV : X_INV
    port map (
      I => ERR_TORGTS,
      O => ERR_ENABLE
    );
  ERR_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => ERR_TORGTS
    );
  ERR_OUTMUX_34 : X_BUF
    port map (
      I => ERR_OBUF,
      O => ERR_OUTMUX
    );
  ERR_OMUX : X_BUF
    port map (
      I => lerr,
      O => ERR_OD
    );
  NEWFRAME_IMUX : X_BUF
    port map (
      I => NEWFRAME_IBUF_0,
      O => NEWFRAME_IBUF
    );
  NEWFRAME_IBUF_35 : X_BUF
    port map (
      I => NEWFRAME,
      O => NEWFRAME_IBUF_0
    );
  NEWFRAME_DELAY : X_BUF
    port map (
      I => NEWFRAME_IBUF_0,
      O => NEWFRAME_IDELAY
    );
  dinl_15 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_15_IDELAY,
      CE => NEWFRAME_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => DIN_15_IFF_RST,
      O => dinl(15)
    );
  DIN_15_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_15_IFF_RST
    );
  lerr_36 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lerr_LOGIC_ONE,
      CE => Q_n00171_O,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => Q_n0016,
      O => lerr
    );
  lfsr_0 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => Q_n0056,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => lfsr_1_SRMUX_OUTPUTNOT,
      O => lfsr(0)
    );
  dinl_0 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_0_IDELAY,
      CE => NEWFRAME_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => DIN_0_IFF_RST,
      O => dinl(0)
    );
  DIN_0_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_0_IFF_RST
    );
  dinl_1 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_1_IDELAY,
      CE => NEWFRAME_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => DIN_1_IFF_RST,
      O => dinl(1)
    );
  DIN_1_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_1_IFF_RST
    );
  dinl_2 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_2_IDELAY,
      CE => NEWFRAME_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => DIN_2_IFF_RST,
      O => dinl(2)
    );
  DIN_2_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_2_IFF_RST
    );
  dinl_3 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_3_IDELAY,
      CE => NEWFRAME_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => DIN_3_IFF_RST,
      O => dinl(3)
    );
  DIN_3_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_3_IFF_RST
    );
  dinl_4 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_4_IDELAY,
      CE => NEWFRAME_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => DIN_4_IFF_RST,
      O => dinl(4)
    );
  DIN_4_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_4_IFF_RST
    );
  dinl_5 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_5_IDELAY,
      CE => NEWFRAME_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => DIN_5_IFF_RST,
      O => dinl(5)
    );
  DIN_5_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_5_IFF_RST
    );
  dinl_6 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_6_IDELAY,
      CE => NEWFRAME_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => DIN_6_IFF_RST,
      O => dinl(6)
    );
  DIN_6_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_6_IFF_RST
    );
  dinl_7 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_7_IDELAY,
      CE => NEWFRAME_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => DIN_7_IFF_RST,
      O => dinl(7)
    );
  DIN_7_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_7_IFF_RST
    );
  dinl_8 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_8_IDELAY,
      CE => NEWFRAME_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => DIN_8_IFF_RST,
      O => dinl(8)
    );
  DIN_8_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_8_IFF_RST
    );
  lfsr_1 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(0),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => lfsr_1_SRMUX_OUTPUTNOT,
      O => lfsr(1)
    );
  lfsr_11 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(10),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => lfsr_11_SRMUX_OUTPUTNOT,
      O => lfsr(11)
    );
  lfsr_14 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(13),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => lfsr_15_SRMUX_OUTPUTNOT,
      O => lfsr(14)
    );
  lfsr_13 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(12),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => lfsr_13_SRMUX_OUTPUTNOT,
      O => lfsr(13)
    );
  lfsr_15 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(14),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => lfsr_15_SRMUX_OUTPUTNOT,
      O => lfsr(15)
    );
  lfsr_2 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(1),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => lfsr_3_SRMUX_OUTPUTNOT,
      O => lfsr(2)
    );
  lfsr_4 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(3),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => lfsr_5_SRMUX_OUTPUTNOT,
      O => lfsr(4)
    );
  lfsr_3 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(2),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => lfsr_3_SRMUX_OUTPUTNOT,
      O => lfsr(3)
    );
  lfsr_5 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(4),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => lfsr_5_SRMUX_OUTPUTNOT,
      O => lfsr(5)
    );
  lfsr_7 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(6),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => lfsr_7_SRMUX_OUTPUTNOT,
      O => lfsr(7)
    );
  lfsrl_0 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(0),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => lfsrl_1_FFY_RST,
      O => lfsrl(0)
    );
  lfsrl_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => lfsrl_1_FFY_RST
    );
  lfsr_9 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(8),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => lfsr_9_SRMUX_OUTPUTNOT,
      O => lfsr(9)
    );
  lfsrl_1 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(1),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => lfsrl_1_FFX_RST,
      O => lfsrl(1)
    );
  lfsrl_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => lfsrl_1_FFX_RST
    );
  lfsrl_2 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(2),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => lfsrl_3_FFY_RST,
      O => lfsrl(2)
    );
  lfsrl_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => lfsrl_3_FFY_RST
    );
  lfsrl_3 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(3),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => lfsrl_3_FFX_RST,
      O => lfsrl(3)
    );
  lfsrl_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => lfsrl_3_FFX_RST
    );
  lfsrl_4 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(4),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => lfsrl_5_FFY_RST,
      O => lfsrl(4)
    );
  lfsrl_5_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => lfsrl_5_FFY_RST
    );
  lfsrl_5 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(5),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => lfsrl_5_FFX_RST,
      O => lfsrl(5)
    );
  lfsrl_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => lfsrl_5_FFX_RST
    );
  lfsrl_6 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(6),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => lfsrl_7_FFY_RST,
      O => lfsrl(6)
    );
  lfsrl_7_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => lfsrl_7_FFY_RST
    );
  lfsrl_7 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(7),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => lfsrl_7_FFX_RST,
      O => lfsrl(7)
    );
  lfsrl_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => lfsrl_7_FFX_RST
    );
  lfsrl_8 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(8),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => lfsrl_9_FFY_RST,
      O => lfsrl(8)
    );
  lfsrl_9_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => lfsrl_9_FFY_RST
    );
  lfsrl_9 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(9),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => lfsrl_9_FFX_RST,
      O => lfsrl(9)
    );
  lfsrl_9_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => lfsrl_9_FFX_RST
    );
  lfsrl_10 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(10),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => lfsrl_11_FFY_RST,
      O => lfsrl(10)
    );
  lfsrl_11_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => lfsrl_11_FFY_RST
    );
  lfsrl_11 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(11),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => lfsrl_11_FFX_RST,
      O => lfsrl(11)
    );
  lfsrl_11_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => lfsrl_11_FFX_RST
    );
  lfsrl_12 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(12),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => lfsrl_13_FFY_RST,
      O => lfsrl(12)
    );
  lfsrl_13_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => lfsrl_13_FFY_RST
    );
  lfsrl_13 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(13),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => lfsrl_13_FFX_RST,
      O => lfsrl(13)
    );
  lfsrl_13_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => lfsrl_13_FFX_RST
    );
  lfsrl_14 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(14),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => lfsrl_15_FFY_RST,
      O => lfsrl(14)
    );
  lfsrl_15_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => lfsrl_15_FFY_RST
    );
  lfsrl_15 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => lfsr(15),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => lfsrl_15_FFX_RST,
      O => lfsrl(15)
    );
  lfsrl_15_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => lfsrl_15_FFX_RST
    );
  dinl_9 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => DIN_9_IDELAY,
      CE => NEWFRAME_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => DIN_9_IFF_RST,
      O => dinl(9)
    );
  DIN_9_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => DIN_9_IFF_RST
    );
  ERR_37 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ERR_OD,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => ERR_OFF_RST,
      O => ERR_OBUF
    );
  ERR_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => ERR_OFF_RST
    );
  lnewframe_38 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => NEWFRAME_IDELAY,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => NEWFRAME_IFF_RST,
      O => lnewframe
    );
  NEWFRAME_IFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => NEWFRAME_IFF_RST
    );
  CLK_BUF : X_CKBUF
    port map (
      I => CLK,
      O => CLK_BUFGP_IBUFG
    );
  CLK_BUFGP_BUFG_BUF : X_CKBUF
    port map (
      I => CLK_BUFGP_IBUFG,
      O => CLK_BUFGP
    );
  NlwBlock_testsuite_datain_GND : X_ZERO
    port map (
      O => GND
    );
  NlwBlock_testsuite_datain_VCC : X_ONE
    port map (
      O => VCC
    );
  NlwBlockROC : X_ROC
    generic map (ROC_WIDTH => 100 ns)
    port map (O => GSR);
  NlwBlockTOC : X_TOC
    port map (O => GTS);

end Structure;

