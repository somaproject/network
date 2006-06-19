VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/memory/_behavioral.var: ../../../vhdl/memory.vhd
	$(VHDLC) ../../../vhdl/memory.vhd

$(WORKDIR)/memtest/_behavioral.var: ../../../vhdl/memory.vhd ../vhdl/memtest.vhd
	$(VHDLC) ../vhdl/memtest.vhd

hw: $(WORKDIR)/memory/_behavioral.var $(WORKDIR)/memtest/_behavioral.var 

comp: 

$(WORKDIR)/noblsram/_behavioral.var: ../../../sim/components/NoBLram/NoBLSRAM.vhd
	$(VHDLC) ../../../sim/components/NoBLram/NoBLSRAM.vhd

$(WORKDIR)/memtesttest/_behavioral.var: ../../../sim/components/NoBLram/NoBLSRAM.vhd memtesttest.vhd
	$(VHDLC) memtesttest.vhd

sim: $(WORKDIR)/noblsram/_behavioral.var $(WORKDIR)/memtesttest/_behavioral.var 
runsim: all
	$(VHDLS) memtesttest


clean:
	rm -Rf $(WORKDIR)$

