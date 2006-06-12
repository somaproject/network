VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/crc_combinational/_behavioral.var: ../../vhdl/crc_combinational.vhd
	$(VHDLC) ../../vhdl/crc_combinational.vhd

$(WORKDIR)/txoutput/_behavioral.var: ../../vhdl/crc_combinational.vhd ../../vhdl/TXoutput.vhd
	$(VHDLC) ../../vhdl/TXoutput.vhd

hw: $(WORKDIR)/crc_combinational/_behavioral.var $(WORKDIR)/txoutput/_behavioral.var 

$(WORKDIR)/simpleram/_behavioral.var: ../components/simpleram/simpleram.vhdl
	$(VHDLC) ../components/simpleram/simpleram.vhdl

comp: $(WORKDIR)/simpleram/_behavioral.var 

$(WORKDIR)/txoutputtest/_behavior.var: ../components/simpleram/simpleram.vhdl txoutputtest.vhd
	$(VHDLC) txoutputtest.vhd

sim: $(WORKDIR)/txoutputtest/_behavior.var 
runsim: all
	$(VHDLS) txoutputtest


clean:
	rm -Rf $(WORKDIR)$

