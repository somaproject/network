library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity serialio is
  port ( CLK    : in  std_logic;
         RESET  : in  std_logic;
         SCLK   : in  std_logic;
         SCS    : in  std_logic;
         SIN    : in  std_logic;
         SOUT   : out std_logic;
         NEWCMD : out std_logic;
         DOUTENOUT : out std_logic; 
         ADDR   : out std_logic_vector(5 downto 0);
         RW     : out std_logic;
         DOUT   : out std_logic_vector(31 downto 0);
         DIN    : in  std_logic_vector(31 downto 0)
         );
end serialio;

architecture Behavioral of serialio is

  -- clock-related
  signal sclkl, sclkll, lsclkdelta, sclkdelta, sclkdeltal,
    sclkdeltall, sclkdeltalll :
    std_logic                                               := '0';
  signal bitcnt              : std_logic_vector(5 downto 0) := (others => '0');
  signal scsl, scsll, scslll : std_logic                    := '0';

  signal addrreg : std_logic_vector(7 downto 0) := (others => '0');

  -- data signals
  signal sinl, sinll, sinlll : std_logic                     := '0';
  signal addrl
                             : std_logic_vector(7 downto 0)  := (others => '0');
  signal dinreg, doutreg     : std_logic_vector(31 downto 0) := (others => '0');
  signal douten              : std_logic                     := '0';
  signal rwint : std_logic := '0';


begin


  douten <= '1' when sclkdeltall = '1' and bitcnt = 8 else '0';
  DOUTENOUT <= douten;
  
  main : process(CLK, RESET)
  begin
    if RESET = '1' then

    else
      if rising_edge(CLK) then
        -- sclk:
        sclkl       <= SCLK;
        sclkll      <= sclkl;
        sclkdelta   <= lsclkdelta;
        sclkdeltal  <= sclkdelta;
        sclkdeltall <= sclkdeltal;

        -- cs:
        scsl   <= SCS;
        scsll  <= scsl;
        scslll <= scsll;

        -- sin
        sinl   <= sin;
        sinll  <= sinl;
        sinlll <= sinll;

        -- dout
        SOUT <= dinreg(31);



        if scslll = '1' then
          bitcnt   <= "000000";
        else
          if sclkdelta = '1' then
            bitcnt <= bitcnt + 1;
          end if;
        end if;

        -- address register
        if sclkdelta = '1' and bitcnt < 8 then
          addrreg <= addrreg(6 downto 0) & sinlll;
        end if;

        -- data in register
        if sclkdelta = '1' and bitcnt > 7 then
          doutreg <= doutreg(30 downto 0) & sinlll;
        end if;


        -- data in register
        if douten = '1' then
          dinreg   <= DIN;
        else
          if sclkdelta = '1' and bitcnt > 7 and rwint = '0' then
            dinreg <= dinreg(30 downto 0) & '0';
          end if;
        end if;

      end if;

    end if;
  end process main;


  lsclkdelta <= (not sclkll) and (sclkl);
  rwint      <= addrreg(7);
  RW         <= rwint;
  ADDR       <= addrreg(5 downto 0);
  DOUT       <= doutreg;
  NEWCMD <= '1' when sclkdeltal = '1' and bitcnt = 40 else '0'; 

end Behavioral;
