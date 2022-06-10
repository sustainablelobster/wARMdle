.syntax     unified
.global     trim_newline
.type       trim_newline, %function

.section    .text
@ void trim_newline(char *str)
@   Trim trailing newline char from str.
trim_newline:
    ldrb    r1, [r0]        @ while (*str != 0) {
    cmp     r1, #0          @   if (*str == '\n') {
    beq     return          @       *str = 0;
    cmp     r1, #'\n'       @       break;
    addne   r0, #1          @   }
    bne     trim_newline    @   str++;
    eor     r1, r1          @ }
    strb    r1, [r0]

return:
    bx      lr              @ return;
