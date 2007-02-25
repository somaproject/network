VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/rxpktfifo/_behavioral.var: ../../vhdl/rxpktfifo.vhd
	$(VHDLC) -vital2000 ../../vhdl/rxpktfifo.vhd

hw: $(WORKDIR)/rxpktfifo/_behavioral.var 

comp: 

$(WORKDIR)/rxpktfifotest/_behavior.var: rxpktfifotest.vhd
	$(VHDLC) -vital2000 rxpktfifotest.vhd

sim: $(WORKDIR)/rxpktfifotest/_behavior.var 
runsim: all
	$(VHDLS) rxpktfifotest


clean:
	rm -Rf *.sym

