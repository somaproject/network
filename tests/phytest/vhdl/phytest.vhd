library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


library UNISIM;
use UNISIM.VComponents.all;


entity phytest is

  port (
    CLKIN    : in  std_logic;
    RESET    : in  std_logic;
    MCLK     : out std_logic;
    PHYRESET : out std_logic;
    LEDPOWER : out std_logic;
    LED100   : out std_logic;
    LED1000  : out std_logic;
    LEDACT   : out std_logic;
    LEDTX    : out std_logic;
    LEDRX    : out std_logic;
    LEDDPX   : out std_logic;
    GTX_CLK  : out std_logic;
    TX_EN    : out std_logic;
    TX_ER    : out std_logic;
    TXD      : out std_logic_vector(7 downto 0);
    SCLKOUT : out std_logic;
    SINOUT : out std_logic;
    SOUTOUT : out std_logic;
    SCSOUT: out std_logic;
    LOCKED : out std_logic; 
    MDIO : inout std_logic;
    MDC  : out   std_logic
    );

end phytest;

architecture Behavioral of phytest is

  signal clk, clkint : std_logic                     := '0';
  signal clkf, clkfint : std_logic                     := '0';
  signal clklo       : std_logic                     := '0';
  signal clkcnt      : integer range 0 to 7          := 0;
  signal ledcnt      : std_logic_vector(22 downto 0) := (others => '0');

  signal pingaddr        : std_logic_vector(10 downto 0) := (others => '0');
  signal do              : std_logic_vector(7 downto 0)  := (others => '0');
  signal tx_enl, tx_enll : std_logic                     := '0';

  component control
    port ( CLK        : in    std_logic;
           CLKLO      : in    std_logic;
           RESET      : in    std_logic;
           SCLK       : in    std_logic;
           SCS        : in    std_logic;
           SIN        : in    std_logic;
           SOUT       : out   std_logic;
           LEDACT     : out   std_logic;
           LEDTX      : out   std_logic;
           LEDRX      : out   std_logic;
           LED100     : out   std_logic;
           LED1000    : out   std_logic;
           LEDDPX     : out   std_logic;
           PHYRESET   : out   std_logic;
           TXF        : in    std_logic;
           RXF        : in    std_logic;
           TXFIFOWERR : in    std_logic;
           RXFIFOWERR : in    std_logic;
           RXPHYERR   : in    std_logic;
           RXOFERR    : in    std_logic;
           RXCRCERR   : in    std_logic;
           RXBCAST    : out   std_logic;
           RXMCAST    : out   std_logic;
           RXUCAST    : out   std_logic;
           RXALLF     : out   std_logic;
           MACADDR    : out   std_logic_vector(47 downto 0);
           MDIO       : inout std_logic;
           MDC        : out   std_logic;
           MDEBUGADDR : out   std_logic_vector(16 downto 0);
           MDEBUGDATA : in    std_logic_vector(31 downto 0);
           RXBP       : in    std_logic_vector(15 downto 0);
           RXFBBP     : in    std_logic_vector(15 downto 0);
           TXBP       : in    std_logic_vector(15 downto 0);
           TXFBBP     : in    std_logic_vector(15 downto 0));

  end component;

  signal SCLK : std_logic := '0';
  signal SCS  : std_logic := '0';
  signal SIN  : std_logic := '0';
  signal SOUT : std_logic := '0';

  component jtagserial
    port (
      CLK : in std_logic; 
      SCLK : out std_logic;
      SOUT : out std_logic;
      SCS  : out std_logic;
      SIN  : in  std_logic);
  end component;

begin  -- Behavioral

  MCLK    <= '0';
  GTX_CLK <= not clk;
  TX_ER   <= '0';

  jtagserial_inst : jtagserial
    port map (
      CLK => clkf, 
      SCLK => SCLK,
      SOUT => SIN,
      SIN  => SOUT,
      SCS  => SCS);

  SCLKOUT <= SCLK;
  SOUTOUT <= SOUT;
  SINOUT <= SIN;
  SCSOUT <= SCS;
  
  clockenable : process(CLK)
  begin
    if rising_edge(CLK) then
      if clkcnt = 7 then
        clkcnt <= 0;
      else
        clkcnt <= clkcnt +1;
      end if;

      ledcnt   <= ledcnt + 1;
      LEDPOWER <= ledcnt(22);

      TXD      <= do;
      if pingaddr /= "00001001000" then
        tx_enl <= '1';
      else
        tx_enl <= '0';
      end if;

      tx_enll <= tx_enl;
      TX_EN   <= tx_enl;

      if ledcnt(14 downto 0) = "000000000000000" then
        pingaddr   <= (others => '0');
      else
        if pingaddr /= "00001001000" then
          pingaddr <= pingaddr + 1;
        end if;
      end if;
    end if;


  end process clockenable;


  control_inst : control
    port map (
      CLK        => clk,
      CLKLO      => clk,
      RESET      => '0',
      SCLK       => SCLK,
      SCS        => SCS,
      SIN        => SIN,
      SOUT       => SOUT,
      LEDACT     => LEDACT,
      LEDTX      => LEDTX,
      LEDRX      => LEDRX,
      LED100     => LED100,
      LED1000    => LED1000,
      LEDDPX     => LEDDPX,
      PHYRESET   => PHYRESET,
      TXF        => '0',
      RXF        => '0',
      TXFIFOWERR => '0',
      RXFIFOWERR => '0',
      RXPHYERR   => '0',
      RXOFERR    => '0',
      RXCRCERR   => '0',
      RXBCAST    => open,
      RXMCAST    => open,
      RXUCAST    => open,
      RXALLF     => open,
      MACADDR    => open,
      MDIO       => MDIO,
      MDC        => MDC,
      MDEBUGADDR => open,
      MDEBUGDATA => X"00000000",
      RXBP       => X"0000",
      RXFBBP     => X"0000",
      TXBP       => X"0000",
      TXFBBP     => X"0000");

  pingram : RAMB16_S9
    generic map (
      -- Address 0 to 511
      INIT_00 => X"000000000000000000000008000010001000FFFFFFFFFFFFD555555555555555",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"000000000000000000000000000000000000000000000000E185E85100000000",
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
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000")
    port map (
      DO      => DO,                    -- 8-bit Data Output
      DOP     => open,
      ADDR    => pingaddr,
      CLK     => CLK,                   -- Clock
      DI      => X"00",
      DIP     => "0",                   -- 1-bit parity Input
      EN      => '1',                   -- RAM Enable Input
      SSR     => '0',                   -- Synchronous Set/Reset Input
      WE      => '0'                    -- Write Enable Input
      );




  DCM_BASE_inst : DCM
    generic map (
      CLKDV_DIVIDE => 3.5,
      CLKFX_DIVIDE => 2, 
      CLKFX_MULTIPLY => 5, 
      CLKIN_PERIOD => 10.0,        
      CLK_FEEDBACK => "1X",        
      STARTUP_WAIT => true)
    port map (
      CLK0         => clkfint,      
      CLKDV        => CLKLO,       
      CLKFB        => clkf,         
      CLKIN        => CLKIN,
      CLKFX => clkint, 
      RST          => '0',
      LOCKED => LOCKED
      );

  clk_bufg : BUFG
    port map (
      O => clk,                         -- Clock buffer output
      I => clkint                       -- Clock buffer input
      );

  clkf_bufg : BUFG
    port map (
      O => clkf,                         -- Clock buffer output
      I => clkfint                       -- Clock buffer input
      );

  
end Behavioral;

