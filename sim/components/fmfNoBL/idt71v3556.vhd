--------------------------------------------------------------------------------
--  File Name: idt71v3556.vhd
--------------------------------------------------------------------------------
--  Copyright (C) 2001, 2003 Free Model Foundry; http://www.FreeModelFoundry.com
-- 
--  This program is free software; you can redistribute it and/or modify
--  it under the terms of the GNU General Public License version 2 as
--  published by the Free Software Foundation.
-- 
--  MODIFICATION HISTORY:
-- 
--  version: |  author:  | mod date: | changes made:
--    V1.0    R. Munden    01 OCT 24   Initial release based on idt71v546 V2.3
--    V1.1    R. Munden    01 NOV 23   Add memory pre-load and UX01 conversions
--    V1.2    R. Munden    03 MAR 01   Changed mem_file declaration to VHDL'93
-- 
--------------------------------------------------------------------------------
--  PART DESCRIPTION:
-- 
--  Library:    RAM
--  Technology: LVTTL
--  Part:       IDT71V3556
-- 
--  Description: Pipelined ZBT SRAM 128K x 36
--------------------------------------------------------------------------------

LIBRARY IEEE;   USE IEEE.std_logic_1164.ALL;
                USE IEEE.VITAL_timing.ALL;
                USE IEEE.VITAL_primitives.ALL;
                USE STD.textio.ALL;
LIBRARY FMF;    USE FMF.gen_utils.ALL;
                USE FMF.conversions.ALL;

--------------------------------------------------------------------------------
-- ENTITY DECLARATION
--------------------------------------------------------------------------------
ENTITY idt71v3556 IS
    GENERIC (
        -- tipd delays: interconnect path delays
        tipd_A0                  : VitalDelayType01 := VitalZeroDelay01;
        tipd_A1                  : VitalDelayType01 := VitalZeroDelay01;
        tipd_A2                  : VitalDelayType01 := VitalZeroDelay01;
        tipd_A3                  : VitalDelayType01 := VitalZeroDelay01;
        tipd_A4                  : VitalDelayType01 := VitalZeroDelay01;
        tipd_A5                  : VitalDelayType01 := VitalZeroDelay01;
        tipd_A6                  : VitalDelayType01 := VitalZeroDelay01;
        tipd_A7                  : VitalDelayType01 := VitalZeroDelay01;
        tipd_A8                  : VitalDelayType01 := VitalZeroDelay01;
        tipd_A9                  : VitalDelayType01 := VitalZeroDelay01;
        tipd_A10                 : VitalDelayType01 := VitalZeroDelay01;
        tipd_A11                 : VitalDelayType01 := VitalZeroDelay01;
        tipd_A12                 : VitalDelayType01 := VitalZeroDelay01;
        tipd_A13                 : VitalDelayType01 := VitalZeroDelay01;
        tipd_A14                 : VitalDelayType01 := VitalZeroDelay01;
        tipd_A15                 : VitalDelayType01 := VitalZeroDelay01;
        tipd_A16                 : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQA0                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQA1                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQA2                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQA3                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQA4                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQA5                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQA6                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQA7                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQA8                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQB0                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQB1                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQB2                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQB3                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQB4                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQB5                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQB6                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQB7                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQB8                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQC0                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQC1                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQC2                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQC3                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQC4                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQC5                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQC6                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQC7                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQC8                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQD0                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQD1                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQD2                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQD3                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQD4                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQD5                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQD6                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQD7                : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQD8                : VitalDelayType01 := VitalZeroDelay01;
        tipd_ADV                 : VitalDelayType01 := VitalZeroDelay01;
        tipd_R                   : VitalDelayType01 := VitalZeroDelay01;
        tipd_CLKENNeg            : VitalDelayType01 := VitalZeroDelay01;
        tipd_BWDNeg              : VitalDelayType01 := VitalZeroDelay01;
        tipd_BWCNeg              : VitalDelayType01 := VitalZeroDelay01;
        tipd_BWBNeg              : VitalDelayType01 := VitalZeroDelay01;
        tipd_BWANeg              : VitalDelayType01 := VitalZeroDelay01;
        tipd_CE1Neg              : VitalDelayType01 := VitalZeroDelay01;
        tipd_CE2Neg              : VitalDelayType01 := VitalZeroDelay01;
        tipd_CE2                 : VitalDelayType01 := VitalZeroDelay01;
        tipd_CLK                 : VitalDelayType01 := VitalZeroDelay01;
        tipd_LBONeg              : VitalDelayType01 := VitalZeroDelay01;
        tipd_OENeg               : VitalDelayType01 := VitalZeroDelay01;
        -- tpd delays
        tpd_CLK_DQA0             : VitalDelayType01Z := UnitDelay01Z;
        tpd_OENeg_DQA0           : VitalDelayType01Z := UnitDelay01Z;
        -- tpw values: pulse widths
        tpw_CLK_posedge        : VitalDelayType := UnitDelay;
        tpw_CLK_negedge        : VitalDelayType := UnitDelay;
        -- tperiod min (calculated as 1/max freq)
        tperiod_CLK_posedge    : VitalDelayType := UnitDelay;
        -- tsetup values: setup times
        tsetup_CLKENNeg_CLK     : VitalDelayType := UnitDelay;
        tsetup_A0_CLK           : VitalDelayType := UnitDelay;
        tsetup_DQA0_CLK         : VitalDelayType := UnitDelay;
        tsetup_R_CLK            : VitalDelayType := UnitDelay;
        tsetup_ADV_CLK          : VitalDelayType := UnitDelay;
        tsetup_CE2_CLK          : VitalDelayType := UnitDelay;
        tsetup_BWANeg_CLK       : VitalDelayType := UnitDelay;
        -- thold values: hold times
        thold_CLKENNeg_CLK      : VitalDelayType := UnitDelay;
        thold_A0_CLK            : VitalDelayType := UnitDelay;
        thold_DQA0_CLK          : VitalDelayType := UnitDelay;
        thold_R_CLK             : VitalDelayType := UnitDelay;
        thold_ADV_CLK           : VitalDelayType := UnitDelay;
        thold_CE2_CLK           : VitalDelayType := UnitDelay;
        thold_BWANeg_CLK        : VitalDelayType := UnitDelay;
        -- generic control parameters
        InstancePath        : STRING    := DefaultInstancePath;
        TimingChecksOn      : BOOLEAN   := DefaultTimingChecks;
        MsgOn               : BOOLEAN   := DefaultMsgOn;
        XOn                 : BOOLEAN   := DefaultXon;
        SeverityMode        : SEVERITY_LEVEL := WARNING;
        -- memory file to be loaded
        mem_file_name       : STRING    := "idt71v3556.mem";
        -- For FMF SDF technology file usage
        TimingModel         : STRING    := DefaultTimingModel
    );
    PORT (
        A0              : IN    std_logic := 'U';
        A1              : IN    std_logic := 'U';
        A2              : IN    std_logic := 'U';
        A3              : IN    std_logic := 'U';
        A4              : IN    std_logic := 'U';
        A5              : IN    std_logic := 'U';
        A6              : IN    std_logic := 'U';
        A7              : IN    std_logic := 'U';
        A8              : IN    std_logic := 'U';
        A9              : IN    std_logic := 'U';
        A10             : IN    std_logic := 'U';
        A11             : IN    std_logic := 'U';
        A12             : IN    std_logic := 'U';
        A13             : IN    std_logic := 'U';
        A14             : IN    std_logic := 'U';
        A15             : IN    std_logic := 'U';
        A16             : IN    std_logic := 'U';
        DQA0            : INOUT std_logic := 'U';
        DQA1            : INOUT std_logic := 'U';
        DQA2            : INOUT std_logic := 'U';
        DQA3            : INOUT std_logic := 'U';
        DQA4            : INOUT std_logic := 'U';
        DQA5            : INOUT std_logic := 'U';
        DQA6            : INOUT std_logic := 'U';
        DQA7            : INOUT std_logic := 'U';
        DQA8            : INOUT std_logic := 'U';
        DQB0            : INOUT std_logic := 'U';
        DQB1            : INOUT std_logic := 'U';
        DQB2            : INOUT std_logic := 'U';
        DQB3            : INOUT std_logic := 'U';
        DQB4            : INOUT std_logic := 'U';
        DQB5            : INOUT std_logic := 'U';
        DQB6            : INOUT std_logic := 'U';
        DQB7            : INOUT std_logic := 'U';
        DQB8            : INOUT std_logic := 'U';
        DQC0            : INOUT std_logic := 'U';
        DQC1            : INOUT std_logic := 'U';
        DQC2            : INOUT std_logic := 'U';
        DQC3            : INOUT std_logic := 'U';
        DQC4            : INOUT std_logic := 'U';
        DQC5            : INOUT std_logic := 'U';
        DQC6            : INOUT std_logic := 'U';
        DQC7            : INOUT std_logic := 'U';
        DQC8            : INOUT std_logic := 'U';
        DQD0            : INOUT std_logic := 'U';
        DQD1            : INOUT std_logic := 'U';
        DQD2            : INOUT std_logic := 'U';
        DQD3            : INOUT std_logic := 'U';
        DQD4            : INOUT std_logic := 'U';
        DQD5            : INOUT std_logic := 'U';
        DQD6            : INOUT std_logic := 'U';
        DQD7            : INOUT std_logic := 'U';
        DQD8            : INOUT std_logic := 'U';
        ADV             : IN    std_logic := 'U';
        R               : IN    std_logic := 'U';
        CLKENNeg        : IN    std_logic := 'U';
        BWDNeg          : IN    std_logic := 'U';
        BWCNeg          : IN    std_logic := 'U';
        BWBNeg          : IN    std_logic := 'U';
        BWANeg          : IN    std_logic := 'U';
        CE1Neg          : IN    std_logic := 'U';
        CE2Neg          : IN    std_logic := 'U';
        CE2             : IN    std_logic := 'U';
        CLK             : IN    std_logic := 'U';
        LBONeg          : IN    std_logic := '1';
        OENeg           : IN    std_logic := 'U'
    );
    ATTRIBUTE VITAL_LEVEL0 of idt71v3556 : ENTITY IS TRUE;
