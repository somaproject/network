library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

library UNISIM;
use UNISIM.VComponents.all;


entity rxpktfifo is
  port (
    CLK       : in  std_logic;
    -- Input interface
    DIN       : in  std_logic_vector(7 downto 0);
    OFIN      : in  std_logic;
    ERIN      : in  std_logic;
    ENDFIN    : in  std_logic;
    VALIDIN   : in  std_logic;
    -- output interface
    NEXTF     : in  std_logic;
    DOUT      : out std_logic_vector(7 downto 0);
    GMIIOFOUT : out std_logic;
    EROUT     : out std_logic;
    ENDFOUT   : out std_logic;
    OFOUT     : out std_logic;
    VALID     : out std_logic);
end rxpktfifo;

architecture Behavioral of rxpktfifo is

  -- input signals
  signal dinl   : std_logic_vector(7 downto 0) := (others => '0');
  signal ofl    : std_logic                    := '0';
  signal erl    : std_logic                    := '0';
  signal endfl  : std_logic                    := '0';
  signal validl : std_logic                    := '0';

  signal endfll : std_logic := '0';
  signal we, wel : std_logic := '0';

  signal di : std_logic_vector(15 downto 0) := (others => '0');

  signal ff, ffl, ffll        : std_logic                    := '0';
  signal ai, ail, ai2, ai3 : std_logic_vector(9 downto 0) := (others => '0');

  -- output side
  signal do : std_logic_vector(15 downto 0) := (others => '0');

  signal ao : std_logic_vector(9 downto 0) := (others => '0');

  signal neq : std_logic := '0';
  signal nextfl, nford : std_logic := '0';
  signal lvalid : std_logic := '0';
  
begin  -- Behavioral

  endfll <= endfl or ffl;
  we     <= (validl and (not ffll)) or (ffl and not ffll);
  neq    <= '0' when ai3 = ao else '1';


  ff <= '0' when ai3(9 downto 8) = "00" and ao(9 downto 8) = "00" else
        '0' when ai3(9 downto 8) = "01" and ao(9 downto 8) = "00" else
        '0' when ai3(9 downto 8) = "10" and ao(9 downto 8) = "00" else
        '1' when ai3(9 downto 8) = "11" and ao(9 downto 8) = "00" else
        '0' when ai3(9 downto 8) = "01" and ao(9 downto 8) = "01" else
        '0' when ai3(9 downto 8) = "10" and ao(9 downto 8) = "01" else
        '0' when ai3(9 downto 8) = "11" and ao(9 downto 8) = "01" else
        '1' when ai3(9 downto 8) = "00" and ao(9 downto 8) = "01" else
        '0' when ai3(9 downto 8) = "10" and ao(9 downto 8) = "10" else
        '0' when ai3(9 downto 8) = "11" and ao(9 downto 8) = "10" else
        '0' when ai3(9 downto 8) = "00" and ao(9 downto 8) = "10" else
        '1' when ai3(9 downto 8) = "01" and ao(9 downto 8) = "10" else
        '0' when ai3(9 downto 8) = "11" and ao(9 downto 8) = "11" else
        '0' when ai3(9 downto 8) = "00" and ao(9 downto 8) = "11" else
        '0' when ai3(9 downto 8) = "01" and ao(9 downto 8) = "11" else
        '1' when ai3(9 downto 8) = "10" and ao(9 downto 8) = "11" else
        '0';

  fifo : RAMB16_S18_S18
    generic map
    ( WRITE_MODE_A        => "READ_FIRST",
      WRITE_MODE_B        => "READ_FIRST",
      SIM_COLLISION_CHECK => "GENERATE_X_ONLY"
      )
    port map (
      DIA                 => di,
      DIB                 => X"0000",
      DIPA                => "00",
      DIPB                => "00",
      ENA                 => '1',
      ENB                 => '1',
      WEA                 => wel,
      WEB                 => '0',
      SSRA                => '0',
      SSRB                => '0',
      CLKA                => CLK,
      CLKB                => CLK,
      ADDRA               => ail,
      ADDRB               => ao,
      DOA                 => open,
      DOB                 => do,
      DOPA                => open,
      DOPB                => open);


  nford <= nextfl and not (lvalid and do(15));
  
  main : process(CLK)
  begin
    if rising_edge(CLK) then

      -- input
      dinl   <= DIN;
      ofl    <= OFIN;
      erl    <= ERIN;
      endfl  <= ENDFIN;
      validl <= VALIDIN;

      ffll <= ffl;
      
      if endfl = '1' and validl = '1' then
        ffl   <= '0';
      else
        if ff = '1' then
          ffl <= '1';
        end if;
      end if;

      wel <= we;
      di  <= endfll & erl & ofl & "00" & ffl & "00" & dinl;

      if we = '1' then
        ai <= ai + 1;
      end if;

      ail <= ai;
      ai2 <= ail;
      ai3 <= ai2;

      -- output
      DOUT      <= do(7 downto 0);
      GMIIOFOUT <= do(13);
      EROUT     <= do(14);
      ENDFOUT   <= do(15);
      OFOUT     <= do(10);
      VALID     <= lvalid;

      if lvalid = '1' and do(15) = '1' then
        nextfl   <= '0';
      else
        if NEXTF = '1' then
          nextfl <= '1';
        end if;
      end if;

      if neq = '1' and nford = '1' then
        lvalid <= '1';
        ao     <= ao + 1;
      else
        lvalid <= '0';
      end if;


    end if;
  end process main;


end Behavioral;
