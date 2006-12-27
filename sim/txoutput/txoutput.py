#!/usr/bin/python


import sys
sys.path.append("../../code/")
import frame
import random
import struct
import numpy
import crcmod

def generateCRC(data):
    """ Takes in data and appends the crc

    """
    fcscrc = crcmod.Crc(0x104C11DB7)
    # create the string:
    d = ""
    for i in data:
        d += chr(i)
        
    fcscrc.update(d)
    
    i = struct.unpack('i', fcscrc.digest())[0]
    invcrc = struct.pack('I', ~i)
    return [ord(invcrc[3]),  ord(invcrc[2]), ord(invcrc[1]), ord(invcrc[0])]

filename = "basic"

ramfile = file("%s.ram.dat" % filename, 'w')
bpfile = file("%s.bp.dat" % filename, 'w')
gmiifile = file("%s.gmii.dat" % filename, 'w')

ramaddr = 0; 

for i in range(256):
    framedatalen = random.randint(56, 100)
    framedata = range(framedatalen)

    for i in range(framedatalen):
        framedata[i] = i % 256 #random.randint(0, 255)

    destmacaddr = range(6)
    srcmacaddr =  range(6)
    for i in range(6):
        destmacaddr[i] = random.randint(0, 255)
        srcmacaddr[i] = random.randint(0, 255)

    protocol = [8, 0]
        
    
    totaldata = destmacaddr + srcmacaddr + protocol + framedata
    crc = generateCRC(totaldata)
    totaldata = totaldata + crc
    totallen = len(totaldata)
    totaldata += [0, 0, 0, 0] # extra padding so ram write has enough to add
    
    
    # write the current ram address as a bp
    bpfile.write("%d %d \n" % (ramaddr, totallen))


    # write the ram :
    
    ramfile.write("%04X %08X\n" % (ramaddr, totallen))
    ramaddr += 1
    
    for i in range((totallen+3) / 4) : # extra +3 such that odd lens work
        
        ramfile.write("%04X %02X%02X%02X%02X\n" % (ramaddr,
                                             totaldata[i*4+2],
                                             totaldata[i*4+3],
                                             totaldata[i*4+0],
                                             totaldata[i*4+1]))
        ramaddr += 1

    # GMII output
    totalbindata = ""
    for i in (framedata + crc) :
        totalbindata += struct.pack("B", i)
    
    f = frame.frame(destmacaddr, srcmacaddr, 0x0800, totalbindata)
    framebin = f.getWire()
    for i in framebin:
        gmiifile.write('%02X ' % struct.unpack('B', i)[0])

    gmiifile.write('\n')

    
