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
        self.gfid.writeempty(int(len(fdata)*0.07))
        
        if (not RXErrors) and CRCvalid :
            d = f.getWire(preamble=0, SFD=False)[:-4]
            self.dfid.write(nop, (len(d) + 1)/2 - readShort+1, d)


            
        
class TXinput:

    def __init__(self, iteration):
       
        self.dinfile = file("din.%d.dat" % iteration, 'w')
        self.wait(4)
    def wait(self, nticks):
        # we wait n ticks to put the data on the wire
        #
        for i in range(nticks):
            self.dinfile.write("0 0000\n")

    def write(self, length, data):
        self.dinfile.write("1 %04X\n" % length)

        for i in range((length)/2):
            lowbyte = struct.unpack("B", data[2*i])[0]
            highbyte = struct.unpack("B", data[2*i+1])[0]
            
            self.dinfile.write("1 %02X%02X\n" %(highbyte, lowbyte) )
            
        if (length % 2) == 1:
            self.dinfile.write("1 00%02X\n" % struct.unpack("B", data[-1])[0])

        self.wait(3)

class TXoutput:
    def __init__(self, iteration):
        self.fid = file("gmiiout.%d.dat" % iteration, "w")

    def write(self, f):
        fdata = f.getWire()

        for i in fdata:
            self.fid.write("%02X " % struct.unpack("B", i)[0])

        self.fid.write("\n")

class TXsystem:
    def __init__(self, iteration):
        self.gfid = TXoutput(iteration)
        self.dfid = TXinput(iteration)

    def writeFrame(self, length, destMAC = "C0:FF:EE:01:02:03",
                   wronglenval = 0 ):
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

        fdataall = f.getWire(preamble=0, SFD=False)
        fdata = fdataall[:-4] # no CRC
        self.dfid.write(len(fdata), fdata)

        self.gfid.write(f)
    

        
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
    
    l = 2**18 # a fifo-wrap of data
    t = 0 
    while  t < l:
        f = random.randint(64, 2000)
        rx.writeFrame(f)
        t += f
        
        

def TXsuite():
    tx = TXsystem(0)
    tx.writeFrame(4, destMAC="12:34:56:78:90:AB")
    tx.writeFrame(5)
    tx.writeFrame(500)
    tx.writeFrame(2500)
    tx.writeFrame(10000)
    
    
    l = 2**18 # a fifo-wrap of data
    t = 0 
    while  t < l:
        f = random.randint(64, 2000)
        tx.writeFrame(f)
        t += f
        

if __name__ == "__main__":    
    RXsuite()
    TXsuite()

