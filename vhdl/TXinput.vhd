library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity TXinput is
    Port ( CLK : in std_logic;
    		  CLKIO : in std_logic; 
    		  RESET : in std_logic; 
           DIN : in std_logic_vector(15 downto 0);
           NEWFRAME : in std_logic;
           MD : out std_logic_vector(31 downto 0);
           MWEN : out std_logic;
           MA : out std_logic_vector(15 downto 0);
			  FIFOFULL : in std_logic; 
           BPOUT : out std_logic_vector(15 downto 0);
				TXFIFOWERR : out std_logic; 
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
   										  
   signal addr, bp : std_logic_vector(15 downto 0) := (others => '0');
   signal bpen : std_logic := '0';
   signal CNT : std_logic_vector(15 downto 0);

   type states is (none, newf, low_w, low, high_w, high, waitlow,
   			    lowmemw, pktdone1, pktdone2, pktdone3, pktabort); 
   signal cs, ns : states := none; 

   -- signals for clock-boundary-crossing logic
   signal nenable, enable, enableint, enableintl, den, lden :
   		std_logic := '0';
   signal dinl, dinint, ldinint : std_logic_vector(15 downto 0) 
					:= (others => '0');
   signal newframel, newfint, lnewfint : std_logic := '0'; 

   -- fifo control
   signal fifofulll : std_logic := '0';


	component SRL16
	  generic (
	       INIT : bit_vector := X"0000");
	  port (D   : in STD_logic;
	        CLK : in STD_logic;
	        A0  : in STD_logic;
	        A1  : in STD_logic;
	        A2  : in STD_logic;
	        A3  : in STD_logic;
	        Q   : out STD_logic); 
	end component;

begin

   lmd <= dh & dl;
   BPOUT <= bp;
   
   
   -- clocks to outside:
   clock_external: process(CLKIO) is
   begin
   	 if rising_edge(CLKIO) then
	     enable <= not enable; 

		dinl <= DIN;

		newframel <= NEWFRAME;
	 end if; 
   end process clock_external; 

   srl16_enable: srl16 port map (
   		D => enable,
			CLK => clk,
			A0 => '0',
			A1 => '0',
			A2 => '1',
			A3 => '0',
			Q => enableint);
   srl16_newframe: srl16 port map (
   			D => newframel,
			CLK => clk,
			A0 => '0',
			A1 => '0',
			A2 => '1',
			A3 => '0',
			Q => lnewfint);
   srl16_din: for i in 0 to 15 generate
	    srl16_din_bit: srl16 port map (
   			D => dinl(i),
			CLK => clk,
			A0 => '0',
			A1 => '0',
			A2 => '1',
			A3 => '0',
			Q => ldinint(i));
   end generate; 

   lden <= enableintl xor enableint; 


   clock: process(CLK, RESET) is
   begin
   	if RESET = '1' then
		cs <= none;
		MD <= (others => '0');
		MWEN <= '0';
		MA <= (others => '0');
	else
		if rising_edge(CLK) then

			cs <= ns;

			-- enable code
			enableintl <= enableint; 

			-- data latching
			if den = '1' and (cs = none or dlen = '1') then
				dl <= dinint;	
			end if; 

			if den = '1' and dhen = '1' then
				dh <= dinint;
			end if;

			-- byte counter
			if den = '1' then
				if cs = none then
					cnt <= dinint;
				else
					cnt <= cnt - 2;
				end if;
			end if;

			MWEN <= mrw; 

			-- memory-pointer associated code:
			if cs = none then 
				addr <= bp;
			elsif cpen = '1' then
				addr <= addr + 1;
			end if; 

			if bpen = '1' then
				bp <= addr;
			end if; 
			-- fifo concerns
			fifofulll <= FIFOFULL; 

			-- extra registers at output
			dinint <= ldinint;
			newfint <= lnewfint; 
			den <= lden;   

			-- memory interface
			if MEN = '1' then
				MD <= lmd;
				MWEN <= mrw;
				MA <= addr;
			end if;
		end if;
	end if;
   end process clock; 


   fsm: process(cs, ns, den, din, dinint, newfint, cnt, fifofulll) is
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
			TXFIFOWERR <= '0';
			if den = '1' and newfint = '1' then
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
			TXFIFOWERR <= '0';
			if newfint = '0' then
				ns <= none;
			else
				ns <= low_w;
			end if; 
	 	when low_w => 
			dlen <= '1';
			dhen <= '0';
			mrw <= '0';
			men <= '0';
			bpen <= '0';
			cpen <= '0';
			DONE <= '0';
			TXFIFOWERR <= '0';
			if newfint = '0' then
				ns <= none;
			else
				if den = '1' then
					ns <= low;
				else
					ns <= low_w;
				end if;
			end if; 

	 	when low => 
			dlen <= '0';
			dhen <= '0';
			mrw <= '0';
			men <= '0';
			bpen <= '0';
			cpen <= '1';
			DONE <= '0';
			TXFIFOWERR <= '0';
			if newfint = '0' then
				ns <= none;
			else
				if cnt =0 or cnt = 65535 then --i.e. 0 or -1
					ns <= waitlow;
				else
					ns <= high_w;
				end if;
			end if; 

	 	when high_w => 
			dlen <= '0';
			dhen <= '1';
			mrw <= '0';
			men <= '0';
			bpen <= '0';
			cpen <= '0';
			DONE <= '0';
			TXFIFOWERR <= '0';
			if newfint = '0' then
				ns <= none;
			else
				if den = '1'  then
					ns <= high;
				else
					ns <= high_w;
				end if;
			end if; 
	 	when high => 
			dlen <= '0';
			dhen <= '1';
			mrw <= '1';
			men <= '1';
			bpen <= '0';
			cpen <= '0';
			DONE <= '0';
			TXFIFOWERR <= '0';
			if newfint = '0' then
				ns <= none;
			else
				if  cnt =0 or cnt = 65535 then --i.e. 0 or -1
					ns <= pktdone1;
				else
					ns <= low_w;
				end if; 
			end if; 
 	 	when waitlow => 
			dlen <= '0';
			dhen <= '0';
			mrw <= '0';
			men <= '0';
			bpen <= '0';
			cpen <= '0';
			DONE <= '0';
			TXFIFOWERR <= '0';
			if newfint = '0' then
				ns <= none;
			else
				ns <= lowmemw;
			end if; 
			
	 	when lowmemw => 
			dlen <= '0';
			dhen <= '0';
			mrw <= '1';
			men <= '1';
			bpen <= '0';
			cpen <= '0';
			DONE <= '0';
			TXFIFOWERR <= '0';
			if newfint = '0' then
				ns <= none;
			else
				ns <= pktdone1;
			end if; 
			
	 	when pktdone1 => 
			dlen <= '0';
			dhen <= '0';
			mrw <= '0';
			men <= '0';
			bpen <= '0';
			cpen <= '1';
			DONE <= '0';
			TXFIFOWERR <= '0';
			if fifofulll = '1' then
			   ns <= pktabort;
			else
			   ns <= pktdone2;
			end if; 

	 	when pktdone2 => 
			dlen <= '0';
			dhen <= '0';
			mrw <= '0';
			men <= '0';
			bpen <= '1';
			cpen <= '0';
			DONE <= '0';
			TXFIFOWERR <= '0';
			ns <= pktdone3;
	 	when pktabort => 
			dlen <= '0';
			dhen <= '0';
			mrw <= '0';
			men <= '0';
			bpen <= '0';
			cpen <= '0';
			DONE <= '0';
			TXFIFOWERR <= '1';
			ns <= none;
	 	when pktdone3 => 
			dlen <= '0';
			dhen <= '0';
			mrw <= '0';
			men <= '0';
			bpen <= '0';
			cpen <= '0';
			DONE <= '1';
			TXFIFOWERR <= '0';
			if newfinit = '1' then
				ns <= pktdone3
			else
				ns <= none; 
			end if; 
	 	when others => 
			dlen <= '0';
			dhen <= '0';
			mrw <= '0';
			men <= '0';
			bpen <= '0';
			cpen <= '0';
			DONE <= '0';
			TXFIFOWERR <= '0';
			ns <= none;	
	end case; 
													
			 
   end process fsm;  


   
end Behavioral;
