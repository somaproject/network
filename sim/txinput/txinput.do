# TXINPUT .DO file

vlib work

-- actual hardware 
vcom -93 -explicit ../../vhdl/TXinput.vhd


-- simulation entities
vcom -93 -explicit txinputtest.vhd


vsim -t 1ps -L xilinxcorelib -lib work txinputtest
view wave
add wave *
view structure
