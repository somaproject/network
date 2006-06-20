VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/serialio/_behavioral.var: ../../vhdl/serialio.vhd
	$(VHDLC) ../../vhdl/serialio.vhd

hw: $(WORKDIR)/serialio/_behavioral.var 

comp: 

$(WORKDIR)/serialiotest/_behavioral.var: serialiotest.vhd
	$(VHDLC) serialiotest.vhd

sim: $(WORKDIR)/serialiotest/_behavioral.var 
runsim: all
	$(VHDLS) serialiotest.vhd


clean:
	rm -Rf $(WORKDIR)$

