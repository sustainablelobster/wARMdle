.syntax unified
.section .text

.global div
.type div, %function

@ unsigned int div(unsigned int dividend, unsigned int divisor)
@   Returns the quotient of dividend / divisor.
div:
    eor r2, r2

.loop:
    cmp r0, r1      @ unsigned int quotient = 0;
    blo .return     @ while (dividend >= divsor)
    sub r0, r1      @   remainder -= divisor;
    add r2, #1
    b   .loop

.return:
    mov r0, r2
    bx  lr          @ return remainder
