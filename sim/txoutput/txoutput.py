#!/usr/bin/python


import sys
sys.path.append("../../code/")
import frame
import random
import struct

filename = "basic"

ramfile = file("%s.ram.dat" % filename, 'w')
bpfile = file("%s.bp.dat" % filename, 'w')
gmiifile = file("%s.gmii.dat" % filename, 'w')

ramaddr = 0; 

for i in range(256):
    framedatalen = random.randint(56, 1500)
    framedata = range(framedatalen)

    for i in range(framedatalen):
        framedata[i] = random.randint(0, 255)

    destmacaddr = range(6)
    srcmacaddr =  range(6)
    for i in range(6):
        destmacaddr[i] = random.randint(0, 255)
        srcmacaddr[i] = random.randint(0, 255)

    protocol = [8, 0]
        
    totallen = 6 + 6 + 2 + framedatalen
    totaldata = destmacaddr + srcmacaddr + protocol + framedata + [0, 0, 0, 0]

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
    for i in framedata:
        totalbindata += struct.pack("B", i)
    
    f = frame.frame(destmacaddr, srcmacaddr, 0x0800, totalbindata)
    framebin = f.getWire()
    for i in framebin:
        gmiifile.write('%02X ' % struct.unpack('B', i)[0])

    gmiifile.write('\n')

    
