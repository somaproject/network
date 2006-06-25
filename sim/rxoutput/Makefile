VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/rxoutput/_behavioral.var: ../../vhdl/RXoutput.vhd
	$(VHDLC) ../../vhdl/RXoutput.vhd

hw: $(WORKDIR)/rxoutput/_behavioral.var 

comp: 

$(WORKDIR)/rxoutputtest/_behavior.var: rxoutputtest.vhd
	$(VHDLC) rxoutputtest.vhd

sim: $(WORKDIR)/rxoutputtest/_behavior.var 
runsim: all
	$(VHDLS) rxoutputtest


clean:
	rm -Rf $(WORKDIR)$

