# NETWORK.VHD generic .DO file
# Because modelsim was, well, sucking, I've made my own .DO 
vlib work

# actual hardware
vcom -93 -explicit Network_PR.vhd

-- simulation entities
vcom -93 -explicit test_NoBLSRAM.vhd

vcom -93 -explicit network_testbench.vhd


vsim -t 1ps -L xilinxcorelib -lib work network_testbench
view wave
add wave *
view structure