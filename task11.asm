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
rjmp signals

array: .db 95,0, 96,0, 105,0, 106,0, 115,0, 116,0, 125,0, 126,0
;array: .db 135,0, 136,0, 145,0, 146,0, 165,0, 166,0, 185,0, 186,0


turn_off:
ldi r17, 0b11111111
out PORTC, r17

Signals:
ldi zl, low(array*2)
ldi zh, high(array*2)
ldi r17, 0
in r16, PINB
com r16
brbs 1, turn_off
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
subi r17,2
add r30, r17
lpm r16 , z
cpi r16, 255
in r0, sreg
sbrc r0, 1
rjmp theend

call ligh_Signals
jmp Signals

theend:
ldi r17, 0b11111100
out PORTC, r17
jmp theend

.org 0x0200
ligh_Signals:

cpi r16, 96
in r0, sreg
sbrc r0, 0
rjmp message_1

cpi r16, 106
in r0, sreg
sbrc r0, 0
rjmp message_2

cpi r16, 116
in r0, sreg
sbrc r0, 0
rjmp message_3

cpi r16, 126
in r0, sreg
sbrc r0, 0
rjmp message_4

cpi r16, 136
in r0, sreg
sbrc r0, 0
rjmp message_5

cpi r16, 146
in r0, sreg
sbrc r0, 0
rjmp message_6

cpi r16, 166
in r0, sreg
sbrc r0, 0
rjmp message_7

cpi r16, 186
in r0, sreg
sbrc r0, 0
rjmp message_8

cpi r16, 255
in r0, sreg
sbrc r0, 0
rjmp message_9
end:
ret

message_1:
ldi r17, 0b01111111
out PORTC, r17
rjmp end
message_2:
ldi r17, 0b00111111
out PORTC, r17
rjmp end
message_3:
ldi r17, 0b10011111
out PORTC, r17
rjmp end
message_4:
ldi r17, 0b11001111
out PORTC, r17
rjmp end
message_5:
ldi r17, 0b11100111
out PORTC, r17
rjmp end
message_6:
ldi r17, 0b11110011
out PORTC, r17
rjmp end
message_7:
ldi r17, 0b11111001
out PORTC, r17
rjmp end
message_8:
ldi r17, 0b11111100
out PORTC, r17
rjmp end
message_9:
ldi r17, 0b11111110
out PORTC, r17
rjmp end
