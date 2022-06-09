.syntax unified
.section .text
.global strchr
.type strchr, %function

@ char *strchr(const char *str, char c)
@   Return pointer to the first occurence of c in str, NULL if not found.
strchr:
    ldrb    r2, [r0]        @ char *ret_val;
    cmp     r2, #0          @ while (1) {
    eoreq   r0, r0          @   if (*str == 0) {
    beq     .LSCHR_return   @       ret_val = NULL;
    cmp     r2, r1          @       break;
    beq     .LSCHR_return   @   } else if (*str == c) {
    add     r0, #1          @       ret_val = str;
    b       strchr          @       break;
                            @   }
                            @   str++;
                            @ }

.LSCHR_return:
    bx      lr              @ return contains;
