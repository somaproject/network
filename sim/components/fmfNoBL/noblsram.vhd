
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.TextIO.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;

library FMF;
use FMF.gen_utils.all;
use FMF.conversions.all;

entity noblsram is
  port ( CLK   : in    std_logic;
         DQ    : inout std_logic_vector(31 downto 0);
         ADDR  : in    std_logic_vector(16 downto 0);
         WE    : in    std_logic;
         RESET : in    std_logic;
         SAVE  : in    std_logic);
end noblsram;

architecture Behavioral of noblsram is

  component idt71v3556
    generic (
      -- tipd delays: interconnect path delays
      tipd_A0             :       VitalDelayType01  := VitalZeroDelay01;
      tipd_A1             :       VitalDelayType01  := VitalZeroDelay01;
      tipd_A2             :       VitalDelayType01  := VitalZeroDelay01;
      tipd_A3             :       VitalDelayType01  := VitalZeroDelay01;
      tipd_A4             :       VitalDelayType01  := VitalZeroDelay01;
      tipd_A5             :       VitalDelayType01  := VitalZeroDelay01;
      tipd_A6             :       VitalDelayType01  := VitalZeroDelay01;
      tipd_A7             :       VitalDelayType01  := VitalZeroDelay01;
      tipd_A8             :       VitalDelayType01  := VitalZeroDelay01;
      tipd_A9             :       VitalDelayType01  := VitalZeroDelay01;
      tipd_A10            :       VitalDelayType01  := VitalZeroDelay01;
      tipd_A11            :       VitalDelayType01  := VitalZeroDelay01;
      tipd_A12            :       VitalDelayType01  := VitalZeroDelay01;
      tipd_A13            :       VitalDelayType01  := VitalZeroDelay01;
      tipd_A14            :       VitalDelayType01  := VitalZeroDelay01;
      tipd_A15            :       VitalDelayType01  := VitalZeroDelay01;
      tipd_A16            :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQA0           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQA1           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQA2           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQA3           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQA4           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQA5           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQA6           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQA7           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQA8           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQB0           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQB1           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQB2           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQB3           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQB4           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQB5           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQB6           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQB7           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQB8           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQC0           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQC1           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQC2           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQC3           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQC4           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQC5           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQC6           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQC7           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQC8           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQD0           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQD1           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQD2           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQD3           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQD4           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQD5           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQD6           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQD7           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_DQD8           :       VitalDelayType01  := VitalZeroDelay01;
      tipd_ADV            :       VitalDelayType01  := VitalZeroDelay01;
      tipd_R              :       VitalDelayType01  := VitalZeroDelay01;
      tipd_CLKENNeg       :       VitalDelayType01  := VitalZeroDelay01;
      tipd_BWDNeg         :       VitalDelayType01  := VitalZeroDelay01;
      tipd_BWCNeg         :       VitalDelayType01  := VitalZeroDelay01;
      tipd_BWBNeg         :       VitalDelayType01  := VitalZeroDelay01;
      tipd_BWANeg         :       VitalDelayType01  := VitalZeroDelay01;
      tipd_CE1Neg         :       VitalDelayType01  := VitalZeroDelay01;
      tipd_CE2Neg         :       VitalDelayType01  := VitalZeroDelay01;
      tipd_CE2            :       VitalDelayType01  := VitalZeroDelay01;
      tipd_CLK            :       VitalDelayType01  := VitalZeroDelay01;
      tipd_LBONeg         :       VitalDelayType01  := VitalZeroDelay01;
      tipd_OENeg          :       VitalDelayType01  := VitalZeroDelay01;
      -- tpd delays
      tpd_CLK_DQA0        :       VitalDelayType01Z := UnitDelay01Z;
      tpd_OENeg_DQA0      :       VitalDelayType01Z := UnitDelay01Z;
      -- tpw values: pulse widths
      tpw_CLK_posedge     :       VitalDelayType    := UnitDelay;
      tpw_CLK_negedge     :       VitalDelayType    := UnitDelay;
      -- tperiod min (calculated as 1/max freq)
      tperiod_CLK_posedge :       VitalDelayType    := UnitDelay;
      -- tsetup values: setup times
      tsetup_CLKENNeg_CLK :       VitalDelayType    := UnitDelay;
      tsetup_A0_CLK       :       VitalDelayType    := UnitDelay;
      tsetup_DQA0_CLK     :       VitalDelayType    := UnitDelay;
      tsetup_R_CLK        :       VitalDelayType    := UnitDelay;
      tsetup_ADV_CLK      :       VitalDelayType    := UnitDelay;
      tsetup_CE2_CLK      :       VitalDelayType    := UnitDelay;
      tsetup_BWANeg_CLK   :       VitalDelayType    := UnitDelay;
      -- thold values: hold times
      thold_CLKENNeg_CLK  :       VitalDelayType    := UnitDelay;
      thold_A0_CLK        :       VitalDelayType    := UnitDelay;
      thold_DQA0_CLK      :       VitalDelayType    := UnitDelay;
      thold_R_CLK         :       VitalDelayType    := UnitDelay;
      thold_ADV_CLK       :       VitalDelayType    := UnitDelay;
      thold_CE2_CLK       :       VitalDelayType    := UnitDelay;
      thold_BWANeg_CLK    :       VitalDelayType    := UnitDelay;
      -- generic control parameters
      InstancePath        :       string            := DefaultInstancePath;
      TimingChecksOn      :       boolean           := DefaultTimingChecks;
      MsgOn               :       boolean           := DefaultMsgOn;
      XOn                 :       boolean           := DefaultXon;
      SeverityMode        :       severity_level    := warning;
      -- memory file to be loaded
      mem_file_name       :       string            := "idt71v3556.mem";
      -- For FMF SDF technology file usage
      TimingModel         :       string            := DefaultTimingModel
      );
    port (
      A0                  : in    std_logic         := 'U';
      A1                  : in    std_logic         := 'U';
      A2                  : in    std_logic         := 'U';
      A3                  : in    std_logic         := 'U';
      A4                  : in    std_logic         := 'U';
      A5                  : in    std_logic         := 'U';
      A6                  : in    std_logic         := 'U';
      A7                  : in    std_logic         := 'U';
      A8                  : in    std_logic         := 'U';
      A9                  : in    std_logic         := 'U';
      A10                 : in    std_logic         := 'U';
      A11                 : in    std_logic         := 'U';
      A12                 : in    std_logic         := 'U';
      A13                 : in    std_logic         := 'U';
      A14                 : in    std_logic         := 'U';
      A15                 : in    std_logic         := 'U';
      A16                 : in    std_logic         := 'U';
      DQA0                : inout std_logic         := 'U';
      DQA1                : inout std_logic         := 'U';
      DQA2                : inout std_logic         := 'U';
      DQA3                : inout std_logic         := 'U';
      DQA4                : inout std_logic         := 'U';
      DQA5                : inout std_logic         := 'U';
      DQA6                : inout std_logic         := 'U';
      DQA7                : inout std_logic         := 'U';
      DQA8                : inout std_logic         := 'U';
      DQB0                : inout std_logic         := 'U';
      DQB1                : inout std_logic         := 'U';
      DQB2                : inout std_logic         := 'U';
      DQB3                : inout std_logic         := 'U';
      DQB4                : inout std_logic         := 'U';
      DQB5                : inout std_logic         := 'U';
      DQB6                : inout std_logic         := 'U';
      DQB7                : inout std_logic         := 'U';
      DQB8                : inout std_logic         := 'U';
      DQC0                : inout std_logic         := 'U';
      DQC1                : inout std_logic         := 'U';
      DQC2                : inout std_logic         := 'U';
      DQC3                : inout std_logic         := 'U';
      DQC4                : inout std_logic         := 'U';
      DQC5                : inout std_logic         := 'U';
      DQC6                : inout std_logic         := 'U';
      DQC7                : inout std_logic         := 'U';
      DQC8                : inout std_logic         := 'U';
      DQD0                : inout std_logic         := 'U';
      DQD1                : inout std_logic         := 'U';
      DQD2                : inout std_logic         := 'U';
      DQD3                : inout std_logic         := 'U';
      DQD4                : inout std_logic         := 'U';
      DQD5                : inout std_logic         := 'U';
      DQD6                : inout std_logic         := 'U';
      DQD7                : inout std_logic         := 'U';
      DQD8                : inout std_logic         := 'U';
      ADV                 : in    std_logic         := 'U';
      R                   : in    std_logic         := 'U';
      CLKENNeg            : in    std_logic         := 'U';
      BWDNeg              : in    std_logic         := 'U';
      BWCNeg              : in    std_logic         := 'U';
      BWBNeg              : in    std_logic         := 'U';
      BWANeg              : in    std_logic         := 'U';
      CE1Neg              : in    std_logic         := 'U';
      CE2Neg              : in    std_logic         := 'U';
      CE2                 : in    std_logic         := 'U';
      CLK                 : in    std_logic         := 'U';
      LBONeg              : in    std_logic         := '1';
      OENeg               : in    std_logic         := 'U';
      LoadMem             : in    boolean           := false

      );
  end component;

  signal pbits : std_logic_vector(3 downto 0) := (others => 'L');
  signal loadmem : boolean := false;
