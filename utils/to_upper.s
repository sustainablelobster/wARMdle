.syntax unified
.section .text
.global to_upper
.type to_upper, %function

@ void to_upper(char *str)
@   Converts all lowercase characters to uppercase.
to_upper:
    ldrb    r1, [r0]    @ while (*str != 0) {
    cmp     r1, #0      @   *str &= 0xdf;
    beq     .Ltu_return @   str++;
    and     r1, 0xdf    @ }
    strb    r1, [r0]
    add     r0, #1
    b       to_upper

.Ltu_return:
    bx      lr          @ return;
