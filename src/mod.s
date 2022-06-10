.syntax     unified
.global     mod
.type       mod, %function

.section    .text
@ uint32_t mod(uint32_t dividend, uint32_t divisor)
@   Returns the remainder of dividend / divisor.
mod:
    cmp     r0, r1          @ uint32_t remainder = dividend;
    blo     return          @ while (remainder >= divisor)
    sub     r0, r1          @   remainder -= divisor;
    b       mod

return:
    bx      lr              @ return remainder;
