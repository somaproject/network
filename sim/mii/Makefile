VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/mii/_behavioral.var: ../../vhdl/mii.vhd
	$(VHDLC) -vital2000 ../../vhdl/mii.vhd

hw: $(WORKDIR)/mii/_behavioral.var 

comp: 

$(WORKDIR)/gmii/_behavioral.var: ../components/GMII/GMII.vhd
	$(VHDLC) -vital2000 ../components/GMII/GMII.vhd

$(WORKDIR)/miitest/_behavior.var: ../components/GMII/GMII.vhd miitest.vhd
	$(VHDLC) -vital2000 miitest.vhd

sim: $(WORKDIR)/gmii/_behavioral.var $(WORKDIR)/miitest/_behavior.var 
runsim: all
	$(VHDLS) miitest


clean:
	rm -Rf *.sym

