/*
 * AssemblerApplication1.asm
 *
 *  Created: 10.01.2024 08:18:18
 *   Author: Damian Pietroń
 */ 
.cseg
.org 0
rjmp main

main:
ldi r16, 0
out DDRB, r16

ldi r16, 0xff
out DDRC, r16

loop:
ldi r19, 8
ldi r17, 0
in r16, PINB
mov r18, r16
bclr 0
rjmp message

another_loop:
com r17
out PORTC, r17
rjmp loop

message:
inc r17
lsr r18
brbs 0, if_two_pressed
dec r19
brbs 1, loop
jmp message

if_two_pressed:
lsr r18
dec r19
brbs 1, another_loop
brbs 0, two_pressed
jmp if_two_pressed

two_pressed: 
ldi r16, 128
com r16
out PORTC, r16
jmp loop
