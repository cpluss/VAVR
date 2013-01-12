/*
 *  Created: 2013
 *   Author: Sebastian Lund

    Main video work is done here ..
*/
#include "defs.inc"
#include "vert_lookup.inc"

//ISR
.global TIMER1_COMPA_vect

//Global functions ..
.global vavr_init
.global vavr_clear
.global vavr_swap
.global vavr_putpixel
.global vavr_readpixel

/*
    Routine to init video routine.
*/
vavr_init:
    //Save registers we use
    push A

    //Init VRAM IO bits
    ser A
    out DDRC, A
    out DDRD, A
    out DDRA, A
    clr A
    out PORTC, A
    out PORTD, A
    out PORTA, A

    //Control pins always connected to PORTB
    out DDRB, A
    sbi DDRB, hsync
    sbi DDRB, vsync
    sbi DDRB, wrm
    sbi DDRB, rgbout
    sbi DDRB, bank
    //Active low
    out PORTB, A
    sbi PORTB, wrm
    sbi PORTB, rgbout

    //Setup timer1 comparator interrupt
    ldi A, _BV(CS10) | _BV(WGM12)
    sts TCCR1B, A
    ldi A, _BV(OCIE1A)
    sts TIMSK1, A
    ldi A, hi8(636)
    sts OCR1AH, A
    ldi A, lo8(636)
    sts OCR1AL, A

    //Setup variable sections
    clr A
    sts VRAMHI_ADDR, A
    sts VLINELO_ADDR, A
    sts VLINEHI_ADDR, A

    //Set memory ready flag to be .. well ready
    clr MR

    //Restore registers
    pop A
    ret

/*
    Routine to clear the video memory
    C: color
*/
vavr_clear:
    push A
    push B
    
    clr A
    clr B
    out PORTD, A
    out PORTC, B
    out PORTA, C

    cbi PORTB, wrm //Write!
outer:
    clr B
    out PORTD, A
inner:
    out PORTC, B

    inc B
    brne inner
    inc A
    brne outer

    pop B
    pop A
    ret

/*
    Routine to flip buffers
*/
vavr_swap:
    push A

    //Wait for vsync
    f0:
        sbic PORTB, vsync
        rjmp f0

    //Swap buffers
    in A, PORTB
    sbrc A, bank
    cbi PORTB, bank
    sbrs A, bank
    sbi PORTB, bank

    pop A
    ret

/*
    Routine to put a pixel to the screen
    A - Y coordinate, B - X coordinate, C - color
*/
vavr_putpixel:
;    sbrc MR, 0
;    rjmp vavr_putpixel

    //Assign
    out PORTD, A
    out PORTA, C
    out PORTC, B

    //Clock out the data :3
    cbi PORTB, wrm
    sbi PORTB, wrm
    ret
/*
    Routine to read a pixel of screen
*/
vavr_readpixel:
    out PORTD, A
    out PORTC, B
    
    push A
    clr A
    out DDRA, A
    nop
    in C, PINA
    nop
    ser A
    out DDRA, A
    pop A
    ret




/*
    Routine to wait for the memory ready flag (r25)
*/
vavr_memready:
    sbrc MR, 0
    rjmp vavr_memready
    ret

/* VIDEO INTERRUPT SERVICE ROUTINE 

	Horizontal timings:
		Front porch: 12 cycles
		Sync porch : 76 cycles
		Back porch : 36 cycles
		Pixels     : 512 cycles
		Total	   : 636 cycles
	Vertical timings:
		Lines	   : 480 lines
		Front porch: 11 lines
		Sync porch : 2 lines
		Back porch : 32 lines (this is where we have time to do other stuff ... )
		Total	   : 525 lines
*/
TIMER1_COMPA_vect:
    //----> Front porch - 12 cycles
    //Save status register, like a good citizen :3
    push A                  // 2
    in A, SREG              // 1
    push A                  // 2

    //Equalize interrupt latency
    // credits goes to AtomicZombie at AVRFREAKS forums for this hack
    lds A, TCNT1L           // 2
    cpi A, 11               // 1
    brlo s1                 // 1 or 2
s1: cpi A, 12               // 1
    brlo s2                 // 1 or 2
s2: cpi A, 13               // 1
    brlo s3                 // 1 or 2
s3: cpi A, 14               // 1
    brlo s4                 // 1 or 2
