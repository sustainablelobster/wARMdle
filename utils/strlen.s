.syntax unified
.section .text

.global strlen
.type strlen, %function

@ size_t strlen(const char *str)
@   Calculates the length of str.
@   Returns the number of bytes in the str, excluding the null terminator.
strlen:
    eor     r1, r1          @ size_t len = 0;
    eor     r2, r2

.loop:
    ldrb    r2, [r0, r1]    @ while (str[len] != 0)
    cmp     r2, #0          @   len++;
    addne   r1, #1
    bne     .loop
    mov     r0, r1

    bx      lr              @ return len;
