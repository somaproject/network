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

Concerns  / things to test / do:
1. what about the counters? how are we implementing them? 
2. what happens when the



TX_OUT ***************************************************************
TX_out calculations:
Okay, we're using the CRC calculation logic from the Nair et. al. paper

System gives correct checksum on the following packets:
60 bytes, all zeros: 0x04128908
DA: 00:00:3F:00:01:00, SA: 00:00:3F:00:00:04, Type:0x0101, rest zeros : 0xD0D5DEE7

However, there are issues with the pipelining of the address incrementing in the main DATABYTE loop causing the ADDR to inc right past the end of the packet. 

Trying to not inc addr if bytecnt < 8... works. Must also be sure to inc addr in CRC3 state. Admittedly, this if trashes our nice clean FSM design, but oh well.

System works, sends out packets of right size, sends new pkt when bp changes. 

ADDRL is there so that the decsiion to start sending a packet (addrl=BPL) has an extra register layer, to meet timing constraints. 

TXF : frame was successfully transmitted. high on the falling-low transition of TXEN. 
c
3 oct 2003: BCNTL pipeline created to solve some timing issues. 

----------------------------------------------------------------------
TX INPUT
----------------------------------------------------------------------
NEWFRAME is kept high for the entire transmission duration of a frame, which is prefaced with the length in bytes. 

We read in n bytes, based on what the header says, and westop reading once we've gotten that many bytes. 

the input 16-bit interface always has the first byte on the wire placed, well, first. That is, for a signal Data[15:0], the byte DATA[15:8] was transmitted BEFORE the byte DATA[7:0]

Since the input clock is on the order of 60 MHz or less, we use a system like that outlined to work across async boundaries. 

Test:
simple 8-byte frame : (pass, 20030921)
simple 10-byte frame: (pass, 20030921)
8-byte frame with len=8 but NEWFRAME high for an extra clock cycle (pass, 20030921)



TXFIFOWERR : transmit fifo write error : the fifo was full! A separate state, generated by the FSM. 



RX_IN *****************************************************************
We'll need to check the CRC, make sure there are no errors, that sort of thing. 

File organization: 
   RXinput_GMII : pre-fifo side, running off the RX_CLK
   RXinput_memio : post-fifo side, running off the internal clock
   RXinput_FIFO : the fifo itsel


FIFO concerns: Peter's response to xilinx patent concerns on usenet is less than encouraging, but it's not like this code will ever be run on a non-xilinx FPGA, anyway, and time is of the essence. 

We need to deal with packet overrunns. A 1% difference in clocks (which we will assume is the absolute worst-case scenario, because I mean, jesus, that's one at 125 MHz and one at 126 MHz) will produce 90 bytes of difference on a 9k jumbo frame. That could be a lot. Not that we'll ever get data at that rate, but whatever. 

and 1% is a pretty big asymmetry. 

But this means we'll need to put at least 1 bit past the 8 in the fifo, suggesting the BlockSelect+ solution will be 16x256. 

RX_DV
RXD[7:0]
RX_ER
RX_OF

where the first three are their real GMII signals

when the incoming side tries to put data in the nearly-full FIFO, it will set the RX_OIF (overflow) bit and then stop putting in data for the remainder of the frame. 

We do this without a state machine by having a fifo CE pin that's set and reset, and ORed with the set signal. Let RX_DVL be  RX_DV one cycle before, i.e. the registered version. SET = RX_DV and (not RX_DVL), i.e. SET is high when RX_DV is high and wasn't high before. 

Now, SET and RSET are input to a set-reset latch, which obeys reset before set. CE is actually the output of this latch ORed with SET, such that the first cycle where RX_DV is high is succesfsully recorded. 

RST = (not RX_DV) or RX_ER or RX_OF. This results CE going low the cycle after a low RX_DV, or the cycle after a high RX_ER or RX_OF, is detected. This way, those signals can select the DATA mux. 

Tests (9/29/03): 
  behavioral test for set of inputs successfully aborts entry into FIFO following
  error condition


To make timing constraints a bit better, we registered all inputs to and outputs from the FIFO. Since we don't really care about the 3/4 full signal (we're playuing it safe) having the system respond a tick later isn't a big deal. 

