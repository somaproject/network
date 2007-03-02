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
         ENDFOUT : out std_logic;
         EROUT   : out std_logic;
         OFOUT   : out std_logic;
         VALID   : out std_logic;
         DOUT    : out std_logic_vector(7 downto 0));

end gmiiin;

architecture Behavioral of gmiiin is

  --RX_CLK domain signals 
  signal erl, dvl, dvll, erin, endfin, wein, ff, ffsll,
    we, wel : std_logic := '0';

  signal rxdl, din : std_logic_vector(7 downto 0) := (others => '0');

  signal ain, al, al2 : std_logic_vector(9 downto 0) := (others => '0');

  signal di : std_logic_vector(15 downto 0) := (others => '0');

  -- CLK domain signals:
  signal aneq, endfo, val, lvalid, nfl, ffs, ffsl, efv :
    std_logic := '0';
  signal ao, al3, al3l : std_logic_vector(9 downto 0)
              := (others => '0');
  signal do      : std_logic_vector(15 downto 0)
              := (others => '0');

  signal rx_clkint : std_logic := '0';


begin


  we     <= dvll and (not ff);
  endfin <= wel and (not we);
  wein   <= we or wel;

  di <= endfin & erin & ff & "00000" & din;


  rxacquire: process(RX_CLK)
    begin
      if falling_edge(RX_CLK) then
        erl  <= RX_ER;
        dvl  <= RX_DV;
        rxdl <= RXD;

      end if;
    end process;
    
  rxclk_domain : process (RX_CLK)
  begin
    if rising_edge(RX_CLK) then


      din  <= rxdl;
      dvll <= dvl;
      erin <= erl;


      wel  <= we;
      ffsll <= ffsl;

      if dvl = '0' then
        ff   <= '0';
      else
        if ffsll = '1' then
          ff <= '1';
        end if;
      end if;

      if wein = '1' then
        ain <= ain + 1;
      end if;

      al  <= ain;
      al2 <= al;
    end if;
  end process rxclk_domain;


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
      WEA                 => wein,
      WEB                 => '0',
      SSRA                => '0',
      SSRB                => '0',
      CLKA                => RX_CLK,
      CLKB                => CLK,
      ADDRA               => ain,
      ADDRB               => ao,
      DOA                 => open,
      DOB                 => do,
      DOPA                => open,
      DOPB                => open);


  aneq <= '1' when al3 /= ao else '0';

  ffs <= '0' when al3l(9 downto 8) = "00" and ao(9 downto 8) = "00" else
         '0' when al3l(9 downto 8) = "01" and ao(9 downto 8) = "00" else
         '0' when al3l(9 downto 8) = "10" and ao(9 downto 8) = "00" else
         '1' when al3l(9 downto 8) = "11" and ao(9 downto 8) = "00" else
         '0' when al3l(9 downto 8) = "01" and ao(9 downto 8) = "01" else
         '0' when al3l(9 downto 8) = "10" and ao(9 downto 8) = "01" else
         '0' when al3l(9 downto 8) = "11" and ao(9 downto 8) = "01" else
         '1' when al3l(9 downto 8) = "00" and ao(9 downto 8) = "01" else
         '0' when al3l(9 downto 8) = "10" and ao(9 downto 8) = "10" else
         '0' when al3l(9 downto 8) = "11" and ao(9 downto 8) = "10" else
         '0' when al3l(9 downto 8) = "00" and ao(9 downto 8) = "10" else
         '1' when al3l(9 downto 8) = "01" and ao(9 downto 8) = "10" else
         '0' when al3l(9 downto 8) = "11" and ao(9 downto 8) = "11" else
         '0' when al3l(9 downto 8) = "00" and ao(9 downto 8) = "11" else
         '0' when al3l(9 downto 8) = "01" and ao(9 downto 8) = "11" else
         '1' when al3l(9 downto 8) = "10" and ao(9 downto 8) = "11" else
         '0';

  clk_domain : process(CLK)
  begin
    if rising_edge(CLK) then


      EROUT <= do(14);
      DOUT  <= do(7 downto 0);
      OFOUT <= do(13);

      ENDFOUT <= do(15);
      lvalid   <= aneq;
      VALID <= lvalid;
      
      --ffsl <= ffs;

      al3  <= al2;
      al3l <= al3;

      if aneq = '1' then
        ao <= ao + 1;
      end if;


    end if;
  end process clk_domain;


end Behavioral;
