
-- VHDL Test Bench Created from source file txinput.vhd  -- 17:06:41 10/15/2004
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

entity txinputtest is
end txinputtest;

architecture behavior of txinputtest is

  component txinput
    port(
      CLK        : in  std_logic;
      CLKIO      : in  std_logic;
      RESET      : in  std_logic;
      DIN        : in  std_logic_vector(15 downto 0);
      NEWFRAME   : in  std_logic;
      FIFOFULL   : in  std_logic;
      MD         : out std_logic_vector(31 downto 0);
      MWEN       : out std_logic;
      MA         : out std_logic_vector(15 downto 0);
      BPOUT      : out std_logic_vector(15 downto 0);
      TXFIFOWERR : out std_logic;
      DONE       : out std_logic
      );
  end component;

  signal CLK        : std_logic := '0';
  signal CLKIO      : std_logic := '0';
  signal RESET      : std_logic := '1';
  signal DIN        : std_logic_vector(15 downto 0);
  signal NEWFRAME   : std_logic;
  signal MD         : std_logic_vector(31 downto 0);
  signal MWEN       : std_logic;
  signal MA         : std_logic_vector(15 downto 0);
  signal FIFOFULL   : std_logic := '0';
  signal BPOUT      : std_logic_vector(15 downto 0);
  signal TXFIFOWERR : std_logic;
  signal DONE       : std_logic;

  signal TESTDONE  : std_logic := '0';
  signal correctma : std_logic_vector(15 downto 0);
begin

  uut : txinput port map(
    CLK        => CLK,
    CLKIO      => CLKIO,
    RESET      => RESET,
    DIN        => DIN,
    NEWFRAME   => NEWFRAME,
    MD         => MD,
    MWEN       => MWEN,
    MA         => MA,
    FIFOFULL   => FIFOFULL,
    BPOUT      => BPOUT,
    TXFIFOWERR => TXFIFOWERR,
    DONE       => DONE
    );


  -- clocks
  CLK   <= not CLK   after 4 ns;
  CLKIO <= not CLKIO after 10.75418651 ns;  -- roughly 50 Mhz
  RESET <= '0'       after 40 ns;


  -- input data:
  inputdata             : process
    file dinfile        : text;
    variable L          : line;
    variable newframein : integer := 0;
    variable dinin      : std_logic_vector(15 downto 0);

  begin
    TESTDONE     <= '0';
    wait until falling_edge(RESET);
    file_open(dinfile, "din.dat", read_mode);
    while not endfile(dinfile) loop
      wait until rising_edge(CLKIO);
      readline(dinfile, L);
      read(L, newframein);
      hread(L, dinin);
      if newframein = 0 then
        NEWFRAME <= '0';
      elsif newframein = 1 then
        NEWFRAME <= '1';
      end if;
      DIN        <= dinin;
    end loop;
    assert false
      report "End of simulation"
      severity failure;
    TESTDONE     <= '1';

  end process;

  -- memory transition error detector: 
  memtest             : process(CLK)
    variable memaddrl : std_logic_vector(15 downto 0)
                                  := (others => '0');
    variable memdatal : std_logic_vector(31 downto 0)
                                  := (others => '0');
    variable mwel     : std_logic := '0';

    variable matick, mdtick, mwetick : integer := 0;

  begin
    if RESET = '0' and rising_edge(clk) then
      if memaddrl /= MA then
        memaddrl := MA;
        assert matick > 2
          report "Memory state error :MA was not constant for at least 4 ticks"
          severity error;
        matick   := 0;
      else
        matick   := matick + 1;
      end if;
      if memdatal /= MD then
        memdatal := MD;
        assert mdtick > 2
          report "Memory state error :MD was not constant for at least 4 ticks"
          severity error;
        mdtick   := 0;
      else
        mdtick   := mdtick + 1;
      end if;
      if mwel /= MWEN then
        mwel     := MWEN;
        assert mwetick > 2
          report "Memory state error:MWE was not constant for at least 4 ticks"
          severity error;
        mwetick  := 0;
      else
        mwetick  := mwetick + 1;
      end if;
    end if;
  end process memtest;

  -- memory address/data/write detector:

  memdata              : process
    file memfile       : text;
    variable L         : line;
    variable addr, mal : std_logic_vector(15 downto 0)
 := (others => '0');
    variable data, mdl : std_logic_vector(31 downto 0)
 := (others => '0');

  begin
    wait until falling_edge(RESET);
    file_open(memfile, "RAM.writes.dat", read_mode);
    while not endfile(memfile) loop
      wait until rising_edge(CLK);
      wait until rising_edge(CLK);
      wait until rising_edge(CLK);
      wait until rising_edge(CLK);


      if MWEN = '1' then
        if mdl /= MD or mal /= MA then

          readline(memfile, L);
          hread(L, addr);
          hread(L, data);
          correctma <= addr;
          if MA /= addr then
               --assert false
               --      report "memory address write error"
               --      severity failure;   
          end if;

          assert MD = data
            report "Memory data write error"
            severity error;
        end if;
        mdl := MD;
        mal := MA;
      end if;
    end loop;

  end process memdata;


end;