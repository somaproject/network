#!/usr/bin/python

import sys
sys.path.append("../../code")
import frame
import struct
import random



class GMIIin:
    # generic gmii data class

    def __init__(self):
        self.data = ""
        self.errors = []

    def setData(self, data):
        self.data = data

    def addER(self, er):
        # er should be a tuple listing start and finish bytes
        self.errors.append(er)

class GMIIfile:
    def __init__(self, filename):
        self.filename = filename
        self.fid = file(filename, 'w')

    def write(self, gmiidat):
        pos = 0;
        l = len(gmiidat.data)
        error = []
        for i in range(l):
            p = 0
            for e in gmiidat.errors:
                if i >= e[0] and i <= e[1]:
                    p = 1
            error.append(p)

        for i in range(l):
            val = struct.unpack("B", gmiidat.data[i])
            self.fid.write("%02X 1 %d\n" % (val[0], error[i]))
        self.fid.write("00 0 0\n")
        
    def writeempty(self, l):
        for i in range(l):
            self.fid.write("00 0 0\n")
        
class Output:
    def __init__(self, filename):
        self.filename = filename
        self.fid = file(filename, 'w')

    def write(self, data, erout, ofout):
        val = []
        if len(data) > 0 :
            for i in range(len(data)):
                val = struct.unpack("b", data[i])        
                self.fid.write("00%02X " % val[0])

            if erout:
                self.fid.write("C0%02X\n" % val[0])
            elif ofout:
                self.fid.write("A0%02X\n" % val[0])
            else:
                self.fid.write("80%02X\n" % val[0])
        
class RXoutput:
    def __init__(self, filename):
        self.filename = filename
        self.fid = file(filename, 'w')

    def write(self, noplen, dlen, data):
        self.fid.write("%d %d " % (noplen, dlen))

        self.fid.write("%04X " % (len(data), ))

        for i in range(len(data)/2):
            vals = struct.unpack("BB", data[i*2:(i+1)*2])
            self.fid.write("%02X%02X " % (vals[1], vals[0]))
        if len(data) % 2 == 1:
            vals = struct.unpack("B", data[-1])
            self.fid.write("00%02X" % (vals[0],))
        self.fid.write("\n")
        

class RXsystem:
    def __init__(self, iteration):
        # iteration is the file iteration
        gmiifilename = "gmiiin.%d.dat" % iteration
        doutfilename = "dout.%d.dat" % iteration

        self.gfid = GMIIfile(gmiifilename)

        self.dfid = RXoutput(doutfilename)

    def writeFrame(self, length, RXErrors=False,
                   CRCvalid=True, preamble=7, readShort=0, nop=0,
                   destMAC = "C0:FF:EE:01:02:03"):
        # writes a frame with the above-indicated error conditions

        data = ""
        for i in range(length):
            data += struct.pack("B", random.randint(0, 255))

        srcMAC = "%02X:%02X:%02X:%02X:%02X:%02X" % \
                 (random.randint(0,255), random.randint(0,255),
                  random.randint(0,255), random.randint(0,255),
                  random.randint(0,255), random.randint(0,255))
        
                                         
        f = frame.frame(destMAC,
                        srcMAC,
                        0x0101, data)

        fdata = f.getWire(preamble=preamble)

        if not CRCvalid:
            fdata =  fdata[:-7] + "\x22" + fdata[-6:]

        g = GMIIin();
        g.setData(fdata)
        
        if RXErrors:
            g.addER((10,11))

        self.gfid.write(g)

        
        if (not RXErrors) and CRCvalid :
            d = f.getWire(preamble=0, SFD=False)[:-4]
            self.dfid.write(nop, (len(d) + 1)/2 - readShort+1, d)
      
        
def RXsuite():
   rx = RXsystem(0)
   
   rx.writeFrame(60)
   rx.writeFrame(70)
   rx.writeFrame(80)
   rx.writeFrame(90)
   rx.writeFrame(100, preamble=0)
   

   # now we try some error frames
   rx.writeFrame(100, RXErrors=True)
   rx.writeFrame(110)
   rx.writeFrame(100, CRCvalid=False)
   rx.writeFrame(110)

   # super long frames
   rx.writeFrame(1000)
   rx.writeFrame(2000)
   rx.writeFrame(10000)
   
   

if __name__ == "__main__":    
    RXsuite()


