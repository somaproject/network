VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/memtest/_behavioral.var: ../vhdl/memtest.vhd
	$(VHDLC) ../vhdl/memtest.vhd

hw: $(WORKDIR)/memtest/_behavioral.var 

$(WORKDIR)/mt55l256l32p/_behave.var: ../../../sim/components/ram/mt55l256l32p.vhd
	$(VHDLC) ../../../sim/components/ram/mt55l256l32p.vhd

comp: $(WORKDIR)/mt55l256l32p/_behave.var 

$(WORKDIR)/memtesttest/_behavioral.var: ../../../sim/components/ram/mt55l256l32p.vhd memtesttest.vhd
	$(VHDLC) memtesttest.vhd

sim: $(WORKDIR)/memtesttest/_behavioral.var 
runsim: all
	$(VHDLS) memtesttest


clean:
	rm -Rf $(WORKDIR)$

