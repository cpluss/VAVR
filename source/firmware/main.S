//
//   Copyright (C) 2012 Sebastian Lund
//    
//

//Reset PORT offset
#define __SFR_OFFSET 0
#include <avr/io.h>

#define LO(x) (x & 0xff)
#define HI(x) (x >> 8)

#define A r16               //Used to have an accumulator in the 8051 language, might as well declare one //)
#define rgb r23

#define blockWidth 60
#define blocksPerRow 8
#define rowColorStart r19
#define blockCount r20
#define pixelCount r22

#define hsync 0             //PB0
#define vsync 1             //PB1

.global main
.global TIMER1_COMPA_vect

//Circuit definitions
//
//   HSYNC = PB0
//   VSYNC = PB1
//   PC0-5 = RGB
//

main:
    //Setup the environment
    //   * DDRn control bits
    //   * The stack ! Yes we use that kind of magic around here //)
    //   * variables
    //
    
    //Setup the PORTB video signals
    ldi A, 0b00000011
    out DDRB, A
    //Setup the PORTC video signals
    ldi A, 0b00111111    // Enable PC0-5 for output
    out DDRC, A

    //Setup the stack
    ldi A, LO(RAMEND)       //low bits of ramend
    out SPL, A              //to [s]tack [p]ointer [l]ow
    ldi A, HI(RAMEND)       //high bits of ramend
    out SPH, A              //to [s]tack [p]ointer [h]igh

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
    ldi A, LO(636)                  //low bits of 636
    sts OCR1AL, A                   //into Compare Value A Low
    ldi A, HI(636)                  //high bits of 636
    sts OCR1AH, A                   //into Compare Value A High

    //Initialize variables used
    // X = Vertical line count (256 of them)
    ldi XL, LO(256)                 //Low bits of 256
    ldi XH, HI(256)                 //High bits of 256
    clr A
    st X, A

    ldi rgb, 0b00000011

    ;Enable interrupts
    sei

    ldi A, 0xFF
    out DDRD, A
    out PORTD, A
stop:
    rjmp stop

//Video interrupt
// Horizontal Front Porch: 12 cycles
// Horizontal Sync Pulse: 76 cycles
// Horizontal back Porch: 24 cycles
// Horizontal Pixel Clocks: 512 cycles
// Horizontal Blanking: 9 cycles
// Vertical Sync Pulse: 2 lines
// Vertical Back Porch: 21 lines
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

    // Horizontal and vertical sync (76 cycles) -------------------------
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

    //On line 34 we've chewed up vsync and vertical back porch
    ldi r16, LO(34)                                      // (1)
    ldi r17, HI(34)                                      // (1)
    cp r16, r28                                          // (1)
    cpc r17, r29                                         // (1)
    brne vCheckActiveLines //brne = jump not equal       // (1 or 2)

    ldi r18, 1           //Set flag to note lines are       (1)
                         //active pixels
vCheckActiveLines:
    //Active pixels (6)
    //see if we've reached line 514
    ldi r16, LO(514)                                     // (1)
    ldi r17, HI(514)                                     // (1)
    cp r16, r28                                          // (1)
    cpc r17, r29                                         // (1)
    brne stillActivePixels                               // (1 or 2)

    ldi r18, 0           //No more active lines             (1)

stillActivePixels:
    //19 nops = 19 cycles to chew up
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
    nop                                                  // (1)
    nop                                                  // (1)
    nop                                                  // (1)
    nop                                                  // (1)

    //Save our variables back to SRAM for next time
    st -x, r29           //Vertical line count low          (2)
    st -x, r28           //Vertical line count high         (2)
    st -x, r18           //Active lines flag                (2)

    //End horizontal sync pulse
    sbi PORTB, hsync                                     // (2)

//Horizontal back porch (25 cycles) -------------------------------------------
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop

ldi rgb, 0x30
out PORTC, rgb

;Horizontal pixel cycling (512 cycles)  ------------------------------------------
//; 512 cycles ...
//    ldi A, 128
//    loop:
//        dec A
//        nop
//        brne loop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop


//Horizontal blanking (9 cycles)
//clear the color signal to not confuse the monitor
clr A                                                    // (1)
out PORTC, A                                             // (1)
//restore status register    
pop A                                                    // (2)                            
out SREG, A                                              // (1)
reti                                                     // (4)

