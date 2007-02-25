#!/usr/bin/python

"""
format is
valid endf erin ofin din


"""
import numpy as n


def writeframe(infid, pktfid, len, prespace = 0, validprob=1.0):
    for i in range(prespace):
        infid.write("0 0 0 0 00\n")
        
    pktfid.write("%d " % len)
    
    for i in range(len):
        while (n.random.uniform() > validprob):
            infid.write("0 0 0 0 %2.2X\n" % (i % 256))
        infid.write("1 0 0 0 %2.2X\n" % (i % 256))

        pktfid.write("%2.2X " % (i % 256))
    infid.write("1 1 0 0 FF\n")

    pktfid.write('\n')

infid = file("in.0.dat", 'w')
pktfid = file("pkt.0.dat", "w")

writeframe(infid, pktfid, 1, 20, 0.9)
writeframe(infid, pktfid, 2, 20, 0.9)
writeframe(infid, pktfid, 3, 20, 0.9)
writeframe(infid, pktfid, 4, 20, 0.9)
writeframe(infid, pktfid, 30, 20, 1.0)
writeframe(infid, pktfid, 30, 20, 0.7)

for s in range(1, 5) :
    for l in range(1, 30):
        writeframe(infid, pktfid, l, s, 0.9)
    for l in range(1, 1000, 47):
        writeframe(infid, pktfid, l, s, 0.9)
    
for s in range(10, 50, 17) :
    for l in range(1, 1000, s):
        writeframe(infid, pktfid, l, s, 0.7)
    


