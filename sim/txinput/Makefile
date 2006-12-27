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

$(WORKDIR)/txinput/_behavioral.var: ../../vhdl/crc_combinational.vhd ../../vhdl/crc16_combinational.vhd ../../vhdl/crcverify.vhd ../../vhdl/txinput.vhd
	$(VHDLC) ../../vhdl/txinput.vhd

hw: $(WORKDIR)/crc_combinational/_behavioral.var $(WORKDIR)/crc16_combinational/_behavioral.var $(WORKDIR)/crcverify/_behavioral.var $(WORKDIR)/txinput/_behavioral.var 

comp: 

$(WORKDIR)/txinputtest/_behavior.var: txinputtest.vhd
	$(VHDLC) txinputtest.vhd

sim: $(WORKDIR)/txinputtest/_behavior.var 
runsim: all
	$(VHDLS) txinputtest


clean:
	rm -Rf $(WORKDIR)$

