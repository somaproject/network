
-- VHDL Test Bench Created from source file rxinput.vhd  -- 22:15:00 10/27/2004
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.TextIO.all;

entity RXinputtest is
end RXinputtest;

architecture behavior of RXinputtest is

  component rxinput
    port(
      RX_CLK     : in  std_logic;
      CLK        : in  std_logic;
      RESET      : in  std_logic;
      RX_DV      : in  std_logic;
      RX_ER      : in  std_logic;
      RXD        : in  std_logic_vector(7 downto 0);
      FIFOFULL   : in  std_logic;
      MACADDR    : in  std_logic_vector(47 downto 0);
      RXBCAST    : in  std_logic;
      RXMCAST    : in  std_logic;
      RXUCAST    : in  std_logic;
      RXALLF     : in  std_logic;
      MD         : out std_logic_vector(31 downto 0);
      MA         : out std_logic_vector(15 downto 0);
      BPOUT      : out std_logic_vector(15 downto 0);
      RXCRCERR   : out std_logic;
      RXOFERR    : out std_logic;
      RXPHYERR   : out std_logic;
      RXFIFOWERR : out std_logic;
      RXF        : out std_logic
      );
  end component;

  signal RX_CLK            : std_logic := '0';
  signal CLK               : std_logic := '0';
  signal RESET             : std_logic := '1';
  signal RX_DV             : std_logic := '0';
  signal RX_ER             : std_logic := '0';
  signal RXD               : std_logic_vector(7 downto 0)
                                       := (others => '0');
  signal MD, MD1, MD2, MD3 :
    std_logic_vector(31 downto 0);
  signal MA, MA1, MA2, MA3 : std_logic_vector(15 downto 0);
  signal BPOUT             : std_logic_vector(15 downto 0);
  signal RXCRCERR          : std_logic := '0';
  signal RXOFERR           : std_logic := '0';
  signal RXPHYERR          : std_logic := '0';
  signal RXFIFOWERR        : std_logic := '0';
  signal FIFOFULL          : std_logic := '0';
  signal RXF               : std_logic := '0';
  signal MACADDR           : std_logic_vector(47 downto 0)
                                       := (others => '0');
  signal RXBCAST           : std_logic := '0';
  signal RXMCAST           : std_logic := '0';
  signal RXUCAST           : std_logic := '0';
  signal RXALLF            : std_logic := '0';

begin

  uut : rxinput port map(
    RX_CLK     => RX_CLK,
    CLK        => CLK,
    RESET      => RESET,
    RX_DV      => RX_DV,
    RX_ER      => RX_ER,
    RXD        => RXD,
    MD         => MD,
    MA         => MA,
    BPOUT      => BPOUT,
    RXCRCERR   => RXCRCERR,
    RXOFERR    => RXOFERR,
    RXPHYERR   => RXPHYERR,
    RXFIFOWERR => RXFIFOWERR,
    FIFOFULL   => FIFOFULL,
    RXF        => RXF,
    MACADDR    => MACADDR,
    RXBCAST    => RXBCAST,
    RXMCAST    => RXMCAST,
    RXUCAST    => RXUCAST,
    RXALLF     => RXALLF
    );

  RX_CLK <= not RX_CLK after 3.98 ns;
  CLK    <= not CLK    after 4 ns;


  process (CLK) is
  begin
    if rising_edge(CLK) then
      ma3 <= ma2;
      ma2 <= ma1;
      ma1 <= ma;

      md3 <= md2;
      md2 <= md1;
      md1 <= md;

    end if;
  end process;
  -- memory data checking:

  memdata            : process
    file memfile     : text;
    variable L       : line;
    variable bpl     : std_logic_vector(15 downto 0)
                                    := (others => '0');
    type ramtype is array(2**16-1 downto 0) of integer;
    variable ram     : ramtype      := (others => 0);
    variable memdata : std_logic_vector(31 downto 0)
                                    := (others => '0');
  begin
    RESET  <= '0' after 40 ns;
    RXALLF <= '1';
    file_open(memfile, "ram.0.dat", read_mode);
    while not endfile(memfile) loop
      wait until rising_edge(CLK);
      while MD /= md1 or md1 /= md2 or md2 /= md3
        or MA /= ma1 or ma1 /= ma2 or ma2 /= ma3 loop
        wait until rising_edge(CLK);
      end loop;
      -- write the data
      ram(to_integer(unsigned(MA))) := to_integer(signed(MD));
      if bpl /= BPOUT then              -- there's been a write; let's check!
        readline(memfile, L);
        while bpl /= BPOUT loop
          hread(L, memdata);
          assert memdata = std_logic_vector(to_signed(ram(to_integer(unsigned(bpl))), 32))
            report "Error in ram data"
            severity error;

                                        -- yea, this is ugly, but it works
          bpl := std_logic_vector(to_unsigned(
            ((to_integer(unsigned(bpl)) + 1) mod 65536), 16));

        end loop;
      end if;
    end loop;
    file_close(memfile);

    RESET   <= '1';
    wait for 40 ns;
    RXALLF  <= '0';
    RXUCAST <= '1';
    RXBCAST <= '1';
    RXMCAST <= '1';
    MACADDR <= X"C0FFEEC0FFEE";
    RESET   <= '0';
    file_open(memfile, "ram.1.dat", read_mode);
    while not endfile(memfile) loop
      wait until rising_edge(CLK);
      while MD /= md1 or md1 /= md2 or md2 /= md3
        or MA /= ma1 or ma1 /= ma2 or ma2 /= ma3 loop
        wait until rising_edge(CLK);
      end loop;
      -- write the data
      ram(to_integer(unsigned(MA))) := to_integer(signed(MD));
      if bpl /= BPOUT then              -- there's been a write; let's check!
        readline(memfile, L);
        while bpl /= BPOUT loop
          hread(L, memdata);
          assert memdata = std_logic_vector(to_signed(ram(to_integer(unsigned(bpl))), 32))
            report "Error in ram data"
            severity error; 

					-- yea, this is ugly, but it works
          bpl := std_logic_vector(to_unsigned(
            ((to_integer(unsigned(bpl)) + 1) mod 65536), 16)); 

        end loop; 
      end if; 
    end loop;
    file_close(memfile); 
    
    assert false
      report "End of simulation"
      severity failure;   
  end process memdata; 

  
END;