10 Oct 2003: so, when we throw bytes and bytes and bytes at it, unfortunately, the fifo in the RX_input side overflows, with quite a degree of periodicity, in fact. Need to correct... but how?
    Well, it looks like this is essentially an artifact of the RX_input_memio requiring n+c ticks for each n-byte frame. Thus, actually, for longer frames, this is less of an issue. 

----- on the other side of the FIFO

Outputs: 
MA, MD (must be constant for 4 ticks, yadda yadda)
BPOUT: curent base-pointer out, for the next TX_in

Okay, here, we need to deal with putting the packet into memory and checking the FCS and ditching the preamble. We just want to put the actual data packet into memory. 

If there's a "CEEN line" that, when high, allows a high on DRDY to cause a high on CEOUT, then we can both detect the new byte and read it in in a single state transition. 


The SFD can let us transition from the none state, because the SFD 1. marks the start of the packet, and 2. will never be the last data byte at the end of a packet. 
    What if we get a frame that doesn't have a SFD? 
       as we go through the bytes, we will encounter a byte == the SFD, 
       and the FSM will begin writing in bytes. But in this case, the checksum won't match, and the packet will be aborted or, as we go through the bytes, we never get a byte == the sfd, and we just continue to stay in the NONE state. 

I believe if you CRC over the entire frame, including the CRC, you end up with a constant value to let you know if the frame is good or not

This design is somewhat complicated. Basically, once you've read a byte that contains an end of frame bit, it disables the CRCEN. This is starting to get pretty complicated. Unfortuantely, this locks the system into a no-new-bytes situation, hence CEFORCE=1 in the none state, such that we will get the new bytes.       

We've simplified the FSM quite a bit. Since all byte-write states (BYTE0-BYTE3) might occur multiple times (since it's possible that we're waiting on the FIFo, and thus BRDY=0) we have created a MEMDELTA signal. This signal is only high when MEN is high and MEN was low the cycle before; i.e. it's the first temporal derivative of MEN. 

This allows multiple things. First, it allows us to have MEN=1 in BYTE0 and not worry about multipel increments of MA.

Second, by keeping MEN high at the end of a cycle (through NONE), we prevent the first BYTE0 of actually causing a memory write. This guarantees that previous MA/MD (from writing the BP for the last frame) will be stable for 4 ticks, guaranteeing their validity. 

4 Sept 2003: Memio bugs fixed by throwing extra registers at problem. Behavioral simulation appears to work. 


Because timing is so tight with the fifo (what were you thinking, xilinx?) we're going to have to graft on some logic to deal. 

I've called it the RX Input FIFO interface, or RXinput_FifoIO.vhd. It's a little bit complicated, but basically you use the existence of the invalid bit to let you graft onto the fIFO some registering logic. 

The D3-D0 registers start out with their invalid bits set. Since the output of DINL lags CE to such a degree, we use D0 - d3 to store the sequence output. 

This is all due to the fact that the registering of the FIFO output introduces a lag. Thus, say, CE is high for four ticks before we get our first byte. Now, say ten bytes later, we get an end of frame byte. We'd like to be able to immediately stop the FIFO's production of data, but we can't: it's pipelined. So the D3-D0 registers essentially store the output from the pipeline. 

we've combined all of This into a rxinput_fifo file, which now actually contins the FIFO coregen and the auxillary FIFO control. Now, the interesting part is that this design assumes that you keep CE low for four ticks between having it go high. This will require some creative FSM modification. 

Wed 3 September 2003: RXinput_fifo appears to work with behavioral simulation.
Tues 30 September 2003 : Problems from switching ISE/modelsim versions, resulting in there being "issues" with the fifo-full case. 



