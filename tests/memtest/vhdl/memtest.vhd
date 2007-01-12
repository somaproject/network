library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following lines to use the declarations that are
-- provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;


entity memtest is
  port (
    CLKIN    : in    std_logic;
    RESET    : in    std_logic;
    MD       : inout std_logic_vector(31 downto 0);
    MWE      : out   std_logic;
    MA       : out   std_logic_vector(16 downto 0);
    MCLK     : out   std_logic;
    MOE      : out   std_logic;
    PHYRESET : out   std_logic;
    LEDPOWER : out   std_logic;
    LED100   : out   std_logic;
    LED1000  : out   std_logic;
    LEDACT   : out   std_logic
    );
end memtest;

architecture Behavioral of memtest is

  -- clock and timing signals
  signal clk, clkio, clklo, clkrx             : std_logic := '0';
  signal clkint, clkioint, clkloint, clkrxint : std_logic := '0';
  signal clkb, clkbint                        : std_logic := '0';
  signal clkf, clkfint                        : std_logic := '0';

  signal clk90, clk90int   : std_logic := '0';
  signal clk180, clk180int : std_logic := '0';
  signal clk270, clk270int : std_logic := '0';



  signal addr1  : std_logic_vector(16 downto 0) := '0' & X"0000";
  signal d1     : std_logic_vector(31 downto 0) := (others => '0');
  signal q1     : std_logic_vector(31 downto 0) := (others => '0');
  signal we1    : std_logic;
  signal clken1 : std_logic                     := '0';

  signal addr2                          : std_logic_vector(16 downto 0) := '0' & X"FFF0";
  signal expected, expected2, expected3 : std_logic_vector(31 downto 0) := (others => '0');
  signal d2                             : std_logic_vector(31 downto 0) := (others => '0');
  signal q2                             : std_logic_vector(31 downto 0) := (others => '0');
  signal we2                            : std_logic;
  signal clken2                         : std_logic                     := '0';

  signal addr3  : std_logic_vector(16 downto 0) := '1' & X"0000";
  signal d3     : std_logic_vector(31 downto 0) := (others => '0');
  signal q3     : std_logic_vector(31 downto 0) := (others => '0');
  signal we3    : std_logic;
  signal clken3 : std_logic                     := '0';

  signal addr4  : std_logic_vector(16 downto 0) := '1' & X"0000";
  signal d4     : std_logic_vector(31 downto 0) := (others => '0');
  signal q4     : std_logic_vector(31 downto 0) := (others => '0');
  signal we4    : std_logic;
  signal clken4 : std_logic                     := '0';

  signal valid : std_logic := '0';

  signal addr2readen : std_logic := '0';
  signal addr2error  : std_logic := '0';
  signal locked : std_logic_vector(5 downto 0) := (others =>  '0');
  signal dcmreset : std_logic := '1';
  
  component memory
    port ( CLK     : in  std_logic;
           RESET   : in  std_logic; DQEXT : inout std_logic_vector(31 downto 0);
           WEEXT   : out std_logic;
           ADDREXT : out std_logic_vector(16 downto 0);
           ADDR1   : in  std_logic_vector(16 downto 0);
           ADDR2   : in  std_logic_vector(16 downto 0);
           ADDR3   : in  std_logic_vector(16 downto 0);
           ADDR4   : in  std_logic_vector(16 downto 0);
           D1      : in  std_logic_vector(31 downto 0);
           D2      : in  std_logic_vector(31 downto 0);
           D3      : in  std_logic_vector(31 downto 0);
           D4      : in  std_logic_vector(31 downto 0);
           Q1      : out std_logic_vector(31 downto 0);
           Q2      : out std_logic_vector(31 downto 0);
           Q3      : out std_logic_vector(31 downto 0);
           Q4      : out std_logic_vector(31 downto 0);
           WE1     : in  std_logic;
           WE2     : in  std_logic;
           WE3     : in  std_logic;
           WE4     : in  std_logic;
           CLKEN1  : out std_logic;
           CLKEN2  : out std_logic;
           CLKEN3  : out std_logic;
           CLKEN4  : out std_logic);
  end component;


begin  -- Behavioral

  clk_dcm : DCM
    generic map (
      CLKDV_DIVIDE   => 2.0,
      CLKFX_MULTIPLY => 5,
      CLKFX_DIVIDE   => 2)
    port map (
      CLK0           => clkbint,        -- 50 MHz dummy feedback loop
      CLKFB          => clkb,           -- 
      CLKIN          => CLKIN,
      CLKFX          => clkfint,        -- 125 Mhz generated clock
      RST            => RESET,
      LOCKED => locked(0)
      );

  dcmreset <= not locked(4);
  
  clkhi_dcm : DCM
    port map (
      CLK0   => clkint,                 -- 0 degree DCM CLK ouptput
      CLKFB  => clk,                    -- DCM clock feedback
      CLK180 => clk180int,
      CLK90  => clk90int,
      CLK270 => clk270int,
      CLKIN  => clkf,
      RST    => dcmreset
      );

  clkf_bufg : BUFG port map (
    I => clkfint,
    O => clkf);

  clkb_bufg : BUFG port map (
    I => clkbint,
    O => clkb);

  clk_bufg : BUFG port map (
    I => clkint,
    O => clk);

  clk90_bufg : BUFG port map (
    I => clk90int,
    O => clk90 );

  clk180_bufg : BUFG port map (
    I => clk180int,
    O => clk180 );

  clk270_bufg : BUFG port map (
    I => clk270int,
    O => clk270 );


  memory_inst : memory
    port map (
      CLK     => clk,
      RESET   => RESET,
      DQEXT   => MD,
      WEEXT   => MWE,
      ADDREXT => MA,
      ADDR1   => addr1,
      ADDR2   => addr2,
      ADDR3   => addr3,
      ADDR4   => addr4,
      D1      => d1,
      D2      => d2,
      D3      => D3,
      D4      => d4,
      Q1      => q1,
      Q2      => q2,
      Q3      => q3,
      Q4      => q4,
      WE1     => we1,
      WE2     => we2,
      WE3     => we3,
      WE4     => we4,
      CLKEN1  => clken1,
      CLKEN2  => clken2,
      CLKEN3  => clken3,
      CLKEN4  => clken4);


  MCLK <= clk270;


  PHYRESET <= '0';

  WE1 <= '1';
  WE2 <= '0';
  WE3 <= '0';
  WE4 <= '0';

  dcmshift:  process (clkf)
    begin
      if rising_edge(clkf) then
        locked(5 downto 1) <= locked(4 downto 0); 
      end if;
    end process dcmshift;
    
  main : process(clk)
  begin
    if rising_edge(clk) then

      if clken1 = '1' then
        addr1(15 downto 0) <= addr1(15 downto 0) + 1;
        d1                 <= addr1(15 downto 0) & addr1(15 downto 0);
      end if;

      if clken2 = '1' then
        addr2(15 downto 0) <= addr2(15 downto 0) + 1;
        if addr2(15 downto 0) = X"FFFF" then
          addr2readen      <= '1';
        end if;


      end if;

      if addr2readen = '1' then
        if clken2 = '1' then
          if d2 /= (addr2(15 downto 0) - 1) & (addr2(15 downto 0) - 1) then
            addr2error <= '1';
          else
            addr2error <= '0';
          end if;
        else
          addr2error   <= '0';
        end if;
      end if;
    end if;
  end process main;


  LEDPOWER <= valid;
  LED100   <= '0';
  LED1000  <= '0';
  LEDACT   <= valid;

  MOE <= '0';

end Behavioral;

