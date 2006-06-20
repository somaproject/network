library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity serialiotest is

end serialiotest;

architecture Behavioral of serialiotest is

  component serialio
    port ( CLK    : in  std_logic;
           RESET  : in  std_logic;
           SCLK   : in  std_logic;
           SCS    : in  std_logic;
           SIN    : in  std_logic;
           SOUT   : out std_logic;
           NEWCMD : out std_logic;
           ADDR   : out std_logic_vector(5 downto 0);
           RW     : out std_logic;
           DOUT   : out std_logic_vector(31 downto 0);
           DIN    : in  std_logic_vector(31 downto 0)
           );
  end component;

  signal CLK    : std_logic := '0';
  signal RESET  : std_logic := '0';
  signal SCLK   : std_logic := '0';
  signal SCS    : std_logic := '1';
  signal SIN    : std_logic := '0';
  signal SOUT   : std_logic := '0';
  signal NEWCMD : std_logic := '0';

  signal ADDR : std_logic_vector(5 downto 0)  := (others => '0');
  signal RW   : std_logic                     := '0';
  signal DOUT : std_logic_vector(31 downto 0) := (others => '0');
  signal DIN  : std_logic_vector(31 downto 0) := (others => '0');


  signal inclk   : std_logic                     := '0';
  signal outvect : std_logic_vector(39 downto 0) := (others => '0');
  signal invect : std_logic_vector(39 downto 0) := (others => '0');
  

begin  -- Behavioral

  CLK   <= not CLK   after 10 ns;
  INCLK <= not INCLK after 0.495125151 us;


  serialio_uut : serialio
    port map (
      CLK    => CLK,
      RESET  => RESET,
      SCLK   => SCLK,
      SIN    => SIN,
      SCS    => SCS,
      SOUT   => SOUT,
      NEWCMD => NEWCMD,
      ADDR   => ADDR,
      RW     => RW,
      DOUT   => DOUT,
      DIN    => DIN);


  main : process
  begin  -- process main
    wait until rising_edge(INCLK);
    outvect <= X"9301234567";
    DIN <= X"ABCDEF12"; 
    wait until rising_edge(INCLK);
    wait until falling_edge(INCLK);
    SCS     <= '0';

    for i in 39 downto 0 loop
      SIN  <= outvect(i);
      wait until rising_edge(INCLK);
      SCLK <= '1';
      invect(i) <= SOUT; 
      wait until falling_edge(INCLK);
      SCLK <= '0';

    end loop;  -- i
    wait until falling_edge(INCLK);
    SCS <= '1';

    wait for 20 us;

    
    wait until rising_edge(INCLK);
    outvect <= X"1201234567";
    DIN <= X"ABCDEF12"; 
    wait until rising_edge(INCLK);
    wait until falling_edge(INCLK);
    SCS     <= '0';

    for i in 39 downto 0 loop
      SIN  <= outvect(i);
      wait until rising_edge(INCLK);
      SCLK <= '1';
      invect(i) <= SOUT; 
      wait until falling_edge(INCLK);
      SCLK <= '0';

    end loop;  -- i
    wait until falling_edge(INCLK);
    SCS <= '1';
    
    wait;

    
  end process main;

  verify: process
    begin
      wait until rising_edge(CLK) and NEWCMD = '1';
      assert RW = '1' report "Incorrect RW value" severity Error;
      assert ADDR = "10011" report "Incorrect ADDR value" severity Error;
      assert DOUT = X"01234567" report "Incorrect data value" severity Error;

      
      wait for 20 us;
      wait until rising_edge(CLK) and NEWCMD = '1';
      assert RW = '0' report "Incorrect RW value" severity Error;
      assert ADDR = "10010" report "Incorrect ADDR value" severity Error;
      assert invect(31 downto 0) = X"abcdef12" report "Error reading serial data" severity Error;
      assert False report "End of Simulation" severity failure;

      
      
      

    end process verify; 
end Behavioral;
