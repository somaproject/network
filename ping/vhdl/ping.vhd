library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ping is
    Port ( CLKIN : in std_logic;
	 		  RESET : in std_logic; 
           CLKOUT : out std_logic;
           DIN : in std_logic_vector(15 downto 0);
           DINEN : in std_logic;
           NEXTFRAME : out std_logic;
           DOUT : out std_logic_vector(15 downto 0);
           NEWFRAME : out std_logic);
end ping;

architecture Behavioral of ping is
-- PING.VHD -- a simple ping-server, designed to talk to the GigE MAC
-- and respond to pings < 3kB in size. 

   -- address signals
	signal ail, ao, aol, ai, a0, a1 : 
			std_logic_vector(10 downto 0) := (others => '0');
   signal we, we0, we1 : std_logic := '0';

	signal bufout0, bufout1, ldout, lldout, dinl : std_logic_vector(15 downto 0) 
				:= (others => '0');
   signal bufin : std_logic_vector(15 downto 0) := (others => '0'); 

	-- buffer toggle
	signal bsel : std_logic := '0';

	signal lnextframe, lnewframe : std_logic := '0'; 
	-- counter

	signal dinenl : std_logic := '0';
	signal txdone : std_logic := '0'; 
	
	-- comparison registers
	signal macl, macm, mach, ipproto, icmp : std_logic_vector(15 downto 0)
			:= (others => '0');

	signal macleq, macmeq, macheq, ipprotoeq, icmpeq : std_logic := '0';
	signal inlen, outlen : std_logic_vector(15 downto 0) := (others => '0');

	signal validpkt : std_logic := '0';


	-- fsms

	type states_rx is (none, readf, validp, waitb, swapb); 
	type states_tx is (none, sendf, pktdone); 

	signal tcs, tns : states_tx := none;
	signal rcs, rns : states_rx := none; 

	-- clocking
	signal clk : std_logic := '0'; 


	component rambuffer is
	    Port ( CLK : in std_logic;
		 		  RESET : in std_logic; 
	           DIN : in std_logic_vector(15 downto 0);
	           DOUT : out std_logic_vector(15 downto 0);
	           WE : in std_logic;
	           ADDR : in std_logic_vector(10 downto 0));
	end component;
