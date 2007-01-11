VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/memory/_behavioral.var: ../../vhdl/memory.vhd
	$(VHDLC) -vital2000 ../../vhdl/memory.vhd

hw: $(WORKDIR)/memory/_behavioral.var 

fmf.sym/conversions/prim.var: ../components/fmfNoBL/conversions.vhd
	$(VHDLC) -vital2000 -work fmf  ../components/fmfNoBL/conversions.vhd

fmf.sym/gen_utils/prim.var: ../components/fmfNoBL/gen_utils.vhd
	$(VHDLC) -vital2000 -work fmf  ../components/fmfNoBL/gen_utils.vhd

$(WORKDIR)/idt71v3556/_vhdl_behavioral.var: ../components/fmfNoBL/idt71v3556.vhd
	$(VHDLC) -vital2000 ../components/fmfNoBL/idt71v3556.vhd

$(WORKDIR)/noblsram/_behavioral.var: ../components/fmfNoBL/idt71v3556.vhd noblsram.vhd
	$(VHDLC) -vital2000 noblsram.vhd

comp: fmf.sym/conversions/prim.var fmf.sym/gen_utils/prim.var $(WORKDIR)/idt71v3556/_vhdl_behavioral.var $(WORKDIR)/noblsram/_behavioral.var 

$(WORKDIR)/memorytest/_behavioral.var: ../components/fmfNoBL/idt71v3556.vhd noblsram.vhd memorytest.vhd
	$(VHDLC) -vital2000 memorytest.vhd

sim: $(WORKDIR)/memorytest/_behavioral.var 
runsim: all
	$(VHDLS) memorytest


clean:
	rm -Rf *.sym