s4:

    //----> Sync porch - 76 cycles
    //Begin the horizontal sync pulse (active low)
    cbi PORTB, hsync        // 2

    //Push registers to stack
    push r18                // 2
    push r17                // 2
    push YL                 // 2
    push YH                 // 2
    push ZL                 // 2
    push ZH                 // 2

    //set pointer to vertical lookup table
    ldi ZL, lo8(vert_lookup)// 2
    ldi ZH, hi8(vert_lookup)// 2

    //load vertical line counter and vertical address
    lds YL, VLINELO_ADDR    // 2
    lds YH, VLINEHI_ADDR    // 2
    lds r17, VRAMHI_ADDR    // 2

    //Set vertical line table position
    add ZL, YL              // 1
    adc ZH, YH              // 1
    //read vertical line table byte
    lpm A, Z                // 3

    //Increment vertical address?
    sbrs A, 3               // 1 or 2
    inc r17                 // 1
    //Reset vertical address?
    sbrc A, 0               // 1 or 2
    ser r17                 // 1

    //Increment vertical line counter
    adiw YL, 1              // 2

    //reset vertical line counter?
    sbrc A, 0               // 1 or 2
    clr YL                  // 1
    sbrc A, 0               // 1 or 2
    clr YH                  // 1

    //Save vertical line counter
    sts VLINELO_ADDR, YL    // 2
    sts VLINEHI_ADDR, YH    // 2
    sts VRAMHI_ADDR, r17    // 2

    //Vertical sync control
    sbrc A, 1               // 1 or 2
    cbi PORTB, vsync        // 2
    sbrs A, 1               // 1 or 2
    sbi PORTB, vsync        // 2

    //Pop pointers off stack
    pop ZH                  // 2
    pop ZL                  // 2
    pop YH                  // 2
    pop YL                  // 2

    //horizontal sync pulse (active low)
    sbi PORTB, hsync        // 2

    //----> Back porch - 36 cycles (adjusted to 30 cycles for sync stability)

    //Set memory ready flag
    ;sbrc A, 1               // 1 or 2
    ;clr MR                  // 1
    ;sbrs A, 1               // 1 or 2
    ;ser MR                  // 1

    //Active line?
    sbrs A, 2               // 1 or 2
    rjmp no_v               // 2

    //Save PORTD
    in r18, PORTD           // 1
    push r18                // 2
    //Save PORTC
    in r18, PORTC           // 1
    push r18                // 2
    //Save PORTA
    in r18, PORTA           // 1
    push r18                // 2

    //In case we got interrupted in the middle
    //of a SRAM write 
    in r18, PORTB             // 1
    sbrs r18, wrm             // 1 or 2
    sbi PORTB, wrm            // 2
    sbrc r18, wrm             // 1 or 2
    rjmp s5                   // 2
s5:
    
    //Set vertical address
    sbrc A, 2               // 1 or 2
    out PORTD, r17          // 1

    //Set a flag depending if we should restore the write
    //enable bit or not
    mov A, r18
    sbrs A, wrm             // 1 or 2
    clr r18                 // 1
    sbrc A, wrm             // 1 or 2
    ser r18                 // 1

    //----> pixels - 512 cycles
    nop                     // 1

    //Set to front buffer
    sbrc A, bank            // 1 or 2
    cbi PORTB, bank         // 2
    sbrs A, bank            // 1 or 2
    sbi PORTB, bank         // 2

    //Release data bus
    clr A                   // 1
    out DDRA, A             // 1
    //Reset horizontal address
    out PORTC, A            // 1

    //Set rgb buffer to output
    cbi PORTB, rgbout       // 2

    //240 Pixels ..
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1
    inc A                   // 1
    out PORTC, A            // 1

    //Front porch again ...
    //Disable rgb buffer
    sbi PORTB, rgbout       // 2

    //Restore PORTA
    pop A                   // 2
    out PORTA, A            // 1
    //Restore PORTC
    pop A                   // 2
    out PORTC, A            // 1
    //Restore PORTD
    pop A                   // 2
    out PORTD, A            // 1

    //Set to back buffer
    in A, PORTB             // 2
    sbrc A, bank            // 1 or 2
    cbi PORTB, bank         // 2
    sbrs A, bank            // 1 or 2
    sbi PORTB, bank         // 2

    //Restore the write enable bit
    sbrc r18, 0             // 1 or 2
    cbi PORTB, wrm          // 2
    sbrs r18, 1             // 1 or 2
    sbi PORTB, wrm

    ;nop                     // 1
    ;nop                     // 1
    ;nop                     // 1
    ;nop                     // 1
    ;nop
    ;nop

    //Enable data bus
    ser A                   // 1
    out DDRA, A             // 1

no_v:
    //Pop registers from stack
    pop r17                 // 2
    pop r18                 // 2
    pop A                   // 2
    out SREG, A             // 1
    pop A                   // 2
    reti                    // 4
