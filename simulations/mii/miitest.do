# MII TEST .DO file

vlib work

-- actual hardware 
vcom -93 -explicit ../../vhdl/MII.vhd

-- simulation entities
vcom -93 -explicit ../components/GMII/gmii.vhd
vcom -93 -explicit miitest.vhd



vsim -t 1ps -L xilinxcorelib -lib work miitest

view wave
add wave *
view structure
