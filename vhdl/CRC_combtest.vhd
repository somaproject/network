library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CRC_combtest is
    Port ( CLK : in std_logic;
           CRC : out std_logic_vector(31 downto 0);
		 DATA : in std_logic_vector(7 downto 0);

		 RESET : in std_logic; 
           CRCN : out std_logic_vector(31 downto 0);
           CRCR : out std_logic_vector(31 downto 0);
           CRCRN : out std_logic_vector(31 downto 0));
end CRC_combtest;

architecture Behavioral of CRC_combtest is
	component crc_combinational is
	    Port ( CI : in std_logic_vector(31 downto 0);
	           D : in std_logic_vector(7 downto 0);
	           CO : out std_logic_vector(31 downto 0));
	end component;

	signal CRCL, CRCi: std_logic_vector(31 downto 0) := (others => '0');

begin

	CRCCMB: crc_combinational port map (
			CI => CRCL,
			CO => CRCi,
			D => DATA);
			 
	process(CLK, RESET) is
	begin
		if RESET = '1' then
			CRCL <= (others => '1');
		else
			if rising_edge(CLK) then
				CRCL<= CRCi;
			end if;
		end if; 



	end process; 

	CRC <= CRCi;
	CRCN <= not CRCi;

	CRCR(0) <= CRCi(31);
	CRCR(1) <= CRCi(30);
	CRCR(2) <= CRCi(29);
	CRCR(3) <= CRCi(28);
	CRCR(4) <= CRCi(27);
	CRCR(5) <= CRCi(26);
	CRCR(6) <= CRCi(25);
	CRCR(7) <= CRCi(24);
	CRCR(8) <= CRCi(23);
	CRCR(9) <= CRCi(22);
	CRCR(10) <= CRCi(21);
	CRCR(11) <= CRCi(20);
	CRCR(12) <= CRCi(19);
	CRCR(13) <= CRCi(18);
	CRCR(14) <= CRCi(17);
	CRCR(15) <= CRCi(16);
	CRCR(16) <= CRCi(15);
	CRCR(17) <= CRCi(14);
	CRCR(18) <= CRCi(13);
	CRCR(19) <= CRCi(12);
	CRCR(20) <= CRCi(11);
	CRCR(21) <= CRCi(10);
	CRCR(22) <= CRCi(9);
	CRCR(23) <= CRCi(8);
	CRCR(24) <= CRCi(7);
	CRCR(25) <= CRCi(6);
	CRCR(26) <= CRCi(5);
	CRCR(27) <= CRCi(4);
	CRCR(28) <= CRCi(3);
	CRCR(29) <= CRCi(2);
	CRCR(30) <= CRCi(1);
	CRCR(31) <= CRCi(0);

	CRCRN(0) <= not CRCi(31);
	CRCRN(1) <= not CRCi(30);
	CRCRN(2) <= not CRCi(29);
	CRCRN(3) <= not CRCi(28);
	CRCRN(4) <= not CRCi(27);
	CRCRN(5) <= not CRCi(26);
	CRCRN(6) <= not CRCi(25);
	CRCRN(7) <= not CRCi(24);
	CRCRN(8) <= not CRCi(23);
	CRCRN(9) <= not CRCi(22);
	CRCRN(10) <= not CRCi(21);
	CRCRN(11) <= not CRCi(20);
	CRCRN(12) <= not CRCi(19);
	CRCRN(13) <= not CRCi(18);
	CRCRN(14) <= not CRCi(17);
	CRCRN(15) <= not CRCi(16);
	CRCRN(16) <= not CRCi(15);
	CRCRN(17) <= not CRCi(14);
	CRCRN(18) <= not CRCi(13);
	CRCRN(19) <= not CRCi(12);
	CRCRN(20) <= not CRCi(11);
	CRCRN(21) <= not CRCi(10);
	CRCRN(22) <= not CRCi(9);
	CRCRN(23) <= not CRCi(8);
	CRCRN(24) <= not CRCi(7);
	CRCRN(25) <= not CRCi(6);
	CRCRN(26) <= not CRCi(5);
	CRCRN(27) <= not CRCi(4);
	CRCRN(28) <= not CRCi(3);
	CRCRN(29) <= not CRCi(2);
	CRCRN(30) <= not CRCi(1);
	CRCRN(31) <= not CRCi(0);
end Behavioral;