24 Sepember 2003: So, there are problems with bcnt, for situations where there is only a single tick between RX_DVs (i.e. the fastest possible rate of incoming packets) that results in MACCNT not counting correctly. Basically, we were depending on the ENDF staying high (and thus BRDY Staying low) until we started the next packet. However, this means that our CE logic is more complicated. So, we simply gate the bcnt on both ce and brdy. 

To avoid writing the 4 checksum bytes, we simply subtract 1 from the BP when we write it (and subtract 4 from the BCNT. 


3 October 2003: It's really hard to synthesize using ISE 6 with the damn CRC. So I'm going to try and pipeline the inputs and insert an extra receive state. 

We've created CRCRST, CRCEN as registered signals for the CRCL register. Go pipelining! We're also using CRCEQUAL to check . This requires us adding two states to our fsm. 

MAC address filtering -- 
We have RXBCAST, RXMCAST, and RXUCAST, which says we want to receive broadcast, multicast, and unicast packets, respectively. MACADDR is an input...

Broadcast has FF:FF:FF:FF:FF:FF as a destiation
Multicast has 01:* as a destination



--


--------------------------------------------------------------------------
RXoutput
--------------------------------------------------------------------------
Signals: 
NEXTFRAME
DOUTEN
DOUT

The RXoutput side runs off the slower clock on the RX side, and is 16-bits
wide. 

The transition of NEXTFRAME from low-to-high signals that the receiving side is ready for the next frame. This system should be reentrant, i.e. 
    When NEXTFRAME goes low, the MAC will stop sending data, and will abort
    transmission of the current packet. 
    The next time NEXTFRAME goes high, the MAC must start sending the next
    frame. 

The MAC places DOUTEN high when there is a valid frame word on the data lines. 

Each frame is transmitted with it's lenth in bytes first. It's up to the receiver to count the incoming bytes and know when to deassert NEXTFRAME. It's not like i'm going to do _all_ the work here. 

We'll have two signals related to NEXTFRAME on the pre-fifo side, the NFDELTAP and NFDELTAN for positive NEXTFRAME transitions and negative (high-to-low) NEXTFRAME Transitions. 

Since the FIFO may become full during this time (if the output clock is really slow) we need to pause... how to do that? 

what if FIFO_FULL signal disabled INCing the MAC and disabled writing the FIFO... it would effectively be a "pause". Problems are the pipelining.

So, we're going to have a FIFO_full and a FIFO_NEARFULL signal. FIFO_FULL will put the FSM into a nop mode, and it will only return to clocking in bytes when FIFO_NEARFULL goes back to 0. 

testing: the input pattern here is so complicated, and I'm so impatient, that I'm just going to code up the main system and deal with this later. 

Note that the addition of the length to the BP to get the next BP is not going to be too tolerant of error. 
We round LEN such that XX01, XX10, XX11 all get rounded to XX00+100. 

This way a len of one, two, or three counts as a full word for adding to the BP




----------------------------------------------------------------------------
FIFO OVERFLOW PROTECTION
----------------------------------------------------------------------------
If the current BP is less than 2*MAXFRAME bytes behind the feedback BP, don't update our BP. 

So, something is putting data into the FIFO, and it could write up to 16384 bytes, but then if there's less than enough space for two frames, it won't update its base poniter, so the next frame will simply overwrite the previous one. 

Why not just not-update if the FBPB is less than 1 MAXFRAME ahead? Because if the FB is less than 1 MAXFRAME ahead of our BP, and we write in a frame of length MAXFRAME, we will OVERWRITE THE BASE OF THE NEW FRAME, which is bad. 

Plus, it's easy to make these modifications. 

So now all those things that write the FIFO (i.e. anything with *INPUT) has a FIFO full line, which is high. 

There is lots of pipelining in here :)



----------------------------------------------------------------------------
Management Inteface
----------------------------------------------------------------------------
AD: Signal:	Generated by:  Meaning:
10  RSTCTR		       Reset counters, per bits. 
11  TXF		TXoutput	A frame was successfully transmitted 
12  RXF		RXinput		A frame was successfully received
13  TXFIFOWERR	TXinput		TX (memory) FIFO write error
14  RXFIFOWERR	RXinput		RX (memory) FIFO write error 
15  RXPHYERR	RXinput		RX phy error, caused by PHY asserting RX_ER
16  RXOFERR	RXinput		RX small async fifo overflow
17  RXCRCERR	RXinput		RX valid packet received with bad checksum

