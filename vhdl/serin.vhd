library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity serin is
    Port ( CLK : in std_logic;
           CLKEN : in std_logic;
           CLKIN : in std_logic;
           DIN : in std_logic;
			  RESET : in std_logic; 
           NEWFRAME : out std_logic;
           DOUT : out std_logic_vector(63 downto 0));
end serin;

architecture Behavioral of serin is
-- SERIN.VHD  -- serial input section of serial control interface
-- 

	signal CLKIN1, CLKIN2, DIN1, DIN2 : std_logic := '0';
	type states is (none, sbit2, sbit3, sbit4, tempce, chkcnt, ebit1, ebit2, ebit3, ebit4, latch, newfrm);
	signal cstate, nstate : states := none;
	signal shift, dinl, latchce, tmpce : std_logic; 
	signal temp, data : std_logic_vector(63 downto 0);
	signal bitcount : integer range 64 downto 0 := 0; 

begin

	-- general signals
	DINL <= DIN2;
	SHIFT <= (not CLKIN2) AND (CLKIN1);
	DOUT <= DATA;


	-- main clock FSM; 
	clock: process(CLK, RESET, CLKIN, DIN, CLKEN, cstate, nstate, latchce, tmpce, temp) is
	begin
		if reset = '1' then 
			cstate <= none;
		else
			if rising_edge(CLK) then
				if clken = '1' then
					-- here's where we actually get our clock signal. 
					
					-- general latch things
					CLKIN1 <= CLKIN;
					CLKIN2 <= CLKIN1; 
					DIN1 <= DIN;
					DIN2 <= DIN1; 

					if tmpce = '1' then
						TEMP <= TEMP(62 downto 0) & DINL;
					end if; 
				
					if latchce = '1' then
						DATA <= TEMP;
					end if; 
				
					-- FSM-related stuff
					cstate <= nstate; 		
					if cstate = none then 
						bitcount <= 64;
					elsif cstate = tempce then
						bitcount <= bitcount - 1;
					end if;
				end if;
			end if;
		end if; 
	end process clock; 

	fsm: process(cstate, SHIFT, DINL, bitcount) is
	begin
		case cstate is 
			when none =>
				tmpce <= '0';
				latchce <= '0';
				NEWFRAME <= '0';
				if shift = '1' and dinl = '1' then
					nstate <= sbit2;
				else
					nstate <= none;
				end if;
			when sbit2 =>
				tmpce <= '0';
				latchce <= '0';
				NEWFRAME <= '0';
				if shift = '1' then
					if dinl = '0' then
						nstate <= sbit3;
					elsif dinl = '1' then
						nstate <= none;
					end if;
				else
					nstate <= sbit2;
				end if;
			when sbit3 =>
				tmpce <= '0';
				latchce <= '0';
				NEWFRAME <= '0';
				if shift = '1' then
					if dinl = '1' then
						nstate <= sbit4;
					elsif dinl = '0' then
						nstate <= none;
					end if;
				else
					nstate <= sbit3;
				end if;
			when sbit4 =>
				tmpce <= '0';
				latchce <= '0';
				NEWFRAME <= '0';
				if shift = '1' then
					if dinl = '0' then
						nstate <= chkcnt;
					elsif dinl = '1' then
						nstate <= none;
					end if;
				else
					nstate <= sbit4;
				end if;
			when chkcnt =>
				tmpce <= '0';
				latchce <= '0';
				NEWFRAME <= '0';
				if bitcount = 0 then
					nstate <= ebit1;
				else
					if shift = '1' then
						nstate <= tempce;
					else
						nstate <= chkcnt;
					end if;
				end if; 
			when tempce =>
				tmpce <= '1';
				latchce <= '0';
				NEWFRAME <= '0';
				nstate <= chkcnt;
			when ebit1 =>
				tmpce <= '0';
				latchce <= '0';
				NEWFRAME <= '0';
				if shift = '1' then
					if dinl = '1' then
						nstate <= ebit2;
					elsif dinl = '0' then
						nstate <= none;
					end if;
				else
					nstate <= ebit1;
				end if;
			when ebit2 =>
				tmpce <= '0';
				latchce <= '0';
				NEWFRAME <= '0';
				if shift = '1' then
					if dinl = '1' then
						nstate <= ebit3;
					elsif dinl = '0' then
						nstate <= none;
					end if;
				else
					nstate <= ebit2;
				end if;
			when ebit3 =>
				tmpce <= '0';
				latchce <= '0';
				NEWFRAME <= '0';
				if shift = '1' then
					if dinl = '0' then
						nstate <= ebit4;
					elsif dinl = '1' then
						nstate <= none;
					end if;
				else
					nstate <= ebit3;
				end if;
			when ebit4 =>
				tmpce <= '0';
				latchce <= '0';
				NEWFRAME <= '0';
				if shift = '1' then
					if dinl = '1' then
						nstate <= latch;
					elsif dinl = '0' then
						nstate <= none;
					end if;
				else
					nstate <= ebit4;
				end if;
			when latch =>
				tmpce <= '0';
				latchce <= '1';
				NEWFRAME <= '0';
				nstate <= newfrm;
			when newfrm =>
				tmpce <= '0';
				latchce <= '0';
				NEWFRAME <= '1';
				nstate <= none;
			when others =>
				tmpce <= '0';
				latchce <= '0';
				NEWFRAME <= '0';
				nstate <= none;
		end case; 
	end process fsm; 





			




end Behavioral;
