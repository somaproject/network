library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

USE ieee.numeric_std.ALL; 
--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity MII is
    Port ( CLK : in std_logic;
    		  RESET : in std_logic; 
           MDIO : inout std_logic;
		     MDC : out std_logic; 
           DIN : in std_logic_vector(15 downto 0);
           DOUT : out std_logic_vector(15 downto 0);
           ADDR : in std_logic_vector(4 downto 0);
           START : in std_logic;
		     RW : in std_logic; 
           DONE : out std_logic);
end MII;

architecture Behavioral of MII is
-- MII.VHD -- control the MII management interface. Kind
-- of a hack job, but I really don't care about elegance with this
-- part :)
   signal mdcint, clken, shiften : std_logic := '0';
   signal mdccnt : std_logic_vector(5 downto 0) := 
   		(others => '0');
   signal statecnt : integer range 0 to 63 := 0; 
   type states is (none, resetcnt, firstinc, waiting, ldout, setdone);

   signal cs, ns : states := none; 
   signal dreg : std_logic_vector(15 downto 0) := (others => '0');
    
   signal sin, sout, sts : std_logic := '0';

	component IOBUF
	      port (I, T: in std_logic; 
	            O: out std_logic; 
	            IO: inout std_logic);
	end component;   
begin
   
   clock : process(RESET, CLK) is
   begin
   	if RESET = '1' then
	   cs <= none;
	else
	   if rising_edge(CLK) then
	      cs <= ns; 

		 if cs = resetcnt then 
		    mdccnt <= (others => '0');
		 else
		    if cs = waiting or cs = firstinc then
		       mdccnt <= mdccnt + 1;
		    end if;
		 end if; 

		 if cs = resetcnt then 
		    statecnt <= 0;
		 else
		    if clken = '1'  then
		       if statecnt = 63 then 
			  	statecnt <= 0; 
			  else
		          statecnt <= statecnt + 1;
 			  end if; 
		    end if;
		 end if; 

		 mdcint <= mdccnt(5); 

		 if cs = waiting or cs = firstinc then 
		 	dreg <= dreg(14 downto 0) & SIN;
		 end if; 

		 if cs = ldout then
		 	DOUT <= dreg;
		 end if; 
	   end if;
     end if; 
   end process clock;
   
   MDC <= mdcint; 
   clken <= mdcint and (not mdccnt(5));
   shiften <= mdccnt(5) and (not mdcint);

   iobuffer : iobuf port map (
   			I => sout,
			T => sts,
			O => sin,
			IO => MDIO); 
			 

   soutmux: process(sout, statecnt, RW, ADDR, DIN) is
   begin
      case statecnt is 
	   when 0 to 31 => sout <= '1';
	   when 32 => sout <= '0';
	   when 33 => sout <= '1';
	   when 34 => sout <= not RW;
	   when 35 => sout <= RW;
	   when 36 to 40 => sout <= '0';
	   when 41 => sout <= addr(4);
	   when 42 => sout <= addr(3);
	   when 43 => sout <= addr(2);
	   when 44 => sout <= addr(1);
	   when 45 => sout <= addr(0);
	   when 46 => sout <= '1';
	   when 47 => sout <= '0';
	   when 48 => sout <= din(15);
	   when 49 => sout <= din(14);
	   when 50 => sout <= din(13);
	   when 51 => sout <= din(12);
	   when 52 => sout <= din(11);
	   when 53 => sout <= din(10);
	   when 54 => sout <= din(9);
	   when 55 => sout <= din(8);
	   when 56 => sout <= din(7);
	   when 57 => sout <= din(6);
	   when 58 => sout <= din(5);
	   when 59 => sout <= din(4);
	   when 60 => sout <= din(3);
	   when 61 => sout <= din(2);
	   when 62 => sout <= din(1);
	   when 63 => sout <= din(0);
	   when others => sout <= '0';
	 end case; 
	  
      case statecnt is 
	   when 0 to 45 => sts <= '0';
	   when 46 => sts <= '1';
	   when 47 to 63 => sts <= not rw; 
	   when others => sts <= '1';
	 end case;  
   end process soutmux;

   fsm : process (cs, START, statecnt, clken) is
   begin
	case cs is 
	   when none =>
	      DONE <= '0';  
	   	 if START = '1' then
		 	ns <= resetcnt;
		 else
		    ns <= none; 
	      end if; 
	   when resetcnt => 
	      DONE <= '0';
		 ns <= firstinc;
	   when firstinc =>
	      DONE <= '0';  
	   	 if clken = '1' then
		 	ns <= waiting;
		 else
		    ns <= firstinc; 
	      end if; 
	   when waiting =>
	      DONE <= '0';  
	   	 if statecnt = 0  then
		 	ns <= ldout;
		 else
		    ns <= waiting; 
	      end if; 
	   when ldout => 
	      DONE <= '0';
		 ns <= setdone;
	   when setdone => 
	      DONE <= '1';
		 ns <= none;
	   when others => 
	      DONE <= '0';
		 ns <= none;
     end case; 	    	
   end process fsm; 





end Behavioral;