00  No Op (returns 0x01234567)
01  Reset PHY 
    Reset phy uses an 8-bit counter that resets to 255 and then counts down to 0. While it is not zero, PHYRESET is high, thus we hold the reset pin low for 255 ticks of the slower clock. 
02 PHYSTAT
03 no op (returns 0x89ABCDEF)
04 address out debug
05 memory in debug
06 rx buffer pointer and rx feedback bp
07 tx buffer pointer and tx feedback bp


 We also have the:
08 PHY address register (write)
09 PHYDI data in register
0A PHYDO data out register

So, the lower 5 bits of ADR is the address we're trying to read to or write from, and the 6th bit is whether it's a read or a write. The 31st bit is the status. When it goes high, the most recent transaction is complete. The read of ADDR when the status bit is high will clear it. 

Note that this means you should (for a write) WRITE the PHYDO register with the data you want to transmit, and then write the ADDR. To read, you write the ADDR register, then continue to read ADDR until the status bit goes high, at which point the data in PHYDI is valid. 


and then we have (maybe someday) settings related to MAC address filtering
19 ALLF	    1 if we wish to receive all packets (default 1)
1A RXBCAST  1 if we wish to receive broadcast packets
1B RXMCAST  1 if we wish to receive multicast packets
1C RXUCAST  1 if we wish to receive unicast packets
1D MACADDR1 bottom 16 bits of MAC address
1E MACADDR2 middle 16 bits of MAC address
1F MACADDR3 top 16 bits of MAC address



This interface is basically FSM-free. We sample the incoming clock and try and detect whether it's gone from low-to-high or not, as indicated by SCLKDELTA. Things are pretty heavily pipelined, if only to help deal with potential metastability issues. 

All data is sent MSB first

At some point in the past I thought that we could use multiple clkdlls and BUFGs to run this at a divided clock. But, unforutnately, that isn't possible because it appears that there are placement issues due to the way the PCB is layed out. This means that the solution will involve a slowed clock-enable and a multi-cycle timing constraint. 

So, now the relevant error signals set a SR flip-flop that then increments the counter on the next cycle. 

We need to enable autonegotation, as 1000mbit manual mode isn't actually supported by the IEEE spec (from NS DP83865 Data sheet).



For MII interface portion: 
   The MDCCNT line is a 6 -bit counter whose top bit is used as the (registerd) MDC clock,a nd which is enabled by MDCEN. At 33 MHz, this is a .5 MHz clock, which is nice. a delta detector is placed on this signal to generate a clken when the MDC transitions from high to low. This will, in part, drive the FSM. SHIFTEN is derived the same way, but is high on the rising edge of the clock. 

   SIN, SOUT, and STS are the input, output, and tristate control pins for the tristate buffer control of MDIO

The FIRSTINC state is necessary such that the statecnt counter will have advanced past zero, so we can get a full 64-ticks out of this.

For controlling the MII interface portion:
    We periodically read 
       1000BASE-T Extended Status Register (1KSCR)	at 0x0F
       Link and Autonegotionat Status Reg  (LINK_AN)    at  0x11
    and put those results into PHYSTATUS
    
    we have a FSM that reads the 1KSCR register, then reads the RAEDLINKW register, then checks to see if the PHYADDR has been written recently (i.e. if phy addr write set (PHYADDRWS) =1). If so, we go to the MII IO section, where we use the inputs from the level above to query the phy and do related stuff. 
    
    

For 100, 1000, DPX: we get those LEDs from the relevant status lights in the PHYSTAT register

TXF, RXF : driven by counters, which are reset to FOO and coutdown to 0. LEDTX, LEDRX are off when those counters are zero. 

Thing
============================================================================
TO DO / things to debug and test