END idt71v3556;

--------------------------------------------------------------------------------
-- ARCHITECTURE DECLARATION
--------------------------------------------------------------------------------
ARCHITECTURE vhdl_behavioral of idt71v3556 IS
    ATTRIBUTE VITAL_LEVEL0 of vhdl_behavioral : ARCHITECTURE IS TRUE;

    CONSTANT partID           : STRING := "idt71v3556";
    SIGNAL LoadMem            : boolean := false;

    SIGNAL A0_ipd              : std_ulogic := 'U';
    SIGNAL A1_ipd              : std_ulogic := 'U';
    SIGNAL A2_ipd              : std_ulogic := 'U';
    SIGNAL A3_ipd              : std_ulogic := 'U';
    SIGNAL A4_ipd              : std_ulogic := 'U';
    SIGNAL A5_ipd              : std_ulogic := 'U';
    SIGNAL A6_ipd              : std_ulogic := 'U';
    SIGNAL A7_ipd              : std_ulogic := 'U';
    SIGNAL A8_ipd              : std_ulogic := 'U';
    SIGNAL A9_ipd              : std_ulogic := 'U';
    SIGNAL A10_ipd             : std_ulogic := 'U';
    SIGNAL A11_ipd             : std_ulogic := 'U';
    SIGNAL A12_ipd             : std_ulogic := 'U';
    SIGNAL A13_ipd             : std_ulogic := 'U';
    SIGNAL A14_ipd             : std_ulogic := 'U';
    SIGNAL A15_ipd             : std_ulogic := 'U';
    SIGNAL A16_ipd             : std_ulogic := 'U';
    SIGNAL DQA0_ipd            : std_ulogic := 'U';
    SIGNAL DQA1_ipd            : std_ulogic := 'U';
    SIGNAL DQA2_ipd            : std_ulogic := 'U';
    SIGNAL DQA3_ipd            : std_ulogic := 'U';
    SIGNAL DQA4_ipd            : std_ulogic := 'U';
    SIGNAL DQA5_ipd            : std_ulogic := 'U';
    SIGNAL DQA6_ipd            : std_ulogic := 'U';
    SIGNAL DQA7_ipd            : std_ulogic := 'U';
    SIGNAL DQA8_ipd            : std_ulogic := 'U';
    SIGNAL DQB0_ipd            : std_ulogic := 'U';
    SIGNAL DQB1_ipd            : std_ulogic := 'U';
    SIGNAL DQB2_ipd            : std_ulogic := 'U';
    SIGNAL DQB3_ipd            : std_ulogic := 'U';
    SIGNAL DQB4_ipd            : std_ulogic := 'U';
    SIGNAL DQB5_ipd            : std_ulogic := 'U';
    SIGNAL DQB6_ipd            : std_ulogic := 'U';
    SIGNAL DQB7_ipd            : std_ulogic := 'U';
    SIGNAL DQB8_ipd            : std_ulogic := 'U';
    SIGNAL DQC0_ipd            : std_ulogic := 'U';
    SIGNAL DQC1_ipd            : std_ulogic := 'U';
    SIGNAL DQC2_ipd            : std_ulogic := 'U';
    SIGNAL DQC3_ipd            : std_ulogic := 'U';
    SIGNAL DQC4_ipd            : std_ulogic := 'U';
    SIGNAL DQC5_ipd            : std_ulogic := 'U';
    SIGNAL DQC6_ipd            : std_ulogic := 'U';
    SIGNAL DQC7_ipd            : std_ulogic := 'U';
    SIGNAL DQC8_ipd            : std_ulogic := 'U';
    SIGNAL DQD0_ipd            : std_ulogic := 'U';
    SIGNAL DQD1_ipd            : std_ulogic := 'U';
    SIGNAL DQD2_ipd            : std_ulogic := 'U';
    SIGNAL DQD3_ipd            : std_ulogic := 'U';
    SIGNAL DQD4_ipd            : std_ulogic := 'U';
    SIGNAL DQD5_ipd            : std_ulogic := 'U';
    SIGNAL DQD6_ipd            : std_ulogic := 'U';
    SIGNAL DQD7_ipd            : std_ulogic := 'U';
    SIGNAL DQD8_ipd            : std_ulogic := 'U';
    SIGNAL ADV_ipd             : std_ulogic := 'U';
    SIGNAL R_ipd               : std_ulogic := 'U';
    SIGNAL CLKENNeg_ipd        : std_ulogic := 'U';
    SIGNAL BWDNeg_ipd          : std_ulogic := 'U';
    SIGNAL BWCNeg_ipd          : std_ulogic := 'U';
    SIGNAL BWBNeg_ipd          : std_ulogic := 'U';
    SIGNAL BWANeg_ipd          : std_ulogic := 'U';
    SIGNAL CE1Neg_ipd          : std_ulogic := 'U';
    SIGNAL CE2Neg_ipd          : std_ulogic := 'U';
    SIGNAL CE2_ipd             : std_ulogic := 'U';
    SIGNAL CLK_ipd             : std_ulogic := 'U';
    SIGNAL LBONeg_ipd          : std_ulogic := '1';
    SIGNAL OENeg_ipd           : std_ulogic := 'U';

    
