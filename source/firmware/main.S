#include "defs.inc"

#define hsync   0       //PB0
#define vsync   1       //PB1
#define wrm     2       //PB2
#define oem     3       //PB3
#define rgbout  4       //PB4     
#define vramL r19
#define vramH r20

.global main            
.global TIMER1_COMPA_vect

main:
    //Setup PORTB signals
    clr A
    out DDRB, A
    sbi DDRB, hsync
    sbi DDRB, vsync
    sbi DDRB, wrm
    sbi DDRB, oem
    sbi DDRB, rgbout

    //Enable the output

    //Setup PORTC as low address pins 
    //and PORTD as high address pins
    ldi A, 0xff
    out DDRC, A
    out DDRD, A
    clr A
    out PORTC, A
    out PORTD, A

    //Setup PORTA as write access at first
    ldi A, 0xff
    out DDRA, A

    //Setup the stack pointer
    ldi A, LO(RAMEND)
    out SPL, A
    ldi A, HI(RAMEND)
    out SPH, A

    //Set the clock prescaler to be disabled
    ldi A, _BV(CLKPCE)    
    sts CLKPR, A            //select clock prescaler
    ldi A, 0                
    sts CLKPR, A            //set it to zero

    //Setup and configure TIMER1 to use I/O clock (no scaling), and ot CTC mode
    ldi A, _BV(CS10) | _BV(WGM12) 
    sts TCCR1B, A                   //about this black magic recipe ;)
    //Configure interrupt to fire when Timer1 matches Compare Value A
    ldi A, _BV(OCIE1A)              //load compare value a configuration bits
    sts TIMSK1, A                   //set the timer1 configuration bits ^ 
    //Set the Compare Value A to 636 clock cycles.
    //When timer1 reaches this value a flag is set and fires off the interrupt
    ldi A, LO(628)                  //low bits of 628
    sts OCR1AL, A                   //into Compare Value A Low
    ldi A, HI(628)                  //high bits of 628
    sts OCR1AH, A                   //into Compare Value A High

    //Initialize variables used
    // X = Vertical line count (256 of them)
    ldi XL, LO(256)                 //Low bits of 256
    ldi XH, HI(256)                 //High bits of 256
    clr A
    st X, A

    //Now lets test our memory!
/*
    Sequence
        * Write 0xFF to every address.
        * See if every address is equal to 0xFF
*/ 
memtest:
    //Disable RAM output
    sbi PORTB, oem
    //Disable RAM write for now
    sbi PORTB, wrm

    clr r17 //RAM lo
    clr r18 //RAM hi
outer:
    clr r17
    out PORTD, r18
inner:
    out PORTC, r17
    ldi A, 0xff 
    out PORTA, A
    //Clock it out 
    cbi PORTB, wrm
    nop
    sbi PORTB, wrm

    inc r17
    brne inner
    inc r18
    brne outer

    //Every cell should now contain 0xff, check if it is the case
    cbi PORTB, oem
    sbi PORTB, wrm //just in case
    clr r17
    clr r18
outer2:
    clr r17
    out PORTD, r18
inner2:
    clr A
    out PORTC, r17
    nop
    //Should be here now
    in A, PORTA
    cpi A, 0xff
    brne mem_error

    inc r17
    brne inner2
    inc r18
    brne outer2

    //Everything is fine!
    //in A, PORTB
    //sbrs A, bnk
    rjmp mem_done

    //sbi PORTB, bnk
    //rjmp test

mem_error:
   rjmp memtest //Probably because the SRAM isn't initialized yet 
mem_done:  
	clr A
	out DDRA, A
	out PORTA, A
    sei

    stop: rjmp stop     

//Video interrupt
// Horizontal Front Porch: 12 cycles
// Horizontal Sync Pulse: 71 cycles
// Horizontal back Porch: 24 cycles
// Horizontal Pixel Clocks: 512 cycles
// Horizontal Blanking: 9 cycles

// Vertical Sync Pulse: 2 lines
// Vertical Back Porch: 32 lines
// Vertical Line clocks: 480 lines
// Vertical Front Porch: 11 lines
//
// Total scan lines: 525                                 Instruction cycle takeup
TIMER1_COMPA_vect:                         
    //Horizontal front porch (12 cycles) -------------------------------
    in A, SREG              //Save the status register       (1)
    push A                  // into the stack                (2)
    // 9 nops = 9 cycles
    nop                                                  //  (1)
    nop                                                  //  (1)     
    nop                                                  //  (1)
    nop                                                  //  (1)
    nop                                                  //  (1)
    nop                                                  //  (1)
    nop                                                  //  (1)
    nop                                                  //  (1)
    nop                                                  //  (1)

    // Horizontal and vertical sync (71 cycles) -------------------------
    cbi PORTB, hsync     //Begin horizontal sync, active low (2)

    //Load variables from SRAM (14 cycles)
    ldi r26, LO(256)                                     // (1)
    ldi r27, HI(256)                                     // (1)
    ld r18, X+           //Active lines flag             // (2)
    ld r28, X+           //Vertical line count low       // (2)
    ld r29, X+           //Vertical line count high      // (2)
    // 6 nops = 6 cycles
    nop                                                  // (1)  
    nop                                                  // (1)  
    nop                                                  // (1)  
    nop                                                  // (1)  
    nop                                                  // (1)  
    nop                                                  // (1)    

    //Check if we need a vsync pulse (12 cycles)
    adiw r28, 1          //Increment vertical line counter  (2)
    //see if we reached line 525
    //Since X = (r29:r28) we just compare the high and the low bits
    ldi r16, LO(525)                                     // (1)
    ldi r17, HI(525)                                     // (1)
    cp r16, r28                                          // (1)
    cpc r17, r29                                         // (1)
    breq vsyncNeeded                                     // (1 or 2)
    // 3 nops = 3 cycles
    // to stay at the same cycle count if we jump or not
    nop
    nop
    nop
    rjmp vsyncNotNeeded                                  // (2)