FIFO overflows, fifos overwriting each other, etc. Both in the ZBT sram
and the various clock-boundary FIFOs

System status interface -- how do we read all those counters, etc. 

MAC booting, etc. via the stupid physical layer I2C interface thing

Testing modes... 
   Something that just spits out 1024-byte frames to a given MAC
   
----------------------------------------------------------------------------
Overview notes
----------------------------------------------------------------------------
Trying to rename large numbers of signals so that there's some sort
of overall common naming scheme. Go refactoring!!!

Net result is network.vhd

We need feedback signals so that the *inputs don't overwrite the fifo, but this is difficult to implement. Since our buffer size is 256 kB, and we'd like to allow for a maximum frame size of 16384 bytes, or 16 frames of this size in the buffer. Wow, suddenly that doesn't seem like so much. Anyway, we're going to kill two of those such that we can implement the following overflow protection scheme:

Connector notes:
Switching to Molex, series 71660/71661

71161-2068 right-angle plug connector, 68-connector
15-92-1468 vertical receptical connector, 68-pin
for the dev board
87552-0681 right-angle recepticale connector, 68 pin (samples from molex)


--------------------------------------------------------------------------
Simulation testing, etc. 
--------------------------------------------------------------------------
Right now, 20 us into the simulation using any of the physical ones,
we start getting XXXX propagation errors. Disabling global X propagation
didn't turn it off. Uggh. This suggests (drumroll) that maybe the problem
isn't wrt setup/hold times?

New, be-all-end-all test vector setup: -- test all proper functioning of the system:

Things to care about:
MAC address filtering
CRC error rejection
encoding of data
serial interface
MII interface...
			   different_ clocks
receive 300 1024-byte packets, and see if we get an expected number of RXFIFOW errors. 
Add in some PHY errors, some CRC errors


there's a be-all, end all set of test vectors:
packets destined for UCAST, MCAST, BCAST
phyerr packets
crcerr packets

ideally, it's one file, i call it the ubervector

packet sizes from 40 to 9000 bytes


FRAME LEN PHYERRORLOC CRCERRCNT DATA



here's the deal: one file, pass it through three times:
first, just with the ucast set
then with mcast set
then with bcast set

the vector will have :
frames from random sources
frames from mcast addresses
frames from bcast addresses
frames with crc errors
frames with rx_er errors

We make this vector using frames.pl and editing the dest_mac; 


we are changing the format of frames
frame_filter: cat in a bunch of frames, only return those that
   are broadcast
   are mcast
   are ucast
   have no phy errors
takes a new frame format 

randomize macs with addresses via
perl -e '@a = <>; print splice @a, rand @a, 1 while @a' file1 file2 > file3; 

Note that, on PCB, the symbol for C18 is reversed, so the screened component outline is reversed. 

Pullup resistors between magnetics and PHY are correct size. 

I just don't understand what's left to be wrong. Going to try tying the JTAG pins to the TRST 2k-ground pulldown. 

IT WORKS! IT WORKS IT WORKS !!!!!!!!!!!!!!!!

You need to clear the "isolate" bit in PHY register zero. 

Attempts to debug why we can't read the actual packets...

17 November 2003: Signal integrity issues:

So, we're at the point where it looks like memory read errors are going to force us to 


8 December 2003: A New Hope
  So, I have the new board, and it passes all the memory checks I can throw at it. The question is, then, why the heck isn't it working?
We still get the same "TX loop" errors when we try to transmit, where any attempt to transmit a frame causes the system to start transmitting and never stop. 

This really strongly suggests a memory error. I just wish I had the skill to know of what kind, or how to debug it. Well, and I wish I understood how, if this really is a memory error,it manages to pass all the other memory tests. 

So, hmm, I'm running out of options. And this design doesn't synthesize for shit. 

To solve this, I am creating a "memdebug" module, that will let me use the MAC serial interface to read and write from ram, when it's enabled. 

A simple design, really :) I say that a lot. 