BEGIN

    ----------------------------------------------------------------------------
    -- Wire Delays
    ----------------------------------------------------------------------------
    WireDelay : BLOCK
    BEGIN

        w_1 : VitalWireDelay (A0_ipd, A0, tipd_A0);
        w_2 : VitalWireDelay (A1_ipd, A1, tipd_A1);
        w_3 : VitalWireDelay (A2_ipd, A2, tipd_A2);
        w_4 : VitalWireDelay (A3_ipd, A3, tipd_A3);
        w_5 : VitalWireDelay (A4_ipd, A4, tipd_A4);
        w_6 : VitalWireDelay (A5_ipd, A5, tipd_A5);
        w_7 : VitalWireDelay (A6_ipd, A6, tipd_A6);
        w_8 : VitalWireDelay (A7_ipd, A7, tipd_A7);
        w_9 : VitalWireDelay (A8_ipd, A8, tipd_A8);
        w_10 : VitalWireDelay (A9_ipd, A9, tipd_A9);
        w_11 : VitalWireDelay (A10_ipd, A10, tipd_A10);
        w_12 : VitalWireDelay (A11_ipd, A11, tipd_A11);
        w_13 : VitalWireDelay (A12_ipd, A12, tipd_A12);
        w_14 : VitalWireDelay (A13_ipd, A13, tipd_A13);
        w_15 : VitalWireDelay (A14_ipd, A14, tipd_A14);
        w_16 : VitalWireDelay (A15_ipd, A15, tipd_A15);
        w_17 : VitalWireDelay (A16_ipd, A16, tipd_A16);
        w_21 : VitalWireDelay (DQA0_ipd, DQA0, tipd_DQA0);
        w_22 : VitalWireDelay (DQA1_ipd, DQA1, tipd_DQA1);
        w_23 : VitalWireDelay (DQA2_ipd, DQA2, tipd_DQA2);
        w_24 : VitalWireDelay (DQA3_ipd, DQA3, tipd_DQA3);
        w_25 : VitalWireDelay (DQA4_ipd, DQA4, tipd_DQA4);
        w_26 : VitalWireDelay (DQA5_ipd, DQA5, tipd_DQA5);
        w_27 : VitalWireDelay (DQA6_ipd, DQA6, tipd_DQA6);
        w_28 : VitalWireDelay (DQA7_ipd, DQA7, tipd_DQA7);
        w_29 : VitalWireDelay (DQA8_ipd, DQA8, tipd_DQA8);
        w_31 : VitalWireDelay (DQB0_ipd, DQB0, tipd_DQB0);
        w_32 : VitalWireDelay (DQB1_ipd, DQB1, tipd_DQB1);
        w_33 : VitalWireDelay (DQB2_ipd, DQB2, tipd_DQB2);
        w_34 : VitalWireDelay (DQB3_ipd, DQB3, tipd_DQB3);
        w_35 : VitalWireDelay (DQB4_ipd, DQB4, tipd_DQB4);
        w_36 : VitalWireDelay (DQB5_ipd, DQB5, tipd_DQB5);
        w_37 : VitalWireDelay (DQB6_ipd, DQB6, tipd_DQB6);
        w_38 : VitalWireDelay (DQB7_ipd, DQB7, tipd_DQB7);
        w_39 : VitalWireDelay (DQB8_ipd, DQB8, tipd_DQB8);
        w_41 : VitalWireDelay (DQC0_ipd, DQC0, tipd_DQC0);
        w_42 : VitalWireDelay (DQC1_ipd, DQC1, tipd_DQC1);
        w_43 : VitalWireDelay (DQC2_ipd, DQC2, tipd_DQC2);
        w_44 : VitalWireDelay (DQC3_ipd, DQC3, tipd_DQC3);
        w_45 : VitalWireDelay (DQC4_ipd, DQC4, tipd_DQC4);
        w_46 : VitalWireDelay (DQC5_ipd, DQC5, tipd_DQC5);
        w_47 : VitalWireDelay (DQC6_ipd, DQC6, tipd_DQC6);
        w_48 : VitalWireDelay (DQC7_ipd, DQC7, tipd_DQC7);
        w_49 : VitalWireDelay (DQC8_ipd, DQC8, tipd_DQC8);
        w_51 : VitalWireDelay (DQD0_ipd, DQD0, tipd_DQD0);
        w_52 : VitalWireDelay (DQD1_ipd, DQD1, tipd_DQD1);
        w_53 : VitalWireDelay (DQD2_ipd, DQD2, tipd_DQD2);
        w_54 : VitalWireDelay (DQD3_ipd, DQD3, tipd_DQD3);
        w_55 : VitalWireDelay (DQD4_ipd, DQD4, tipd_DQD4);
        w_56 : VitalWireDelay (DQD5_ipd, DQD5, tipd_DQD5);
        w_57 : VitalWireDelay (DQD6_ipd, DQD6, tipd_DQD6);
        w_58 : VitalWireDelay (DQD7_ipd, DQD7, tipd_DQD7);
        w_59 : VitalWireDelay (DQD8_ipd, DQD8, tipd_DQD8);
        w_61 : VitalWireDelay (ADV_ipd, ADV, tipd_ADV);
        w_62 : VitalWireDelay (R_ipd, R, tipd_R);
        w_63 : VitalWireDelay (CLKENNeg_ipd, CLKENNeg, tipd_CLKENNeg);
        w_64 : VitalWireDelay (BWDNeg_ipd, BWDNeg, tipd_BWDNeg);
        w_65 : VitalWireDelay (BWCNeg_ipd, BWCNeg, tipd_BWCNeg);
        w_66 : VitalWireDelay (BWBNeg_ipd, BWBNeg, tipd_BWBNeg);
        w_67 : VitalWireDelay (BWANeg_ipd, BWANeg, tipd_BWANeg);
        w_68 : VitalWireDelay (CE1Neg_ipd, CE1Neg, tipd_CE1Neg);
        w_69 : VitalWireDelay (CE2Neg_ipd, CE2Neg, tipd_CE2Neg);
        w_70 : VitalWireDelay (CE2_ipd, CE2, tipd_CE2);
        w_71 : VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
        w_72 : VitalWireDelay (LBONeg_ipd, LBONeg, tipd_LBONeg);
        w_73 : VitalWireDelay (OENeg_ipd, OENeg, tipd_OENeg);

    END BLOCK;

    ----------------------------------------------------------------------------
    -- Main Behavior Block
    ----------------------------------------------------------------------------
    Behavior: BLOCK

        PORT (
            BWDNIn          : IN    std_ulogic := 'U';
            BWCNIn          : IN    std_ulogic := 'U';
            BWBNIn          : IN    std_ulogic := 'U';
            BWANIn          : IN    std_ulogic := 'U';
            DatDIn          : IN    std_logic_vector(8 downto 0);
            DatCIn          : IN    std_logic_vector(8 downto 0);
            DatBIn          : IN    std_logic_vector(8 downto 0);
            DatAIn          : IN    std_logic_vector(8 downto 0);
            DataOut         : OUT   std_logic_vector(35 downto 0)
                                                     := (others => 'Z');
            CLKIn           : IN    std_ulogic := 'U';
            CKENIn          : IN    std_ulogic := 'U';
            AddressIn       : IN    std_logic_vector(16 downto 0);
            OENegIn         : IN    std_ulogic := 'U';
            RIn             : IN    std_ulogic := 'U';
            ADVIn           : IN    std_ulogic := 'U';
            CE2In           : IN    std_ulogic := 'U';
            LBONegIn        : IN    std_ulogic := '1';
            CE1NegIn        : IN    std_ulogic := 'U';
            CE2NegIn        : IN    std_ulogic := 'U'
        );
        PORT MAP (
            BWDNIn => To_UX01(BWDNeg_ipd),
            BWCNIn => To_UX01(BWCNeg_ipd),
            BWBNIn => To_UX01(BWBNeg_ipd),
            BWANIn => To_UX01(BWANeg_ipd),
            CLKIn => CLK_ipd,
            CKENIn => To_UX01(CLKENNeg_ipd),
            OENegIn => To_UX01(OENeg_ipd),
            RIn => To_UX01(R_ipd),
            ADVIn => To_UX01(ADV_ipd),
            CE2In => To_UX01(CE2_ipd),
            LBONegIn => To_UX01(LBONeg_ipd),
            CE1NegIn => To_UX01(CE1Neg_ipd),
            CE2NegIn => To_UX01(CE2Neg_ipd),
            DataOut(0) =>  DQA0,
            DataOut(1) =>  DQA1,
            DataOut(2) =>  DQA2,
            DataOut(3) =>  DQA3,
            DataOut(4) =>  DQA4,
            DataOut(5) =>  DQA5,
            DataOut(6) =>  DQA6,
            DataOut(7) =>  DQA7,
            DataOut(8) =>  DQA8,
            DataOut(9) =>  DQB0,
            DataOut(10) =>  DQB1,
            DataOut(11) =>  DQB2,
            DataOut(12) =>  DQB3,
            DataOut(13) =>  DQB4,
            DataOut(14) =>  DQB5,
            DataOut(15) =>  DQB6,
            DataOut(16) =>  DQB7,
            DataOut(17) =>  DQB8,
            DataOut(18) =>  DQC0,
            DataOut(19) =>  DQC1,
            DataOut(20) =>  DQC2,
            DataOut(21) =>  DQC3,
            DataOut(22) =>  DQC4,
            DataOut(23) =>  DQC5,
            DataOut(24) =>  DQC6,
            DataOut(25) =>  DQC7,
            DataOut(26) =>  DQC8,
            DataOut(27) =>  DQD0,
            DataOut(28) =>  DQD1,
            DataOut(29) =>  DQD2,
            DataOut(30) =>  DQD3,
            DataOut(31) =>  DQD4,
            DataOut(32) =>  DQD5,
            DataOut(33) =>  DQD6,
            DataOut(34) =>  DQD7,
            DataOut(35) =>  DQD8,
            DatAIn(0) =>  DQA0_ipd,
            DatAIn(1) =>  DQA1_ipd,
            DatAIn(2) =>  DQA2_ipd,
            DatAIn(3) =>  DQA3_ipd,
            DatAIn(4) =>  DQA4_ipd,
            DatAIn(5) =>  DQA5_ipd,
            DatAIn(6) =>  DQA6_ipd,
            DatAIn(7) =>  DQA7_ipd,
            DatAIn(8) =>  DQA8_ipd,
            DatBIn(0) =>  DQB0_ipd,
            DatBIn(1) =>  DQB1_ipd,
            DatBIn(2) =>  DQB2_ipd,
            DatBIn(3) =>  DQB3_ipd,
            DatBIn(4) =>  DQB4_ipd,
            DatBIn(5) =>  DQB5_ipd,
            DatBIn(6) =>  DQB6_ipd,
            DatBIn(7) =>  DQB7_ipd,
            DatBIn(8) =>  DQB8_ipd,
            DatCIn(0) =>  DQC0_ipd,
            DatCIn(1) =>  DQC1_ipd,
            DatCIn(2) =>  DQC2_ipd,
            DatCIn(3) =>  DQC3_ipd,
            DatCIn(4) =>  DQC4_ipd,
            DatCIn(5) =>  DQC5_ipd,
            DatCIn(6) =>  DQC6_ipd,
            DatCIn(7) =>  DQC7_ipd,
            DatCIn(8) =>  DQC8_ipd,
            DatDIn(0) =>  DQD0_ipd,
            DatDIn(1) =>  DQD1_ipd,
            DatDIn(2) =>  DQD2_ipd,
            DatDIn(3) =>  DQD3_ipd,
            DatDIn(4) =>  DQD4_ipd,
            DatDIn(5) =>  DQD5_ipd,
            DatDIn(6) =>  DQD6_ipd,
            DatDIn(7) =>  DQD7_ipd,
            DatDIn(8) =>  DQD8_ipd,
            AddressIn(0) => A0_ipd,
            AddressIn(1) => A1_ipd,
            AddressIn(2) => A2_ipd,
            AddressIn(3) => A3_ipd,
            AddressIn(4) => A4_ipd,
            AddressIn(5) => A5_ipd,
            AddressIn(6) => A6_ipd,
            AddressIn(7) => A7_ipd,
            AddressIn(8) => A8_ipd,
            AddressIn(9) => A9_ipd,
            AddressIn(10) => A10_ipd,
            AddressIn(11) => A11_ipd,
            AddressIn(12) => A12_ipd,
            AddressIn(13) => A13_ipd,
            AddressIn(14) => A14_ipd,
            AddressIn(15) => A15_ipd,
            AddressIn(16) => A16_ipd
        );

        -- Type definition for state machine
        TYPE mem_state IS (desel,
                           begin_rd,
                           begin_wr,
                           burst_rd,
                           burst_wr
                          );

        SIGNAL state     : mem_state;

        TYPE sequence IS ARRAY (0 to 3) OF INTEGER RANGE -3 to 3;
        TYPE seqtab IS ARRAY (0 to 3) OF sequence;

        CONSTANT il0 : sequence := (0, 1, 2, 3);
        CONSTANT il1 : sequence := (0, -1, 2, 1);
        CONSTANT il2 : sequence := (0, 1, -2, -1);
        CONSTANT il3 : sequence := (0, -1, -2, -3);
        CONSTANT il  : seqtab := (il0, il1, il2, il3);

        CONSTANT ln0 : sequence := (0, 1, 2, 3);
        CONSTANT ln1 : sequence := (0, 1, 2, -1);
        CONSTANT ln2 : sequence := (0, 1, -2, -1);
        CONSTANT ln3 : sequence := (0, -3, -2, -1);
        CONSTANT ln  : seqtab := (ln0, ln1, ln2, ln3);

        SIGNAL Burst_Seq : seqtab;

        SIGNAL D_zd      : std_logic_vector(35 DOWNTO 0);

    BEGIN

        Burst_Setup : PROCESS

        BEGIN

           IF (LBONegIn = '1') THEN
               Burst_Seq <= il;
           ELSE
               Burst_Seq <= ln;
           END IF;
           WAIT;    -- Mode can be set only during power up

        END PROCESS Burst_Setup;

    ----------------------------------------------------------------------------
    -- Main Behavior Process
    ----------------------------------------------------------------------------
        Behavior : PROCESS (BWDNIn, BWCNIn, BWBNIn, BWANIn, DatDIn, DatCIn,
                            DatBIn, DatAIn, CLKIn, CKENIn, AddressIn, RIn,
                            OENegIn, ADVIn, CE2In, CE1NegIn, CE2NegIn)

            -- Type definition for commands
            TYPE command_type is (ds,
                                  burst,
                                  read,
                                  write
                                 );

            -- Timing Check Variables
            VARIABLE Tviol_BWDN_CLK     : X01 := '0';
            VARIABLE TD_BWDN_CLK        : VitalTimingDataType;

            VARIABLE Tviol_BWCN_CLK     : X01 := '0';
            VARIABLE TD_BWCN_CLK        : VitalTimingDataType;

            VARIABLE Tviol_BWBN_CLK     : X01 := '0';
            VARIABLE TD_BWBN_CLK        : VitalTimingDataType;

            VARIABLE Tviol_BWAN_CLK     : X01 := '0';
            VARIABLE TD_BWAN_CLK        : VitalTimingDataType;

            VARIABLE Tviol_CKENIn_CLK   : X01 := '0';
            VARIABLE TD_CKENIn_CLK      : VitalTimingDataType;

            VARIABLE Tviol_ADVIn_CLK    : X01 := '0';
            VARIABLE TD_ADVIn_CLK       : VitalTimingDataType;

            VARIABLE Tviol_CE1NegIn_CLK : X01 := '0';
            VARIABLE TD_CE1NegIn_CLK    : VitalTimingDataType;

            VARIABLE Tviol_CE2NegIn_CLK : X01 := '0';
            VARIABLE TD_CE2NegIn_CLK    : VitalTimingDataType;

            VARIABLE Tviol_CE2In_CLK    : X01 := '0';
            VARIABLE TD_CE2In_CLK       : VitalTimingDataType;

            VARIABLE Tviol_RIn_CLK      : X01 := '0';
            VARIABLE TD_RIn_CLK         : VitalTimingDataType;

            VARIABLE Tviol_DatDIn_CLK   : X01 := '0';
            VARIABLE TD_DatDIn_CLK      : VitalTimingDataType;

            VARIABLE Tviol_DatCIn_CLK   : X01 := '0';
            VARIABLE TD_DatCIn_CLK      : VitalTimingDataType;

            VARIABLE Tviol_DatBIn_CLK   : X01 := '0';
            VARIABLE TD_DatBIn_CLK      : VitalTimingDataType;

            VARIABLE Tviol_DatAIn_CLK   : X01 := '0';
            VARIABLE TD_DatAIn_CLK      : VitalTimingDataType;

            VARIABLE Tviol_AddressIn_CLK      : X01 := '0';
            VARIABLE TD_AddressIn_CLK         : VitalTimingDataType;

            VARIABLE Pviol_CLK    : X01 := '0';
            VARIABLE PD_CLK       : VitalPeriodDataType := VitalPeriodDataInit;

            -- Memory array declaration
            TYPE MemStore IS ARRAY (0 to 131071) OF INTEGER
                             RANGE  -2 TO 511;

            FILE mem_file       : text IS mem_file_name;
            VARIABLE MemDataA   : MemStore;
            VARIABLE MemDataB   : MemStore;
            VARIABLE MemDataC   : MemStore;
            VARIABLE MemDataD   : MemStore;
            VARIABLE ind        : NATURAL := 0;
            VARIABLE buf        : line;

            VARIABLE MemAddr    : NATURAL RANGE 0 TO 131071;
            VARIABLE MemAddr1   : NATURAL RANGE 0 TO 131071;
            VARIABLE startaddr  : NATURAL RANGE 0 TO 131071;

            VARIABLE Burst_Cnt  : NATURAL RANGE 0 TO 4 := 0;
            VARIABLE memstart   : NATURAL RANGE 0 TO 3 := 0;
            VARIABLE offset     : INTEGER RANGE -3 TO 3 := 0;

            VARIABLE command : command_type;

            VARIABLE BWD1    : UX01;
            VARIABLE BWC1    : UX01;
            VARIABLE BWB1    : UX01;
            VARIABLE BWA1    : UX01;

            VARIABLE BWD2    : UX01;
            VARIABLE BWC2    : UX01;
            VARIABLE BWB2    : UX01;
            VARIABLE BWA2    : UX01;

            VARIABLE wr1     : boolean := false;
            VARIABLE wr2     : boolean := false;
            VARIABLE wr3     : boolean := false;

            -- Functionality Results Variables
            VARIABLE Violation  : X01 := '0';

            VARIABLE OBuf1      : std_logic_vector(35 DOWNTO 0)
                                   := (OTHERS => 'Z');
            VARIABLE OBuf2      : std_logic_vector(35 DOWNTO 0)
                                   := (OTHERS => 'Z');

        BEGIN

            --------------------------------------------------------------------
            -- Timing Check Section
            --------------------------------------------------------------------
            IF (TimingChecksOn) THEN

                VitalSetupHoldCheck (
                    TestSignal      => BWDNIn,
                    TestSignalName  => "BWD",
                    RefSignal       => CLKIn,
                    RefSignalName   => "CLK",
                    SetupHigh       => tsetup_BWANeg_CLK,
                    SetupLow        => tsetup_BWANeg_CLK,
                    HoldHigh        => thold_BWANeg_CLK,
                    HoldLow         => thold_BWANeg_CLK,
                    CheckEnabled    => (CKENIn ='0'),
                    RefTransition   => '/',
                    HeaderMsg       => InstancePath & PartID,
                    TimingData      => TD_BWDN_CLK,
                    XOn             => XOn,
                    MsgOn           => MsgOn,
                    Violation       => Tviol_BWDN_CLK );

                VitalSetupHoldCheck (
                    TestSignal      => BWCNIn,
                    TestSignalName  => "BWC",
                    RefSignal       => CLKIn,
                    RefSignalName   => "CLK",
                    SetupHigh       => tsetup_BWANeg_CLK,
                    SetupLow        => tsetup_BWANeg_CLK,
                    HoldHigh        => thold_BWANeg_CLK,
                    HoldLow         => thold_BWANeg_CLK,
                    CheckEnabled    => (CKENIn ='0'),
                    RefTransition   => '/',
                    HeaderMsg       => InstancePath & PartID,
                    TimingData      => TD_BWCN_CLK,
                    XOn             => XOn,
                    MsgOn           => MsgOn,
                    Violation       => Tviol_BWCN_CLK );

                VitalSetupHoldCheck (
                    TestSignal      => BWBNIn,
                    TestSignalName  => "BWB",
                    RefSignal       => CLKIn,
                    RefSignalName   => "CLK",
                    SetupHigh       => tsetup_BWANeg_CLK,
                    SetupLow        => tsetup_BWANeg_CLK,
                    HoldHigh        => thold_BWANeg_CLK,
                    HoldLow         => thold_BWANeg_CLK,
                    CheckEnabled    => (CKENIn ='0'),
                    RefTransition   => '/',
                    HeaderMsg       => InstancePath & PartID,
                    TimingData      => TD_BWBN_CLK,
                    XOn             => XOn,
                    MsgOn           => MsgOn,
                    Violation       => Tviol_BWBN_CLK );

                VitalSetupHoldCheck (
                    TestSignal      => BWANIn,
                    TestSignalName  => "BWA",
                    RefSignal       => CLKIn,
                    RefSignalName   => "CLK",
                    SetupHigh       => tsetup_BWANeg_CLK,
                    SetupLow        => tsetup_BWANeg_CLK,
                    HoldHigh        => thold_BWANeg_CLK,
                    HoldLow         => thold_BWANeg_CLK,
                    CheckEnabled    => (CKENIn ='0'),
                    RefTransition   => '/',
                    HeaderMsg       => InstancePath & PartID,
                    TimingData      => TD_BWAN_CLK,
                    XOn             => XOn,
                    MsgOn           => MsgOn,
                    Violation       => Tviol_BWAN_CLK );

                VitalSetupHoldCheck (
                    TestSignal      => CKENIn,
                    TestSignalName  => "CLKENNeg",
                    RefSignal       => CLKIn,
                    RefSignalName   => "CLK",
                    SetupHigh       => tsetup_CLKENNeg_CLK,
                    SetupLow        => tsetup_CLKENNeg_CLK,
                    HoldHigh        => thold_CLKENNeg_CLK,
                    HoldLow         => thold_CLKENNeg_CLK,
                    CheckEnabled    => TRUE,
                    RefTransition   => '/',
                    HeaderMsg       => InstancePath & PartID,
                    TimingData      => TD_CKENIn_CLK,
                    XOn             => XOn,
                    MsgOn           => MsgOn,
                    Violation       => Tviol_CKENIn_CLK );

                VitalSetupHoldCheck (
                    TestSignal      => ADVIn,
                    TestSignalName  => "ADV",
                    RefSignal       => CLKIn,
                    RefSignalName   => "CLK",
                    SetupHigh       => tsetup_ADV_CLK,
                    SetupLow        => tsetup_ADV_CLK,
                    HoldHigh        => thold_ADV_CLK,
                    HoldLow         => thold_ADV_CLK,
                    CheckEnabled    => (CKENIn ='0'),
                    RefTransition   => '/',
                    HeaderMsg       => InstancePath & PartID,
                    TimingData      => TD_ADVIn_CLK,
                    XOn             => XOn,
                    MsgOn           => MsgOn,
                    Violation       => Tviol_ADVIn_CLK );

                VitalSetupHoldCheck (
                    TestSignal      => CE1NegIn,
                    TestSignalName  => "CE1Neg",
                    RefSignal       => CLKIn,
                    RefSignalName   => "CLK",
                    SetupHigh       => tsetup_CE2_CLK,
                    SetupLow        => tsetup_CE2_CLK,
                    HoldHigh        => thold_CE2_CLK,
                    HoldLow         => thold_CE2_CLK,
                    CheckEnabled    => (CKENIn ='0'),
                    RefTransition   => '/',
                    HeaderMsg       => InstancePath & PartID,
                    TimingData      => TD_CE1NegIn_CLK,
                    XOn             => XOn,
                    MsgOn           => MsgOn,
                    Violation       => Tviol_CE1NegIn_CLK );

                VitalSetupHoldCheck (
                    TestSignal      => CE2NegIn,
                    TestSignalName  => "CE2Neg",
                    RefSignal       => CLKIn,
                    RefSignalName   => "CLK",
                    SetupHigh       => tsetup_CE2_CLK,
                    SetupLow        => tsetup_CE2_CLK,
                    HoldHigh        => thold_CE2_CLK,
                    HoldLow         => thold_CE2_CLK,
                    CheckEnabled    => (CKENIn ='0'),
                    RefTransition   => '/',
                    HeaderMsg       => InstancePath & PartID,
                    TimingData      => TD_CE2NegIn_CLK,
                    XOn             => XOn,
                    MsgOn           => MsgOn,
                    Violation       => Tviol_CE2NegIn_CLK );

                VitalSetupHoldCheck (
                    TestSignal      => CE2In,
                    TestSignalName  => "CE2",
                    RefSignal       => CLKIn,
                    RefSignalName   => "CLK",
                    SetupHigh       => tsetup_CE2_CLK,
                    SetupLow        => tsetup_CE2_CLK,
                    HoldHigh        => thold_CE2_CLK,
                    HoldLow         => thold_CE2_CLK,
                    CheckEnabled    => (CKENIn ='0'),
                    RefTransition   => '/',
                    HeaderMsg       => InstancePath & PartID,
                    TimingData      => TD_CE2In_CLK,
                    XOn             => XOn,
                    MsgOn           => MsgOn,
                    Violation       => Tviol_CE2In_CLK );

                VitalSetupHoldCheck (
                    TestSignal      => RIn,
                    TestSignalName  => "R",
                    RefSignal       => CLKIn,
                    RefSignalName   => "CLK",
                    SetupHigh       => tsetup_R_CLK,
                    SetupLow        => tsetup_R_CLK,
                    HoldHigh        => thold_R_CLK,
                    HoldLow         => thold_R_CLK,
                    CheckEnabled    => (CKENIn ='0'),
                    RefTransition   => '/',
                    HeaderMsg       => InstancePath & PartID,
                    TimingData      => TD_RIn_CLK,
                    XOn             => XOn,
                    MsgOn           => MsgOn,
                    Violation       => Tviol_RIn_CLK );

                VitalSetupHoldCheck (
                    TestSignal      => AddressIn,
                    TestSignalName  => "Address",
                    RefSignal       => CLKIn,
                    RefSignalName   => "CLK",
                    SetupHigh       => tsetup_A0_CLK,
                    SetupLow        => tsetup_A0_CLK,
                    HoldHigh        => thold_A0_CLK,
                    HoldLow         => thold_A0_CLK,
                    CheckEnabled    => (CKENIn ='0'),
                    RefTransition   => '/',
                    HeaderMsg       => InstancePath & PartID,
                    TimingData      => TD_AddressIn_CLK,
                    XOn             => XOn,
                    MsgOn           => MsgOn,
                    Violation       => Tviol_AddressIn_CLK );

                VitalSetupHoldCheck (
                    TestSignal      => DatDIn,
                    TestSignalName  => "DatD",
                    RefSignal       => CLKIn,
                    RefSignalName   => "CLK",
                    SetupHigh       => tsetup_DQA0_CLK,
                    SetupLow        => tsetup_DQA0_CLK,
                    HoldHigh        => thold_DQA0_CLK,
                    HoldLow         => thold_DQA0_CLK,
                    CheckEnabled    => (CKENIn ='0'),
                    RefTransition   => '/',
                    HeaderMsg       => InstancePath & PartID,
                    TimingData      => TD_DatDIn_CLK,
                    XOn             => XOn,
                    MsgOn           => MsgOn,
                    Violation       => Tviol_DatDIn_CLK );

                VitalSetupHoldCheck (
                    TestSignal      => DatCIn,
                    TestSignalName  => "DatC",
                    RefSignal       => CLKIn,
                    RefSignalName   => "CLK",
                    SetupHigh       => tsetup_DQA0_CLK,
                    SetupLow        => tsetup_DQA0_CLK,
                    HoldHigh        => thold_DQA0_CLK,
                    HoldLow         => thold_DQA0_CLK,
                    CheckEnabled    => (CKENIn ='0'),
                    RefTransition   => '/',
                    HeaderMsg       => InstancePath & PartID,
                    TimingData      => TD_DatCIn_CLK,
                    XOn             => XOn,
                    MsgOn           => MsgOn,
                    Violation       => Tviol_DatCIn_CLK );

                VitalSetupHoldCheck (
                    TestSignal      => DatBIn,
                    TestSignalName  => "DatB",
                    RefSignal       => CLKIn,
                    RefSignalName   => "CLK",
                    SetupHigh       => tsetup_DQA0_CLK,
                    SetupLow        => tsetup_DQA0_CLK,
                    HoldHigh        => thold_DQA0_CLK,
                    HoldLow         => thold_DQA0_CLK,
                    CheckEnabled    => (CKENIn ='0'),
                    RefTransition   => '/',
                    HeaderMsg       => InstancePath & PartID,
                    TimingData      => TD_DatBIn_CLK,
                    XOn             => XOn,
                    MsgOn           => MsgOn,
                    Violation       => Tviol_DatBIn_CLK );

                VitalSetupHoldCheck (
                    TestSignal      => DatAIn,
                    TestSignalName  => "DatA",
                    RefSignal       => CLKIn,
                    RefSignalName   => "CLK",
                    SetupHigh       => tsetup_DQA0_CLK,
                    SetupLow        => tsetup_DQA0_CLK,
                    HoldHigh        => thold_DQA0_CLK,
                    HoldLow         => thold_DQA0_CLK,
                    CheckEnabled    => (CKENIn ='0'),
                    RefTransition   => '/',
                    HeaderMsg       => InstancePath & PartID,
                    TimingData      => TD_DatAIn_CLK,
                    XOn             => XOn,
                    MsgOn           => MsgOn,
                    Violation       => Tviol_DatAIn_CLK );

                VitalPeriodPulseCheck (
                    TestSignal      =>  CLKIn,
                    TestSignalName  =>  "CLK",
                    Period          =>  tperiod_CLK_posedge,
                    PulseWidthLow   =>  tpw_CLK_negedge,
                    PulseWidthHigh  =>  tpw_CLK_posedge,
                    PeriodData      =>  PD_CLK,
                    XOn             =>  XOn,
                    MsgOn           =>  MsgOn,
                    Violation       =>  Pviol_CLK,
                    HeaderMsg       =>  InstancePath & PartID,
                    CheckEnabled    =>  (CKENIn ='0') );

                Violation := Pviol_CLK OR Tviol_DatAIn_CLK OR Tviol_DatBIn_CLK
                             OR Tviol_DatCIn_CLK OR Tviol_DatDIn_CLK OR
                             Tviol_AddressIn_CLK OR Tviol_RIn_CLK OR 
                             Tviol_CE2In_CLK OR Tviol_CE2NegIn_CLK OR
                             Tviol_CE1NegIn_CLK OR Tviol_ADVIn_CLK OR
                             Tviol_CKENIn_CLK OR Tviol_BWAN_CLK OR
                             Tviol_BWBN_CLK OR Tviol_BWCN_CLK OR
                             Tviol_BWDN_CLK;


                ASSERT Violation = '0'
                    REPORT InstancePath & partID & ": simulation may be" &
                           " inaccurate due to timing violations"
                    SEVERITY SeverityMode;

            END IF; -- Timing Check Section

    --------------------------------------------------------------------
    -- Functional Section
    --------------------------------------------------------------------

    IF (rising_edge(CLKIn) AND CKENIn = '0') THEN
        ASSERT (not(Is_X(BWDNIn)))
            REPORT InstancePath & partID & ": Unusable value for BWDN"
            SEVERITY SeverityMode;
        ASSERT (not(Is_X(BWCNIn)))
            REPORT InstancePath & partID & ": Unusable value for BWCN"
            SEVERITY SeverityMode;
        ASSERT (not(Is_X(BWBNIn)))
            REPORT InstancePath & partID & ": Unusable value for BWBN"
            SEVERITY SeverityMode;
        ASSERT (not(Is_X(BWANIn)))
            REPORT InstancePath & partID & ": Unusable value for BWAN"
            SEVERITY SeverityMode;
        ASSERT (not(Is_X(RIn)))
            REPORT InstancePath & partID & ": Unusable value for R"
            SEVERITY SeverityMode;
        ASSERT (not(Is_X(ADVIn)))
            REPORT InstancePath & partID & ": Unusable value for ADV"
            SEVERITY SeverityMode;
        ASSERT (not(Is_X(CE2In)))
            REPORT InstancePath & partID & ": Unusable value for CE2"
            SEVERITY SeverityMode;
        ASSERT (not(Is_X(CE1NegIn)))
            REPORT InstancePath & partID & ": Unusable value for CE1Neg"
            SEVERITY SeverityMode;
        ASSERT (not(Is_X(CE2NegIn)))
            REPORT InstancePath & partID & ": Unusable value for CE2Neg"
            SEVERITY SeverityMode;

        -- Command Decode
        IF ((ADVIn = '0') AND (CE1NegIn = '1' OR CE2NegIn = '1' OR
                CE2In = '0')) THEN
            command := ds;
        ELSIF (CE1NegIn = '0' AND CE2NegIn = '0' AND CE2In = '1' AND
                ADVIn = '0') THEN
            IF (RIn = '1') THEN
                command := read;
            ELSE
                command := write;
            END IF;
        ELSIF (ADVIn = '1') AND (CE1NegIn = '0' AND CE2NegIn = '0' AND
                  CE2In = '1') THEN
            command := burst;
        ELSE
            ASSERT false
                REPORT InstancePath & partID & ": Could not decode "
                       & "command."
                SEVERITY SeverityMode;
        END IF;

        wr3 := wr2;
        wr2 := wr1;
        wr1 := false;

        IF (wr3) THEN
            IF (BWA2 = '0') THEN
                IF Violation = 'X' THEN
                    MemDataA(MemAddr1) := -1;
                ELSE
                    MemDataA(MemAddr1) := to_nat(DatAIn);
                END IF;
            END IF;
            IF (BWB2 = '0') THEN
                IF Violation = 'X' THEN
                    MemDataB(MemAddr1) := -1;
                ELSE
                    MemDataB(MemAddr1) := to_nat(DatBIn);
                END IF;
            END IF;
            IF (BWC2 = '0') THEN
                IF Violation = 'X' THEN
                    MemDataC(MemAddr1) := -1;
                ELSE
                    MemDataC(MemAddr1) := to_nat(DatCIn);
                END IF;
            END IF;
            IF (BWD2 = '0') THEN
                IF Violation = 'X' THEN
                    MemDataD(MemAddr1) := -1;
                ELSE
                    MemDataD(MemAddr1) := to_nat(DatDIn);
                END IF;
            END IF;
        END IF;

        MemAddr1 := MemAddr;
        OBuf2 := OBuf1;

        -- The State Machine
        CASE state IS
            WHEN desel =>
                CASE command IS
                    WHEN ds =>
                        OBuf1 := (others => 'Z');
                    WHEN read =>
                        state <= begin_rd;
                        MemAddr := to_nat(AddressIn);
                        startaddr := MemAddr;
                        memstart := to_nat(AddressIn(1 downto 0));
                        IF MemDataA(MemAddr) = -2 THEN
                            OBuf1(8 downto 0) := (others => 'U');
                        ELSIF MemDataA(MemAddr) = -1 THEN
                            OBuf1(8 downto 0) := (others => 'X');
                        ELSE
                            OBuf1(8 downto 0) := to_slv(MemDataA(MemAddr),9);
                        END IF;
                        IF MemDataB(MemAddr) = -2 THEN
                            OBuf1(17 downto 9) := (others => 'U');
                        ELSIF MemDataB(MemAddr) = -1 THEN
                            OBuf1(17 downto 9) := (others => 'X');
                        ELSE
                            OBuf1(17 downto 9) := to_slv(MemDataB(MemAddr),9);
                        END IF;
                        IF MemDataC(MemAddr) = -2 THEN
                            OBuf1(26 downto 18) := (others => 'U');
                        ELSIF MemDataC(MemAddr) = -1 THEN
                            OBuf1(26 downto 18) := (others => 'X');
                        ELSE
                            OBuf1(26 downto 18) := to_slv(MemDataC(MemAddr),9);
                        END IF;
                        IF MemDataD(MemAddr) = -2 THEN
                            OBuf1(35 downto 27) := (others => 'U');
                        ELSIF MemDataD(MemAddr) = -1 THEN
                            OBuf1(35 downto 27) := (others => 'X');
                        ELSE
                            OBuf1(35 downto 27) := to_slv(MemDataD(MemAddr),9);
                        END IF;
                    WHEN write =>
                        state <= begin_wr;
                        MemAddr := to_nat(AddressIn);
                        startaddr := MemAddr;
                        memstart := to_nat(AddressIn(1 downto 0));
                        OBuf1 := (others => 'Z');
                        BWA1 := BWANIn;
                        BWB1 := BWBNIn;
                        BWC1 := BWCNIn;
                        BWD1 := BWDNIn;
                        wr1  := true;
                    WHEN burst =>
                        OBuf1 := (others => 'Z');
                 END CASE;

            WHEN begin_rd =>
                Burst_Cnt := 0;
                CASE command IS
                    WHEN ds =>
                        state <= desel;
                        OBuf1 := (others => 'Z');
                    WHEN read =>
                        state <= begin_rd;
                        MemAddr := to_nat(AddressIn);
                        startaddr := MemAddr;
                        memstart := to_nat(AddressIn(1 downto 0));
                        IF MemDataA(MemAddr) = -2 THEN
                            OBuf1(8 downto 0) := (others => 'U');
                        ELSIF MemDataA(MemAddr) = -1 THEN
                            OBuf1(8 downto 0) := (others => 'X');
                        ELSE
                            OBuf1(8 downto 0) := to_slv(MemDataA(MemAddr),9);
                        END IF;
                        IF MemDataB(MemAddr) = -2 THEN
                            OBuf1(17 downto 9) := (others => 'U');
                        ELSIF MemDataB(MemAddr) = -1 THEN
                            OBuf1(17 downto 9) := (others => 'X');
                        ELSE
                            OBuf1(17 downto 9) := to_slv(MemDataB(MemAddr),9);
                        END IF;
                        IF MemDataC(MemAddr) = -2 THEN
                            OBuf1(26 downto 18) := (others => 'U');
                        ELSIF MemDataC(MemAddr) = -1 THEN
                            OBuf1(26 downto 18) := (others => 'X');
                        ELSE
                            OBuf1(26 downto 18) := to_slv(MemDataC(MemAddr),9);
                        END IF;
                        IF MemDataD(MemAddr) = -2 THEN
                            OBuf1(35 downto 27) := (others => 'U');
                        ELSIF MemDataD(MemAddr) = -1 THEN
                            OBuf1(35 downto 27) := (others => 'X');
                        ELSE
                            OBuf1(35 downto 27) := to_slv(MemDataD(MemAddr),9);
                        END IF;
                    WHEN write =>
                        state <= begin_wr;
                        MemAddr := to_nat(AddressIn);
                        startaddr := MemAddr;
                        memstart := to_nat(AddressIn(1 downto 0));
                        OBuf1 := (others => 'Z');
                        BWA1 := BWANIn;
                        BWB1 := BWBNIn;
                        BWC1 := BWCNIn;
                        BWD1 := BWDNIn;
                        wr1  := true;
                    WHEN burst =>
                        state <= burst_rd;
                        Burst_Cnt := Burst_Cnt + 1;
                        IF (Burst_Cnt = 4) THEN
                            Burst_Cnt := 0;
                        END IF;
                        offset := Burst_Seq(memstart)(Burst_Cnt);
                        MemAddr := startaddr + offset;
                        IF MemDataA(MemAddr) = -2 THEN
                            OBuf1(8 downto 0) := (others => 'U');
                        ELSIF MemDataA(MemAddr) = -1 THEN
                            OBuf1(8 downto 0) := (others => 'X');
                        ELSE
                            OBuf1(8 downto 0) := to_slv(MemDataA(MemAddr),9);
                        END IF;
                        IF MemDataB(MemAddr) = -2 THEN
                            OBuf1(17 downto 9) := (others => 'U');
                        ELSIF MemDataB(MemAddr) = -1 THEN
                            OBuf1(17 downto 9) := (others => 'X');
                        ELSE
                            OBuf1(17 downto 9) := to_slv(MemDataB(MemAddr),9);
                        END IF;
                        IF MemDataC(MemAddr) = -2 THEN
                            OBuf1(26 downto 18) := (others => 'U');
                        ELSIF MemDataC(MemAddr) = -1 THEN
                            OBuf1(26 downto 18) := (others => 'X');
                        ELSE
                            OBuf1(26 downto 18) := to_slv(MemDataC(MemAddr),9);
                        END IF;
                        IF MemDataD(MemAddr) = -2 THEN
                            OBuf1(35 downto 27) := (others => 'U');
                        ELSIF MemDataD(MemAddr) = -1 THEN
                            OBuf1(35 downto 27) := (others => 'X');
                        ELSE
                            OBuf1(35 downto 27) := to_slv(MemDataD(MemAddr),9);
                        END IF;
                 END CASE;

            WHEN begin_wr =>
                BWA2 := BWA1;
                BWB2 := BWB1;
                BWC2 := BWC1;
                BWD2 := BWD1;
                Burst_Cnt := 0;
                CASE command IS
                    WHEN ds =>
                        state <= desel;
                        OBuf1 := (others => 'Z');
                    WHEN read =>
                        state <= begin_rd;
                        MemAddr := to_nat(AddressIn);
                        startaddr := MemAddr;
                        memstart := to_nat(AddressIn(1 downto 0));
                        IF MemDataA(MemAddr) = -2 THEN
                            OBuf1(8 downto 0) := (others => 'U');
                        ELSIF MemDataA(MemAddr) = -1 THEN
                            OBuf1(8 downto 0) := (others => 'X');
                        ELSE
                            OBuf1(8 downto 0) := to_slv(MemDataA(MemAddr),9);
                        END IF;
                        IF MemDataB(MemAddr) = -2 THEN
                            OBuf1(17 downto 9) := (others => 'U');
                        ELSIF MemDataB(MemAddr) = -1 THEN
                            OBuf1(17 downto 9) := (others => 'X');
                        ELSE
                            OBuf1(17 downto 9) := to_slv(MemDataB(MemAddr),9);
                        END IF;
                        IF MemDataC(MemAddr) = -2 THEN
                            OBuf1(26 downto 18) := (others => 'U');
                        ELSIF MemDataC(MemAddr) = -1 THEN
                            OBuf1(26 downto 18) := (others => 'X');
                        ELSE
                            OBuf1(26 downto 18) := to_slv(MemDataC(MemAddr),9);
                        END IF;
                        IF MemDataD(MemAddr) = -2 THEN
                            OBuf1(35 downto 27) := (others => 'U');
                        ELSIF MemDataD(MemAddr) = -1 THEN
                            OBuf1(35 downto 27) := (others => 'X');
                        ELSE
                            OBuf1(35 downto 27) := to_slv(MemDataD(MemAddr),9);
                        END IF;
                    WHEN write =>
                        state <= begin_wr;
                        MemAddr := to_nat(AddressIn);
                        startaddr := MemAddr;
                        OBuf1 := (others => 'Z');
                        BWA1 := BWANIn;
                        BWB1 := BWBNIn;
                        BWC1 := BWCNIn;
                        BWD1 := BWDNIn;
                        wr1  := true;
                    WHEN burst =>
                        state <= burst_wr;
                        Burst_Cnt := Burst_Cnt + 1;
                        IF (Burst_Cnt = 4) THEN
                            Burst_Cnt := 0;
                        END IF;
                        offset := Burst_Seq(memstart)(Burst_Cnt);
                        MemAddr := startaddr + offset;
                        BWA1 := BWANIn;
                        BWB1 := BWBNIn;
                        BWC1 := BWCNIn;
                        BWD1 := BWDNIn;
                        wr1  := true;
                 END CASE;

            WHEN burst_rd =>
                CASE command IS
                    WHEN ds =>
                        state <= desel;
                        OBuf1 := (others => 'Z');
                    WHEN read =>
                        state <= begin_rd;
                        MemAddr := to_nat(AddressIn);
                        startaddr := MemAddr;
                        memstart := to_nat(AddressIn(1 downto 0));
                        IF MemDataA(MemAddr) = -2 THEN
                            OBuf1(8 downto 0) := (others => 'U');
                        ELSIF MemDataA(MemAddr) = -1 THEN
                            OBuf1(8 downto 0) := (others => 'X');
                        ELSE
                            OBuf1(8 downto 0) := to_slv(MemDataA(MemAddr),9);
                        END IF;
                        IF MemDataB(MemAddr) = -2 THEN
                            OBuf1(17 downto 9) := (others => 'U');
                        ELSIF MemDataB(MemAddr) = -1 THEN
                            OBuf1(17 downto 9) := (others => 'X');
                        ELSE
                            OBuf1(17 downto 9) := to_slv(MemDataB(MemAddr),9);
                        END IF;
                        IF MemDataC(MemAddr) = -2 THEN
                            OBuf1(26 downto 18) := (others => 'U');
                        ELSIF MemDataC(MemAddr) = -1 THEN
                            OBuf1(26 downto 18) := (others => 'X');
                        ELSE
                            OBuf1(26 downto 18) := to_slv(MemDataC(MemAddr),9);
                        END IF;
                        IF MemDataD(MemAddr) = -2 THEN
                            OBuf1(35 downto 27) := (others => 'U');
                        ELSIF MemDataD(MemAddr) = -1 THEN
                            OBuf1(35 downto 27) := (others => 'X');
                        ELSE
                            OBuf1(35 downto 27) := to_slv(MemDataD(MemAddr),9);
                        END IF;
                    WHEN write =>
                        state <= begin_wr;
                        MemAddr := to_nat(AddressIn);
                        startaddr := MemAddr;
                        memstart := to_nat(AddressIn(1 downto 0));
                        OBuf1 := (others => 'Z');
                        BWA1 := BWANIn;
                        BWB1 := BWBNIn;
                        BWC1 := BWCNIn;
                        BWD1 := BWDNIn;
                        wr1  := true;
                    WHEN burst =>
                        Burst_Cnt := Burst_Cnt + 1;
                        IF (Burst_Cnt = 4) THEN
                            Burst_Cnt := 0;
                        END IF;
                        offset := Burst_Seq(memstart)(Burst_Cnt);
                        MemAddr := startaddr + offset;
                        IF MemDataA(MemAddr) = -2 THEN
                            OBuf1(8 downto 0) := (others => 'U');
                        ELSIF MemDataA(MemAddr) = -1 THEN
                            OBuf1(8 downto 0) := (others => 'X');
                        ELSE
                            OBuf1(8 downto 0) := to_slv(MemDataA(MemAddr),9);
                        END IF;
                        IF MemDataB(MemAddr) = -2 THEN
                            OBuf1(17 downto 9) := (others => 'U');
                        ELSIF MemDataB(MemAddr) = -1 THEN
                            OBuf1(17 downto 9) := (others => 'X');
                        ELSE
                            OBuf1(17 downto 9) := to_slv(MemDataB(MemAddr),9);
                        END IF;
                        IF MemDataC(MemAddr) = -2 THEN
                            OBuf1(26 downto 18) := (others => 'U');
                        ELSIF MemDataC(MemAddr) = -1 THEN
                            OBuf1(26 downto 18) := (others => 'X');
                        ELSE
                            OBuf1(26 downto 18) := to_slv(MemDataC(MemAddr),9);
                        END IF;
                        IF MemDataD(MemAddr) = -2 THEN
                            OBuf1(35 downto 27) := (others => 'U');
                        ELSIF MemDataD(MemAddr) = -1 THEN
                            OBuf1(35 downto 27) := (others => 'X');
                        ELSE
                            OBuf1(35 downto 27) := to_slv(MemDataD(MemAddr),9);
                        END IF;
                 END CASE;

            WHEN burst_wr =>
                CASE command IS
                    WHEN ds =>
                        state <= desel;
                        OBuf1 := (others => 'Z');
                    WHEN read =>
                        state <= begin_rd;
                        MemAddr := to_nat(AddressIn);
                        startaddr := MemAddr;
                        memstart := to_nat(AddressIn(1 downto 0));
                        IF MemDataA(MemAddr) = -2 THEN
                            OBuf1(8 downto 0) := (others => 'U');
                        ELSIF MemDataA(MemAddr) = -1 THEN
                            OBuf1(8 downto 0) := (others => 'X');
                        ELSE
                            OBuf1(8 downto 0) := to_slv(MemDataA(MemAddr),9);
                        END IF;
                        IF MemDataB(MemAddr) = -2 THEN
                            OBuf1(17 downto 9) := (others => 'U');
                        ELSIF MemDataB(MemAddr) = -1 THEN
                            OBuf1(17 downto 9) := (others => 'X');
                        ELSE
                            OBuf1(17 downto 9) := to_slv(MemDataB(MemAddr),9);
                        END IF;
                        IF MemDataC(MemAddr) = -2 THEN
                            OBuf1(26 downto 18) := (others => 'U');
                        ELSIF MemDataC(MemAddr) = -1 THEN
                            OBuf1(26 downto 18) := (others => 'X');
                        ELSE
                            OBuf1(26 downto 18) := to_slv(MemDataC(MemAddr),9);
                        END IF;
                        IF MemDataD(MemAddr) = -2 THEN
                            OBuf1(35 downto 27) := (others => 'U');
                        ELSIF MemDataD(MemAddr) = -1 THEN
                            OBuf1(35 downto 27) := (others => 'X');
                        ELSE
                            OBuf1(35 downto 27) := to_slv(MemDataD(MemAddr),9);
                        END IF;
                    WHEN write =>
                        state <= begin_wr;
                        MemAddr := to_nat(AddressIn);
                        startaddr := MemAddr;
                        memstart := to_nat(AddressIn(1 downto 0));
                        OBuf1 := (others => 'Z');
                        BWA1 := BWANIn;
                        BWB1 := BWBNIn;
                        BWC1 := BWCNIn;
                        BWD1 := BWDNIn;
                        wr1  := true;
                    WHEN burst =>
                        Burst_Cnt := Burst_Cnt + 1;
                        IF (Burst_Cnt = 4) THEN
                            Burst_Cnt := 0;
                        END IF;
                        offset := Burst_Seq(memstart)(Burst_Cnt);
                        MemAddr := startaddr + offset;
                        BWA1 := BWANIn;
                        BWB1 := BWBNIn;
                        BWC1 := BWCNIn;
                        BWD1 := BWDNIn;
                        wr1  := true;
                 END CASE;

        END CASE;

        IF (OENegIn = '0') THEN
            D_zd <= (others => 'Z'), OBuf2 AFTER 1 ns;
        END IF;

    END IF;

    --------------------------------------------------------------------
    -- File Read Section
    --------------------------------------------------------------------
    -- Reads hex data from file. Three characters per 9 bit word.
    -- Memory loads whenever LoadMem toggles.
    IF LoadMem'EVENT and (mem_file_name /= "none") THEN
        ind := 0;
        WHILE (not ENDFILE (mem_file)) LOOP
            READLINE (mem_file, buf);
            IF buf(1) = '#' THEN  -- comment line
                NEXT;
            ELSIF buf(1) = '@' THEN  -- set address
                ind := h(buf(2 to 6));
            ELSE
                MemDataD(ind) := h(buf(1 to 3));
                MemDataC(ind) := h(buf(4 to 6));
                MemDataB(ind) := h(buf(7 to 9));
                MemDataA(ind) := h(buf(10 to 12));
                ind := ind + 1;
            END IF;
        END LOOP;
    END IF;

    --------------------------------------------------------------------
    -- Output Section
    --------------------------------------------------------------------
    IF (OENegIn = '1') THEN
        D_zd <= (others => 'Z');
    ELSE
        D_zd <= OBuf2;
    END IF;

    END PROCESS;

        ------------------------------------------------------------------------
        -- Path Delay Process
        ------------------------------------------------------------------------
        DataOutBlk : FOR i IN 35 DOWNTO 0 GENERATE
            DataOut_Delay : PROCESS (D_zd(i))
                VARIABLE D_GlitchData:VitalGlitchDataArrayType(35 Downto 0);
            BEGIN
                VitalPathDelay01Z (
                    OutSignal       => DataOut(i),
                    OutSignalName   => "Data",
                    OutTemp         => D_zd(i),
                    Mode            => VitalTransport,
                    GlitchData      => D_GlitchData(i),
                    Paths           => (
                        1 => (InputChangeTime => CLKIn'LAST_EVENT,
                              PathDelay => tpd_CLK_DQA0,
                              PathCondition   => OENegIn = '0'),
                        2 => (InputChangeTime => OENegIn'LAST_EVENT,
                              PathDelay => tpd_OENeg_DQA0,
                              PathCondition   => true)
                   )
                );

            END PROCESS;
        END GENERATE;

end BLOCK;

END vhdl_behavioral;
