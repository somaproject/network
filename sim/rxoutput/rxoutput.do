# TXINPUT .DO file

vlib work

-- actual hardware 
vcom -93 -explicit ../../vhdl/RXoutput.vhd


-- simulation entities
vcom -93 -explicit rxoutputtest.vhd


vsim -t 1ps -L xilinxcorelib -lib work rxoutputtest
view wave
add wave *
view structure
