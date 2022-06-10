.syntax     unified
.extern     input
.extern     print
.extern     to_upper
.global     get_guess
.type       get_guess, %function

.section    .rodata
prompt:
    .asciz  "\n> "


.section    .text
@ void get_guess(char *buf)
@   Prompts user for guess.
@
@   Register usage:
@       r4 - char *buf - buffer to store player's guess
get_guess:
    push    {r4, lr}
    mov     r4, r0

    ldr     r0, =prompt    @ print(prompt);
    bl      print

    mov     r0, r4         @ input(buf, 5);
    mov     r1, #5
    bl      input

    mov     r0, r4         @ to_upper(buf);
    bl      to_upper

    pop     {r4, pc}
