import struct

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
        self.fid.write("%d %d " % (noplen, dlen))

        self.fid.write("%04X " % (len(data), ))

        for i in range(len(data)/2):
            vals = struct.unpack("BB", data[i*2:(i+1)*2])
            self.fid.write("%02X%02X " % (vals[1], vals[0]))
        if len(data) % 2 == 1:
            vals = struct.unpack("B", data[-1])
            self.fid.write("00%02X" % (vals[0],))

        self.fid.write('\n')

        
        

def simplepackets(bpfid, ram, data):
    # simple code to write tiny packets and see if we process them correctly.
    # sure, we'll never encounter these in the real world, but it doesn't
    # hurt to be correct everywhere.

    # first, len = 1
    bpfid.write("0000 0002\n")
    d = "A"
    ram.write(d)
    data.write(0, 2, d)

    # len = 2
    bpfid.write("0002 0004\n")
    d = "AB"
    ram.write(d)
    data.write(0, 2, d)

    # len = 3
    bpfid.write("0004 0006\n")
    d = "ABC"
    ram.write(d)
    data.write(0, 3, d)
    
    # len = 4
    bpfid.write("0006 0008\n")
    d = "WXYZ"
    ram.write(d)
    data.write(0, 3, d)
    
    # len = 5
    bpfid.write("0008 000B\n")
    d = "\x00\x01\x02\x03\x04"
    ram.write(d)
    data.write(0, 4, d)
    
    # len = 6
    bpfid.write("000B 000E\n")
    d = "\x00\x01\x02\x03\x04\x05"
    ram.write(d)
    data.write(0, 4, d)

    # len = 7
    bpfid.write("000E 0011\n")
    d = "\x00\x01\x02\x03\x04\x05\x06"
    ram.write(d)
    data.write(0, 5, d)

    # len = 8
    bpfid.write("0011 0014\n")
    d = "\x00\x01\x02\x03\x04\x05\x06\07"
    ram.write(d)
    data.write(0, 5, d)

def main():
    
    bpfid = file("bp.dat", 'w')
    
    ram = RamWrite()
    data = DataWrite("data.dat")


    simplepackets(bpfid, ram, data)
    

if __name__ == "__main__":
    main()
