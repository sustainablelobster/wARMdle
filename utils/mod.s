.syntax unified
.section .text

.global mod
.type mod, %function

@ unsigned int mod(unsigned int dividend, unsigned int divisor)
@   Returns the remainder of dividend / divisor.
mod:
.loop:
    cmp r0, r1      @ unsigned int remainder = dividend;
    blo .return     @ while (remainder >= divsor)
    sub r0, r1      @   remainder -= divisor;
    b   .loop

.return:
    bx  lr          @ return remainder
