#!/usr/bin/python
"""
Takes the hacked-up output from our xc3sprog and extracts out an event
"""
import os
import sys

def bytereverse(x):
    res = 0
    for i in range(8):
        # xtract 
        b = (x >> i) & 0x1
        res |= (b << (7-i))
    return res


type = sys.argv[1]

# take in bytes/numbers
addr = int(sys.argv[2], 16)
if len(sys.argv) > 3:
    datastr = sys.argv[3]
    dataword = int(datastr, 16)
    data = []
    for i in range(4):
        data.append((dataword >> i *8) & 0xFF)
    data = data[::-1]
else:
    data = [0, 0, 0, 0]


cmdbyte = 0
if type == "read":
    cmdbyte = 0x00 | addr 
elif type == "write":
    cmdbyte = 0x80 | addr
else:
    raise "error in command"


xc3sprog = "~/XC3Sprog/xc3sprog"
cmdstr = xc3sprog + ( ' 0 0x02 "%2.2X %2.2X %2.2X %2.2X %2.2X"' %  (
    data[3], data[2], data[1], data[0], cmdbyte))

print cmdstr

fid = os.popen(cmdstr)

res = fid.read().split()

if type == 'read':
    cmdstr = xc3sprog + ' 0 0x03 "00 00 00 00"'
    fid = os.popen(cmdstr)
    
    res = fid.read().split()
    
    bytes = []
    word = 0

    for j, i  in enumerate(res):
        x = int(i, 16)
        word += x << (j *8)


    print hex(word)


    

