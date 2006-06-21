VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/serialio/_behavioral.var: ../../vhdl/serialio.vhd
	$(VHDLC) ../../vhdl/serialio.vhd

$(WORKDIR)/mii/_behavioral.var: ../../vhdl/serialio.vhd ../../vhdl/MII.vhd
	$(VHDLC) ../../vhdl/MII.vhd

$(WORKDIR)/phystatus/_behavioral.var: ../../vhdl/serialio.vhd ../../vhdl/MII.vhd ../../vhdl/PHYstatus.vhd
	$(VHDLC) ../../vhdl/PHYstatus.vhd

$(WORKDIR)/counter/_behavioral.var: ../../vhdl/serialio.vhd ../../vhdl/MII.vhd ../../vhdl/PHYstatus.vhd ../../vhdl/counter.vhd
	$(VHDLC) ../../vhdl/counter.vhd

$(WORKDIR)/sourcefilter/_behavioral.var: ../../vhdl/serialio.vhd ../../vhdl/MII.vhd ../../vhdl/PHYstatus.vhd ../../vhdl/counter.vhd ../../vhdl/sourcefilter.vhd
	$(VHDLC) ../../vhdl/sourcefilter.vhd

$(WORKDIR)/control/_behavioral.var: ../../vhdl/serialio.vhd ../../vhdl/MII.vhd ../../vhdl/PHYstatus.vhd ../../vhdl/counter.vhd ../../vhdl/sourcefilter.vhd ../../vhdl/control.vhd
	$(VHDLC) ../../vhdl/control.vhd

hw: $(WORKDIR)/serialio/_behavioral.var $(WORKDIR)/mii/_behavioral.var $(WORKDIR)/phystatus/_behavioral.var $(WORKDIR)/counter/_behavioral.var $(WORKDIR)/sourcefilter/_behavioral.var $(WORKDIR)/control/_behavioral.var 

comp: 

$(WORKDIR)/gmii/_behavioral.var: ../components/GMII/GMII.vhd
	$(VHDLC) ../components/GMII/GMII.vhd

$(WORKDIR)/controltest/_behavior.var: ../components/GMII/GMII.vhd controltest.vhd
	$(VHDLC) controltest.vhd

sim: $(WORKDIR)/gmii/_behavioral.var $(WORKDIR)/controltest/_behavior.var 
runsim: all
	$(VHDLS) controltest


clean:
	rm -Rf $(WORKDIR)$

