nop
jump(foo)
movc(0x01, r0) 		; comment
movc(0x02, r1)		; comment two
add(r0, r1, r2)		; comment three
sub(r0, r1, r2)		; comment four
nop
jump( foo)
movc ( 0x01, r0) 	; comment
movc  ( 0x02,r1)	; comment two
addc(0x0333,r1,r2)		; comment three
sub( r0,r1,r2 )		; comment four