begin

	ram0 : rambuffer port map (
			CLK => clk,
			RESET => RESET,
			DIN => bufin,
			DOUT => bufout0,
			WE => we0,
			ADDR => a0); 

	ram1 : rambuffer port map (
			CLK => clk,
			RESET => RESET,
			DIN => bufin,
			DOUT => bufout1,
			WE => we1,
			ADDR => a1); 


	-- making clocks

   clk<= clkin; 

	clock: process(clk, RESET) is
	begin
	   if RESET = '1' then
		   tcs <= none;
			rcs <= none; 
		else
		   if rising_edge(clk) then 
				rcs <= rns;
				tcs <= tns; 

				-- IO signals
				dinl <= DIN;
				NEXTFRAME <= lnextframe;
				dinenl <= DINEN;
				NEWFRAME <= lnewframe; 
				bufin <= dinl;

				-- this is some pretty serious stuff
				if aol = "00000010001"	then 
					DOUT <= not ((not ldout) - X"0800"); 
				else
					DOUT <= ldout; 
				end if; 

				if bsel = '1' then
					ldout <= bufout1;
				else
					ldout <= bufout0;
				end if; 



				-- comparison registers:
				if dinenl = '1' and ai = "00000000001" then
					macl <= dinl;
				end if; 
				if dinenl = '1' and ai = "00000000010" then
					macm <= dinl;
				end if; 
				if dinenl = '1' and ai = "00000000011" then
					mach <= dinl;
				end if; 
				if dinenl = '1' and ai = "00000000111" then
					ipproto <= dinl;
				end if; 
				if dinenl = '1' and ai = "00000001101" then
					icmp <= dinl;
				end if; 

				if macl = X"C0FF" then 
					macleq <= '1';
				else
					macleq <= '0';
				end if; 
				if macm = X"EE01" then 
					macmeq <= '1';
				else
					macmeq <= '0';
				end if; 
				if mach = X"0203" then 
					macheq <= '1';
				else
					macheq <= '0';
				end if; 
				if ipproto = X"0800" then 
					ipprotoeq <= '1';
				else
					ipprotoeq <= '0';
				end if; 
				if icmp(7 downto 0) = X"01" then 
					icmpeq <= '1';
				else
					icmpeq <= '0';
				end if; 


				-- register lengths
				if rcs = none then 
					inlen <= (others => '1');
				else
				   if dinenl = '1' and ai = "00000000000" then
						inlen <= dinl;
					end if;
				end if ;

				if aol = "00000000000" then
					outlen <= ldout; 
				end if; 


				-- counters
				if rcs = none then
				   ai <= (others => '0');
				else
				   if dinenl = '1' then
					   ai <= ai + 1;
				 	end if; 
				end if; 

				if tcs = none then 
					ao <= (others => '0');
				else
					if lnewframe = '1' then
						ao <= ao + 1;
					end if;
				end if; 

				-- swap buffers
				if rcs = swapb then
					bsel <= not bsel;
				end if; 

				-- tx ao lookup
				case ao is 
					when "00000000001" => aol <= "00000000100"; -- MAC SRC L 
					when "00000000010" => aol <= "00000000101"; -- MAC SRC M 
					when "00000000011" => aol <= "00000000110"; -- MAC SRC H
					when "00000000100" => aol <= "00000000001"; -- MAC DEST L 
					when "00000000101" => aol <= "00000000010"; -- MAC DEST M
					when "00000000110" => aol <= "00000000011"; -- MAC DEST H
					when "00000001110" => aol <= "00000010000"; -- IP SWAP
					when "00000001111" => aol <= "00000010001"; -- IP SWAP
					when "00000010000" => aol <= "00000001110"; -- IP SWAP
					when "00000010001" => aol <= "00000001111"; -- IP SWAP

					when others => aol <= ao; 
				end case; 


				-- check for packet validity
				if macleq = '1' and macmeq = '1' and macheq = '1' and
						ipprotoeq = '1' and icmpeq = '1' then 
					validpkt <= '1';
				else
					validpkt <= '0';
				end if; 

				ail <= ai; 
				we <= dinenl; 

			end if; 
		end if; 
	end process clock;

	-- ram input muxes
	a0 <= ail when bsel = '0' else
			aol; 
	a1 <= aol when bsel = '0' else
			ail;

	we0 <= we when bsel = '0' else '0';
	we1 <= '0' when bsel = '0' else we; 

	

	-- fsm for input

	fsmin : process(rcs, ai, txdone, inlen, validpkt) is
	begin
	   case rcs is 
			when none => 
				lnextframe <= '0';
				rns <= readf;
			when readf => 
				lnextframe <= '1';
				if ai = inlen then 
					rns <= validp;
				else
					rns <= readf;
				end if;
			when validp => 
			 	lnextframe <= '0';
				if validpkt = '1' then
					rns <= waitb;
				else
					rns <= none;
				end if;
			when waitb => 
				lnextframe <= '0';
				if txdone = '1' then
					rns <= swapb;
				else
					rns <= waitb;
				end if;
			when swapb =>
				lnextframe <= '0';
				rns <= none;
			when others =>
				lnextframe <= '0';
				rns <= none;
		end case; 
	end process fsmin; 
	
		
	fsmout : process(tcs, rcs, ao, outlen) is
	begin
	   case tcs is
			when none =>
				txdone <= '1';
				lnewframe <= '0'; 
				if rcs = swapb then
					tns <= sendf;
				else
					tns <= none;
				end if; 	 
			when sendf =>
				txdone <= '0';
				lnewframe <= '1';
				if ao = outlen then
					tns <= pktdone;
				else
					tns <= sendf;
				end if;
			when pktdone =>
				txdone <= '0'; 
				lnewframe <= '0';
				tns <= none;
			when others => 
				txdone <= '1';
				lnewframe <= '0';
				tns <= none;
		end case;
	end process fsmout; 

						
end Behavioral;
