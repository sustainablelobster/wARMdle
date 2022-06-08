.syntax unified
.section .text
.global to_upper
.type to_upper, %function

@ void to_upper(char *str)
@   Converts all lowercase characters to uppercase.
to_upper:
    ldrb    r1, [r0]        @ while (*str != 0) {
    cmp     r1, #0          @   if (*str >= 'a' && *str <= 'z') {
    beq     .Ltu_return     @       *str &= 0xdf;
    cmp     r1, #'a'        @   }
    blt     .LTU_next_iter  @   str++;
    cmp     r1, #'z'        @ }
    bgt     .LTU_next_iter
    and     r1, 0xdf
    strb    r1, [r0]

.LTU_next_iter:
    add     r0, #1
    b       to_upper

.Ltu_return:
    bx      lr          @ return;
