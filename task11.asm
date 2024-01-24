;
; AssemblerApplication1.asm
;
; Created: 24.01.2024 14:52:33
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

	ldi r16, 0
	out DDRB, r16

	ldi r16, 0xff
	out DDRC, r16
	rjmp test 

test:
	.org 0x0200 
	array: .db 100,0, 110,0, 120,0, 130,0, 140,0, 150,0, 160,0, 170,0, 200,0
	ldi zl, low(array*2)
	ldi zh, high(array*2)


.org 0x0400
Signals:
	ldi r17, 0 
	in r16, PINB
	mov r18,r16

	calc_buttons:
	inc r17
	cpi r17, 9
	brbs 1, Signals
	lsr r18
	brbs 0, loop
	jmp calc_buttons

	loop:
		lsl r17
		add r30, r17
		lpm r16 , z
		cpi r16, 255
		in r0, sreg
		sbrc r0, 1 
		rjmp theend
		call ligh_Signals

theend: jmp theend

ligh_Signals:
	cpi r16, 96
	in r0, sreg
	sbrc r0, 0 
	rjmp message_1

	cpi r16, 105
	in r0, sreg
	sbrc r0, 0 
	rjmp message_2

	cpi r16, 115
	in r0, sreg
	sbrc r0, 0 
	rjmp message_3

	cpi r16, 125
	in r0, sreg
	sbrc r0, 0 
	rjmp message_4

	cpi r16, 135
	in r0, sreg
	sbrc r0, 0 
	rjmp message_5

	cpi r16, 145
	in r0, sreg
	sbrc r0, 0 
	rjmp message_6

	cpi r16, 165
	in r0, sreg
	sbrc r0, 0 
	rjmp message_7

	cpi r16, 185
	in r0, sreg
	sbrc r0, 0 
	rjmp message_8

	end:
	ret

	message_1: 
		ldi r17, 0b01111111
		out PORTC, r17
		rjmp loop
	message_2:
		ldi r17, 0b00111111
		out PORTC, r17
		rjmp loop
	message_3:
		ldi r17, 0b10011111
		out PORTC, r17
		rjmp loop
	message_4:
		ldi r17, 0b11001111
		out PORTC, r17
		rjmp loop
	message_5:
		ldi r17, 0b11100111 
		out PORTC, r17
		rjmp loop
	message_6:
		ldi r17, 0b11110011
		out PORTC, r17
		rjmp loop
	message_7:
		ldi r17, 0b11111001
		out PORTC, r17
		rjmp loop
	message_8:
		ldi r17, 0b11111100
		out PORTC, r17
		rjmp loop
