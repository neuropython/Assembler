;
; AssemblerApplication3.asm
;
; Created: 15.01.2024 15:30:20
; Author : Damian

.equ stack = 0x0700
.cseg
rjmp start 
.org 0x0500

start: 
	ldi r16, low(stack)
	out SPL, r16 
	ldi r16, high(stack)
	out SPH, r16 
	
	ldi r16, 0b011100111
	mov r17, r16 
	andi r17, 0b00000111
	cpi r17, 0b000000111
	in r17,sreg

	sbrc r17, 1
	call pp1
	sbrs r17, 1 
	call pp2
	jmp pc 

.org 0x0600
	pp1:
	push r17
	nop
	pop r17
	ret 

.org 0x0700
	pp2:
	nop 
	ret 
