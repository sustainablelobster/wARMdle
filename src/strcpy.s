.syntax     unified
.global     strcpy
.type       strcpy, %function

.section    .text
@ void strcpy(const char *src, const char *dst)
@   Copies src string to dst.
strcpy:
    ldrb    r2, [r0]        @ do {
    strb    r2, [r1]        @   *dst = *src
    cmp     r2, #0          @   if (*src == 0) 
    beq     return          @       break;
    add     r0, #1          @   src++;
    add     r1, #1          @   dst++;
    b       strcpy          @ } while (1);

return:
    bx      lr
