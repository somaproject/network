library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RXinput_addrchk is
    Port ( CLK : in std_logic;
	 		  RESET : in std_logic; 
           NEWF : in std_logic;
           NEXTB : in std_logic;
           DATA : in std_logic_vector(7 downto 0);
           MACADDR : in std_logic_vector(47 downto 0);
           RXBCAST : in std_logic;
           RXMCAST : in std_logic;
           RXUCAST : in std_logic;
			  RXALLF : in std_logic;
           DESTOK : out std_logic);
end RXinput_addrchk;

architecture Behavioral of RXinput_addrchk is
-- RXINPUT_ADDRCHK.VHD -- code to check whether or not this frame has a valid MAC
-- address. 

	signal macaddrl, datal 
				: std_logic_vector(47 downto 0) := (others => '0');
	signal bcast, mcast, maceq, lbcast, lmcast, lmaceq
			 	: std_logic_vector(5 downto 0) := (others => '0');
	signal validmcast, validucast, validbcast : std_logic := '0';
	signal rxbcastl, rxmcastl, rxucastl, rxallfl : std_logic := '0';
	signal bcastok, mcastok, ucastok : std_logic := '0';

	-- fsm stuff
	type states is (none, byte0, byte1, byte2, byte3, byte4, byte5);
	signal cs, ns : states := none; 


begin

	clock: process(RESET, CLK) is
	begin 
		if RESET = '1' then 
			cs <= none;
		else
			if rising_edge(CLK) then
				cs <= ns; 

				-- inputs
				macaddrl <= mACADDR;
				rxbcastl <= RXBCAST;
				rxmcastl <= RXMCAST;
				rxucastl <= RXUCAST;
				rxallfl <= RXALLF; 

				-- valids
				if bcast = "111111" then
					validbcast <= '1';
				else
					validbcast <= '0';
				end if; 

				if mcast(0) = '1' then
					validmcast <= '1';
				else
					validmcast <= '0';
				end if; 

				if maceq = "111111" then
					validucast <= '1';
				else
					validucast <= '0';
				end if; 

				if bcastok = '1' or mcastok = '1' or ucastok = '1' 
					or rxallfl = '1' then
					DESTOK <= '1';
				else
					DESTOK <= '0';
				end if; 		  

				-- comparisons
				bcast <= lbcast;
				mcast <= lmcast; 
				maceq <= lmaceq; 

				if cs = byte0 then
					datal(47 downto 40) <= DATA;
				end if; 
				if cs = byte1 then
					datal(39 downto 32) <= DATA;
				end if; 
				if cs = byte2 then
					datal(31 downto 24) <= DATA;
				end if; 
				if cs = byte3 then
					datal(23 downto 16) <= DATA;
				end if; 
				if cs = byte4 then
					datal(15 downto 8) <= DATA;
				end if; 
				if cs = byte5 then
					datal(7 downto 0) <= DATA;
				end if; 
			end if; 
		end if;
	end process clock;

	bcastok <= validbcast and rxbcastl;
	mcastok <= validmcast and rxmcastl;
	ucastok <= validucast and rxucastl;

	comparisons: for n in 0 to 5 generate 
	begin
		 lbcast(n) <=  '1' when 
		 		datal(47 - 8*n downto 40 - 8*n) = "11111111" else '0';
		 lmcast(n) <= '1' when 
			   datal(47 - 8*n downto 40 - 8*n) = "00000001" else '0';
		 lmaceq(n) <= '1' when 
			   datal(47 - 8*n downto 40 - 8*n) = 
				macaddrl(47 - 8*n downto 40 - 8*n)
				else '0';
	end generate; 	
	

	fsm: process(NEWF, NEXTB, cs) is
	begin
		case cs is
			when none =>
				if newf = '1' then
					ns <= byte0;
				else
					ns <= none;
				end if; 
			when byte0 =>
				if newf = '1' then
					ns <= byte0;
				else
					if nextb = '1' then
						ns <= byte1;
					else
						ns <= byte0;
					end if;
				end if;
			when byte1 =>
				if newf = '1' then
					ns <= byte0;
				else
					if nextb = '1' then
						ns <= byte2;
					else
						ns <= byte1;
					end if;
				end if;
			when byte2 =>
				if newf = '1' then
					ns <= byte0;
				else
					if nextb = '1' then
						ns <= byte3;
					else
						ns <= byte2;
					end if;
				end if;
			when byte3 =>
				if newf = '1' then
					ns <= byte0;
				else
					if nextb = '1' then
						ns <= byte4;
					else
						ns <= byte3;
					end if;
				end if;
			when byte4 =>
				if newf = '1' then
					ns <= byte0;
				else
					if nextb = '1' then
						ns <= byte5;
					else
						ns <= byte4;
					end if;
				end if;
			when byte5 =>
				if newf = '1' then
					ns <= byte0;
				else
					if nextb = '1' then
						ns <= none;
					else
						ns <= byte5;
					end if;
				end if;
			when others =>
				ns <= none;
		end case;
	end process fsm; 

end Behavioral;
