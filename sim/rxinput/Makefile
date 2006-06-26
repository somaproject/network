VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/rxvalid/_behavioral.var: ../../vhdl/RXValid.vhd
	$(VHDLC) ../../vhdl/RXValid.vhd

$(WORKDIR)/crc_combinational/_behavioral.var: ../../vhdl/RXValid.vhd ../../vhdl/crc_combinational.vhd
	$(VHDLC) ../../vhdl/crc_combinational.vhd

$(WORKDIR)/rxinput/_behavioral.var: ../../vhdl/RXValid.vhd ../../vhdl/crc_combinational.vhd ../../vhdl/RXinput.vhd
	$(VHDLC) ../../vhdl/RXinput.vhd

hw: $(WORKDIR)/rxvalid/_behavioral.var $(WORKDIR)/crc_combinational/_behavioral.var $(WORKDIR)/rxinput/_behavioral.var 

$(WORKDIR)/gmiiinsim/_behavioral.var: GMIIinsim.vhd
	$(VHDLC) GMIIinsim.vhd

comp: $(WORKDIR)/gmiiinsim/_behavioral.var 

$(WORKDIR)/rxinputtest/_behavior.var: GMIIinsim.vhd rxinputtest.vhd
	$(VHDLC) rxinputtest.vhd

sim: $(WORKDIR)/rxinputtest/_behavior.var 
runsim: all
	$(VHDLS) RXinputtest


clean:
	rm -Rf $(WORKDIR)$

