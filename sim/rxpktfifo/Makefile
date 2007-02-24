VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/gmiiin/_behavioral.var: ../../vhdl/gmiiin.vhd
	$(VHDLC) -vital2000 ../../vhdl/gmiiin.vhd

hw: $(WORKDIR)/gmiiin/_behavioral.var 

comp: 

$(WORKDIR)/gmiiintest/_behavior.var: gmiiintest.vhd
	$(VHDLC) -vital2000 gmiiintest.vhd

sim: $(WORKDIR)/gmiiintest/_behavior.var 
runsim: all
	$(VHDLS) gmiiintest


clean:
	rm -Rf *.sym

