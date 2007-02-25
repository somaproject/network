library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


library UNISIM;
use UNISIM.VComponents.all;

entity datagen is
  port (
    CLK       : in  std_logic;
    NEXTFRAME : in  std_logic;
    DOUTEN    : out std_logic;
    DOUT      : out std_logic_vector(15 downto 0)
    );
end datagen;

architecture Behavioral of datagen is
  -- this is a simple demo in which we wait for nextframe to go high,
  -- and then transmit a burst of expected data

  signal nextframel : std_logic                     := '0';
  signal framecnt   : std_logic_vector(15 downto 0) := (others => '0');
  signal countdown  : std_logic_vector(31 downto 0) := X"80000000";


begin  -- Behavioral

  main : process(CLK)
  begin
    if rising_edge(CLK) then
      if countdown = X"00000000" then
        null;
      else
        countdown <= countdown -1;
      end if;
      nextframel  <= NEXTFRAME;


      if nextframel = '0' then
        framecnt <= (others => '0');
        DOUT     <= (others => '0');
        DOUTEN   <= '0';
      else
        if countdown = X"00000000" then
          if framecnt = X"0041" then
            DOUT     <= X"0000";
            DOUTEN   <= '0';
          else
            framecnt <= framecnt + 1;

            DOUTEN <= '1';
            if framecnt = X"0000" then
              DOUT <= X"0080";
            else
              DOUT <= framecnt(3 downto 0) & framecnt(3 downto 0) & framecnt(3 downto 0) & framecnt(3 downto 0);
            end if;
          end if;
        end if;
      end if;
    end if;
  end process main;


end Behavioral;
