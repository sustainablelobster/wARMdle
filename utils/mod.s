.syntax unified
.section .text
.global mod
.type mod, %function

@ uint32_t mod(uint32_t dividend, uint32_t divisor)
@   Returns the remainder of dividend / divisor.
mod:
    cmp r0, r1          @ uint32_t remainder = dividend;
    blo .Lmod_return    @ while (remainder >= divsor)
    sub r0, r1          @   remainder -= divisor;
    b   mod

.Lmod_return:
    bx  lr              @ return remainder
