library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NICserial is
    Port ( IFCLK : in std_logic;
	 		  RESET : in std_logic; 
           SCLK : out std_logic;
           SCS : out std_logic;
           SIN : out std_logic;
           SOUT : in std_logic;
			  DATA : inout std_logic_vector(15 downto 0); 
			  ADDR : in std_logic_vector(7 downto 0); 
			  RW : in std_logic; 
			  CMD : in std_logic;
			  SAMPLE : out std_logic;  
			  DONE : out std_logic);
end NICserial;

architecture Behavioral of NICserial is
-- NICSERIAL.VHD -- system for interfacing with the serial NIC. 
-- there is an array of 32 32-bit registers here, where we only need
-- to read to / write from one of them at a time, so we can use
-- a register file. Also, we only need to either read or write, thus no
-- need for a register file. 
-- 
-- Virtually the same as the protointerface's code.  



	signal clk : std_logic := '0';    

	component spdistram is 
	 port (clk : in std_logic; 
	 	we  : in std_logic; 
	 	a   : in std_logic_vector(5 downto 0); 
	 	di  : in std_logic_vector(15 downto 0); 
	 	do  : out std_logic_vector(15 downto 0));
	 end component; 

	component serialout is
		port ( CLK : in std_logic;
				 DIN : in std_logic_vector(31 downto 0);
				 DOUT : out std_logic_vector(31 downto 0);
				 ADDR : in std_logic_vector(7 downto 0);
				 SDIN : out std_logic;
				 SDOUT : in std_logic; 
				 SCS : out std_logic; 
				 SCLK : out std_logic; 
				 SAMPLE : out std_logic; 
				 SDONE : out std_logic;
				 SSTART : in std_logic);
	end component;

	
	signal cmdl, rwl, rwll, ramwe : std_logic := '0';
	signal addrl, addrll, seraddr : std_logic_vector(7 downto 0) := (others => '0'); 
	signal modesel, insel, saddrw : std_logic := '0';
	signal serdout, serdin : std_logic_vector(31 downto 0) := (others => '0');
	signal ramaddr : std_logic_vector(5 downto 0) := (others => '0'); 
	signal tsl : std_logic := '1';

	signal din, dinl, dout, doutl, ramdin, macdatal, ramdout : 
			std_logic_vector(15 downto 0) := (others => '0');
	 
	type states is (none, ramw, ramr, ramr_wait, ramr_wait2, donestate, serialwl, serialwh, swstart,
						 swwait, serialr, srstart, srwait, serrh, serrl,
						 donestatenodone, macreadwait);
	signal cs, ns : states := none;
	signal macreadcnt : std_logic_vector(4 downto 0) := (others => '0'); 

	signal sstart, sdone : std_logic := '0'; 	



	

