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
60-bytes, all zeros: 0x04128908
DA: 00:00:3F:00:01:00, SA: 00:00:3F:00:00:04, Type:0x0101, rest zeros : 0xD0D5DEE7

However, there are issues with the pipelining of the address incrementing in the main DATABYTE loop causing the ADDR to inc right past the end of the packet. 

Trying to not inc addr if bytecnt < 8... works. Must also be sure to inc addr in CRC3 state. Admittedly, this if trashes our nice clean FSM design, but oh well.

System works, sends out packets of right size, sends new pkt when bp changes. 

ADDRL is there so that the decsiion to start sending a packet (addrl=BPL) has an extra register layer, to meet timing constraints. 



----------------------------------------------------------------------
TX INPUT
----------------------------------------------------------------------
NEWFRAME is kept high for the entire transmission duration of a frame, which is prefaced with the length in bytes. 

We read in n bytes, based on what the header says, and westop reading once we've gotten that many bytes. 

Since the input clock is on the order of 60 MHz or less, we use a system like that outlined to work across async boundaries. 

Test:
simple 8-byte frame : (pass, 20030921)
simple 10-byte frame: (pass, 20030921)
8-byte frame with len=8 but NEWFRAME high for an extra clock cycle (pass, 20030921)




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

In the state ERRCHK_AND_BPW we write the base pointer and check for errors. If there
are any errors, we just don't update the BP. Otherwise, we wait enough states to be sure the memory was written, and then go back to NONE. 

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

24 Sepember 2003: So, there are problems with bcnt, for situations where there is only a single tick between RX_DVs (i.e. the fastest possible rate of incoming packets) that results in MACCNT not counting correctly. Basically, we were depending on the ENDF staying high (and thus BRDY Staying low) until we started the next packet. However, this means that our CE logic is more complicated. So, we simply gate the bcnt on both ce and brdy. 


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



============================================================================
TO DO / things to debug and test

FIFO overflows, fifos overwriting each other, etc. Both in the ZBT sram
and the various clock-boundary FIFOs

System status interface -- how do we read all those counters, etc. 

MAC booting, etc. via the stupid physical layer I2C interface thing

Testing modes... 
   Something that just spits out 1024-byte frames to a given MAC
   
Uhh, did we want to do any sort of MAC address filtering? 

----------------------------------------------------------------------------
Overview notes
----------------------------------------------------------------------------
Trying to rename large numbers of signals so that there's some sort
of overall common naming scheme. Go refactoring!!!

Net result is network.vhd

We need feedback signals so that the *inputs don't overwrite the fifo, but this is difficult to implement. Since our buffer size is 256 kB, and we'd like to allow for a maximum frame size of 16384 bytes, or 16 frames of this size in the buffer. Wow, suddenly that doesn't seem like so much. Anyway, we're going to kill two of those such that we can implement the following overflow protection scheme:

