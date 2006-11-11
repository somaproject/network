VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/memtest/_behavioral.var: ../vhdl/memtest.vhd
	$(VHDLC) ../vhdl/memtest.vhd

hw: $(WORKDIR)/memtest/_behavioral.var 

$(WORKDIR)/noblsram/_behavioral.var: ../../../sim/components/NoBLram/NoBLSRAM.vhd
	$(VHDLC) ../../../sim/components/NoBLram/NoBLSRAM.vhd

comp: $(WORKDIR)/noblsram/_behavioral.var 

$(WORKDIR)/memtesttest/_behavioral.var: ../../../sim/components/NoBLram/NoBLSRAM.vhd memtesttest.vhd
	$(VHDLC) memtesttest.vhd

sim: $(WORKDIR)/memtesttest/_behavioral.var 
runsim: all
	$(VHDLS) memtesttest


clean:
	rm -Rf $(WORKDIR)$

