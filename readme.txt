Okay, this is a generic readme file full of notes and things I have left to do on this design. It's like a pre-changelog, i.e. as things are done here they should be checked in and added to the changelog. This is mainly a collection of notes for this particular section. 

To-do: byte order in memory -- how are we handling this??


General Ethernet Notes:
transmit preamble (10101010) 7 times, LSB (leftmost bit) sent first
meaing, of course, that what we really want to view it as is 01010101 and 11010101 for the SFD (start frame delimieter). The spec is confusing. 


CRC code heavily inspired by xilinx appnote XAPP209, IEEE 802.3 Cyclic Redundancy Check . Also  Nair, Ryan, and Farzaneh, 
2  A symbol based algorithm for hardware implementation of cyclic redundancy check (CRC)
Nair, R.; Ryan, G.; Farzaneh, F.;
VHDL International Users' Forum, 1997. Proceedings , 19-22 Oct. 1997
Page(s): 82 -87

1  Automatic generation of parallel CRC circuits
Sprachmann, M.;
Design & Test of Computers, IEEE , Volume: 18 Issue: 3 , May-June 2001
Page(s): 108 -114

The Frame check sequence is described in IEEE 802.3-2003 section 3.2.8 . We evidently send the MSB-containing byte of the FCS first, and in fact, the MSB first. Meaning the MSB of the FCS is actually the LSB, so we need to do bit-reversal. 
pre-setting the CRCL to FFFFFFFF is the same as complementing the first 32 bits of the input stream, which we need to do. 




We have six main sections here: 


TX_in : input to the TX session from the uP interface
TX_out : system to read packets from memory and push them to the PHY
RX_in : receive section from the phy, gets clock from the PHY
RX_out : system to let the output system clock out packets from memory. 

Memory: 4-way memory controller


Higher-level interface, for things like the collision, etc. It would be smart to design this in from the groud up, no really. But yea, like that's gonna happen. 
   TX light, RX light, Activity, collision, that sort of nonsense. 



TX_OUT ***************************************************************
TX_out calculations:
Okay, we're using the CRC calculation logic from the Nair et. al. paper

System gives correct checksum on the following packets:
60-bytes, all zeros: 0x04128908
DA: 00:00:3F:00:01:00, SA: 00:00:3F:00:00:04, Type:0x0101, rest zeros : 0xD0D5DEE7

However, there are issues with the pipelining of the address incrementing in the main DATABYTE loop causing the ADDR to inc right past the end of the packet. 

Trying to not inc addr if bytecnt < 8... works. Must also be sure to inc addr in CRC3 state. Admittedly, this if trashes our nice clean FSM design, but oh well.

System works, sends out packets of right size, sends new pkt when bp changes. 

FRAMETX  is the status/indicator signal to be used by MAC-wide counters, etc. 





				   