#define __SFR_OFFSET 0
#include <avr/io.h>

#define LO(x) (x & 0xff)
#define HI(x) (x >> 8)

#define A r16
#define B r17
#define C r18

//Memory ready flag
#define MR r25

//PORTB definitions
#define hsync       0
#define vsync       1
#define wrm         2
#define brgb        3
#define bank        4

//SRAM definitions
#define VRAMHI_ADDR 256
#define VLINELO_ADDR 257
#define VLINEHI_ADDR 258
