/*
    Copyright (C) 2012 Sebastian Lund
    
*/

//Reset PORT offset
#define __SFR_OFFSET 0
#include <avr/io.h>

#define accum r16
.global main

main:
    ldi accum, 0xFF
    out DDRC, accum
    sbi PORTC, 2

stop:
    rjmp stop
