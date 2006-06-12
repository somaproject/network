#!/usr/bin/python
import random


class Ramout:

    # ram FIFO simulation
    def __init__(self):
        self.ramfile = file("RAM.writes.dat", 'w')
        self.addr = 0
        self.inframe = False
        self.lowword = None
        self.highword = None
        self.maxaddr = 2**16-1
        self.framestartaddr = 0
        
    def newframe(self):
        # end the current frame
        self.inframe = True
        self.lowword = None
        self.highword = None
        self.lasthighword = None
        self.framestartaddr = self.addr
        
    def write(self, data):

        # writes the 16-bit word to the output
        # always writes the low word first
        if self.inframe:
            if self.lowword == None:
                self.lowword = data
            elif self.lowword != None:
                # now write the high word, and reset
                self.highword = data
                self.ramfile.write("%04X %04X%04X\n" % (self.addr, self.highword,
                                                    self.lowword))

                self.highword = None
                self.lasthighword = data
                self.lowword = None
                if self.addr == self.maxaddr:
                    self.addr = 0
                else:
                    self.addr += 1

        else:
            print "Error, write called when not in frame"
    def abortframe(self):
        self.addr = self.framestartaddr
        self.inframe = False
            
    def endframe(self):
        if self.inframe : 
            if self.lowword != None and self.highword == None:
                self.write(self.lasthighword);
            self.inframe = False
        else:
            print "Error, endframe called when not in frame"
    
    
            
        
class txinput:

    def __init__(self):
       
        self.bpfile = file("BPs.writes.dat", 'w')
        self.dinfile = file("din.dat", 'w')
        self.ram = Ramout()
        self.bp = 0 

    def wait(self, nticks):
        # we wait n ticks to put the data on the wire
        #
        for i in range(nticks):
            self.dinfile.write("0 0000\n")

    def writeframe(self, len, datalen):
        """
        len = the len word that's to be written at the start of the
        frame

        datalen = the actual number of bytes in the data portion of the
        frame

        so, for example,
        writeframe(10, 10) writes a correct frame
        writeframe(12, 10) writes an aborted frame (NEWFRAME goes low too soon)
        writeframe(10, 12) writes a frame with superfluous data at the end

        """
        if len % 2 == 0 and datalen == len -1:
            print "You wrote a runt frame of len %d and datalen %d, but this frame will not show up as a runt" % (len, datalen)
            exit()
        self.ram.newframe()
        self.ram.write(len)
        self.ram.write(0x0000)
        if len > datalen:
            expstr = "runt frame"
        elif len == datalen:
            expstr = "normal frame"
        else:
            expstr = "superfluous data frame"
            
        self.dinfile.write("1 %04X %s\n" % (len, expstr))
    
        if len == datalen :
            # correct frame
            
            for i in range((datalen+1)/2):
                self.ram.write(i)
                self.dinfile.write("1 %04X\n" % (i))

            self.ram.endframe()
            self.bp = (self.bp + 1 + (3 + len)/4) % 2**16
            self.bpfile.write("%04X\n" % (self.bp))

        elif len > datalen :
            # aborted frame:
            for i in range((datalen+1)/2):
                self.ram.write(i)
                self.dinfile.write("1 %04X\n" % (i))
            
            self.ram.abortframe()

        elif len < datalen:
            # superfluous data:
            for i in range((datalen+1)/2):
                if i < (len + 1) / 2:
                    self.ram.write(i)
                self.dinfile.write("1 %04X\n" % i)

            self.ram.endframe()
            self.bp = (self.bp + 1 + (3 + len)/4) % 2**16
            self.bpfile.write("%04X\n" % self.bp)



if __name__ == "__main__":
    ti = txinput();


    ti.wait(5)
    ti.writeframe(10, 10)
    ti.wait(5)
    ti.writeframe(12, 10)
    ti.wait(4)
    ti.writeframe(10, 10)
    ti.wait(3)
    ti.writeframe(12, 16)
    ti.wait(3)
    ti.writeframe(11, 11)
    ti.wait(3)
    ti.writeframe(1543, 1543)
    ti.wait(3)
    ti.writeframe(1575, 1575)
    
    
    # now, random data, whee
    datalen = 0 
    for i in range(1000):
        ti.wait(random.randint(3, 10))
        r = random.randint(0, 18) # disabling bad packet gen
        if r < 19 :
            l = random.randint(4, 4000)
            #print "Generating nomal packet with len = ", l
            ti.writeframe(l, l)
            datalen += l 
        elif r == 19:
            l = random.randint(4, 4000)
            m = random.randint(1, 5)
            #print "Generating too long packet with len = ", l + m
            ti.writeframe(l, l+m)
            datalen += l
        elif r == 20:
            l = random.randint(4, 4000)
            m = random.randint(2, 5)
            #print "Generating runt packet with len = ", l - m
            ti.writeframe(l, l - m)
        print "Total packet size: ", datalen
            
