# TXINPUT .DO file

vlib work

-- actual hardware 
vcom -93 -explicit ../../vhdl/GMIIin.vhd


-- simulation entities
vcom -93 -explicit GMIIintest.vhd
vlog -93 endsim.v


vsim -t 1ps -L xilinxcorelib -lib work GMIIintest
view wave
add wave *
view structure

run 400 ms
exit -force