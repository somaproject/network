VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/mii/_behavioral.var: ../../vhdl/MII.vhd
	$(VHDLC) ../../vhdl/MII.vhd

hw: $(WORKDIR)/mii/_behavioral.var 

comp: 

$(WORKDIR)/gmii/_behavioral.var: ../components/GMII/GMII.vhd
	$(VHDLC) ../components/GMII/GMII.vhd

$(WORKDIR)/miitest/_behavior.var: ../components/GMII/GMII.vhd miitest.vhd
	$(VHDLC) miitest.vhd

sim: $(WORKDIR)/gmii/_behavioral.var $(WORKDIR)/miitest/_behavior.var 
runsim: all
	$(VHDLS) miitest


clean:
	rm -Rf $(WORKDIR)$

