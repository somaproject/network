VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/txinput/_behavioral.var: ../../vhdl/TXinput.vhd
	$(VHDLC) ../../vhdl/TXinput.vhd

hw: $(WORKDIR)/txinput/_behavioral.var 

comp: 

$(WORKDIR)/txinputtest/_behavior.var: txinputtest.vhd
	$(VHDLC) txinputtest.vhd

sim: $(WORKDIR)/txinputtest/_behavior.var 
runsim: all
	$(VHDLS) txinputtest


clean:
	rm -Rf $(WORKDIR)$

