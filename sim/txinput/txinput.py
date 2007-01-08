#!/usr/bin/python
import random
import sys
sys.path.append("../../crc/code/")
import frame
import struct
import numpy as n

def packageData(data):
    """ Takes in a data string and appends the CRC to it
    """
    crc = frame.generateFCS(data)

    return data + crc

class Ramout:

    # ram FIFO simulation
    def __init__(self):
        self.ramfile = file("RAM.writes.dat", 'w')
        self.addr = 0
        self.inframe = False
        self.lowword = None
        self.highword = None
        self.maxaddr = 2**16-1
        self.framestartaddr = 0
        
    def newframe(self):
        # end the current frame
        self.inframe = True
        self.lowword = None
        self.highword = None
        self.lasthighword = None
        self.framestartaddr = self.addr
        
    def write(self, data):

        # writes the 16-bit word to the output
        # always writes the low word first
        if self.inframe:
            if self.lowword == None:
                self.lowword = data
            elif self.lowword != None:
                # now write the high word, and reset
                self.highword = data
                self.ramfile.write("%04X %04X%04X\n" % (self.addr, self.highword,
                                                    self.lowword))
                self.highword = None
                self.lasthighword = data
                self.lowword = None
                if self.addr == self.maxaddr:
                    self.addr = 0
                else:
                    self.addr += 1

        else:
            print "Error, write called when not in frame"
    def abortframe(self):
        self.addr = self.framestartaddr
        self.inframe = False
            
    def endframe(self):
        if self.inframe : 
            if self.lowword != None and self.highword == None:
                self.write(self.lasthighword);
            self.inframe = False
        else:
            print "Error, endframe called when not in frame"
    
    
def generateDataWithCRC(dlen):
    """
    generates an input data series of dlen bytes
    packaged as 16-bit words.

    dlen includes the 4-byte CRC at the end.

    should dlen be odd, an extra 00 is added to the end
    
    """

    data = "" 
    for i in range(dlen-4):
        data += chr(i % 256)

    alldata =  packageData(data)
    if dlen % 2 == 1:
        alldata += "\x00"
    
    bytex = n.fromstring(alldata, dtype=n.uint8)

    # now we package bytex, big-endian style (network byte order)
    wordx = n.zeros((dlen + 1) / 2 , dtype = n.uint16)
    for i in range((dlen + 1)/2):
        wordx[i] = bytex[2*i] << 8 |  bytex[2*i + 1]

    return wordx

class txinput:

    def __init__(self):
       
        self.bpfile = file("BPs.writes.dat", 'w')
        self.dinfile = file("din.dat", 'w')
        self.ram = Ramout()
        self.bp = 0 
        self.framecnt = 0
        self.crcerrcnt = 0
        
    def wait(self, nticks):
        # we wait n ticks to put the data on the wire
        #
        for i in range(nticks):
            self.dinfile.write("0 0000\n")

    def writeframe(self, hdrlen, datalen, corrupt = False):
        """
        hdrlen = the length word that's to be written at the start of the
        frame, representing the number of bytes in the frame

        datalen = the actual number of bytes in the data portion of the
        frame, including the crc

        so, for example,
        writeframe(10, 10) writes a correct frame
        writeframe(8, 10) writes a frame with superfluous data at the end
        writeframe(12, 10) writes an aborted frame (NEWFRAME goes low too soon) 
        writeframe(10, 10, corrupt=True) corrupts one of the bytes
        
        (past the CRC) 

        """
        if hdrlen % 2 == 0 and datalen == hdrlen -1:
            print "You wrote a runt frame of len %d and datalen %d, but this frame will not show up as a runt" % (hdrlen, datalen)
            exit()
        self.ram.newframe()
        self.ram.write(hdrlen)
        self.ram.write(0x0000)
        
        if hdrlen > datalen:
            expstr = "runt frame"
            data = generateDataWithCRC(datalen)
        elif hdrlen == datalen:
            expstr = "normal frame"
            data = generateDataWithCRC(datalen)
        else:
            expstr = "superfluous data frame"
            data = generateDataWithCRC(hdrlen)            
        self.dinfile.write("1 %04X %s\n" % (hdrlen, expstr))

        # we now generate all the data ahead of time!


        if hdrlen == datalen :
            if corrupt:
                data[1] += 1

            for i in range((datalen+1)/2):
                self.ram.write(data[i])
                self.dinfile.write("1 %04X\n" % data[i])

            self.ram.endframe()
            if not corrupt:
                self.bp = (self.bp + 1 + (3 + hdrlen)/4) % 2**16
                self.bpfile.write("%04X\n" % (self.bp))
                self.framecnt += 1
            else:
                self.ram.abortframe()
                self.crcerrcnt += 1
            
        elif hdrlen > datalen :
            # aborted frame:
            for i in range((datalen+1)/2):
                self.ram.write(data[i])
                self.dinfile.write("1 %04X\n" % (data[i]))
            
            self.ram.abortframe()

        elif hdrlen < datalen:
            # superfluous data:
            self.framecnt += 1

            for i in range((hdrlen+1)/2):
                if i < (hdrlen + 1) / 2:
                    self.ram.write(data[i])
                self.dinfile.write("1 %04X\n" % data[i])
            for i in range((hdrlen -datalen)/2):
                self.dinfile.write("1 0000\n")
            
            self.ram.endframe()
            self.bp = (self.bp + 1 + (3 + hdrlen)/4) % 2**16
            self.bpfile.write("%04X\n" % self.bp)



if __name__ == "__main__":
    ti = txinput();

    ti.wait(5)
    ti.writeframe(10, 10) # write 10 bytes, -- this should result in a BP=4
    ti.wait(5)
    ti.writeframe(12, 10) # aborted frame
    ti.wait(5)  
    ti.writeframe(10, 10) # nominal 10 bytes
    ti.wait(5)
    ti.writeframe(10, 10, corrupt = True)
    ti.wait(5)
    ti.writeframe(12, 16) # too short
    ti.wait(5)
    ti.writeframe(11, 11) # fine 
    ti.wait(5)
    ti.writeframe(1543, 1543)
    ti.wait(5)
    ti.writeframe(1575, 1575)
    
    
    # now, random data, whee
    datalen = 0 
    for i in range(100):
        ti.wait(random.randint(3, 10))
        r = random.randint(0, 22)
        if r < 19 :
            l = random.randint(4, 2000)
            #print "Generating nomal packet with len = ", l
            ti.writeframe(l, l)
            datalen += l 
        elif r == 19:
            l = random.randint(4, 2000)
            m = random.randint(1, 5)
            #print "Generating too long packet with len = ", l + m
            ti.writeframe(l, l+m)
            datalen += l
        elif r == 20:
            l = random.randint(4, 2000)
            m = random.randint(2, 5)
            #print "Generating runt packet with len = ", l - m
            ti.writeframe(l, l - m)
        elif r > 20:
            l = random.randint(4, 2000)
            print "Generating corrupted packet with len = ", l
            ti.writeframe(l, l, corrupt = True)
            datalen += l 
            
        print "Total packet size: ", datalen
            
    fidframecnt = file('framecnt.txt', 'w')
    
    fidframecnt.write("%d\n" % ti.framecnt)

    fidcrcerrcnt = file('crcerrcnt.txt', 'w')
    fidcrcerrcnt.write("%d\n" % ti.crcerrcnt)
    
