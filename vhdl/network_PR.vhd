-- Xilinx Vhdl netlist produced by netgen application (version G.25a)
-- Command       : -intstyle ise -s 6 -pcf testsuite.pcf -ngm testsuite.ngm -rpw 100 -tpw 0 -ar Structure -xon false -w -ofmt vhdl -sim testsuite_map.ncd network_PR.vhd 
-- Input file    : testsuite_map.ncd
-- Output file   : network_PR.vhd
-- Design name   : testsuite
-- # of Entities : 7
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

entity testsuite_tx is
  port (
    CLK : in STD_LOGIC := 'X'; 
    RESET : in STD_LOGIC := 'X'; 
    TX_EN : out STD_LOGIC; 
    TXD : out STD_LOGIC_VECTOR ( 7 downto 0 ) 
  );
end testsuite_tx;

architecture Structure of testsuite_tx is
  signal GSR : STD_LOGIC;
  signal GTS : STD_LOGIC;
  signal CHOICE719 : STD_LOGIC; 
  signal CHOICE726 : STD_LOGIC; 
  signal CHOICE747 : STD_LOGIC; 
  signal N27402 : STD_LOGIC; 
  signal Q_n0001 : STD_LOGIC; 
  signal Q_n0001126_1 : STD_LOGIC; 
  signal CHOICE753 : STD_LOGIC; 
  signal CHOICE734 : STD_LOGIC; 
  signal CHOICE741 : STD_LOGIC; 
  signal N1261 : STD_LOGIC; 
  signal NlwRenamedSig_OI_TX_EN : STD_LOGIC; 
  signal txsim_counter_2_FROM : STD_LOGIC; 
  signal txsim_counter_2_CYMUXG : STD_LOGIC; 
  signal txsim_counter_2_LOGIC_ZERO : STD_LOGIC; 
  signal txsim_counter_2_GROM : STD_LOGIC; 
  signal counter_Madd_n0000_inst_cy_2 : STD_LOGIC; 
  signal txsim_counter_2_CYINIT : STD_LOGIC; 
  signal txsim_counter_8_FROM : STD_LOGIC; 
  signal txsim_counter_8_CYMUXG : STD_LOGIC; 
  signal txsim_counter_8_LOGIC_ZERO : STD_LOGIC; 
  signal txsim_counter_8_GROM : STD_LOGIC; 
  signal counter_Madd_n0000_inst_cy_8 : STD_LOGIC; 
  signal txsim_counter_8_CYINIT : STD_LOGIC; 
  signal txsim_counter_6_FROM : STD_LOGIC; 
  signal txsim_counter_6_CYMUXG : STD_LOGIC; 
  signal txsim_counter_6_LOGIC_ZERO : STD_LOGIC; 
  signal txsim_counter_6_GROM : STD_LOGIC; 
  signal counter_Madd_n0000_inst_cy_6 : STD_LOGIC; 
  signal txsim_counter_6_CYINIT : STD_LOGIC; 
  signal txsim_counter_4_FROM : STD_LOGIC; 
  signal txsim_counter_4_CYMUXG : STD_LOGIC; 
  signal txsim_counter_4_LOGIC_ZERO : STD_LOGIC; 
  signal txsim_counter_4_GROM : STD_LOGIC; 
  signal counter_Madd_n0000_inst_cy_4 : STD_LOGIC; 
  signal txsim_counter_4_CYINIT : STD_LOGIC; 
  signal txsim_counter_22_LOGIC_ZERO : STD_LOGIC; 
  signal txsim_counter_22_FROM : STD_LOGIC; 
  signal counter_23_rt : STD_LOGIC; 
  signal counter_Madd_n0000_inst_cy_22 : STD_LOGIC; 
  signal txsim_counter_22_CYINIT : STD_LOGIC; 
  signal txsim_counter_20_FROM : STD_LOGIC; 
  signal txsim_counter_20_CYMUXG : STD_LOGIC; 
  signal txsim_counter_20_LOGIC_ZERO : STD_LOGIC; 
  signal txsim_counter_20_GROM : STD_LOGIC; 
  signal counter_Madd_n0000_inst_cy_20 : STD_LOGIC; 
  signal txsim_counter_20_CYINIT : STD_LOGIC; 
  signal txsim_counter_18_FROM : STD_LOGIC; 
  signal txsim_counter_18_CYMUXG : STD_LOGIC; 
  signal txsim_counter_18_LOGIC_ZERO : STD_LOGIC; 
  signal txsim_counter_18_GROM : STD_LOGIC; 
  signal counter_Madd_n0000_inst_cy_18 : STD_LOGIC; 
  signal txsim_counter_18_CYINIT : STD_LOGIC; 
  signal txsim_counter_16_FROM : STD_LOGIC; 
  signal txsim_counter_16_CYMUXG : STD_LOGIC; 
  signal txsim_counter_16_LOGIC_ZERO : STD_LOGIC; 
  signal txsim_counter_16_GROM : STD_LOGIC; 
  signal counter_Madd_n0000_inst_cy_16 : STD_LOGIC; 
  signal txsim_counter_16_CYINIT : STD_LOGIC; 
  signal txsim_counter_14_FROM : STD_LOGIC; 
  signal txsim_counter_14_CYMUXG : STD_LOGIC; 
  signal txsim_counter_14_LOGIC_ZERO : STD_LOGIC; 
  signal txsim_counter_14_GROM : STD_LOGIC; 
  signal counter_Madd_n0000_inst_cy_14 : STD_LOGIC; 
  signal txsim_counter_14_CYINIT : STD_LOGIC; 
  signal txsim_CHOICE719_FROM : STD_LOGIC; 
  signal txsim_CHOICE719_GROM : STD_LOGIC; 
  signal TXD_0_ENABLE : STD_LOGIC; 
  signal TXD_0_TORGTS : STD_LOGIC; 
  signal TXD_0_OUTMUX : STD_LOGIC; 
  signal TXD_0_OBUF : STD_LOGIC; 
  signal TXD_0_OD : STD_LOGIC; 
  signal txsim_CHOICE734_GROM : STD_LOGIC; 
  signal txsim_counter_12_FROM : STD_LOGIC; 
  signal txsim_counter_12_CYMUXG : STD_LOGIC; 
  signal txsim_counter_12_LOGIC_ZERO : STD_LOGIC; 
  signal txsim_counter_12_GROM : STD_LOGIC; 
  signal counter_Madd_n0000_inst_cy_12 : STD_LOGIC; 
  signal txsim_counter_12_CYINIT : STD_LOGIC; 
  signal txsim_counter_10_FROM : STD_LOGIC; 
  signal txsim_counter_10_CYMUXG : STD_LOGIC; 
  signal txsim_counter_10_LOGIC_ZERO : STD_LOGIC; 
  signal txsim_counter_10_GROM : STD_LOGIC; 
  signal counter_Madd_n0000_inst_cy_10 : STD_LOGIC; 
  signal txsim_counter_10_CYINIT : STD_LOGIC; 
  signal txsim_CHOICE726_GROM : STD_LOGIC; 
  signal counter_Madd_n0000_inst_lut2_0 : STD_LOGIC; 
  signal txsim_counter_0_CYMUXG : STD_LOGIC; 
  signal txsim_counter_0_GROM : STD_LOGIC; 
  signal counter_Madd_n0000_inst_cy_0 : STD_LOGIC; 
  signal txsim_counter_0_LOGIC_ZERO : STD_LOGIC; 
  signal txsim_N27402_FROM : STD_LOGIC; 
  signal txsim_N27402_GROM : STD_LOGIC; 
  signal txsim_CHOICE753_GROM : STD_LOGIC; 
  signal txsim_CHOICE741_GROM : STD_LOGIC; 
  signal txsim_CHOICE747_GROM : STD_LOGIC; 
  signal TXD_1_ENABLE : STD_LOGIC; 
  signal TXD_1_TORGTS : STD_LOGIC; 
  signal TXD_1_OUTMUX : STD_LOGIC; 
  signal TXD_1_OBUF : STD_LOGIC; 
  signal TXD_1_OD : STD_LOGIC; 
  signal TXD_2_ENABLE : STD_LOGIC; 
  signal TXD_2_TORGTS : STD_LOGIC; 
  signal TXD_2_OUTMUX : STD_LOGIC; 
  signal TXD_2_OBUF : STD_LOGIC; 
  signal TXD_2_OD : STD_LOGIC; 
  signal TXD_7_ENABLE : STD_LOGIC; 
  signal TXD_7_TORGTS : STD_LOGIC; 
  signal TXD_7_OUTMUX : STD_LOGIC; 
  signal TXD_7_OBUF : STD_LOGIC; 
  signal TXD_7_OD : STD_LOGIC; 
  signal TXD_4_ENABLE : STD_LOGIC; 
  signal TXD_4_TORGTS : STD_LOGIC; 
  signal TXD_4_OUTMUX : STD_LOGIC; 
  signal TXD_4_OBUF : STD_LOGIC; 
  signal TXD_4_OD : STD_LOGIC; 
  signal TXD_5_ENABLE : STD_LOGIC; 
  signal TXD_5_TORGTS : STD_LOGIC; 
  signal TXD_5_OUTMUX : STD_LOGIC; 
  signal TXD_5_OBUF : STD_LOGIC; 
  signal TXD_5_OD : STD_LOGIC; 
  signal TXD_6_ENABLE : STD_LOGIC; 
  signal TXD_6_TORGTS : STD_LOGIC; 
  signal TXD_6_OUTMUX : STD_LOGIC; 
  signal TXD_6_OBUF : STD_LOGIC; 
  signal TXD_6_OD : STD_LOGIC; 
  signal TXD_3_ENABLE : STD_LOGIC; 
  signal TXD_3_TORGTS : STD_LOGIC; 
  signal TXD_3_OUTMUX : STD_LOGIC; 
  signal TXD_3_OBUF : STD_LOGIC; 
  signal TXD_3_OD : STD_LOGIC; 
  signal txsim_rom_DOB15 : STD_LOGIC; 
  signal txsim_rom_DOB14 : STD_LOGIC; 
  signal txsim_rom_DOB13 : STD_LOGIC; 
  signal txsim_rom_DOB12 : STD_LOGIC; 
  signal txsim_rom_DOB11 : STD_LOGIC; 
  signal txsim_rom_DOB10 : STD_LOGIC; 
  signal txsim_rom_DOB9 : STD_LOGIC; 
  signal txsim_rom_DOB8 : STD_LOGIC; 
  signal txsim_rom_DOB7 : STD_LOGIC; 
  signal txsim_rom_DOB6 : STD_LOGIC; 
  signal txsim_rom_DOB5 : STD_LOGIC; 
  signal txsim_rom_DOB4 : STD_LOGIC; 
  signal txsim_rom_DOB3 : STD_LOGIC; 
  signal txsim_rom_DOB2 : STD_LOGIC; 
  signal txsim_rom_DOB1 : STD_LOGIC; 
  signal txsim_rom_DOB0 : STD_LOGIC; 
  signal txsim_rom_DOA15 : STD_LOGIC; 
  signal txsim_rom_DOA14 : STD_LOGIC; 
  signal txsim_rom_DOA13 : STD_LOGIC; 
  signal txsim_rom_DOA12 : STD_LOGIC; 
  signal txsim_rom_DOA11 : STD_LOGIC; 
  signal txsim_rom_DOA10 : STD_LOGIC; 
  signal txsim_rom_DOA9 : STD_LOGIC; 
  signal txsim_rom_DOA8 : STD_LOGIC; 
  signal txsim_rom_DIB15 : STD_LOGIC; 
  signal txsim_rom_DIB14 : STD_LOGIC; 
  signal txsim_rom_DIB13 : STD_LOGIC; 
  signal txsim_rom_DIB12 : STD_LOGIC; 
  signal txsim_rom_DIB11 : STD_LOGIC; 
  signal txsim_rom_DIB10 : STD_LOGIC; 
  signal txsim_rom_DIB9 : STD_LOGIC; 
  signal txsim_rom_DIB8 : STD_LOGIC; 
  signal txsim_rom_DIB7 : STD_LOGIC; 
  signal txsim_rom_DIB6 : STD_LOGIC; 
  signal txsim_rom_DIB5 : STD_LOGIC; 
  signal txsim_rom_DIB4 : STD_LOGIC; 
  signal txsim_rom_DIB3 : STD_LOGIC; 
  signal txsim_rom_DIB2 : STD_LOGIC; 
  signal txsim_rom_DIB1 : STD_LOGIC; 
  signal txsim_rom_DIB0 : STD_LOGIC; 
  signal txsim_rom_DIA15 : STD_LOGIC; 
  signal txsim_rom_DIA14 : STD_LOGIC; 
  signal txsim_rom_DIA13 : STD_LOGIC; 
  signal txsim_rom_DIA12 : STD_LOGIC; 
  signal txsim_rom_DIA11 : STD_LOGIC; 
  signal txsim_rom_DIA10 : STD_LOGIC; 
  signal txsim_rom_DIA9 : STD_LOGIC; 
  signal txsim_rom_DIA8 : STD_LOGIC; 
  signal txsim_rom_ADDRB11 : STD_LOGIC; 
  signal txsim_rom_ADDRB10 : STD_LOGIC; 
  signal txsim_rom_ADDRB9 : STD_LOGIC; 
  signal txsim_rom_ADDRB8 : STD_LOGIC; 
  signal txsim_rom_ADDRB7 : STD_LOGIC; 
  signal txsim_rom_ADDRB6 : STD_LOGIC; 
  signal txsim_rom_ADDRB5 : STD_LOGIC; 
  signal txsim_rom_ADDRB4 : STD_LOGIC; 
  signal txsim_rom_ADDRB3 : STD_LOGIC; 
  signal txsim_rom_ADDRB2 : STD_LOGIC; 
  signal txsim_rom_ADDRB1 : STD_LOGIC; 
  signal txsim_rom_ADDRB0 : STD_LOGIC; 
  signal txsim_rom_ADDRA2 : STD_LOGIC; 
  signal txsim_rom_ADDRA1 : STD_LOGIC; 
  signal txsim_rom_ADDRA0 : STD_LOGIC; 
  signal txsim_rom_LOGIC_ZERO : STD_LOGIC; 
  signal txsim_rom_LOGIC_ONE : STD_LOGIC; 
  signal txsim_ltxd_3_FFY_RST : STD_LOGIC; 
  signal txsim_ltxd_5_FFY_RST : STD_LOGIC; 
  signal txsim_ltxd_7_FFY_RST : STD_LOGIC; 
  signal TXD_2_OFF_RST : STD_LOGIC; 
  signal TXD_3_OFF_RST : STD_LOGIC; 
  signal TXD_4_OFF_RST : STD_LOGIC; 
  signal TXD_5_OFF_RST : STD_LOGIC; 
  signal TXD_6_OFF_RST : STD_LOGIC; 
  signal txsim_ltxd_7_FFX_RST : STD_LOGIC; 
  signal txsim_ltxd_1_FFY_RST : STD_LOGIC; 
  signal txsim_ltxd_1_FFX_RST : STD_LOGIC; 
  signal txsim_ltxd_3_FFX_RST : STD_LOGIC; 
  signal txsim_ltxd_5_FFX_RST : STD_LOGIC; 
  signal TXD_0_OFF_RST : STD_LOGIC; 
  signal TXD_1_OFF_RST : STD_LOGIC; 
  signal TXD_7_OFF_RST : STD_LOGIC; 
  signal VCC : STD_LOGIC; 
  signal GND : STD_LOGIC; 
  signal ltxd : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal counter : STD_LOGIC_VECTOR ( 23 downto 0 ); 
  signal ramout : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal counter_n0000 : STD_LOGIC_VECTOR ( 23 downto 1 ); 
begin
  TX_EN <= NlwRenamedSig_OI_TX_EN;
  txsim_counter_2_LOGIC_ZERO_0 : X_ZERO
    port map (
      O => txsim_counter_2_LOGIC_ZERO
    );
  counter_Madd_n0000_inst_cy_2_1 : X_MUX2
    port map (
      IA => txsim_counter_2_LOGIC_ZERO,
      IB => txsim_counter_2_CYINIT,
      SEL => txsim_counter_2_FROM,
      O => counter_Madd_n0000_inst_cy_2
    );
  counter_Madd_n0000_inst_sum_2 : X_XOR2
    port map (
      I0 => txsim_counter_2_CYINIT,
      I1 => txsim_counter_2_FROM,
      O => counter_n0000(2)
    );
  txsim_counter_2_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(2),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_2_FROM
    );
  txsim_counter_2_G : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(3),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_2_GROM
    );
  counter_Madd_n0000_inst_cy_3 : X_MUX2
    port map (
      IA => txsim_counter_2_LOGIC_ZERO,
      IB => counter_Madd_n0000_inst_cy_2,
      SEL => txsim_counter_2_GROM,
      O => txsim_counter_2_CYMUXG
    );
  counter_Madd_n0000_inst_sum_3 : X_XOR2
    port map (
      I0 => counter_Madd_n0000_inst_cy_2,
      I1 => txsim_counter_2_GROM,
      O => counter_n0000(3)
    );
  txsim_counter_2_CYINIT_2 : X_BUF
    port map (
      I => txsim_counter_0_CYMUXG,
      O => txsim_counter_2_CYINIT
    );
  txsim_counter_8_LOGIC_ZERO_3 : X_ZERO
    port map (
      O => txsim_counter_8_LOGIC_ZERO
    );
  counter_Madd_n0000_inst_cy_8_4 : X_MUX2
    port map (
      IA => txsim_counter_8_LOGIC_ZERO,
      IB => txsim_counter_8_CYINIT,
      SEL => txsim_counter_8_FROM,
      O => counter_Madd_n0000_inst_cy_8
    );
  counter_Madd_n0000_inst_sum_8 : X_XOR2
    port map (
      I0 => txsim_counter_8_CYINIT,
      I1 => txsim_counter_8_FROM,
      O => counter_n0000(8)
    );
  txsim_counter_8_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(8),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_8_FROM
    );
  txsim_counter_8_G : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(9),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_8_GROM
    );
  counter_Madd_n0000_inst_cy_9 : X_MUX2
    port map (
      IA => txsim_counter_8_LOGIC_ZERO,
      IB => counter_Madd_n0000_inst_cy_8,
      SEL => txsim_counter_8_GROM,
      O => txsim_counter_8_CYMUXG
    );
  counter_Madd_n0000_inst_sum_9 : X_XOR2
    port map (
      I0 => counter_Madd_n0000_inst_cy_8,
      I1 => txsim_counter_8_GROM,
      O => counter_n0000(9)
    );
  txsim_counter_8_CYINIT_5 : X_BUF
    port map (
      I => txsim_counter_6_CYMUXG,
      O => txsim_counter_8_CYINIT
    );
  txsim_counter_6_LOGIC_ZERO_6 : X_ZERO
    port map (
      O => txsim_counter_6_LOGIC_ZERO
    );
  counter_Madd_n0000_inst_cy_6_7 : X_MUX2
    port map (
      IA => txsim_counter_6_LOGIC_ZERO,
      IB => txsim_counter_6_CYINIT,
      SEL => txsim_counter_6_FROM,
      O => counter_Madd_n0000_inst_cy_6
    );
  counter_Madd_n0000_inst_sum_6 : X_XOR2
    port map (
      I0 => txsim_counter_6_CYINIT,
      I1 => txsim_counter_6_FROM,
      O => counter_n0000(6)
    );
  txsim_counter_6_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(6),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_6_FROM
    );
  txsim_counter_6_G : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(7),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_6_GROM
    );
  counter_Madd_n0000_inst_cy_7 : X_MUX2
    port map (
      IA => txsim_counter_6_LOGIC_ZERO,
      IB => counter_Madd_n0000_inst_cy_6,
      SEL => txsim_counter_6_GROM,
      O => txsim_counter_6_CYMUXG
    );
  counter_Madd_n0000_inst_sum_7 : X_XOR2
    port map (
      I0 => counter_Madd_n0000_inst_cy_6,
      I1 => txsim_counter_6_GROM,
      O => counter_n0000(7)
    );
  txsim_counter_6_CYINIT_8 : X_BUF
    port map (
      I => txsim_counter_4_CYMUXG,
      O => txsim_counter_6_CYINIT
    );
  txsim_counter_4_LOGIC_ZERO_9 : X_ZERO
    port map (
      O => txsim_counter_4_LOGIC_ZERO
    );
  counter_Madd_n0000_inst_cy_4_10 : X_MUX2
    port map (
      IA => txsim_counter_4_LOGIC_ZERO,
      IB => txsim_counter_4_CYINIT,
      SEL => txsim_counter_4_FROM,
      O => counter_Madd_n0000_inst_cy_4
    );
  counter_Madd_n0000_inst_sum_4 : X_XOR2
    port map (
      I0 => txsim_counter_4_CYINIT,
      I1 => txsim_counter_4_FROM,
      O => counter_n0000(4)
    );
  txsim_counter_4_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(4),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_4_FROM
    );
  txsim_counter_4_G : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(5),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_4_GROM
    );
  counter_Madd_n0000_inst_cy_5 : X_MUX2
    port map (
      IA => txsim_counter_4_LOGIC_ZERO,
      IB => counter_Madd_n0000_inst_cy_4,
      SEL => txsim_counter_4_GROM,
      O => txsim_counter_4_CYMUXG
    );
  counter_Madd_n0000_inst_sum_5 : X_XOR2
    port map (
      I0 => counter_Madd_n0000_inst_cy_4,
      I1 => txsim_counter_4_GROM,
      O => counter_n0000(5)
    );
  txsim_counter_4_CYINIT_11 : X_BUF
    port map (
      I => txsim_counter_2_CYMUXG,
      O => txsim_counter_4_CYINIT
    );
  txsim_counter_22_LOGIC_ZERO_12 : X_ZERO
    port map (
      O => txsim_counter_22_LOGIC_ZERO
    );
  counter_Madd_n0000_inst_cy_22_13 : X_MUX2
    port map (
      IA => txsim_counter_22_LOGIC_ZERO,
      IB => txsim_counter_22_CYINIT,
      SEL => txsim_counter_22_FROM,
      O => counter_Madd_n0000_inst_cy_22
    );
  counter_Madd_n0000_inst_sum_22 : X_XOR2
    port map (
      I0 => txsim_counter_22_CYINIT,
      I1 => txsim_counter_22_FROM,
      O => counter_n0000(22)
    );
  txsim_counter_22_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(22),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_22_FROM
    );
  counter_23_rt_14 : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(23),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => counter_23_rt
    );
  counter_Madd_n0000_inst_sum_23 : X_XOR2
    port map (
      I0 => counter_Madd_n0000_inst_cy_22,
      I1 => counter_23_rt,
      O => counter_n0000(23)
    );
  txsim_counter_22_CYINIT_15 : X_BUF
    port map (
      I => txsim_counter_20_CYMUXG,
      O => txsim_counter_22_CYINIT
    );
  txsim_counter_20_LOGIC_ZERO_16 : X_ZERO
    port map (
      O => txsim_counter_20_LOGIC_ZERO
    );
  counter_Madd_n0000_inst_cy_20_17 : X_MUX2
    port map (
      IA => txsim_counter_20_LOGIC_ZERO,
      IB => txsim_counter_20_CYINIT,
      SEL => txsim_counter_20_FROM,
      O => counter_Madd_n0000_inst_cy_20
    );
  counter_Madd_n0000_inst_sum_20 : X_XOR2
    port map (
      I0 => txsim_counter_20_CYINIT,
      I1 => txsim_counter_20_FROM,
      O => counter_n0000(20)
    );
  txsim_counter_20_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(20),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_20_FROM
    );
  txsim_counter_20_G : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(21),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_20_GROM
    );
  counter_Madd_n0000_inst_cy_21 : X_MUX2
    port map (
      IA => txsim_counter_20_LOGIC_ZERO,
      IB => counter_Madd_n0000_inst_cy_20,
      SEL => txsim_counter_20_GROM,
      O => txsim_counter_20_CYMUXG
    );
  counter_Madd_n0000_inst_sum_21 : X_XOR2
    port map (
      I0 => counter_Madd_n0000_inst_cy_20,
      I1 => txsim_counter_20_GROM,
      O => counter_n0000(21)
    );
  txsim_counter_20_CYINIT_18 : X_BUF
    port map (
      I => txsim_counter_18_CYMUXG,
      O => txsim_counter_20_CYINIT
    );
  txsim_counter_18_LOGIC_ZERO_19 : X_ZERO
    port map (
      O => txsim_counter_18_LOGIC_ZERO
    );
  counter_Madd_n0000_inst_cy_18_20 : X_MUX2
    port map (
      IA => txsim_counter_18_LOGIC_ZERO,
      IB => txsim_counter_18_CYINIT,
      SEL => txsim_counter_18_FROM,
      O => counter_Madd_n0000_inst_cy_18
    );
  counter_Madd_n0000_inst_sum_18 : X_XOR2
    port map (
      I0 => txsim_counter_18_CYINIT,
      I1 => txsim_counter_18_FROM,
      O => counter_n0000(18)
    );
  txsim_counter_18_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(18),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_18_FROM
    );
  txsim_counter_18_G : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(19),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_18_GROM
    );
  counter_Madd_n0000_inst_cy_19 : X_MUX2
    port map (
      IA => txsim_counter_18_LOGIC_ZERO,
      IB => counter_Madd_n0000_inst_cy_18,
      SEL => txsim_counter_18_GROM,
      O => txsim_counter_18_CYMUXG
    );
  counter_Madd_n0000_inst_sum_19 : X_XOR2
    port map (
      I0 => counter_Madd_n0000_inst_cy_18,
      I1 => txsim_counter_18_GROM,
      O => counter_n0000(19)
    );
  txsim_counter_18_CYINIT_21 : X_BUF
    port map (
      I => txsim_counter_16_CYMUXG,
      O => txsim_counter_18_CYINIT
    );
  txsim_counter_16_LOGIC_ZERO_22 : X_ZERO
    port map (
      O => txsim_counter_16_LOGIC_ZERO
    );
  counter_Madd_n0000_inst_cy_16_23 : X_MUX2
    port map (
      IA => txsim_counter_16_LOGIC_ZERO,
      IB => txsim_counter_16_CYINIT,
      SEL => txsim_counter_16_FROM,
      O => counter_Madd_n0000_inst_cy_16
    );
  counter_Madd_n0000_inst_sum_16 : X_XOR2
    port map (
      I0 => txsim_counter_16_CYINIT,
      I1 => txsim_counter_16_FROM,
      O => counter_n0000(16)
    );
  txsim_counter_16_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(16),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_16_FROM
    );
  txsim_counter_16_G : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(17),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_16_GROM
    );
  counter_Madd_n0000_inst_cy_17 : X_MUX2
    port map (
      IA => txsim_counter_16_LOGIC_ZERO,
      IB => counter_Madd_n0000_inst_cy_16,
      SEL => txsim_counter_16_GROM,
      O => txsim_counter_16_CYMUXG
    );
  counter_Madd_n0000_inst_sum_17 : X_XOR2
    port map (
      I0 => counter_Madd_n0000_inst_cy_16,
      I1 => txsim_counter_16_GROM,
      O => counter_n0000(17)
    );
  txsim_counter_16_CYINIT_24 : X_BUF
    port map (
      I => txsim_counter_14_CYMUXG,
      O => txsim_counter_16_CYINIT
    );
  txsim_counter_14_LOGIC_ZERO_25 : X_ZERO
    port map (
      O => txsim_counter_14_LOGIC_ZERO
    );
  counter_Madd_n0000_inst_cy_14_26 : X_MUX2
    port map (
      IA => txsim_counter_14_LOGIC_ZERO,
      IB => txsim_counter_14_CYINIT,
      SEL => txsim_counter_14_FROM,
      O => counter_Madd_n0000_inst_cy_14
    );
  counter_Madd_n0000_inst_sum_14 : X_XOR2
    port map (
      I0 => txsim_counter_14_CYINIT,
      I1 => txsim_counter_14_FROM,
      O => counter_n0000(14)
    );
  txsim_counter_14_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(14),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_14_FROM
    );
  txsim_counter_14_G : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(15),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_14_GROM
    );
  counter_Madd_n0000_inst_cy_15 : X_MUX2
    port map (
      IA => txsim_counter_14_LOGIC_ZERO,
      IB => counter_Madd_n0000_inst_cy_14,
      SEL => txsim_counter_14_GROM,
      O => txsim_counter_14_CYMUXG
    );
  counter_Madd_n0000_inst_sum_15 : X_XOR2
    port map (
      I0 => counter_Madd_n0000_inst_cy_14,
      I1 => txsim_counter_14_GROM,
      O => counter_n0000(15)
    );
  txsim_counter_14_CYINIT_27 : X_BUF
    port map (
      I => txsim_counter_12_CYMUXG,
      O => txsim_counter_14_CYINIT
    );
  Q_n000112 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => counter(8),
      ADR1 => counter(9),
      ADR2 => counter(10),
      ADR3 => counter(11),
      O => txsim_CHOICE719_FROM
    );
  Q_n0001126_1_28 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => CHOICE719,
      ADR1 => CHOICE726,
      ADR2 => CHOICE747,
      ADR3 => N27402,
      O => txsim_CHOICE719_GROM
    );
  txsim_CHOICE719_XUSED : X_BUF
    port map (
      I => txsim_CHOICE719_FROM,
      O => CHOICE719
    );
  txsim_CHOICE719_YUSED : X_BUF
    port map (
      I => txsim_CHOICE719_GROM,
      O => Q_n0001126_1
    );
  TXD_0_OBUF_29 : X_TRI
    port map (
      I => TXD_0_OUTMUX,
      CTL => TXD_0_ENABLE,
      O => TXD(0)
    );
  TXD_0_ENABLEINV : X_INV
    port map (
      I => TXD_0_TORGTS,
      O => TXD_0_ENABLE
    );
  TXD_0_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => TXD_0_TORGTS
    );
  TXD_0_OUTMUX_30 : X_BUF
    port map (
      I => TXD_0_OBUF,
      O => TXD_0_OUTMUX
    );
  TXD_0_OMUX : X_BUF
    port map (
      I => ltxd(0),
      O => TXD_0_OD
    );
  Q_n000149 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => counter(16),
      ADR1 => counter(17),
      ADR2 => counter(18),
      ADR3 => counter(19),
      O => txsim_CHOICE734_GROM
    );
  txsim_CHOICE734_YUSED : X_BUF
    port map (
      I => txsim_CHOICE734_GROM,
      O => CHOICE734
    );
  txsim_counter_12_LOGIC_ZERO_31 : X_ZERO
    port map (
      O => txsim_counter_12_LOGIC_ZERO
    );
  counter_Madd_n0000_inst_cy_12_32 : X_MUX2
    port map (
      IA => txsim_counter_12_LOGIC_ZERO,
      IB => txsim_counter_12_CYINIT,
      SEL => txsim_counter_12_FROM,
      O => counter_Madd_n0000_inst_cy_12
    );
  counter_Madd_n0000_inst_sum_12 : X_XOR2
    port map (
      I0 => txsim_counter_12_CYINIT,
      I1 => txsim_counter_12_FROM,
      O => counter_n0000(12)
    );
  txsim_counter_12_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(12),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_12_FROM
    );
  txsim_counter_12_G : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(13),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_12_GROM
    );
  counter_Madd_n0000_inst_cy_13 : X_MUX2
    port map (
      IA => txsim_counter_12_LOGIC_ZERO,
      IB => counter_Madd_n0000_inst_cy_12,
      SEL => txsim_counter_12_GROM,
      O => txsim_counter_12_CYMUXG
    );
  counter_Madd_n0000_inst_sum_13 : X_XOR2
    port map (
      I0 => counter_Madd_n0000_inst_cy_12,
      I1 => txsim_counter_12_GROM,
      O => counter_n0000(13)
    );
  txsim_counter_12_CYINIT_33 : X_BUF
    port map (
      I => txsim_counter_10_CYMUXG,
      O => txsim_counter_12_CYINIT
    );
  txsim_counter_10_LOGIC_ZERO_34 : X_ZERO
    port map (
      O => txsim_counter_10_LOGIC_ZERO
    );
  counter_Madd_n0000_inst_cy_10_35 : X_MUX2
    port map (
      IA => txsim_counter_10_LOGIC_ZERO,
      IB => txsim_counter_10_CYINIT,
      SEL => txsim_counter_10_FROM,
      O => counter_Madd_n0000_inst_cy_10
    );
  counter_Madd_n0000_inst_sum_10 : X_XOR2
    port map (
      I0 => txsim_counter_10_CYINIT,
      I1 => txsim_counter_10_FROM,
      O => counter_n0000(10)
    );
  txsim_counter_10_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(10),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_10_FROM
    );
  txsim_counter_10_G : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => counter(11),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_10_GROM
    );
  counter_Madd_n0000_inst_cy_11 : X_MUX2
    port map (
      IA => txsim_counter_10_LOGIC_ZERO,
      IB => counter_Madd_n0000_inst_cy_10,
      SEL => txsim_counter_10_GROM,
      O => txsim_counter_10_CYMUXG
    );
  counter_Madd_n0000_inst_sum_11 : X_XOR2
    port map (
      I0 => counter_Madd_n0000_inst_cy_10,
      I1 => txsim_counter_10_GROM,
      O => counter_n0000(11)
    );
  txsim_counter_10_CYINIT_36 : X_BUF
    port map (
      I => txsim_counter_8_CYMUXG,
      O => txsim_counter_10_CYINIT
    );
  Q_n000125 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => counter(12),
      ADR1 => counter(13),
      ADR2 => counter(14),
      ADR3 => counter(15),
      O => txsim_CHOICE726_GROM
    );
  txsim_CHOICE726_YUSED : X_BUF
    port map (
      I => txsim_CHOICE726_GROM,
      O => CHOICE726
    );
  txsim_counter_0_LOGIC_ZERO_37 : X_ZERO
    port map (
      O => txsim_counter_0_LOGIC_ZERO
    );
  counter_Madd_n0000_inst_cy_0_38 : X_MUX2
    port map (
      IA => N1261,
      IB => txsim_counter_0_LOGIC_ZERO,
      SEL => counter_Madd_n0000_inst_lut2_0,
      O => counter_Madd_n0000_inst_cy_0
    );
  counter_Madd_n0000_inst_lut2_01 : X_LUT4
    generic map(
      INIT => X"3333"
    )
    port map (
      ADR0 => N1261,
      ADR1 => counter(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => counter_Madd_n0000_inst_lut2_0
    );
  txsim_counter_0_G : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => NlwRenamedSig_OI_TX_EN,
      ADR1 => counter(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => txsim_counter_0_GROM
    );
  counter_Madd_n0000_inst_cy_1 : X_MUX2
    port map (
      IA => NlwRenamedSig_OI_TX_EN,
      IB => counter_Madd_n0000_inst_cy_0,
      SEL => txsim_counter_0_GROM,
      O => txsim_counter_0_CYMUXG
    );
  counter_Madd_n0000_inst_sum_1 : X_XOR2
    port map (
      I0 => counter_Madd_n0000_inst_cy_0,
      I1 => txsim_counter_0_GROM,
      O => counter_n0000(1)
    );
  Q_n0001126_SW0 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => CHOICE753,
      ADR1 => CHOICE734,
      ADR2 => CHOICE741,
      ADR3 => VCC,
      O => txsim_N27402_FROM
    );
  Q_n0001126 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => CHOICE719,
      ADR1 => CHOICE726,
      ADR2 => CHOICE747,
      ADR3 => N27402,
      O => txsim_N27402_GROM
    );
  txsim_N27402_XUSED : X_BUF
    port map (
      I => txsim_N27402_FROM,
      O => N27402
    );
  txsim_N27402_YUSED : X_BUF
    port map (
      I => txsim_N27402_GROM,
      O => Q_n0001
    );
  Q_n000196 : X_LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      ADR0 => counter(2),
      ADR1 => counter(3),
      ADR2 => counter(0),
      ADR3 => counter(1),
      O => txsim_CHOICE753_GROM
    );
  txsim_CHOICE753_YUSED : X_BUF
    port map (
      I => txsim_CHOICE753_GROM,
      O => CHOICE753
    );
  Q_n000162 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => counter(20),
      ADR1 => counter(21),
      ADR2 => counter(22),
      ADR3 => counter(23),
      O => txsim_CHOICE741_GROM
    );
  txsim_CHOICE741_YUSED : X_BUF
    port map (
      I => txsim_CHOICE741_GROM,
      O => CHOICE741
    );
  Q_n000184 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => counter(4),
      ADR1 => counter(7),
      ADR2 => counter(6),
      ADR3 => counter(5),
      O => txsim_CHOICE747_GROM
    );
  txsim_CHOICE747_YUSED : X_BUF
    port map (
      I => txsim_CHOICE747_GROM,
      O => CHOICE747
    );
  TXD_1_OBUF_39 : X_TRI
    port map (
      I => TXD_1_OUTMUX,
      CTL => TXD_1_ENABLE,
      O => TXD(1)
    );
  TXD_1_ENABLEINV : X_INV
    port map (
      I => TXD_1_TORGTS,
      O => TXD_1_ENABLE
    );
  TXD_1_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => TXD_1_TORGTS
    );
  TXD_1_OUTMUX_40 : X_BUF
    port map (
      I => TXD_1_OBUF,
      O => TXD_1_OUTMUX
    );
  TXD_1_OMUX : X_BUF
    port map (
      I => ltxd(1),
      O => TXD_1_OD
    );
  TXD_2_OBUF_41 : X_TRI
    port map (
      I => TXD_2_OUTMUX,
      CTL => TXD_2_ENABLE,
      O => TXD(2)
    );
  TXD_2_ENABLEINV : X_INV
    port map (
      I => TXD_2_TORGTS,
      O => TXD_2_ENABLE
    );
  TXD_2_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => TXD_2_TORGTS
    );
  TXD_2_OUTMUX_42 : X_BUF
    port map (
      I => TXD_2_OBUF,
      O => TXD_2_OUTMUX
    );
  TXD_2_OMUX : X_BUF
    port map (
      I => ltxd(2),
      O => TXD_2_OD
    );
  TXD_7_OBUF_43 : X_TRI
    port map (
      I => TXD_7_OUTMUX,
      CTL => TXD_7_ENABLE,
      O => TXD(7)
    );
  TXD_7_ENABLEINV : X_INV
    port map (
      I => TXD_7_TORGTS,
      O => TXD_7_ENABLE
    );
  TXD_7_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => TXD_7_TORGTS
    );
  TXD_7_OUTMUX_44 : X_BUF
    port map (
      I => TXD_7_OBUF,
      O => TXD_7_OUTMUX
    );
  TXD_7_OMUX : X_BUF
    port map (
      I => ltxd(7),
      O => TXD_7_OD
    );
  TXD_4_OBUF_45 : X_TRI
    port map (
      I => TXD_4_OUTMUX,
      CTL => TXD_4_ENABLE,
      O => TXD(4)
    );
  TXD_4_ENABLEINV : X_INV
    port map (
      I => TXD_4_TORGTS,
      O => TXD_4_ENABLE
    );
  TXD_4_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => TXD_4_TORGTS
    );
  TXD_4_OUTMUX_46 : X_BUF
    port map (
      I => TXD_4_OBUF,
      O => TXD_4_OUTMUX
    );
  TXD_4_OMUX : X_BUF
    port map (
      I => ltxd(4),
      O => TXD_4_OD
    );
  TXD_5_OBUF_47 : X_TRI
    port map (
      I => TXD_5_OUTMUX,
      CTL => TXD_5_ENABLE,
      O => TXD(5)
    );
  TXD_5_ENABLEINV : X_INV
    port map (
      I => TXD_5_TORGTS,
      O => TXD_5_ENABLE
    );
  TXD_5_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => TXD_5_TORGTS
    );
  TXD_5_OUTMUX_48 : X_BUF
    port map (
      I => TXD_5_OBUF,
      O => TXD_5_OUTMUX
    );
  TXD_5_OMUX : X_BUF
    port map (
      I => ltxd(5),
      O => TXD_5_OD
    );
  TXD_6_OBUF_49 : X_TRI
    port map (
      I => TXD_6_OUTMUX,
      CTL => TXD_6_ENABLE,
      O => TXD(6)
    );
  TXD_6_ENABLEINV : X_INV
    port map (
      I => TXD_6_TORGTS,
      O => TXD_6_ENABLE
    );
  TXD_6_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => TXD_6_TORGTS
    );
  TXD_6_OUTMUX_50 : X_BUF
    port map (
      I => TXD_6_OBUF,
      O => TXD_6_OUTMUX
    );
  TXD_6_OMUX : X_BUF
    port map (
      I => ltxd(6),
      O => TXD_6_OD
    );
  TXD_3_OBUF_51 : X_TRI
    port map (
      I => TXD_3_OUTMUX,
      CTL => TXD_3_ENABLE,
      O => TXD(3)
    );
  TXD_3_ENABLEINV : X_INV
    port map (
      I => TXD_3_TORGTS,
      O => TXD_3_ENABLE
    );
  TXD_3_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => TXD_3_TORGTS
    );
  TXD_3_OUTMUX_52 : X_BUF
    port map (
      I => TXD_3_OBUF,
      O => TXD_3_OUTMUX
    );
  TXD_3_OMUX : X_BUF
    port map (
      I => ltxd(3),
      O => TXD_3_OD
    );
  txsim_rom_LOGIC_ZERO_53 : X_ZERO
    port map (
      O => txsim_rom_LOGIC_ZERO
    );
  txsim_rom_LOGIC_ONE_54 : X_ONE
    port map (
      O => txsim_rom_LOGIC_ONE
    );
  rom : X_RAMB4_S8
    generic map(
      INIT_00 => X"0000000000000000000000000000000000000000000000000000050403020100",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      XON => FALSE
    )
    port map (
      CLK => CLK,
      EN => txsim_rom_LOGIC_ONE,
      RST => RESET,
      WE => txsim_rom_LOGIC_ZERO,
      GSR => GSR,
      ADDR(8) => counter(8),
      ADDR(7) => counter(7),
      ADDR(6) => counter(6),
      ADDR(5) => counter(5),
      ADDR(4) => counter(4),
      ADDR(3) => counter(3),
      ADDR(2) => counter(2),
      ADDR(1) => counter(1),
      ADDR(0) => counter(0),
      DI(7) => NlwRenamedSig_OI_TX_EN,
      DI(6) => NlwRenamedSig_OI_TX_EN,
      DI(5) => NlwRenamedSig_OI_TX_EN,
      DI(4) => NlwRenamedSig_OI_TX_EN,
      DI(3) => NlwRenamedSig_OI_TX_EN,
      DI(2) => NlwRenamedSig_OI_TX_EN,
      DI(1) => NlwRenamedSig_OI_TX_EN,
      DI(0) => NlwRenamedSig_OI_TX_EN,
      DO(7) => ramout(7),
      DO(6) => ramout(6),
      DO(5) => ramout(5),
      DO(4) => ramout(4),
      DO(3) => ramout(3),
      DO(2) => ramout(2),
      DO(1) => ramout(1),
      DO(0) => ramout(0)
    );
  ltxd_2 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ramout(2),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => txsim_ltxd_3_FFY_RST,
      O => ltxd(2)
    );
  txsim_ltxd_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => txsim_ltxd_3_FFY_RST
    );
  ltxd_4 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ramout(4),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => txsim_ltxd_5_FFY_RST,
      O => ltxd(4)
    );
  txsim_ltxd_5_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => txsim_ltxd_5_FFY_RST
    );
  ltxd_6 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ramout(6),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => txsim_ltxd_7_FFY_RST,
      O => ltxd(6)
    );
  txsim_ltxd_7_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => txsim_ltxd_7_FFY_RST
    );
  counter_10 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => counter_n0000(10),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => Q_n0001,
      O => counter(10)
    );
  counter_12 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => counter_n0000(12),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => Q_n0001,
      O => counter(12)
    );
  counter_15 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => counter_n0000(15),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => Q_n0001,
      O => counter(15)
    );
  counter_19 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => counter_n0000(19),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => Q_n0001,
      O => counter(19)
    );
  counter_14 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => counter_n0000(14),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => Q_n0001,
      O => counter(14)
    );
  counter_17 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => counter_n0000(17),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => Q_n0001,
      O => counter(17)
    );
  TXD_2 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => TXD_2_OD,
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => TXD_2_OFF_RST,
      O => TXD_2_OBUF
    );
  TXD_2_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => TXD_2_OFF_RST
    );
  TXD_3 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => TXD_3_OD,
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => TXD_3_OFF_RST,
      O => TXD_3_OBUF
    );
  TXD_3_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => TXD_3_OFF_RST
    );
  TXD_4 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => TXD_4_OD,
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => TXD_4_OFF_RST,
      O => TXD_4_OBUF
    );
  TXD_4_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => TXD_4_OFF_RST
    );
  TXD_5 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => TXD_5_OD,
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => TXD_5_OFF_RST,
      O => TXD_5_OBUF
    );
  TXD_5_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => TXD_5_OFF_RST
    );
  TXD_6 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => TXD_6_OD,
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => TXD_6_OFF_RST,
      O => TXD_6_OBUF
    );
  TXD_6_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => TXD_6_OFF_RST
    );
  ltxd_7 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ramout(7),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => txsim_ltxd_7_FFX_RST,
      O => ltxd(7)
    );
  txsim_ltxd_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => txsim_ltxd_7_FFX_RST
    );
  counter_22 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => counter_n0000(22),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => Q_n0001126_1,
      O => counter(22)
    );
  counter_2 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => counter_n0000(2),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => Q_n0001126_1,
      O => counter(2)
    );
  counter_5 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => counter_n0000(5),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => Q_n0001126_1,
      O => counter(5)
    );
  counter_9 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => counter_n0000(9),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => Q_n0001126_1,
      O => counter(9)
    );
  counter_4 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => counter_n0000(4),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => Q_n0001126_1,
      O => counter(4)
    );
  counter_7 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => counter_n0000(7),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => Q_n0001126_1,
      O => counter(7)
    );
  counter_6 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => counter_n0000(6),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => Q_n0001126_1,
      O => counter(6)
    );
  ltxd_0 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ramout(0),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => txsim_ltxd_1_FFY_RST,
      O => ltxd(0)
    );
  txsim_ltxd_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => txsim_ltxd_1_FFY_RST
    );
  counter_8 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => counter_n0000(8),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => Q_n0001126_1,
      O => counter(8)
    );
  ltxd_1 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ramout(1),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => txsim_ltxd_1_FFX_RST,
      O => ltxd(1)
    );
  txsim_ltxd_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => txsim_ltxd_1_FFX_RST
    );
  ltxd_3 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ramout(3),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => txsim_ltxd_3_FFX_RST,
      O => ltxd(3)
    );
  txsim_ltxd_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => txsim_ltxd_3_FFX_RST
    );
  ltxd_5 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => ramout(5),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => txsim_ltxd_5_FFX_RST,
      O => ltxd(5)
    );
  txsim_ltxd_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => txsim_ltxd_5_FFX_RST
    );
  TXD_0 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => TXD_0_OD,
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => TXD_0_OFF_RST,
      O => TXD_0_OBUF
    );
  TXD_0_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => TXD_0_OFF_RST
    );
  TXD_1 : X_FF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => TXD_1_OD,
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => TXD_1_OFF_RST,
      O => TXD_1_OBUF
    );
  TXD_1_OFF_RSTOR : X_BUF
    port map (
      I => GSR,
      O => TXD_1_OFF_RST
    );
  counter_16 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      I => counter_n0000(16),
      CE => VCC,
      CLK => CLK,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => Q_n0001,
      O => counter(16)
    );
  counter_23 : X_SFF
    generic map(
      XON => FALSE,
      INIT => '0'
    )
    port map (
      