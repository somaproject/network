
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity miitest is
end miitest;

architecture behavior of miitest is

  component mii
    port(
      CLK     : in    std_logic;
      RESET   : in    std_logic;
      DIN     : in    std_logic_vector(15 downto 0);
      ADDR    : in    std_logic_vector(4 downto 0);
      START   : in    std_logic;
      RW      : in    std_logic;
      MDIO    : inout std_logic;
      MDC     : out   std_logic;
      DOUT    : out   std_logic_vector(15 downto 0);
      DONE    : out   std_logic
      );
  end component;

  component GMII is
                   port ( MDIO : inout std_logic;
                          MDC  : in    std_logic;
                          DONE : out   std_logic);
  end component;

  signal CLK     : std_logic := '0';
  signal RESET   : std_logic := '1';
  signal MDIO    : std_logic;
  signal MDC     : std_logic;
  signal DIN     : std_logic_vector(15 downto 0);
  signal DOUT    : std_logic_vector(15 downto 0);
  signal ADDR    : std_logic_vector(4 downto 0);
  signal START   : std_logic;
  signal RW      : std_logic;
  signal DONE    : std_logic;

begin

  uut : mii port map(
    CLK     => CLK,
    RESET   => RESET,
    MDIO    => MDIO,
    MDC     => MDC,
    DIN     => DIN,
    DOUT    => DOUT,
    ADDR    => ADDR,
    START   => START,
    RW      => RW,
    DONE    => DONE
    );

  gmii_uut : gmii port map (
    MDIO => MDIO,
    MDC  => MDC,
    DONE => open);

  clk   <= not clk after 4 ns;
  RESET <= '0'     after 20 ns;


  main : process is
  begin
    DIN   <= X"0000";
    ADDR  <= "00000";
    START <= '0';
    RW    <= '0';

    wait for 10 us;
    DIN   <= X"ABCD";
    ADDR  <= "00000";
    RW    <= '1';
    wait until rising_edge(CLK);
    START <= '1';
    wait until rising_edge(CLK) ; 
    START <= '0';
    wait until rising_edge(CLK)
      and DONE = '1';

    wait for 10 us;
    DIN   <= X"1234";
    ADDR  <= "00100";
    RW    <= '1';
    wait until rising_edge(CLK); 
    START <= '1';
    wait until rising_edge(CLK);
    START <= '0';
    wait until rising_edge(CLK)
      and DONE = '1';

    wait for 10 us;
    DIN   <= X"1234";
    ADDR  <= "00000";
    RW    <= '0';
    wait until rising_edge(CLK); 
    START <= '1';
    wait until rising_edge(CLK); 
    START <= '0';
    wait until rising_edge(CLK)
      and DONE = '1';
    assert DOUT = X"ABCD"
      report "Error reading data at address 0"
      severity error;

    wait for 10 us;
    DIN   <= X"7777";
    ADDR  <= "00100";
    RW    <= '0';
    wait until rising_edge(CLK) ; 
    START <= '1';
    wait until rising_edge(CLK) ; 
    START <= '0';
    wait until rising_edge(CLK)
      and DONE = '1';
    assert DOUT = X"1234"
      report "Error reading data at address 100"
      severity error;

    assert false
      report "End of Simulation"
      severity failure;


  end process main;

end;
