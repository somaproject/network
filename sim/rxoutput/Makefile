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

$(WORKDIR)/rxoutput/_behavioral.var: ../../crc/vhdl/crc_combinational.vhd ../../crc/vhdl/crc16_combinational.vhd ../../crc/vhdl/crcverify.vhd ../../vhdl/rxoutput.vhd
	$(VHDLC) -vital2000 ../../vhdl/rxoutput.vhd

hw: $(WORKDIR)/crc_combinational/_behavioral.var $(WORKDIR)/crc16_combinational/_behavioral.var $(WORKDIR)/crcverify/_behavioral.var $(WORKDIR)/rxoutput/_behavioral.var 

comp: 

$(WORKDIR)/rxoutputtest/_behavior.var: rxoutputtest.vhd
	$(VHDLC) -vital2000 rxoutputtest.vhd

sim: $(WORKDIR)/rxoutputtest/_behavior.var 
runsim: all
	$(VHDLS) rxoutputtest


clean:
	rm -Rf *.sym

