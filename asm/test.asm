	nop	
	nop
	nop
	movc(0x01, r0)		;
	not(r0, r1)
	swap(r0, r2)
	nop
	nop
	movc(0x1000, r1)
	movc(0xbeef, rmd)	;
	memw(r0, r1)		;
	nop
	nop
