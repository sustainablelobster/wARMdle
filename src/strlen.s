.syntax     unified
.global     strlen
.type       strlen, %function

.section    .text
@ uint32_t strlen(const char *str)
@   Calculates the length of str.
@   Returns the number of bytes in the str, excluding the null terminator.
strlen:
    mov     r1, r0
    eor     r0, r0          @ uint32_t len = 0;

loop:
    ldrb    r2, [r1, r0]    @ while(str[len] != 0)
    cmp     r2, #0          @   len++;
    beq     return          
    add     r0, #1
    b       loop

return:
    bx      lr              @ return len;
