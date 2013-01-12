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
    
    clr C
    cbi PORTB, bank
    rcall vavr_clear
    sbi PORTB, bank
    rcall vavr_clear

    sei    
    cbi PORTB, led

    //Initialize beginning position
    ldi A, 20
    ldi B, 10
    ldi r22, 0b00000001

    mov r23, A
    mov r24, B
    mov r25, A
    mov r26, B

mainloop:	
    //Toggle led
	in D, PORTB
	sbrc D, led
    cbi PORTB, led
    sbrs D, led
	sbi PORTB, led   
    
    rcall draw
    rjmp mainloop

/*
    Temporary snake routine to draw something ...
*/
draw:
    ;clr C
    ;rcall vavr_clear 

    //Clear last position
    push A
    push B
    clr C
    mov A, r23
    mov B, r24
    rcall draw_piece
    pop B
    pop A
    rcall draw_piece

    //Save last positions ...
    mov r23, A
    mov r24, B
    
    //Handle A variable
    sbrs r22, 0
    rjmp Aincr
    sbrc r22, 0
    rjmp Adecr
Aincr:
    inc A
    inc A
    inc A
    rjmp l0
Adecr:
    dec A
;    dec A
;    dec A
    rjmp l0

l0:
    cpi A, 235
    brsh AtoggleDEC
    cpi A, 5
    brlo AtoggleINC
    rjmp l1
AtoggleINC:
    andi r22, 0b11111110
    rjmp l1
AtoggleDEC:
    ori r22, 1
l1:
    
    //Handle B variable
    sbrs r22, 1
    rjmp Binc
    sbrc r22, 1
    rjmp Bdec
Binc:
    inc B
;    inc B
;    inc B
;    inc B
    rjmp l2
Bdec:
;    dec B
;    dec B
    dec B
    dec B
l2:
    cpi B, 235
    brsh BtoggleDEC
    cpi B, 5
    brlo BtoggleINC
    rjmp l3
BtoggleINC:
    andi r22, 0b11111101
    rjmp l3
BtoggleDEC:
    ori r22, 0b00000010
l3:

    //Draw new piece 
    ldi C, 0b00000101
    rcall draw_piece

    ;Swap buffers ...
    rcall vavr_swap
    ret

//Draws piece at (B, A) color C
draw_piece:
    //Draws faster :3
    push D
    push r24
    push r0
    push A
    push B

    mov D, B    //Copy as reference

    ldi r24, 3
    mov r0, r24
    mov r24, A
    add r24, r0

p0: 
    out PORTD, A
    out PORTA, C
    out PORTC, B

    //Set to write
    cbi PORTB, wrm

    //Draw 3 in length
    inc B
    out PORTC, B
    inc B
    out PORTC, B
;    inc B
;    out PORTC, B
;
    //Disable write
    sbi PORTB, wrm

    mov B, D
    inc A
    cp A, r24
    brne p0

    pop B
    pop A
    pop r0
    pop r24
    pop D
    ret
