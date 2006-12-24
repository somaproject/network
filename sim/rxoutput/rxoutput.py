import struct
import random
import sys
sys.path.append("../../code/")
import crcmod

class RamWrite:
    def __init__(self):
        self.fid = None
        self.rampos = 0 
        self.ramaddr = 0

    def write(self, data):
        if self.ramaddr >= 0 and self.ramaddr < 30000 \
        and self.rampos == 0:
            self.fid = file("ram.0.low.dat", 'w')
            self.rampos = 1
        elif self.ramaddr > 30000 and self.rampos == 1:
            self.fid = file("ram.0.high.dat", 'w')
            self.rampos = 2
            
        elif self.ramaddr >= 0 and  self.ramaddr < 30000 and \
        self.rampos == 2:
            self.fid = file("ram.1.low.dat", 'w')
            self.rampos = 3
        elif self.ramaddr > 30000 and self.rampos == 3:
            self.fid = file("ram.1.high.dat", 'w')
            self.rampos = 4
        elif self.ramaddr >= 0 and self.ramaddr < 30000 and \
                 self.rampos == 4:
            self.fid = file("ram.2.low.dat", 'w')
            self.rampos = 5
        elif self.ramaddr > 30000 and self.rampos == 5:
            self.fid = file("ram.2.high.dat", 'w')
            self.rampos = 6
        elif self.ramaddr >= 0 and self.rampos == 6:
            self.fid = None
            
        
        dlen = len(data)

        self.fid.write("%04X %08X\n" % (self.ramaddr, dlen))
        self.ramaddr = (self.ramaddr + 1 ) % 2**16
        for i in range(dlen / 4 ):
            vals = struct.unpack("BBBB", data[(i*4):((i+1)*4)])

            self.fid.write("%04X %02X%02X%02X%02X\n" %
                           (self.ramaddr, vals[3], vals[2], vals[1], vals[0]))
            self.ramaddr = (self.ramaddr + 1 ) % 2**16

        if dlen % 4 == 0:
            # nothing special
            pass
        elif dlen % 4 == 1:
            vals = struct.unpack("B", data[-1])
            self.fid.write("%04X 000000%02X\n" %(self.ramaddr, vals[0]))
            self.ramaddr = (self.ramaddr + 1 ) % 2**16
            
        elif dlen % 4 == 2:
            vals = struct.unpack("BB", data[-2:])
            self.fid.write("%04X 0000%02X%02X\n" %(self.ramaddr,
                                                 vals[1], vals[0]))
            self.ramaddr = (self.ramaddr + 1 ) % 2**16 
        elif dlen % 4 == 3:
            vals = struct.unpack("BBB", data[-3:])
            self.fid.write("%04X 00%02X%02X%02X\n" %(self.ramaddr, vals[2],
                                                   vals[1], vals[0]))
            self.ramaddr = (self.ramaddr + 1 ) % 2**16
        
        
class DataWrite:
    def __init__(self, filename):
        self.filename = filename
        self.fid = file(filename, 'w')

    def write(self, noplen, dlen, data):
        """
        dlen == words to wait for
        """
        self.fid.write("%d %d " % (noplen, dlen))

        self.fid.write("%04X " % (len(data), ))

        for i in range(len(data)/2):
            vals = struct.unpack("BB", data[i*2:(i+1)*2])
            self.fid.write("%02X%02X " % (vals[1], vals[0]))
        if len(data) % 2 == 1:
            vals = struct.unpack("B", data[-1])
            self.fid.write("00%02X" % (vals[0],))

        self.fid.write('\n')


class BpWrite:
    def __init__(self, filename):
        self.filename = filename
        self.fid = file(filename, 'w')
        self.bp = 0
        
    def write(self, delta):
        
        self.fid.write("%04X %04X\n" % (self.bp, (self.bp + delta) % 2**16))
        self.bp = ((self.bp + delta) % 2**16)

                

def packageData(data):
    """ Takes in data and

    """
    fcscrc = crcmod.Crc(0x104C11DB7)
    fcscrc.update(data)
    
    i = struct.unpack('i', fcscrc.digest())[0]
    invcrc = struct.pack('I', ~i)
    outdata = data + invcrc[3] + invcrc[2] + invcrc[1] + invcrc[0]
    return outdata

def simplepackets(bpfid, ram, data):
    # simple code to write tiny packets and see if we process them correctly.
    # sure, we'll never encounter these in the real world, but it doesn't
    # hurt to be correct everywhere.

    # first, len = 1
    bpfid.write(3)
    d = packageData("A")
    ram.write(d)
    data.write(0, 4, d)

    # len = 2
    bpfid.write(3)
    d = packageData("AB")
    ram.write(d)
    data.write(0, 4, d)

    # len = 3
    bpfid.write(3)
    d = packageData("ABC")
    ram.write(d)
    data.write(0, 5, d)
    
    # len = 4
    bpfid.write(3)
    d = packageData("WXYZ")
    ram.write(d)
    data.write(0, 5, d)
    
    # len = 5
    bpfid.write(4)
    d = packageData("\x00\x01\x02\x03\x04")
    ram.write(d)
    data.write(0, 6, d)
    
    # len = 6
    bpfid.write(4)
    d = packageData("\x00\x01\x02\x03\x04\x05")
    ram.write(d)
    data.write(0, 6, d)

    # len = 7
    bpfid.write(4)
    d = packageData("\x00\x01\x02\x03\x04\x05\x06")
    ram.write(d)
    data.write(0, 7, d)

    # len = 8
    bpfid.write(4)
    d = packageData("\x00\x01\x02\x03\x04\x05\x06\07")
    ram.write(d)
    data.write(0, 7, d)

def randpacket(delay, bpfid, ram, data, minsize, maxsize):
    # packet larger than the fifo
    l = random.randint(minsize, maxsize)
    s = ""
    for i in range(l):
        s += struct.pack("B", random.randint(0, 255))

    l += 4  # add on the CRC
    s = packageData(s)
    bpfid.write((l+3)/4 + 1)
    ram.write(s)
    data.write(delay, (l+1)/2 + 1 , s)
    return l


def main():
    
    bpfid = BpWrite("bp.dat")
    
    ram = RamWrite()
    data = DataWrite("data.dat")


    simplepackets(bpfid, ram, data)
    randpacket(0, bpfid, ram, data, 3000, 4000)
    randpacket(2500,  bpfid, ram, data, 3000, 4000)

    # now we generate quite a lot of extra crap 

    l = 0
    while l < 500000:
        l += randpacket(0, bpfid, ram, data, 100, 6000)
    
                  
if __name__ == "__main__":
    main()
