#!/usr/bin/python

import struct


class GMII:
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
            val = struct.unpack("b", gmiidat.data[i])
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

        
        


def main():

    gf = GMIIfile("gmii.dat")    
    of = Output("output.dat")
    
    g = GMII();
    d = "0123456789"
    g.setData(d)

    gf.writeempty(4)
    gf.write(g)
    of.write(d, False, False)
        
    gf.writeempty(4)
    
    g = GMII();
    d = "abcdefghijklmnopqurst"
    g.setData(d)

    gf.write(g)
    of.write(d, False, False)

    # this is a test of having only one tick between frames
    g = GMII();
    d = "Use the Source, Luke!"
    g.setData(d)

    gf.write(g)
    of.write(d, False, False)
        
    gf.writeempty(1)

    # and an error in the middle of a frame

    g = GMII();
    d = "Chevron seven... lock!" 
    g.setData(d)
    g.addER((14, 14))

    gf.write(g)
    d = d[:14]
    of.write(d, True, False)
        
    gf.writeempty(1)

    # and an error in the middle of a frame

    g = GMII();
    d = "Chevron seven... lock!" 
    g.setData(d)
    g.addER((0 , 0))

    gf.write(g)
    d = ""
    of.write(d, True, False)
        
    gf.writeempty(1)

    # this is a test of having only one tick between frames
    g = GMII();
    d = "Use the Source, Luke!"
    g.setData(d)

    gf.write(g)
    of.write(d, False, False)
        
    gf.writeempty(1)

    


if __name__ == "__main__":
    main()
    
