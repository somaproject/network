VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/rxvalid/_behavioral.var: ../../vhdl/rxvalid.vhd
	$(VHDLC) -vital2000 ../../vhdl/rxvalid.vhd

$(WORKDIR)/crc_combinational/_behavioral.var: ../../vhdl/rxvalid.vhd ../../crc/vhdl/crc_combinational.vhd
	$(VHDLC) -vital2000 ../../crc/vhdl/crc_combinational.vhd

$(WORKDIR)/rxinput/_behavioral.var: ../../vhdl/rxvalid.vhd ../../crc/vhdl/crc_combinational.vhd ../../vhdl/rxinput.vhd
	$(VHDLC) -vital2000 ../../vhdl/rxinput.vhd

hw: $(WORKDIR)/rxvalid/_behavioral.var $(WORKDIR)/crc_combinational/_behavioral.var $(WORKDIR)/rxinput/_behavioral.var 

$(WORKDIR)/gmiiinsim/_behavioral.var: GMIIinsim.vhd
	$(VHDLC) -vital2000 GMIIinsim.vhd

comp: $(WORKDIR)/gmiiinsim/_behavioral.var 

$(WORKDIR)/rxinputtest/_behavior.var: GMIIinsim.vhd rxinputtest.vhd
	$(VHDLC) -vital2000 rxinputtest.vhd

sim: $(WORKDIR)/rxinputtest/_behavior.var 
runsim: all
	$(VHDLS) RXinputtest


clean:
	rm -Rf *.sym

