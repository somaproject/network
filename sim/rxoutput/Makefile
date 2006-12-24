VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/rxoutput/_behavioral.var: ../../vhdl/rxoutput.vhd
	$(VHDLC) ../../vhdl/rxoutput.vhd

$(WORKDIR)/crc_combinational/_behavioral.var: ../../vhdl/rxoutput.vhd ../../vhdl/crc_combinational.vhd
	$(VHDLC) ../../vhdl/crc_combinational.vhd

hw: $(WORKDIR)/rxoutput/_behavioral.var $(WORKDIR)/crc_combinational/_behavioral.var 

comp: 

$(WORKDIR)/rxoutputtest/_behavior.var: rxoutputtest.vhd
	$(VHDLC) rxoutputtest.vhd

sim: $(WORKDIR)/rxoutputtest/_behavior.var 
runsim: all
	$(VHDLS) rxoutputtest


clean:
	rm -Rf $(WORKDIR)$

