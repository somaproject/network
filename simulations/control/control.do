# TXINPUT .DO file

vlib work

-- actual hardware 
vcom -93 -explicit ../../vhdl/MII.vhd
vcom -93 -explicit ../../vhdl/PHYstatus.vhd
vcom -93 -explicit ../../vhdl/control.vhd


-- simulation entities
vcom -93 -explicit ../components/GMII/gmii.vhd
vcom -93 -explicit controltest.vhd



vsim -t 1ps -L xilinxcorelib -lib work controltest

view wave
add wave *
view structure
