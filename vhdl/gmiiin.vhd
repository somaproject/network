library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

library UNISIM;
use UNISIM.VComponents.all;

entity gmiiin is
  port ( CLK     : in  std_logic;
         RX_CLK  : in  std_logic;
         RX_ER   : in  std_logic;
         RX_DV   : in  std_logic;
         RXD     : in  std_logic_vector(7 downto 0);
         NEXTF   : in  std_logic;
         ENDFOUT : out std_logic;
         EROUT   : out std_logic;
         OFOUT   : out std_logic;
         VALID   : out std_logic;
         DOUT    : out std_logic_vector(7 downto 0));
end gmiiin;

architecture Behavioral of gmiiin is

  --RX_CLK domain signals 
  signal erl, dvl, dvll, erin, endfin, wein, ff,
    we, wel : std_logic := '0';

  signal rxdl, din : std_logic_vector(7 downto 0)
 := (others => '0');

  signal ain, al : std_logic_vector(9 downto 0)
 := (others => '0');

  signal di : std_logic_vector(15 downto 0)
 := (others => '0');

  -- CLK domain signals:
  signal aeq, endfo, val, lvalid, nfl, ffs, efv :
    std_logic := '0';
  signal ao, aol, al2, al2l : std_logic_vector(9 downto 0)
              := (others => '0');
  signal do                 : std_logic_vector(15 downto 0)
              := (others => '0');

  signal rx_clkint : std_logic := '0';

  component RAMB16_S18_S18
    generic (
      WRITE_MODE_A : string     := "WRITE_FIRST";
      WRITE_MODE_B : string     := "WRITE_FIRST";
      INIT_A       : bit_vector := X"00000";
      SRVAL_A      : bit_vector := X"00000";

      INIT_B      :     bit_vector := X"00000";
      SRVAL_B     :     bit_vector := X"00000"); 
      port (DIA   : in  std_logic_vector (15 downto 0);
            DIB   : in  std_logic_vector (15 downto 0);
            DIPA  : in  std_logic_vector (1 downto 0);
            DIPB  : in  std_logic_vector (1 downto 0);
            ENA   : in  std_logic;
            ENB   : in  std_logic;
            WEA   : in  std_logic;
            WEB   : in  std_logic;
            SSRA  : in  std_logic;
            SSRB  : in  std_logic;
            CLKA  : in  std_logic;
            CLKB  : in  std_logic;
            ADDRA : in  std_logic_vector (9 downto 0);
            ADDRB : in  std_logic_vector (9 downto 0);
            DOA   : out std_logic_vector (15 downto 0);
            DOB   : out std_logic_vector (15 downto 0);
            DOPA  : out std_logic_vector (1 downto 0);
            DOPB  : out std_logic_vector (1 downto 0)
            );
  end component;


begin

  we     <= (not erin) and (dvll) and (not ff);
  endfin <= wel and (not we);
  wein   <= we or wel;

  di <= endfin & erin & ff & "00000" & din;

  RX_CLKint <= RX_CLK;
  rxclk_domain : process (RX_CLKint)
  begin
    if rising_edge(RX_CLKint) then
      erl   <= RX_ER;
      dvl   <= RX_DV;
      rxdl  <= RXD;
      din   <= rxdl;
      dvll  <= dvl;
      wel   <= we;

      if dvl = '0' then
        erin   <= '0';
      else
        if erl = '1' then
          erin <= '1';
        end if;
      end if;

      if dvl = '0' then
        ff   <= '0';
      else
        if ffs = '1' then
          ff <= '1';
        end if;
      end if;
      if wein = '1' then
        ain  <= ain + 1;
      end if;

      al <= ain;

    end if;
  end process rxclk_domain;


  fifo : RAMB16_S18_S18 port map (
    DIA   => di,
    DIB   => X"0000",
    DIPA  => "00",
    DIPB  => "00",
    ENA   => '1',
    ENB   => '1',
    WEA   => wein,
    WEB   => '0',
    SSRA  => '0',
    SSRB  => '0',
    CLKA  => RX_CLKint,
    CLKB  => CLK,
    ADDRA => ain,
    ADDRB => ao,
    DOA   => open,
    DOB   => do,
    DOPA  => open,
    DOPB  => open);

  EROUT <= do(14);
  DOUT  <= do(7 downto 0);
  OFOUT <= do(13);

  endfo <= do(15);

  aeq <= '1' when al2 = ao else '0';

  efv     <= val and endfo;
  lvalid  <= nfl and (not aeq) and (not efv);
  VALID   <= val;
  ENDFOUT <= endfo;

  ffs <= '0' when al2l(9 downto 8) = "00" and ao(9 downto 8) = "00" else
         '0' when al2l(9 downto 8) = "01" and ao(9 downto 8) = "00" else
         '0' when al2l(9 downto 8) = "10" and ao(9 downto 8) = "00" else
         '1' when al2l(9 downto 8) = "11" and ao(9 downto 8) = "00" else
         '0' when al2l(9 downto 8) = "01" and ao(9 downto 8) = "01" else
         '0' when al2l(9 downto 8) = "10" and ao(9 downto 8) = "01" else
         '0' when al2l(9 downto 8) = "11" and ao(9 downto 8) = "01" else
         '1' when al2l(9 downto 8) = "00" and ao(9 downto 8) = "01" else
         '0' when al2l(9 downto 8) = "10" and ao(9 downto 8) = "10" else
         '0' when al2l(9 downto 8) = "11" and ao(9 downto 8) = "10" else
         '0' when al2l(9 downto 8) = "00" and ao(9 downto 8) = "10" else
         '1' when al2l(9 downto 8) = "01" and ao(9 downto 8) = "10" else
         '0' when al2l(9 downto 8) = "11" and ao(9 downto 8) = "11" else
         '0' when al2l(9 downto 8) = "00" and ao(9 downto 8) = "11" else
         '0' when al2l(9 downto 8) = "01" and ao(9 downto 8) = "11" else
         '1' when al2l(9 downto 8) = "10" and ao(9 downto 8) = "11";

  clk_domain : process(CLK)
  begin
    if rising_edge(CLK) then
      val <= lvalid;

      al2  <= al;
      al2l <= al2;
      if lvalid = '1' then
        ao <= ao + 1;
      end if;

      if NEXTF = '1' then
        nfl   <= '1';
      else
        if efv = '1' then
          nfl <= '0';
        end if;
      end if;


    end if;
  end process clk_domain;


end Behavioral;