begin  -- Behavioral


  memory : idt71v3556
    generic map (
      -- tipd delays: interconnect path delays
      tipd_A0       => (3.2 ns, 3.2 ns),
      tipd_A1       => (3.2 ns, 3.2 ns),
      tipd_A2       => (3.2 ns, 3.2 ns),
      tipd_A3       => (3.2 ns, 3.2 ns),
      tipd_A4       => (3.2 ns, 3.2 ns),
      tipd_A5       => (3.2 ns, 3.2 ns),
      tipd_A6       => (3.2 ns, 3.2 ns),
      tipd_A7       => (3.2 ns, 3.2 ns),
      tipd_A8       => (3.2 ns, 3.2 ns),
      tipd_A9       => (3.2 ns, 3.2 ns),
      tipd_A10      => (3.2 ns, 3.2 ns),
      tipd_A11      => (3.2 ns, 3.2 ns),
      tipd_A12      => (3.2 ns, 3.2 ns),
      tipd_A13      => (3.2 ns, 3.2 ns),
      tipd_A14      => (3.2 ns, 3.2 ns),
      tipd_A15      => (3.2 ns, 3.2 ns),
      tipd_A16      => (3.2 ns, 3.2 ns),
      tipd_DQA0     => (3.2 ns, 3.2 ns),
      tipd_DQA1     => (3.2 ns, 3.2 ns),
      tipd_DQA2     => (3.2 ns, 3.2 ns),
      tipd_DQA3     => (3.2 ns, 3.2 ns),
      tipd_DQA4     => (3.2 ns, 3.2 ns),
      tipd_DQA5     => (3.2 ns, 3.2 ns),
      tipd_DQA6     => (3.2 ns, 3.2 ns),
      tipd_DQA7     => (3.2 ns, 3.2 ns),
      tipd_DQA8     => (3.2 ns, 3.2 ns),
      tipd_DQB0     => (3.2 ns, 3.2 ns),
      tipd_DQB1     => (3.2 ns, 3.2 ns),
      tipd_DQB2     => (3.2 ns, 3.2 ns),
      tipd_DQB3     => (3.2 ns, 3.2 ns),
      tipd_DQB4     => (3.2 ns, 3.2 ns),
      tipd_DQB5     => (3.2 ns, 3.2 ns),
      tipd_DQB6     => (3.2 ns, 3.2 ns),
      tipd_DQB7     => (3.2 ns, 3.2 ns),
      tipd_DQB8     => (3.2 ns, 3.2 ns),
      tipd_DQC0     => (3.2 ns, 3.2 ns),
      tipd_DQC1     => (3.2 ns, 3.2 ns),
      tipd_DQC2     => (3.2 ns, 3.2 ns),
      tipd_DQC3     => (3.2 ns, 3.2 ns),
      tipd_DQC4     => (3.2 ns, 3.2 ns),
      tipd_DQC5     => (3.2 ns, 3.2 ns),
      tipd_DQC6     => (3.2 ns, 3.2 ns),
      tipd_DQC7     => (3.2 ns, 3.2 ns),
      tipd_DQC8     => (3.2 ns, 3.2 ns),
      tipd_DQD0     => (3.2 ns, 3.2 ns),
      tipd_DQD1     => (3.2 ns, 3.2 ns),
      tipd_DQD2     => (3.2 ns, 3.2 ns),
      tipd_DQD3     => (3.2 ns, 3.2 ns),
      tipd_DQD4     => (3.2 ns, 3.2 ns),
      tipd_DQD5     => (3.2 ns, 3.2 ns),
      tipd_DQD6     => (3.2 ns, 3.2 ns),
      tipd_DQD7     => (3.2 ns, 3.2 ns),
      tipd_DQD8     => (3.2 ns, 3.2 ns),
      tipd_ADV      => (3.2 ns, 3.2 ns),
      tipd_R        => (3.2 ns, 3.2 ns),
      tipd_CLKENNeg => (3.2 ns, 3.2 ns),
      tipd_BWDNeg   => (3.2 ns, 3.2 ns),
      tipd_BWCNeg   => (3.2 ns, 3.2 ns),
      tipd_BWBNeg   => (3.2 ns, 3.2 ns),
      tipd_BWANeg   => (3.2 ns, 3.2 ns),
      tipd_CE1Neg   => (3.2 ns, 3.2 ns),
      tipd_CE2Neg   => (3.2 ns, 3.2 ns),
      tipd_CE2      => (3.2 ns, 3.2 ns),
      tipd_CLK      => (3.2 ns, 3.2 ns),
      tipd_LBONeg   => (3.2 ns, 3.2 ns),
      tipd_OENeg    => (3.2 ns, 3.2 ns),

      -- tpd delays
      tpd_CLK_DQA0    => (1.5 ns, 2.8 ns, 4 ns, 1.5 ns, 2.8 ns, 4 ns),
      tpd_OENeg_DQA0  => (1.5 ns, 2.8 ns, 4 ns, 1.5 ns, 2.8 ns, 4 ns),
      -- tpw values: pulse widths
      tpw_CLK_posedge => 2.8 ns,
      tpw_CLK_negedge => 2.8 ns,

      -- tperiod min (calculated as 1/max freq)
      tperiod_CLK_posedge => 7 ns,

-- tsetup values: setup times
      tsetup_CLKENNeg_CLK => 2 ns,
      tsetup_A0_CLK       => 2 ns,
      tsetup_DQA0_CLK     => 1.7 ns,
      tsetup_R_CLK        => 2 ns,
      tsetup_ADV_CLK      => 2 ns,
      tsetup_CE2_CLK      => 2 ns,
      tsetup_BWANeg_CLK   => 2 ns,

-- thold values: hold times
      thold_CLKENNeg_CLK => 0.5 ns,
      thold_A0_CLK       => 0.5 ns,
      thold_DQA0_CLK     => 0.5 ns,
      thold_R_CLK        => 0.5 ns,
      thold_ADV_CLK      => 0.5 ns,
      thold_CE2_CLK      => 0.5 ns,
      thold_BWANeg_CLK   => 0.5 ns,

      -- generic control parameters
--      InstancePath   : string         := DefaultInstancePath;
      TimingChecksOn => true,
      MsgOn          => true,
-- XOn => true,
-- SeverityMode : severity_level := warning;

-- memory file to be loaded
      mem_file_name => "test.mem"
      -- For FMF SDF technology file usage
      --TimingModel                      :       string    := DefaultTimingModel
      )
    port map (
      A0            => ADDR(0),
      A1            => ADDR(1),
      A2            => ADDR(2),
      A3            => ADDR(3),
      A4            => ADDR(4),
      A5            => ADDR(5),
      A6            => ADDR(6),
      A7            => ADDR(7),
      A8            => ADDR(8),
      A9            => ADDR(9),
      A10           => ADDR(10),
      A11           => ADDR(11),
      A12           => ADDR(12),
      A13           => ADDR(13),
      A14           => ADDR(14),
      A15           => ADDR(15),
      A16           => ADDR(16),
      DQA0          => DQ(0),
      DQA1          => DQ(1),
      DQA2          => DQ(2),
      DQA3          => DQ(3),
      DQA4          => DQ(4),
      DQA5          => DQ(5),
      DQA6          => DQ(6),
      DQA7          => DQ(7),
      DQA8          => pbits(0),
      DQB0          => DQ(8),
      DQB1          => DQ(9),
      DQB2          => DQ(10),
      DQB3          => DQ(11),
      DQB4          => DQ(12),
      DQB5          => DQ(13),
      DQB6          => DQ(14),
      DQB7          => DQ(15),
      DQB8          => pbits(1),
      DQC0          => DQ(16),
      DQC1          => DQ(17),
      DQC2          => DQ(18),
      DQC3          => DQ(19),
      DQC4          => DQ(20),
      DQC5          => DQ(21),
      DQC6          => DQ(22),
      DQC7          => DQ(23),
      DQC8          => pbits(2),
      DQD0          => DQ(24),
      DQD1          => DQ(25),
      DQD2          => DQ(26),
      DQD3          => DQ(27),
      DQD4          => DQ(28),
      DQD5          => DQ(29),
      DQD6          => DQ(30),
      DQD7          => DQ(31),
      DQD8          => pbits(3),
      ADV           => '0',
      R             => WE,
      CLKENNeg      => '0',
      BWDNeg        => '0',
      BWCNeg        => '0',
      BWBNeg        => '0',
      BWANeg        => '0',
      CE1Neg        => '0',
      CE2Neg        => '0',
      CE2           => '1',
      CLK           => CLK,
      LBONeg        => '0',
      OENeg         => '0',
      LoadMem       => loadmem
      );

LoadMem <= true after 1 ns;
pbits <= (others => 'L');
  
end Behavioral;
