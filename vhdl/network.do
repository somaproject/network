# NETWORK.VHD generic .DO file
# Because modelsim was, well, sucking, I've made my own .DO 
vlib work

# actual hardware 
vcom -93 -explicit TXoutput.vhd
vcom -93 -explicit rxoutput_async_fifo.vhd
vcom -93 -explicit RXoutput.vhd
vcom -93 -explicit crc_combinational.vhd
vcom -93 -explicit async_fifo.vhd
vcom -93 -explicit rxinput_fifocontrol.vhd
vcom -93 -explicit RXinput_fifo.vhd
vcom -93 -explicit RXinput_GMII.vhd
vcom -93 -explicit RXinput_memio.vhd
vcom -93 -explicit RXinput.vhd
vcom -93 -explicit memory.vhd
vcom -93 -explicit FIFOcheck.vhd
vcom -93 -explicit TXinput.vhd
vcom -93 -explicit network.vhd


-- simulation entities
vcom -93 -explicit test_NoBLSRAM.vhd

vcom -93 -explicit network_testbench.vhd


vsim -t 1ps -L xilinxcorelib -lib work testbench
view wave
add wave *
view structure