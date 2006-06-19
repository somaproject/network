library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test3 is
   
    Generic ( startdata : in std_logic_vector(31 downto 0) := X"ABCDEF98";	
    		    startaddr : in std_logic_vector(14 downto 0) := (others => '0'));
    Port ( CLK : in std_logic;
           CE : in std_logic;
           WE : out std_logic;
           D : out std_logic_vector(31 downto 0);
           Q : in std_logic_vector(31 downto 0);
           ADDR : out std_logic_vector(14 downto 0);
		 ERR : out std_logic; 
		 RESET : in std_logic);
end test3;

architecture Behavioral of test3 is
-- TEST3.VHD -- Sequential memory write. 

   constant wordcntmax : integer := 32700;
   signal addrcnt: std_logic_vector(14 downto 0) := (others =>'0'); 
   signal datacnt : std_logic_vector(31 downto 0) := (others => '0'); 

   signal cyclecnt: integer range 0 to 31 := 0; 
   signal wordcnt : integer range 0 to 32767 := 10000; 
   signal dl1, dl2, dl3,  ql :  std_logic_vector(31 downto 0) 
   	:= (others => '0'); 

   type states is (none, prewrite, writes, preread, reads);
   signal cs, ns : states := none; 

   signal prereadwait: integer range 0 to 16 := 9; 
begin
	
	ADDR <= addrcnt; 
	D <= datacnt; 

	main: process (CLK, RESET) is
	begin
		if RESET = '1' then
			cs <= none; 
		else
			if rising_edge(CLK) then
			   cs <= ns; 

			   if cs = writes and CE = '1' then
			   	addrcnt <= addrcnt + 1; 
				datacnt <= datacnt + 1;
				wordcnt <= wordcnt + 1;  
			   end if; 

			   if cs = reads and CE = '1' then
			   	addrcnt <= addrcnt + 1; 
				datacnt <= datacnt + 1;
				wordcnt <= wordcnt + 1;  
			   end if; 

			   if cs = preread or cs = prewrite then
			   	addrcnt <= startaddr;
				datacnt <= startdata;
				wordcnt <= 0; 
			   end if; 

			   if CE = '1' then
			   	dl1 <= datacnt; 
				dl2 <= dl1;
				dl3 <= dl2; 
				ql <= Q;  
			   end if; 

			   if cs = writes then
			   	prereadwait <= 12; 
			   elsif cs = preread then
			   	prereadwait <= prereadwait -1; 
			   end if; 

			   if ce = '1' and cs = reads then
			   	if ql /= dl3 then
					err <= '1';
				else 
					err <= '0';
				end if; 
			   end if; 


			end if; 
		end if; 
	end process main;
	
	fsm: process (cs, wordcnt, prereadwait) is
	begin
		case cs is
			when none =>
				ns <= prewrite;
				WE <= '0';
			when prewrite =>
				ns <= writes;
	 			WE <= '0';
			when writes =>
				if wordcnt >= wordcntmax then
					ns <= preread;
				else
					ns <= writes; 
				end if; 
				WE <= '1';
			when preread =>
				-- to prime pipeline for reading comparisons
				if prereadwait = 1 then
					ns <= reads; 
				else
					ns <= preread;
				end if; 
				WE <= '0';


			when reads =>
				if wordcnt = wordcntmax then
					ns <= prewrite; 
				else
					ns <= reads;
				end if; 
				WE <= '0';
			when others =>
				ns <= none; 
				WE <= '1'; 
		end case; 
	end process fsm; 

				 





end Behavioral;
