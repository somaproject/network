# RXINPUT.DO file

vlib work

-- fake hardware
vcom -93 -explicit GMIIinsim.vhd

-- actual hardware 
vcom -93 -explicit ../../vhdl/RXvalid.vhd
vcom -93 -explicit ../../vhdl/crc_combinational.vhd
vcom -93 -explicit ../../vhdl/RXinput.vhd


-- simulation entities
vcom -93 -explicit rxinputtest.vhd


vsim -t 1ps -L xilinxcorelib -lib work RXinputtest
view wave
add wave *
view structure
