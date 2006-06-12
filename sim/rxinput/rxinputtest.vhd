
-- VHDL Test Bench Created from source file rxinput.vhd -- 22:15:00 10/27/2004
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_textio.all; 
use  ieee.numeric_std.all; 
use std.TextIO.ALL; 

ENTITY RXinputtest IS
END RXinputtest;

ARCHITECTURE behavior OF RXinputtest IS 

	COMPONENT rxinput
	PORT(
		RX_CLK : IN std_logic;
		CLK : IN std_logic;
		RESET : IN std_logic;
		RX_DV : IN std_logic;
		RX_ER : IN std_logic;
		RXD : IN std_logic_vector(7 downto 0);
		FIFOFULL : IN std_logic;
		MACADDR : IN std_logic_vector(47 downto 0);
		RXBCAST : IN std_logic;
		RXMCAST : IN std_logic;
		RXUCAST : IN std_logic;
		RXALLF : IN std_logic;          
		MD : OUT std_logic_vector(31 downto 0);
		MA : OUT std_logic_vector(15 downto 0);
		BPOUT : OUT std_logic_vector(15 downto 0);
		RXCRCERR : OUT std_logic;
		RXOFERR : OUT std_logic;
		RXPHYERR : OUT std_logic;
		RXFIFOWERR : OUT std_logic;
		RXF : OUT std_logic
		);
	END COMPONENT;

	SIGNAL RX_CLK :  std_logic := '0';
	SIGNAL CLK :  std_logic := '0';
	SIGNAL RESET :  std_logic := '1';
	SIGNAL RX_DV :  std_logic := '0';
	SIGNAL RX_ER :  std_logic := '0';
	SIGNAL RXD :  std_logic_vector(7 downto 0)
		 := (others => '0');
	SIGNAL MD, MD1, MD2, MD3 :  
			std_logic_vector(31 downto 0);
	SIGNAL MA, MA1, MA2, MA3:  std_logic_vector(15 downto 0);
	SIGNAL BPOUT :  std_logic_vector(15 downto 0);
	SIGNAL RXCRCERR :  std_logic :='0';
	SIGNAL RXOFERR :  std_logic :='0';
	SIGNAL RXPHYERR :  std_logic :='0';
	SIGNAL RXFIFOWERR :  std_logic :='0';
	SIGNAL FIFOFULL :  std_logic :='0';
	SIGNAL RXF :  std_logic :='0';
	SIGNAL MACADDR :  std_logic_vector(47 downto 0)
		 := (others => '0');
	SIGNAL RXBCAST :  std_logic :='0';
	SIGNAL RXMCAST :  std_logic :='0';
	SIGNAL RXUCAST :  std_logic :='0';
	SIGNAL RXALLF :  std_logic :='0';

BEGIN

	uut: rxinput PORT MAP(
		RX_CLK => RX_CLK,
		CLK => CLK,
		RESET => RESET,
		RX_DV => RX_DV,
		RX_ER => RX_ER,
		RXD => RXD,
		MD => MD,
		MA => MA,
		BPOUT => BPOUT,
		RXCRCERR => RXCRCERR,
		RXOFERR => RXOFERR,
		RXPHYERR => RXPHYERR,
		RXFIFOWERR => RXFIFOWERR,
		FIFOFULL => FIFOFULL,
		RXF => RXF,
		MACADDR => MACADDR,
		RXBCAST => RXBCAST,
		RXMCAST => RXMCAST,
		RXUCAST => RXUCAST,
		RXALLF => RXALLF
	);

	RX_CLK <= not RX_CLK after 3.98 ns; 
	CLK <= not CLK after 4 ns; 


	process (CLK) is
	begin
		if rising_edge(CLK) then
			ma3 <= ma2;
			ma2 <= ma1;
			ma1 <= ma;
			
			md3 <= md2;
			md2 <= md1;
			md1 <= md;
			 
		end if;
	end process; 
	-- memory data checking:

	memdata : process is
		file memfile : text;
		variable L: line; 
		variable bpl : std_logic_vector(15 downto 0)
			:= (others => '0'); 
		type ramtype is array(2**16-1 downto 0) of integer ; 
		variable ram : ramtype := (others => 0); 
		variable memdata : std_logic_vector(31 downto 0)
			:= (others => '0'); 
	begin
		RESET <= '0' after 40 ns; 
		RXALLF <= '1'; 
		file_open(memfile, "ram.0.dat", read_mode); 
		while not endfile(memfile) loop
			wait until rising_edge(CLK); 
			while MD /= md1  or md1 /= md2 or md2 /= md3 
				 or MA /= ma1 or ma1 /= ma2 or ma2 /= ma3  loop
				wait until rising_edge(CLK);
			end loop; 
			-- write the data
			ram(to_integer(unsigned(MA))) := to_integer(signed(MD));
			if bpl /= BPOUT then -- there's been a write; let's check!
				readline(memfile, L);
				while bpl /= BPOUT loop	
					hread(L, memdata); 
					assert memdata = std_logic_vector(to_signed(ram(to_integer(unsigned(bpl))), 32)) 
						report "Error in ram data"
						severity error; 

					-- yea, this is ugly, but it works
					bpl := std_logic_vector(to_unsigned(
							((to_integer(unsigned(bpl)) + 1) mod 65536), 16)); 

				end loop; 
			end if; 
		end loop;
		file_close(memfile); 

		RESET <= '1'; 
		wait for 40 ns; 
		RXALLF <= '0';
		RXUCAST <= '1';
		RXBCAST <= '1';
		RXMCAST <= '1';
		MACADDR <= X"C0FFEEC0FFEE"; 
		RESET <= '0'; 
		file_open(memfile, "ram.1.dat", read_mode); 
		while not endfile(memfile) loop
			wait until rising_edge(CLK); 
			while MD /= md1  or md1 /= md2 or md2 /= md3 
				 or MA /= ma1 or ma1 /= ma2 or ma2 /= ma3  loop
				wait until rising_edge(CLK);
			end loop; 
			-- write the data
			ram(to_integer(unsigned(MA))) := to_integer(signed(MD));
			if bpl /= BPOUT then -- there's been a write; let's check!
				readline(memfile, L);
				while bpl /= BPOUT loop	
					hread(L, memdata); 
					assert memdata= std_logic_vector(to_signed(ram(to_integer(unsigned(bpl))), 32))
						report "Error in ram data"
						severity error; 

					-- yea, this is ugly, but it works
					bpl := std_logic_vector(to_unsigned(
							((to_integer(unsigned(bpl)) + 1) mod 65536), 16)); 

				end loop; 
			end if; 
		end loop;
		file_close(memfile); 
		
		assert false
			report "End of simulation"
			severity failure;   
	end process memdata; 

 
END;
