VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/crc_combinational/_behavioral.var: ../../crc/vhdl/crc_combinational.vhd
	$(VHDLC) -vital2000 ../../crc/vhdl/crc_combinational.vhd

$(WORKDIR)/crc16_combinational/_behavioral.var: ../../crc/vhdl/crc_combinational.vhd ../../crc/vhdl/crc16_combinational.vhd
	$(VHDLC) -vital2000 ../../crc/vhdl/crc16_combinational.vhd

$(WORKDIR)/crcverify/_behavioral.var: ../../crc/vhdl/crc_combinational.vhd ../../crc/vhdl/crc16_combinational.vhd ../../crc/vhdl/crcverify.vhd
	$(VHDLC) -vital2000 ../../crc/vhdl/crcverify.vhd

$(WORKDIR)/txoutput/_behavioral.var: ../../crc/vhdl/crc_combinational.vhd ../../crc/vhdl/crc16_combinational.vhd ../../crc/vhdl/crcverify.vhd ../../vhdl/txoutput.vhd
	$(VHDLC) -vital2000 ../../vhdl/txoutput.vhd

hw: $(WORKDIR)/crc_combinational/_behavioral.var $(WORKDIR)/crc16_combinational/_behavioral.var $(WORKDIR)/crcverify/_behavioral.var $(WORKDIR)/txoutput/_behavioral.var 

$(WORKDIR)/simpleram/_behavioral.var: ../components/simpleram/simpleram.vhdl
	$(VHDLC) -vital2000 ../components/simpleram/simpleram.vhdl

comp: $(WORKDIR)/simpleram/_behavioral.var 

$(WORKDIR)/txoutputtest/_behavior.var: ../components/simpleram/simpleram.vhdl txoutputtest.vhd
	$(VHDLC) -vital2000 txoutputtest.vhd

sim: $(WORKDIR)/txoutputtest/_behavior.var 
runsim: all
	$(VHDLS) txoutputtest


clean:
	rm -Rf *.sym

