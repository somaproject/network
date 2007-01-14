#!/usr/bin/python

""" Simple code to read the register and decode the error count """

import os

xc3sprog = "~/XC3Sprog/xc3sprog"
cmdstr = xc3sprog + ( ' 0 0x03 "00 00 00 00 00"' )

fid = os.popen(cmdstr)
print fid.read()

