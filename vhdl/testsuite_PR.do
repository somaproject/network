# NETWORK.VHD generic .DO file
# Because modelsim was, well, sucking, I've made my own .DO 
vlib work

# actual hardware
vcom -93 -explicit testsuite_PR.vhd


-- simulation entities
vcom -93 -explicit test_NoBLSRAM.vhd

vcom -93 -explicit testsuite_testbench.vhd



vsim -t 1ps -L xilinxcorelib -lib work testsuite_testbench
view wave
add wave *
view structure