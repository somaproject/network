# NETWORK.VHD generic .DO file
# Because modelsim was, well, sucking, I've made my own .DO 
vlib work

# actual hardware
vcom -93 -explicit MII.vhd
vcom -93 -explicit PHYstatus.vhd
vcom -93 -explicit control.vhd
vcom -93 -explicit crc_combinational.vhd 
vcom -93 -explicit memory.vhd
vcom -93 -explicit testsuite_memory.vhd
vcom -93 -explicit testsuite.vhd


-- simulation entities
vcom -93 -explicit test_NoBLSRAM.vhd

vcom -93 -explicit testsuite_testbench.vhd



vsim -t 1ps -L xilinxcorelib -lib work testsuite_testbench
view wave
add wave *
view structure