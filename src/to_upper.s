.syntax     unified
.global     to_upper
.type       to_upper, %function

.section    .text
@ void to_upper(char *str)
@   Converts all lowercase characters to uppercase.
to_upper:
    ldrb    r1, [r0]        @ while (*str != 0) {
    cmp     r1, #0          @   if (*str >= 'a' && *str <= 'z') {
    beq     return          @       *str &= 0xdf;
    cmp     r1, #'a'        @   }
    blt     continue        @   str++;
    cmp     r1, #'z'        @ }
    bgt     continue
    and     r1, #0xdf
    strb    r1, [r0]

continue:
    add     r0, #1
    b       to_upper

return:
    bx      lr              @ return;
