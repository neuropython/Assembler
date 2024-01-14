;
; AssemblerApplication1.asm
;
; Created: 14.01.2024 14:52:33
; Author : Damian
;


; Replace with your application code
.equ program = 0x0100
.equ stack = 0x0700
.cseg 
.org 0 
rjmp start

start: 
	ldi r16, low(stack)
	out SPL, r16 
	ldi r16, high(stack)
	out SPH, r16 
	rjmp test 

test:
	.org 0x0200 

	ldi xl, low(program)
	ldi xh, high(program)


Bouble_Sort:
	ldi r19, 0 ;lenght of table		

	calculate_lenght:
		ld r16 , x+
		cpi r16, 255
		in r0, sreg
		sbrc r0, 1
		rjmp loop_n
		inc r19 
		mov r20, r19
		mov r18, r19
		jmp calculate_lenght
	
	loop_n:
		dec r18
		brbs 1, reset_vals
		add r19, r20 
		jmp loop_n

	reset_vals:
		ldi xl, low(program)
		ldi xh, high(program)
		jmp sort

		
	sort: 
		dec r19 
		brbs 1, end
		ld r16, x+
		ld r17, x
		ld r18, -x
		cpi r17, 255
		brbs 1, reset_vals
		cp r17, r16
		brbs 0, swap_places
		st x+, r16
		st x, r17
		jmp sort


	swap_places:
		st x+, r17
		st x, r16
		jmp sort 

	end: ret



