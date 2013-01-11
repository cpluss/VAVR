/*
    Created: 2012
     Author: Sebastian Lund

    Purpose: Perform memorytests ... 
*/
#include "defs.inc"

.global perform_full_memtest
.global perform_memtest

/*
    Tests everything ...
*/
perform_full_memtest:
    cbi PORTB, bank
    rcall perform_memtest
    sbi PORTB, bank
    rcall perform_memtest
    ret

//Purpose: Write random junk to memory to trash content
write_trash:

perform_memtest:
    push A
    push B
    push C

    //Write 0xff to every cell
p0:
    clr A
p1:
    clr B
    out PORTD, A
p2:
    out PORTC, B
    ser C
    out PORTA, C
    
    //Clock out memory
    cbi PORTB, wrm
    nop
    sbi PORTB, wrm

    inc B
    brne p2
    inc A
    brne p1

    //Every memory cell should now contain 0xff
    //test 'em!

    //Set to input
    clr A
    out DDRA, A
    out PORTA, A
    
p3:
    clr B
    out PORTD, A
p4:
    out PORTC, B
    nop
    in C, PINA
    cpi C, 0xFF
    brne err
    
    inc B
    brne p4
    inc A
    brne p3

    //All done
    rjmp succ

err:
    //Memory not initialized yet ..
    rjmp p0
succ:

    ser A
    out DDRA, A

    pop C
    pop B
    pop A
    ret
