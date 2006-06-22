VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/serialio/_behavioral.var: ../../../vhdl/serialio.vhd
	$(VHDLC) ../../../vhdl/serialio.vhd

$(WORKDIR)/mii/_behavioral.var: ../../../vhdl/serialio.vhd ../../../vhdl/MII.vhd
	$(VHDLC) ../../../vhdl/MII.vhd

$(WORKDIR)/phystatus/_behavioral.var: ../../../vhdl/serialio.vhd ../../../vhdl/MII.vhd ../../../vhdl/PHYstatus.vhd
	$(VHDLC) ../../../vhdl/PHYstatus.vhd

$(WORKDIR)/counter/_behavioral.var: ../../../vhdl/serialio.vhd ../../../vhdl/MII.vhd ../../../vhdl/PHYstatus.vhd ../../../vhdl/counter.vhd
	$(VHDLC) ../../../vhdl/counter.vhd

$(WORKDIR)/sourcefilter/_behavioral.var: ../../../vhdl/serialio.vhd ../../../vhdl/MII.vhd ../../../vhdl/PHYstatus.vhd ../../../vhdl/counter.vhd ../../../vhdl/sourcefilter.vhd
	$(VHDLC) ../../../vhdl/sourcefilter.vhd

$(WORKDIR)/control/_behavioral.var: ../../../vhdl/serialio.vhd ../../../vhdl/MII.vhd ../../../vhdl/PHYstatus.vhd ../../../vhdl/counter.vhd ../../../vhdl/sourcefilter.vhd ../../../vhdl/control.vhd
	$(VHDLC) ../../../vhdl/control.vhd

$(WORKDIR)/phytest/_behavioral.var: ../../../vhdl/serialio.vhd ../../../vhdl/MII.vhd ../../../vhdl/PHYstatus.vhd ../../../vhdl/counter.vhd ../../../vhdl/sourcefilter.vhd ../../../vhdl/control.vhd ../vhdl/phytest.vhd
	$(VHDLC) ../vhdl/phytest.vhd

hw: $(WORKDIR)/serialio/_behavioral.var $(WORKDIR)/mii/_behavioral.var $(WORKDIR)/phystatus/_behavioral.var $(WORKDIR)/counter/_behavioral.var $(WORKDIR)/sourcefilter/_behavioral.var $(WORKDIR)/control/_behavioral.var $(WORKDIR)/phytest/_behavioral.var 

comp: 

$(WORKDIR)/phytesttest/_behavioral.var: phytesttest.vhd
	$(VHDLC) phytesttest.vhd

sim: $(WORKDIR)/phytesttest/_behavioral.var 
runsim: all
	$(VHDLS) phytesttest


clean:
	rm -Rf $(WORKDIR)$

