/*
    Created: 2012
     Author: Sebastian Lund

    Purpose: Do mainly stuff ...
*/

#include "defs.inc"
#define led 5

.global main            

main:
    //Setup the stack pointer
    ldi A, LO(RAMEND)
    out SPL, A
    ldi A, HI(RAMEND)
    out SPH, A

    //Init video
    rcall vavr_init

    //Set the led
    sbi DDRB, led
    sbi PORTB, led 
    //Init the memory fully ..
    rcall perform_full_memtest

    cbi PORTB, bank
    
    ser C
    cbi PORTB, bank
    rcall vavr_clear
    sbi PORTB, bank
    rcall vavr_clear

    sei    
    cbi PORTB, led

    //Initialize beginning position
    ldi A, 120
    ldi B, 125

    clr B

mainloop:	
    //Toggle led
	in D, PORTB
	sbrc D, led
    cbi PORTB, led
    sbrs D, led
	sbi PORTB, led   
	
	//Delay
	ldi  r22, 21
    ldi  r23, 199
L1: dec  r23
    brne L1
    dec  r22
    brne L1
    
    rcall draw
    rjmp mainloop

/*
    Temporary snake routine to draw something ...
*/
draw:
    
    //Draw the last one
    push A
    dec A
    ser C
    rcall draw_piece
    pop A

    inc A
    ldi C, 0b00000100
    ldi B, 125
    rcall draw_piece

    ;Swap buffers ...
    rcall vavr_swap
    ret

/*
    Snake functions ...
*/

//Draws piece at (B, A) color C
draw_piece:
    //Draws faster :3
    push D
    push r24
    push r0
    push A

    mov D, B    //Copy as reference

    ldi r24, 3
    mov r0, r24
    mov r24, A
    add r24, r0

p0: //Wait for memory to become ready
    sbrc MR, 0
    rjmp p0 

    out PORTD, A
    out PORTA, C
    out PORTC, B

    //Set to write
    cbi PORTB, wrm

    //Draw 16 in length
    inc B
    out PORTC, B
    inc B
    out PORTC, B
    inc B
    out PORTC, B

    //Disable write
    sbi PORTB, wrm

    mov B, D
    inc A
    cp A, r24
    brne p0

    pop A
    mov B, D

    pop r0
    pop r24
    pop D
    ret
