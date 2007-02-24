#!/usr/bin/python

def writeframe(gmiifid, pktfid, len, prespace = 0, erpos = -1):
    for i in range(prespace):
        gmiifid.write("0 0 00\n")
        
    pktfid.write("%d " % len)
    
    for i in range(len):
        if i == erpos :
            gmiifid.write("1 1 %2.2X\n" % (i % 256))
        else:
            gmiifid.write("1 0 %2.2X\n" % (i % 256))
        pktfid.write("%2.2X " % (i % 256))
    pktfid.write('\n')

gmiifid = file("gmii.0.dat", 'w')
pktfid = file("pkt.0.dat", "w")

for s in range(1, 5) :
    for l in range(1, 30):
        writeframe(gmiifid, pktfid, l, s, 17)
    for l in range(1, 1000, 47):
        writeframe(gmiifid, pktfid, l, s, 17)
    
for s in range(10, 50, 17) :
    for l in range(1, 1000, s):
        writeframe(gmiifid, pktfid, l, s, 17)
    


