library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TXinput is
    Port ( CLK : in std_logic;
    		 RESET : in std_logic; 
           DATA : in std_logic_vector(15 downto 0);
           NEWFRAME : in std_logic;
           DEN : in std_logic;
           MD : out std_logic_vector(31 downto 0);
           MWEN : out std_logic;
           MA : out std_logic_vector(16 downto 0);
           BPOUT : out std_logic_vector(16 downto 0);
           DONE : out std_logic);
end TXinput;

architecture Behavioral of TXinput is
-- TXINPUT.VHD -- Module for packetizing incoming 2-byte wide
-- data stream and placing it in the buffer. Memory outputs, designed
-- to stay constant for at least four ticks such that multiplexed
-- memory controller can work. 



   signal dh, dl : std_logic_vector(15 downto 0) := (others => '0');
   signal lmd : std_logic_vector(31 downto 0) := (others => '0');

   signal dlen, dhen : std_logic := '0';
   signal cpen : std_logic := '0';
   signal mrw, men : std_logic := '0';
   
   signal addr, bp : std_logic_vector(16 downto 0) := (others => '0');
   signal bpen : std_logic := '0';
   signal CNT : std_logic_vector(15 downto 0);

   type states is (none, newf, low_w, low, high_w, high, waitlow,
   			    lowmemw, pktdone1, pktdone2, pktdone3); 
   signal cs, ns : states := none; 


begin

   lmd <= dh & dl;
   BPOUT <= bp; 

   clock: process(CLK) is
   begin
   	if RESET = '1' then
		cs <= none;
	else
		if rising_edge(CLK) then
			

			cs <= ns;

			-- data latching
			if DEN = '1' and (NEWFRAME = '1' or dlen = '1') then
				dl <= DATA;	
			end if; 

			if DEN = '1' and dhen = '1' then
				dh <= DATA;
			end if;

			-- byte counter
			if DEN = '1' then
				if NEWFRAME = '1' then
					cnt <= DATA;
				else
					cnt <= cnt - 1;
				end if;
			end if;


			-- memory-pointer associated code:
			if NEWFRAME = '1' then 
				addr <= bp;
			else 
				if CPEN = '1' then
					addr <= addr + 1;
				end if;
			end if; 

			if bpen = '1' then
				bp <= addr;
			end if; 

			-- memory interface
			if MEN = '1' then
				MD <= lmd;
				MWEN <= mrw;
				MA <= addr;
			end if;
		end if;
	end if;
   end process clock; 


   fsm: process(cs, ns, DEN, NEWFRAME, cnt) is
   begin
   	 case cs is 
	 	when none => 
			dlen <= '1';
			dhen <= '0';
			mrw <= '0';
			men <= '0';
			bpen <= '0';
			cpen <= '0';
			DONE <= '0';
			if DEN = '1' and NEWFRAME = '1' then
				ns <= newf;
			else
				ns <= none;
			end if;
	 	when newf => 
			dlen <= '1';
			dhen <= '0';
			mrw <= '1';
			men <= '1';
			bpen <= '0';
			cpen <= '0';
			DONE <= '0';
			ns <= low_w;
	 	when low_w => 
			dlen <= '1';
			dhen <= '0';
			mrw <= '0';
			men <= '0';
			bpen <= '0';
			cpen <= '0';
			DONE <= '0';
			if DEN = '1' then
				ns <= low;
			else
				ns <= low_w;
			end if;
	 	when low => 
			dlen <= '0';
			dhen <= '0';
			mrw <= '0';
			men <= '0';
			bpen <= '0';
			cpen <= '1';
			DONE <= '0';
			if cnt = "0000000000000000" then
				ns <= waitlow;
			else
				ns <= high_w;
			end if;
	 	when high_w => 
			dlen <= '0';
			dhen <= '1';
			mrw <= '0';
			men <= '0';
			bpen <= '0';
			cpen <= '0';
			DONE <= '0';
			if DEN = '1'  then
				ns <= high;
			else
				ns <= high_w;
			end if;		
	 	when high => 
			dlen <= '0';
			dhen <= '1';
			mrw <= '1';
			men <= '1';
			bpen <= '0';
			cpen <= '0';
			DONE <= '0';
			if  cnt = "0000000000000000" then
				ns <= pktdone1;
			else
				ns <= low_w;
			end if;  
	 	when waitlow => 
			dlen <= '0';
			dhen <= '0';
			mrw <= '0';
			men <= '0';
			bpen <= '0';
			cpen <= '0';
			DONE <= '0';
			ns <= lowmemw;
	 	when lowmemw => 
			dlen <= '0';
			dhen <= '0';
			mrw <= '1';
			men <= '1';
			bpen <= '0';
			cpen <= '0';
			DONE <= '0';
			ns <= pktdone1;
	 	when pktdone1 => 
			dlen <= '0';
			dhen <= '0';
			mrw <= '0';
			men <= '0';
			bpen <= '0';
			cpen <= '1';
			DONE <= '0';
			ns <= pktdone2;
	 	when pktdone2 => 
			dlen <= '0';
			dhen <= '0';
			mrw <= '0';
			men <= '0';
			bpen <= '1';
			cpen <= '0';
			DONE <= '0';
			ns <= pktdone3;
	 	when pktdone3 => 
			dlen <= '0';
			dhen <= '0';
			mrw <= '0';
			men <= '0';
			bpen <= '0';
			cpen <= '0';
			DONE <= '1';
			ns <= none;
	 	when others => 
			dlen <= '0';
			dhen <= '0';
			mrw <= '0';
			men <= '0';
			bpen <= '0';
			cpen <= '0';
			DONE <= '0';
			ns <= none;	
	end case; 
													
			 
   end process fsm;  

end Behavioral;
