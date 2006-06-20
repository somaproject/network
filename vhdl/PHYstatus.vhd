library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity PHYstatus is
  port ( CLK           : in    std_logic;
         CLKSLEN       : in    std_logic;
         PHYDIN        : in    std_logic_vector(15 downto 0);
         PHYDOUT       : out   std_logic_vector(15 downto 0);
         PHYADDRSTATUS : out   std_logic;
         PHYADDR       : in    std_logic_vector(5 downto 0);
         PHYADDRR      : in    std_logic;
         PHYADDRW      : in    std_logic;
         PHYSTAT       : out   std_logic_vector(31 downto 0);
         RESET         : in    std_logic;
         MDIO          : inout std_logic;
         MDC           : out   std_logic;
         DUPLEX        : out   std_logic;
         LINK1000      : out   std_logic;
         LINK100       : out   std_logic;
         ACTIVITY      : out   std_logic);
end PHYstatus;

architecture Behavioral of PHYstatus is

  signal addrl, miiaddr : std_logic_vector(4 downto 0) := (others => '0');
  signal rwl, miirw     : std_logic                    := '0';


  signal din, dout : std_logic_vector(15 downto 0) := (others => '0');

  signal phyaddrdone, phyaddrws : std_logic := '0';

  signal reglinkan, reg1kscr : std_logic_vector(15 downto 0) := (others => '0');

  type states is (read1k, read1kw, readlink, readlinkw, phyl, miiio,
                  miiiow, miiio_done);

  signal cs, ns : states := read1k;

  signal start, done : std_logic := '0';

  signal miisel  : integer                       := 0;
  signal counter : std_logic_vector(15 downto 0) := (others => '0');

  component MII
    port ( CLK     : in    std_logic;
           CLKSLEN : in    std_logic;
           RESET   : in    std_logic;
           MDIO    : inout std_logic;
           MDC     : out   std_logic;
           DIN     : in    std_logic_vector(15 downto 0);
           DOUT    : out   std_logic_vector(15 downto 0);
           ADDR    : in    std_logic_vector(4 downto 0);
           START   : in    std_logic;
           RW      : in    std_logic;
           DONE    : out   std_logic);
  end component;

begin

  MII_Interface : MII port map (
    CLK     => CLK,
    CLKSLEN => CLKSLEN,
    RESET   => RESET,
    MDIO    => MDIO,
    MDC     => MDC,
    DIN     => din,
    DOUT    => dout,
    ADDR    => miiaddr,
    START   => start,
    RW      => miirw,
    DONE    => done);


  PHYSTATUS <= reg1kscr & reglinkan;
  DUPLEX    <= reglinkan(1);
  LINK1000  <= reglinkan(4) and not reglinkan(3);
  LINK100   <= reglinkan(3) and not reglinkan(4);
  ACTIVITY  <= reglinkan(2);

  clock : process(CLK, RESET) 
  begin
    if RESET = '1' then
      cs     <= read1k;
    else
      if rising_edge(CLK) then
        if CLKSLEN = '1' then
          cs <= ns;

                                        -- phyaddr latches
          if cs = phyl then
            addrl <= PHYADDR(4 downto 0);
            rwl   <= PHYADDR(5);
          end if;

                                        -- din and dout latches
          if cs = phyl then
            din <= PHYDIN;
          end if;

                                        -- phy addr write set                           
          if phyaddrdone = '1' then
            phyaddrws   <= '0';
          else
            if phyaddrw = '1' then
              phyaddrws <= '1';
            end if;
          end if;

          if PHYADDRR = '1' then
            phyaddrstatus   <= '0';
          else
            if phyaddrdone = '1' then
              phyaddrstatus <= '1';
            end if;
          end if;

          if done = '1' and miisel = 0 then
            PHYSTAT(15 downto 0) <= dout;
          end if;

          if done = '1' and miisel = 1 then
            reg1kscr <= dout;
          end if;

          if done = '1' and miisel = 2 then
            reglinkan <= dout;
          end if;
        end if;
      end if;
    end if;
  end process clock;


  miiaddr <= "10001" when miisel = 0 else
             "01111" when miisel = 1 else
             addrl;


  miirw <= '0' when miisel = 0 else
           '0' when miisel = 1 else
           rwl;


  fsm : process(cs, ns, done, phyaddrws)
  begin
    case cs is
      when read1k     =>
        start       <= '1';
        miisel      <= 0;
        phyaddrdone <= '0';
        ns          <= read1kw;
      when read1kw    =>
        start       <= '0';
        miisel      <= 0;
        phyaddrdone <= '0';
        if done = '1' then
          ns        <= readlink;
        else
          ns        <= read1kw;
        end if;
      when readlink   =>
        start       <= '1';
        miisel      <= 1;
        phyaddrdone <= '0';
        ns          <= readlinkw;
      when readlinkw  =>
        start       <= '0';
        miisel      <= 1;
        phyaddrdone <= '0';
        if done = '1' then
          ns        <= phyl;
        else
          ns        <= readlinkw;
        end if;
      when phyl       =>
        start       <= '0';
        miisel      <= 2;
        phyaddrdone <= '0';
        if phyaddrws = '1' then
          ns        <= miiio;
        else
          ns        <= read1k;
        end if;
      when miiio      =>
        start       <= '1';
        miisel      <= 2;
        phyaddrdone <= '0';
        ns          <= miiiow;
      when miiiow     =>
        start       <= '0';
        miisel      <= 2;
        phyaddrdone <= '0';
        if done = '1' then
          ns        <= miiio_done;
        else
          ns        <= miiiow;
        end if;
      when miiio_done =>
        start       <= '0';
        miisel      <= 0;
        phyaddrdone <= '1';
        ns          <= read1k;
      when others     =>
        start       <= '0';
        miisel      <= 0;
        phyaddrdone <= '0';
        ns          <= read1k;
    end case;
  end process fsm;

end Behavioral;