For any particular segment or section, I can replace the appropriate subsection with the memory debugger, and look at what's being written in memory. it's sub-optimal because it will cause different synthesis, Aat the moment it's only passive, i.e. you write to a particular MAC lower address, and read from another, and it's always read. 

We've added the MAC controller addresses 04 and 05 for this purpose. 


Following two writes:


00000 : ffffffe0 ffffffff ffffffff ffffe918 45000800 00000054 40014000 ffff9858 
00008 : 0f100001 ffc01112 ffffa800 ffffffe4 1d784820 ffffffb2 00085607 0b0c090a 
00010 : 14150d0e 18191617 1c1d1a1b 20211e1f 24252223 28292627 2c2d2a2b 30312e2f 
00018 : 34353233 00003637 00000000 00000000 00000000 00000000 00000000 00000000 
00020 : 00600000 ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
00028 : ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
00030 : ffffffff 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00038 : 00000000 00000040 ffffffff ffffffff ffffe918 45000800 00000054 40014000 
00040 : ffff9859 0f110001 ffc01112 ffffa800 ffffffe4 1d784820 ffffffb2 00085607 
00048 : 0b0c090a 14140d0e 14141819 1c1d1a1b 20211e1f 24252223 28292627 2c2d2a2b 
00050 : 30312e2f 34353233 00003637 00000000 00000000 00000000 00000000 00000000 
00058 : 00000000 00600000 ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
00060 : ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
00068 : ffffffff ffffffff 00000000 00000000 00000000 00000000 00000000 00000000 
00070 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00078 : 00000000 ffffe465 ffff9273 ffff9e73 ffffffd2 ffffffef ffffff8d fffffc6e 

That's really strange. Now, with my memdebug code filling ram, we get:

> md 0
00000 : 00000000 01000123 01000223 01000323 01000423 01000523 01000623 01000723 
00008 : 01000823 01000923 01000a23 01000b23 01000c23 01000d23 01000e23 01000f23 
00010 : 01001023 01001123 01001223 01001323 01001423 01001423 01001623 01001723 
00018 : 01001823 01001923 01001a23 01001b23 01001c23 01001d23 01001e23 01001f23 
00020 : 01002023 01002123 01002223 01002323 01002423 01002523 01002623 01002723 
00028 : 01002823 01002923 01002a23 01002b23 01002c23 01002d23 01002e23 01002f23 
00030 : 01003023 01003123 01003223 01003323 01003423 01003523 01003623 01003723 
00038 : 01003823 01003923 01003a23 01003b23 01003c23 01003d23 01003e23 01003f23 

which is what we should be getting, save that 0 location, which should have the flanking 01 and 23.

Oh, and crap, haha, I also changed clk0 to clk90. 

Following making WE1 the only write-able section of code, we get:
> md 0
00000 : 01000023 01000123 01000223 01000323 01000423 01000523 01000623 01000723 
00008 : 01000823 01000923 01000a23 01000b23 01000c23 01000d23 01000e23 01000f23 
00010 : 01001023 01001123 01001223 01001323 01001423 01001523 01001623 01001723 
00018 : 01001823 01001923 01001a23 01001b23 01001c23 01001d23 01001e23 01001f23 
00020 : 01002023 01002123 01002223 01002323 01002423 01002523 01002623 01002723 
00028 : 01002823 01002923 01002a23 01002b23 01002c23 01002d23 01002e23 01002f23 
00030 : 01003023 01003123 01003223 01003323 01003423 01003523 01003623 01003723 
00038 : 01003823 01003923 01003a23 01003b23 01003c23 01003d23 01003e23 01003f23 

as expected. Hmm. 

Now, what happens when we go to clk0?

Part of the problems we were experiencint were related to the incorrect printing of the result from nicserial_macread. Fixed now. 

Wow, now it actually works! Added an extra loop at the last state for tx-input to prevent an extra-long newframe from causnig a double-trigger. 

