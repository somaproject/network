VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/memory/_behavioral.var: ../../../vhdl/memory.vhd
	$(VHDLC) -vital2000 ../../../vhdl/memory.vhd

$(WORKDIR)/memtest/_behavioral.var: ../../../vhdl/memory.vhd ../vhdl/memtest.vhd
	$(VHDLC) -vital2000 ../vhdl/memtest.vhd

hw: $(WORKDIR)/memory/_behavioral.var $(WORKDIR)/memtest/_behavioral.var 

fmf.sym/conversions/prim.var: ../../../sim/components/fmfNoBL/conversions.vhd
	$(VHDLC) -vital2000 -work fmf  ../../../sim/components/fmfNoBL/conversions.vhd

fmf.sym/gen_utils/prim.var: ../../../sim/components/fmfNoBL/gen_utils.vhd
	$(VHDLC) -vital2000 -work fmf  ../../../sim/components/fmfNoBL/gen_utils.vhd

$(WORKDIR)/idt71v3556/_vhdl_behavioral.var: ../../../sim/components/fmfNoBL/idt71v3556.vhd
	$(VHDLC) -vital2000 ../../../sim/components/fmfNoBL/idt71v3556.vhd

$(WORKDIR)/noblsram/_behavioral.var: ../../../sim/components/fmfNoBL/idt71v3556.vhd ../../../sim/components/fmfNoBL/noblsram.vhd
	$(VHDLC) -vital2000 ../../../sim/components/fmfNoBL/noblsram.vhd

comp: fmf.sym/conversions/prim.var fmf.sym/gen_utils/prim.var $(WORKDIR)/idt71v3556/_vhdl_behavioral.var $(WORKDIR)/noblsram/_behavioral.var 

$(WORKDIR)/memtesttest/_behavioral.var: ../../../sim/components/fmfNoBL/idt71v3556.vhd ../../../sim/components/fmfNoBL/noblsram.vhd memtesttest.vhd
	$(VHDLC) -vital2000 memtesttest.vhd

sim: $(WORKDIR)/memtesttest/_behavioral.var 
runsim: all
	$(VHDLS) memtesttest


clean:
	rm -Rf *.sym

