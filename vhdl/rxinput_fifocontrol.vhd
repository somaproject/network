library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rxinput_fifocontrol is
    Port ( CLK : in std_logic;
    		 RESET : in std_logic; 
           CEOUT : out std_logic;
		 CE : in std_logic; 
           DIN : in std_logic_vector(9 downto 0);
           DATA : out std_logic_vector(7 downto 0);
           ENDF : out std_logic;
           INVALID : out std_logic);
end rxinput_fifocontrol;

architecture Behavioral of rxinput_fifocontrol is
-- RXINPUT_FIFOCONTROL.VHD -- control to deal with the registering
-- of the fifo control. 
   signal dinl, d0, d1, d2, d3, ldata : std_logic_vector(9 downto 0) :=
   		(others => '0');
   signal cel, cell, celll : std_logic := '0';
   type states is (sel0, sel1, sel2, sel3);
   signal cs, ns : states := sel3; 




begin
    
   CEOUT <= cel;     

   clocks: process(CLK, RESET) is
   begin
      if RESET = '1' then
	 	cs <= sel3;
		D0 <= "1000000000";
		D1 <= "1000000000";
		D2 <= "1000000000";
		D3 <= "1000000000";

	 else 
	     if rising_edge(CLK) then
		   cs <= ns; 
		
		   cel <= CE; 
		   cell <= cel; 
		   celll <= cell; 

		   dinl <=  din;
		   if celll = '1' then
		   	  d0 <= dinl;
			  d1 <= d0; 
			  d2 <= d1;
			  d3 <= d2; 
		   end if; 
		   
		   if CE = '1' then
		      DATA <= ldata(7 downto 0);
			 ENDF <= ldata(8);
			 INVALID <= ldata(9); 
		   end if; 
	    end if;
      end if; 
   end process clocks; 

   ldata <= d3 when cs = sel3 else
   		  d2 when cs = sel2 else
		  d1 when cs = sel1 else
		  d0 when cs = sel0; 

   fsm : process(CS, CE) is
   begin
        case cs is 
	       when sel3 => 
		     if CE = '1' then 
			   ns <= sel2;
			else 
			   ns <= sel3; 
	 		end if;
		  when sel2 => 
		     if CE = '1' then
			   ns <= sel1;
			else
			   ns <= sel3;
			end if;
		  when sel1 => 
		     if CE = '1' then 
			   ns <= sel0;
			else
			   ns <= sel3;
			end if;
		  when sel0 => 
		     if CE = '0' then 
			   ns <= sel3;
			else
			   ns <= sel0;
			end if;
		  when others => 
		     ns <= sel3;
       end case; 
   end process fsm; 

end Behavioral;
