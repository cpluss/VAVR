/*
    Created: 2012
     Author: Sebastian Lund

    Purpose: General definitions ..
*/

#define __SFR_OFFSET 0
#include <avr/io.h>

#define LO(x) (x & 0xff)
#define HI(x) (x >> 8)

//Temporary registers for use anytime!
#define A r16
#define B r17
#define C r18
#define D r19

/*
    Memory ready flag
        Writeable & Readable - MR=0xff
        ^ not !              - MR=0x00
*/
#define MR r25

//PORTB definitions
#define hsync       0
#define vsync       1
#define wrm         2
#define rgbout      3
#define bank        4

//SRAM definitions
#define VRAMHI_ADDR 256
#define VLINELO_ADDR 257
#define VLINEHI_ADDR 258
#define ACTLINE_ADDR 259