Current incurable bug: So, we can send 4 or 5 or whatever fine frames, but then the system TX-locks and we can't shut it down. 
00880 : 30312e2f 34353233 00203637 00000000 00000000 00000000 00000000 00000000 
00888 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00890 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00898 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
008a0 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
008a8 : 00000000 00000000 000000fe ffffffff 0007ffff 8be3e918 45000800 00000054 
008b0 : 40014000 c0a859de 0f100001 13c01112 ff08a800 5e2600e4 1d794820 3fafa2b2 
008b8 : 00085607 0b0c090a 14150d0e 18191617 1c1d1a1b 20211e1f 24252223 28292627 
008c0 : 2c2d2a2b 30312e2f 34353233 00003637 00000000 00000000 00000000 00000000 
008c8 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
008d0 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
008d8 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
008e0 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
008e8 : 00000000 00000000 00000000 00000004 ffff94fe 00000000 ffffffff 0007ffff 
008f0 : 8be3e918 45000800 00000054 40014000 c0a859de 0f100001 13c01112 ff08a800 
008f8 : 5e2600e4 1d794820 3fafa2b2 00085607 0b0c090a 14150d0e 18191617 1c1d1a1b 
00100 : 00000000 00000000 00000000 00000000 000000fe ffffffff 0007ffff 8be3e918 
00108 : 45000800 00000054 40014000 c0a859de 0f100001 13c01112 ff08a800 5e2600e4 
00110 : 1d794820 3fafa2b2 00085607 0b0c090a 14150d0e 18191617 1c1d1a1b 20211e1f 
00118 : 24252223 28292627 2c2d2a2b 30312e2f 34353233 00003637 00000000 00000000 


Okay, with the new tr command in the debug console, we're able to check and really make sure stuff does what it's supposed to. We no longer seem to be suffering from the lock-up related problems that we were earlier, BUT we've got pain-in-the-ass signal integirty issues:

> md 300
00300 : 00000000 00000000 00000000 00000000 000000fe ffffffff 0007ffff 8be3e918 
00308 : 45000800 00000054 40014000 c0a859de 0f100001 13c01112 ff08a800 5e2600e4 
00310 : 1d794820 3fafa2b2 00085607 0b0c090a 14150d0e 18191617 1c1d1a1b 20211e1f 
00318 : 24252223 28292627 2c2d2a2b 30312e2f 34353233 00003637 00000000 00000000 
00320 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00328 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00330 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00338 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
> md 240
00240 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00248 : 00000000 000000de ffffffff 003fffff 8bdbe91e 45000822 00140054 40014000 
00250 : c09e59de 0f100029 13d21112 ff08a800 5e2600cc 1d794826 3fbfa2ba 000e562f 
00258 : 0b0e090a 141f0d0e 181f1617 1c1f1a1b 201f1e1f 24272223 282f2627 2c2f2a2b 
00260 : 30372e2f 34373233 00363637 00000000 00000000 00000000 00000000 00000000 
00268 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00270 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00278 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 

note how the packet in 240 has errors in all sorts of bytes, including the initial length byte.

For OUTCLK (i.e. CLKIO) driving it from the protointerface board at the defaults (12 mA, slow rise) we get a ~2 ns rise time, an overshoot to 4.6 V, the next trough at 1.9 V, and then it takes 16 ns or so to settle down. Ouch. 


at fast slew, 6 mA: overshoot 3.76, undershoot 3.22V, settles in ~4 ns. W00T!
at fast slew, 2 mA: no overshoot (monotonic) but 12 ns to hit 3.3V
at fast slew, 4 mA: no overshoot (monotonic, but wiggly), hits 3.3V in 4.5 ns. 

Alas, that hasnot appeared to have cured my ills

