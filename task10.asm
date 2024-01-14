;
; AssemblerApplication1.asm
;
; Created: 14.01.2024 14:52:33
; Author : Damian
;


; Replace with your application code
.equ stack = 0x0700
.cseg 
.org 0 
rjmp start

start: 
	ldi r16, low(stack)
	out SPL, r16 
	ldi r16, high(stack)
	out SPH, r16 
	jmp test

.org 0x0100
Recalculate: 
	;Registers where I would store my result:
	ldi r16, 0
	ldi r17, 0
	ldi r18, 0

	inc_till_result_100: 
		cpi r19, 100
		brbs 0, inc_till_result_10
		subi r19, 100
		inc r16 
		jmp inc_till_result_100

	inc_till_result_10: 
		cpi r19, 10 
		brbs 0, inc_till_result_0__10
		subi r19, 10
		inc r17 
		jmp inc_till_result_10

	inc_till_result_0__10:
		mov r18, r19
	ret 

test: 
    ldi r19, 255
    call Recalculate
    ldi r19, 120
    call Recalculate
    ldi r19, 80
    call Recalculate
    ldi r19, 2
    call Recalculate
    ldi r19, 0
    call Recalculate
