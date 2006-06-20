# TXOUTPUT .DO file

vlib work

-- actual hardware 
vcom -93 -explicit ../../vhdl/crc_combinational.vhd
vcom -93 -explicit ../../vhdl/TXoutput.vhd


-- simulation entities
vcom -93 -explicit ../components/simpleram/simpleram.vhdl


vcom -93 -explicit 


vsim -t 1ps -L xilinxcorelib -lib work txtest
view wave
add wave *
view structure
