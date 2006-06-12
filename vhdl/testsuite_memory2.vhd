library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testsuite_memory2 is
    Port ( CLK : in std_logic;
           MD : out std_logic_vector(31 downto 0);
           MQ : in std_logic_vector(31 downto 0);
           MA : out std_logic_vector(15 downto 0);
			  MWE : out std_logic; 
			  ERR : out std_logic; 
           CLKEN : in std_logic);
end testsuite_memory2;

architecture Behavioral of testsuite_memory2 is

-- a second memory implementation, using LFSRs

	signal addrlfsr : std_logic_vector(15 downto 0) := (others => '0'); 
	signal datalfsr : std_logic_vector(31 downto 0) := (others => '0');
	signal laddr : std_logic_vector(15 downto 0) := (others => '0'); 
	signal ldata, datain : std_logic_vector(31 downto 0) := (others => '0');
	signal cnt : integer range 0 to 65580 := 0;
	signal data1, data2, data3, data4, data5 : std_logic_vector(31 downto 0)
				:= (others => '0'); 


	type states is (reading, writing);
	signal cs, ns : states := writing;  
	signal lfsr_rst : std_logic := '0'; 

	signal deq, deql : std_logic_vector(3 downto 0) := (others => '0'); 

begin



	deq(0) <= '1' when datain(7 downto 0) = data4(7 downto 0) else '0'; 
	deq(1) <= '1' when datain(15 downto 8) = data4(15 downto 8) else '0'; 
	deq(2) <= '1' when datain(23 downto 16) = data4(23 downto 16) else '0'; 
	deq(3) <= '1' when datain(31 downto 24) = data4(31 downto 24) else '0'; 
	 
   main: process(CLK) is
	begin
		if rising_edge(CLK) then
			laddr <= addrlfsr;
			ldata <= datalfsr; 
			deql <= deq; 

			
			if clken = '1' then
				 
				if cs = writing then
					MA <= laddr; 
					MD <= ldata;
					MWE <= '1'; 
				elsif cs = reading then
					MWE <= '0';
					MA <= laddr; 
					datain <= MQ;

					data1 <= ldata;
					data2 <= data1;
					data3 <= data2;
					data4 <= data3;  
				end if; 
				
				
				if cs = writing then
					if cnt = 65534 then
						cs <= reading;
						cnt <= 0;
					else
						cnt <= cnt + 1;
					end if; 
					if cnt =0 then 
						lfsr_rst <= '1'; 
					else
						lfsr_rst <= '0';
					end if; 

				else

					if cnt < (65538) then
						cnt <= cnt + 1;
					else
						cnt <= 0;
						cs <= writing; 
					end if; 
					if cnt =0 then 
						lfsr_rst <= '1'; 
					else
						lfsr_rst <= '0';
					end if; 
				end if; 

				if cs = writing then 
					err <= '0';
				else
					if cnt > 6 then
						if not (deql = "1111") then
							err <= '1'; 
						else	
							err <= '0';
						end if; 
					end if; 
				end if; 
							
			end if; 


		end if ;
	end process main; 

	lfsr_clk: process(CLK) is
	begin
		if rising_edge(CLK) then
			if lfsr_rst = '1' then
				addrlfsr <= (others => '0');
				datalfsr <= (others => '0'); 
			else
				if clken = '1' then 
					addrlfsr(0) <= addrlfsr(15) xnor addrlfsr(14) xnor
										addrlfsr(12) xnor addrlfsr(3); 
					addrlfsr(15 downto 1) <= addrlfsr(14 downto 0);

					datalfsr(0) <= datalfsr(31) xnor	datalfsr(21)
										xnor datalfsr(1) xnor datalfsr(0); 
					datalfsr(31 downto 1) <= datalfsr(30 downto 0); 
				end if; 

			end if; 


		end if; 
	end process lfsr_clk; 

end Behavioral;