vsyncNeeded:
    clr r28              //Reset line counter               (1)
    clr r29                                              // (1)
    cbi PORTB, vsync     //Begin vertical sync, active low  (2)

// Balanced so that both branches take up 6 cycles
// until they both end up at vsyncNotNeeded

vsyncNotNeeded:
    //Is the vsync pulse done? (8 cycles)
    ldi r16, LO(2)       //Reached line 2?               // (1)
    ldi r17, HI(2)                                       // (1)
    cp r16, r28                                          // (1)
    cpc r17, r29                                         // (1)
    breq vsyncIsDone                                     // (1 or 2)
    nop                  //To make up for the lost cycle    (1)
    rjmp vsyncNotDone                                    // (2)

vsyncIsDone:
    sbi PORTB, vsync     //Disable vsync signal             (2)
vsyncNotDone:
    //Vertical back porch (6 cycles) ---------------------------------------

    //On line 36 we've chewed up vsync and vertical back porch
    ldi r16, LO(36)                                      // (1)
    ldi r17, HI(36)                                      // (1)
    cp r16, r28                                          // (1)
    cpc r17, r29                                         // (1)
    brne vCheckActiveLines //brne = jump not equal       // (1 or 2)

    ldi r18, 1           //Set flag to note lines are       (1)
                         //active pixels
vCheckActiveLines:
    //Active pixels (6)
    //see if we've reached line 514
    ldi r16, LO(518)                                     // (1)
    ldi r17, HI(518)                                     // (1)
    cp r16, r28                                          // (1)
    cpc r17, r29                                         // (1)
    brne stillActivePixels                               // (1 or 2)

    ldi r18, 0           //No more active lines             (1)

stillActivePixels:
    //15 nops = 15 cycles to chew up
    nop                                                  // (1)
    nop                                                  // (1)
    nop                                                  // (1)
    nop                                                  // (1)
    nop                                                  // (1)
    nop                                                  // (1)
    nop                                                  // (1)
    nop                                                  // (1)
    nop                                                  // (1)
    nop                                                  // (1)
    nop                                                  // (1)
    nop                                                  // (1)
    nop                                                  // (1)
    nop                                                  // (1)
    nop                                                  // (1)

    //Save our variables back to SRAM for next time
    st -X, r29           //Vertical line count low          (2)
    st -X, r28           //Vertical line count high         (2)
    st -X, r18           //Active lines flag                (2)

    //End horizontal sync pulse
    sbi PORTB, hsync                                     // (2)

    //Horizontal back porch (24 cycles) -------------------------------------------  
	                                                              
    //Let's prepare the RAM reading                               
	cbi PORTB, oem      								 // (2)
	
    cpi r18, 0                                           // (1)
    brne wastetime                                       // (1 or 2)
    clr vramL                                            // (1)
    clr vramH                                            // (1)
    nop                                                  // (1)
    rjmp newline                                         // (2)  
wastetime:
    nop                                                  // (1)
    nop                                                  // (1)
    nop                                                  // (1)
    nop                                                  // (1)
newline:
    out PORTD, vramH                                     // (1)
    clr vramL                                            // (1)
    mov A, r28                                           // (1)
    andi A, 1                                            // (1)
    breq doubleline                                      // (1 or 2)
    inc vramH

doubleline:
    //here we go !                                              
    cbi PORTB, rgbout                                   // (2)

;Horizontal pixel cycling (512 cycles)  ------------------------------------------
; 512 cycles ...
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1) 
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)   
    out PORTC, vramL                                     // (1)
    inc vramL                                            // (1)
    out PORTC, vramL                                     // (1)  

//Horizontal blanking (9 cycles)
    //disable the color signal to not confuse the monitor
    sbi PORTB, rgbout                                    // (2)
    sbi PORTB, oem                                       // (2)  
nop
nop
nop
nop
    //restore status register    
    pop A                                                // (2)                            
    out SREG, A                                          // (1)
    reti                                                 // (4)