begin
	clk <= IFCLK; 

	myram:spdistram port map (
		clk => clk,
		we => ramwe,
		a => ramaddr,
		di => ramdin,
		do => ramdout);
 
   serialcontrol: serialout port map (
		CLK => clk,
		DIN => serdin,
		DOUT => serdout,
		ADDR => seraddr,
		SDIN => SIN,
		SDOUT => SOUT,
		SCS => SCS,
		SCLK => SCLK,
		SDONE => sdone,
		SAMPLE => SAMPLE,
		SSTART => sstart); 

	ramaddr <= addrll(5 downto 0) when modesel = '0' else
					addrll(4 downto 0) & insel; 
	ramdin <= dinl when modesel = '0' else
				 serdout(15 downto 0) when modesel = '1' and insel = '0' else
				 serdout(31 downto 16) when modesel = '1' and insel = '1';
    


	 clock: process(RESET, clk, CMD) is
	 begin
	 	if RESET = '1' then
			cs <= none; 
		else
			if rising_edge(CLK) then
				cs <= ns; 
				-- input latches
				cmdl <= CMD;
				rwl <= RW;
				addrl <= ADDR;
				din <= DATA;
				doutl <=	dout;
				 

				-- things latched by cmdl
				if cmdl = '1' then
					rwll <= rwl;
					addrll <= addrl;
					dinl <= din; 
				end if;

				if cs = serialwl then
					serdin(15 downto 0) <= dout;
				end if;
				if cs = serialwh then
					serdin(31 downto 16) <= dout;
				end if; 

				if saddrw  = '1' then
					seraddr <= (not rwll) & "00" & addrll(4 downto 0);
				end if; 





			end if;
		end if;
	 end process clock;
	 tsl <= not rwl; 

	 DATA <= doutl when tsl = '0' else (others => 'Z'); 
	 dout <= ramdout; 


	 fsm: process(cs, sstart, sdone, cmdl, addrl, rwl, macreadcnt) is
	 begin
	 	case cs is
			when none => 
				modesel <= '0';
				insel <= '0';
				saddrw <= '0';
				ramwe <= '0';
				DONE <= '0';
				sstart <= '0'; 
				if cmdl = '1' then

						if addrl(6) = '0' then
							if rwl = '0'  then
								ns <= ramw;
							else
								ns <= ramr;
							end if;
						elsif addrl(6) = '1' then
							if rwl = '0' then
								ns <= serialwl;
							else
								ns <= serialr; 
							end if;
						end if;
 
				else
					ns <= none;
				end if; 
			when ramw => 
				modesel <= '0';
				insel <= '0';
				saddrw <= '0';
				ramwe <= '1';
				ns <= donestate;
				DONE <= '0';
				sstart <= '0';  
			when ramr => 
				modesel <= '0';
				insel <= '0';
				saddrw <= '0';
				ramwe <= '0';
				DONE <= '0';
				sstart <= '0';  
				ns <= ramr_wait;  
			when ramr_wait => 
				modesel <= '0';
				insel <= '0';
				saddrw <= '0';
				ramwe <= '0';
				DONE <= '0';
				sstart <= '0';  
				ns <= ramr_wait2;  
			when ramr_wait2 => 
				modesel <= '0';
				insel <= '0';
				saddrw <= '0';
				ramwe <= '0';
				DONE <= '0';
				sstart <= '0';  
				ns <= donestate;
			when donestate =>
				modesel <= '0';
				insel <= '0';
				saddrw <= '0';
				ramwe <= '0';
				DONE <= '1';
				sstart <= '0';  
				ns <= none;
			when donestatenodone =>
				modesel <= '0';
				insel <= '0';
				saddrw <= '0';
				ramwe <= '0';
				DONE <= '0';
				sstart <= '0';  
				ns <= none;
			when serialwl =>
				modesel <= '1';
				insel <= '0';
				saddrw <= '1';
				ramwe <= '0';
				DONE <= '0';
				sstart <= '0';  
				ns <= serialwh;
			when serialwh =>
				modesel <= '1';
				insel <= '1';
				saddrw <= '0';
				ramwe <= '0';
				DONE <= '0';
				sstart <= '0';  
				ns <= swstart;
			when swstart =>
				modesel <= '1';
				insel <= '1';
				saddrw <= '0';
				ramwe <= '0';
				DONE <= '0';
				sstart <= '1';  
				ns <= swwait;
			when swwait =>
				modesel <= '1';
				insel <= '1';
				saddrw <= '0';
				ramwe <= '0';
				DONE <= '0';
				sstart <= '0';
				if sdone = '1' then
					ns <= donestate;
				else
					ns <= swwait;
				end if;
			when serialr =>
				modesel <= '1';
				insel <= '0'; 
				saddrw <= '1';
				ramwe <= '0';
				DONE <= '0';
				sstart <= '0';  
				ns <= srstart;
			when srstart =>
				modesel <= '1';
				insel <= '0'; 
				saddrw <= '1';
				ramwe <= '0';
				DONE <= '0';
				sstart <= '1';  
				ns <= srwait;
			when srwait =>
				modesel <= '1';
				insel <= '1';
				saddrw <= '0';
				ramwe <= '0';
				DONE <= '0';
				sstart <= '0';
				if sdone = '1' then
					ns <= serrh;
				else
					ns <= srwait;
				end if;
			when serrh =>
				modesel <= '1';
				insel <= '1'; 
				saddrw <= '0';
				ramwe <= '1';
				DONE <= '0';
				sstart <= '0';  
				ns <= serrl;
			when serrl =>
				modesel <= '1';
				insel <= '0'; 
				saddrw <= '0';
				ramwe <= '1';
				DONE <= '0';
				sstart <= '0';  
				ns <= donestate;
			when macreadwait =>
				modesel <= '0';
				insel <= '0'; 
				saddrw <= '0';
				ramwe <= '0';
				DONE <= '0';
				sstart <= '0';  
				if macreadcnt = "10000" then
					ns <= donestate;
				else
					ns <= macreadwait;
				end if; 
			when others =>
				modesel <= '0';
				insel <= '1'; 
				saddrw <= '0';
				ramwe <= '0';
				DONE <= '0';
				sstart <= '0';  
				ns <= none;	
			end case; 								
	 end process fsm; 
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity spdistram is 
 port (clk : in std_logic; 
 	we  : in std_logic; 
 	a   : in std_logic_vector(5 downto 0); 
 	di  : in std_logic_vector(15 downto 0); 
 	do  : out std_logic_vector(15 downto 0));
 end spdistram; 
 
 architecture syn of spdistram is 
 
 type ram_type is array (63 downto 0) of std_logic_vector (15 downto 0) ; 
 signal RAM : ram_type := (others =>  X"0000"); 
 
 begin 
 process (clk) 
 begin 
 	if (clk'event and clk = '1') then  
 		if (we = '1') then 
 			RAM(conv_integer(a)) <= di; 
 		end if; 
 	end if; 
 end process; 
 
 do <= RAM(conv_integer(a)); 
 
 end syn;
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity serialout is
	port ( CLK : in std_logic;
			 DIN : in std_logic_vector(31 downto 0);
			 DOUT : out std_logic_vector(31 downto 0);
			 ADDR : in std_logic_vector(7 downto 0);
			 SDIN : out std_logic;
			 SDOUT : in std_logic; 
			 SCS : out std_logic; 
			 SCLK : out std_logic; 
			 SAMPLE : out std_logic; 
			 SDONE : out std_logic;
			 SSTART : in std_logic);
end serialout;

architecture behavioral of serialout is
   signal dinl, ldout : std_logic_vector(31 downto 0) := (others => '0');
	signal addrl : std_logic_vector(7 downto 0) := (others => '0');

	signal cnt : integer range 0 to 255 := 0; 
	signal bitcnt : integer range 0 to 40 := 40; 

begin
	process(CLK) is
	begin
		if rising_edge(CLK) then
			dinl <= DIN;
			DOUT <= ldout; 

			addrl <= ADDR; 
			

			if cnt = 255 or SSTART = '1' then
				cnt <= 0;
			else
				cnt <= cnt + 1; 
			end if;
			 

			if SSTART = '1' then
				bitcnt <= 0; 
				SDONE <= '0';
				ldout <= (others => '0');
			else
				if bitcnt = 40 then
					SDONE <= '1';
				else
					if cnt = 255 then
						bitcnt <= bitcnt + 1;
					end if;
				end if;  
			end if; 

			if bitcnt = 0 then
				SCS <= '0';
			elsif bitcnt = 40 then
				SCS <= '1';
			end if; 
			
			if cnt = 0 then
				SCLK <= '0'; 
			elsif cnt = 128 then
				SCLK <= '1';
			end if; 		

			if cnt = 100 then
				if bitcnt >= 0 and bitcnt < 8 then
					SDIN <= addrl(7-bitcnt);
				elsif bitcnt >7 and bitcnt < 40 then
					SDIN <= dinl(39 - bitcnt); 
				end if; 
			end if; 

			if (cnt = 10 ) and (bitcnt > 7) and (bitcnt < 40)	then
					ldout <=   ldout(30 downto 0)  & SDOUT ;
					sample <= '1';
			else
				SAMPLE <= '0';
			end if; 
		end if; 
	end process; 

end behavioral;  