> md 0
00000 : 000000fe ffffffff 0007ffff 8be3e918 45000800 00000054 40014000 c0a859de 
00008 : 0f100001 13c01112 ff08a800 5e2600e4 1d794820 3fafa2b2 00085607 0b0c090a 
00010 : 14150d0e 18191617 1c1d1a1b 20211e1f 24252223 28292627 2c2d2a2b 30312e2f 
00018 : 34353233 00003637 00000000 00000000 00000000 00000000 00000000 00000000 
00020 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00028 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00030 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00038 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
> md 40
00040 : 00000000 000000fe ffffffff 0027ffff 8be3e918 45000820 00000054 40014000 
00048 : c0a859de c0a859de 13c01112 ff08a800 5e2600e4 1d794820 3fafa2b2 00085627 
00050 : 0b0c090a 14150d0e 18191617 1c1d1a1b 20211e1f 24252223 28292627 2c2d2a2b 
00058 : 30312e2f 34353233 00203637 00000000 00000000 00000000 00000000 00000000 
00060 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00068 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00070 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00078 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 


My solution to test? Have the TX send the output and have the RX compare it against an input. The way we'll actually do this is using an LFSR. 

6 Jan 2004
Of course, the LFSR approach wasn't working. Oh well. How can we figure out whether or not this is an IO SI problem or a RAM problem?

We receive over the net:

0000  ff ff ff ff ff ff 00 1f  eb f8 8b e3 48 00 45 50   ........ ....H.EP
0010  00 54 40 00 40 00 58 01  d9 fe c0 a8 00 11 1f 12   .T@.@.X. ........
0020  13 d2 9b c0 a8 08 ff e8  00 e4 5e 26 58 78 bf fb   ........ ..^&Xx..
0030  ba ba 7f af 56 0f 08 08  0b 0e 0f 0c 1d 1e 16 15   ....V... ........
0040  1e 1f 1a 19 1e 1f 1e 1d  3e 3f 22 21 26 27 26 25   ........ >?"!&'&%
0050  2e 2f 2a 29 2e 2f 2e 2d  3e 3f 32 31 36 37 36 35   ./*)./.- >?216765

and the dump shows:

00000 : 000000fe ffffffff 001fffff 8be3ebf8 45504800 40000054 58014000 c0a8d9fe 
00008 : 1f120011 9bc013d2 ffe8a808 5e2600e4 bffb5878 7fafbaba 0808560f 0f0c0b0e 
00010 : 16151d1e 1a191e1f 1e1d1e1f 22213e3f 26252627 2a292e2f 2e2d2e2f 32313e3f 
00018 : 36353637 00003637 00000000 00000000 00000000 00000000 00000000 00000000 


which strongly suggests that every byte in the dump matches every byte in the tx!
what could this mean? that there are fundamental read errors?

I don't understand -- some bytes go across okay, some live in much pain. 
I think i will work on something else for the time being. 


2 July 2004: Convert to Spartan-3
Okay, today we try and move to a spartan-3, in an attempt to reduce part count and fix some signal integrity errors we've been having. 

Notes: 
Do we want to have flash eeprom we can program for booting? 
Make sure to use current-limiting/pullup resistors on the configuration pins!!

We just can't spare the pins for DCM on the memory, data interfaces. 

There are a -ton- of clocks here. In particular, we get to worry about... 
IOCLK : Bus clock, between 0 an 60 MHz
RXCLK : input clock from PHY
GTX_CLK : output clock to TX interface of PHY
MEMCLK : output clock to memory interface
CLKIN : input 125 MHz clock. 

So, it would be nice to have the input clock be a 25 MHz clock that we 5x with a DCM. Do we really need separate pins for GTK_CLK and MEMCLK? What if we want to independently adjust the phases of the outputs? 

Now, the memory section is really tempermental, so I can understand wanting to control it with its own DCM. 

But really, the other parts should be able to deal pretty well with just the normal clock configurations.

Can / should we try to de-skew the memory interface? 

Wow, so, umm, the damn PHY wants 1.8 V. That sucks. 

Power/ component... the PHY only claims "typically less than 1 W" which I'm going to assume is "300 mA on each interface, max"



2.5 V:
   VCCAUX 
   AVDD on PHY, which is level-sensitivee
1.8 V: 
   
73601 
73618
73625

but, drat, none in the 1.8V category

To do :
   chassis grounding for connector
   move "soma gigabit ethernet" over enough to deal with screw holes for brackets
   other screw holes for mounting
   remaining power planes
   --any-- way we can de-skew? 
   
