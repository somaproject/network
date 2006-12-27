VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/crc_combinational/_behavioral.var: ../../vhdl/crc_combinational.vhd
	$(VHDLC) ../../vhdl/crc_combinational.vhd

$(WORKDIR)/crc16_combinational/_behavioral.var: ../../vhdl/crc_combinational.vhd ../../vhdl/crc16_combinational.vhd
	$(VHDLC) ../../vhdl/crc16_combinational.vhd

$(WORKDIR)/crcverify/_behavioral.var: ../../vhdl/crc_combinational.vhd ../../vhdl/crc16_combinational.vhd ../../vhdl/crcverify.vhd
	$(VHDLC) ../../vhdl/crcverify.vhd

$(WORKDIR)/rxoutput/_behavioral.var: ../../vhdl/crc_combinational.vhd ../../vhdl/crc16_combinational.vhd ../../vhdl/crcverify.vhd ../../vhdl/rxoutput.vhd
	$(VHDLC) ../../vhdl/rxoutput.vhd

hw: $(WORKDIR)/crc_combinational/_behavioral.var $(WORKDIR)/crc16_combinational/_behavioral.var $(WORKDIR)/crcverify/_behavioral.var $(WORKDIR)/rxoutput/_behavioral.var 

comp: 

$(WORKDIR)/rxoutputtest/_behavior.var: rxoutputtest.vhd
	$(VHDLC) rxoutputtest.vhd

sim: $(WORKDIR)/rxoutputtest/_behavior.var 
runsim: all
	$(VHDLS) rxoutputtest


clean:
	rm -Rf $(WORKDIR)$

