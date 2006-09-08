# TXINPUT .DO file

vlib work

-- actual hardware 
vcom -93 -explicit ../../vhdl/MII.vhd
vcom -93 -explicit ../../vhdl/PHYstatus.vhd
vcom -93 -explicit ../../vhdl/control.vhd
vcom -93 -explicit ../../vhdl/fifocheck.vhd
vcom -93 -explicit ../../vhdl/clockenable.vhd
vcom -93 -explicit ../../vhdl/memdebug.vhd
vcom -93 -explicit ../../vhdl/memory.vhd
vcom -93 -explicit ../../vhdl/RXvalid.vhd
vcom -93 -explicit ../../vhdl/GMIIin.vhd
vcom -93 -explicit ../../vhdl/RXinput.vhd
vcom -93 -explicit ../../vhdl/RXoutput.vhd
vcom -93 -explicit ../../vhdl/TXinput.vhd
vcom -93 -explicit ../../vhdl/crc_combinational.vhd
vcom -93 -explicit ../../vhdl/TXoutput.vhd
vcom -93 -explicit ../../vhdl/Network.vhd



-- simulation entities
vcom -93 -explicit ../components/NoBLram/NoBLSRAM.vhd
vcom -93 -explicit networktest.vhd



vsim -t 1ps -L xilinxcorelib -lib work networktest

view wave
add wave *
view structure