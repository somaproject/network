#!/usr/bin/python

"""
Ethernet frame simulation code in python; this is designed for both
extracting data from an ethernet frame and for generating ethernet
frames out of chunks of data

note MAC addresses are strings of the form "AA:BB:CC:DD:EE:FF"


"""
import re
import struct
import crcmod

PROTO_IP = 0x0800
PROTO_ARP = 0x0806


class frame:
    def __init__(self, destmac, srcmac, ethertype, data):
        # for encoding
        if isinstance(destmac, str):
            self.destmac = macdecode(destmac)
        else:
            self.destmac = struct.pack("BBBBBB", destmac[0], destmac[1],
                                       destmac[2], destmac[3], destmac[4],
                                       destmac[5])

        if isinstance(srcmac, str):
            self.srcmac = macdecode(srcmac)
        else:
            self.srcmac = struct.pack("BBBBBB", srcmac[0], srcmac[1],
                                      srcmac[2], srcmac[3], srcmac[4],
                                      srcmac[5])
        
            
        self.ethertype = ethertype
        self.data = data


    def getWire(self, preamble=7, SFD=True):
        # returns a string containing the wire-representation of the
        # frame

        length = 6 + 6 + 2 + len(self.data) + 4

        
        frame = self.destmac + self.srcmac + \
                struct.pack("BB", self.ethertype / 256, self.ethertype % 256)+\
                self.data

        fcscrc = crcmod.Crc(0x104C11DB7)
        fcscrc.update(frame)
        
        i = struct.unpack('i', fcscrc.digest())[0]
        invcrc = struct.pack('I', ~i)
        outdata = frame + invcrc[3] + invcrc[2] + invcrc[1] + invcrc[0]

        if SFD:
            outdata = '\xd5' + outdata

        for i in range(preamble):
            outdata = '\x55' + outdata; 


        return outdata
        


    
def macdecode(macstring):
    macre = re.compile("(\w\w):(\w\w):(\w\w):(\w\w):(\w\w):(\w\w)")
    bytes = macre.match(macstring).groups()
    result = [0, 0, 0, 0, 0, 0]
    for i in range(6):
        result[i] = int(bytes[i], 16)

    return struct.pack("bbbbbb", result[0], result[1], result[2], result[3], result[4], result[5])

def tohex(data):
    
    for i in data:
        print "%02X" % struct.unpack("B", i)[0],

def main():
    strdata = ""
    for i in range(64-14-4):
        strdata += '\x00'
        
    fzero = frame("00:00:00:00:00:00", "00:00:00:00:00:00", 0x0000, strdata)
    
    f = fzero.getWire()
    tohex(f)

    fzero = frame("00:00:3F:00:01:00", "00:00:3F:00:00:04", 0x0101, strdata)
    
    f = fzero.getWire()
    tohex(f)

if __name__ == "__main__":
    main()
