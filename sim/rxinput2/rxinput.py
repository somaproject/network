#!/usr/bin/python

import sys
sys.path.append("../../crc/code")
import frame
import struct
import random

class ramfile:
    def __init__(self, filename):
        self.filename = filename
        self.fid = file(filename, 'w')

    def addFrame(self, data, crc):
        # we take in the frame data as well as a 4-byte CRC
        # which is written to ram if the len(data) is not
        # an exact multiple of 4

        tdata = data + crc # total data
        l = len(tdata)
        
        
        self.fid.write("%08X " % (l,))
        for i in range(l / 4):
            val = struct.unpack("BBBB", tdata[(i*4):((i+1)*4)])
            self.fid.write("%02X%02X%02X%02X " % (val[2], val[3], val[0], val[1]))

        crcval = struct.unpack("BBBB", crc)
        if l % 4 == 0:
            self.fid.write("\n")
        elif l % 4 == 1:
            val = struct.unpack("B", tdata[-1])
             
            self.fid.write("%02X%02X%02X%02X\n" % (crcval[1], crcval[2],
                                              val[0], crcval[0]))
        elif l % 4 == 2:
            val = struct.unpack("BB", tdata[-2:])
             
            self.fid.write("%02X%02X%02X%02X\n" % ( crcval[0],
                                              crcval[1], val[0], val[1]))
        elif l % 4 == 3:
            val = struct.unpack("BBB", tdata[-3:])
             
            self.fid.write("%02X%02X%02X%02X\n" % (val[2], crcval[0], 
                                                   val[0], val[1]))

class GMIIin:
    def __init__(self, filename):
        self.filename = filename
        self.fid = file(filename, 'w')


    def addFrame(self, dframe, space=10, abortn = -1):
        # dframe is just a long string of data, that we normally
        # get from the getWire section of a frame object
        #
        # nvalid is a list of tuples, each showing where we want non-valid
        # frames

        pos = 0
        for s in dframe:
            val = struct.unpack("B", s)

            if pos == abortn:
                self.fid.write("%d %d %02X\n" % (0, 0, val[0]))
            else:
                self.fid.write("%d %d %02X\n" % (0, 1, val[0]))

            pos += 1
            
        for s in range(space):
            self.fid.write("0 0 00\n")
        
def basictest():
    g = GMIIin("gmiiin.0.dat")
    rf = ramfile("ram.0.dat")




    # and finally, perhaps, a ton of random crap:
    for j in range(10000):
        d = ""
        div = []
        for i in range(random.randint(50, 100)):
            r = random.randint(0, 255)
            d += struct.pack("B", r)
            if random.randint(0, 10) < 2 :
                div.append((i, i+random.randint(0,2)))

        s = random.randint(2, 500);
        abortpos = random.randint(-100, 6)
        
        f = frame.frame("AB:00:3F:00:01:00",
                        "12:00:3F:00:00:04",
                        0x0101, d)

        g.addFrame(f.getWire(), space=s,  abortn=abortpos)
        
        fdata = f.getWire(preamble=0, SFD=False)
        # just the raw data
        rf.addFrame(fdata[:-4], fdata[-4:])


def macdesttest():
    g = GMIIin("gmiiin.1.dat")
    rf = ramfile("ram.1.dat")

    # we generate random length frames and randomly select among mac addresses

    macaddrs = ["C0:FF:EE:C0:FF:EE", "01:AB:12:34:CD:EF", 
                "FF:FF:FF:FF:FF:FF", "AB:CD:EF:12:34:56"]

    # and finally, perhaps, a ton of random crap:
    for j in range(1000):
        dmac = random.randint(0, 3)
        
        d = ""
        div = []
        for i in range(random.randint(50, 2000)):
            r = random.randint(0, 255)
            d += struct.pack("B", r)
            if random.randint(0, 10) < 2 :
                div.append((i, i+random.randint(0,2)))

        f = frame.frame(macaddrs[dmac],
                        "12:00:3F:00:00:04",
                        0x0101, d)

        g.addFrame(f.getWire())
        fdata = f.getWire(preamble=0, SFD=False) # just the raw data
        if dmac != 3:
            rf.addFrame(fdata[:-4], fdata[-4:])



    
    

if __name__ == "__main__":
    basictest()
    macdesttest()
    