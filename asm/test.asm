	nop	
	nop
	nop
	movc(20, r1)		;
	movc(0, r0)
main:
	addc(1, r0, r0)		;
	subc(1, r1, r1)
	jumpnz(main)		;
	mov(r0, r0)
	mov(r0, r0)
	nop
	nop
