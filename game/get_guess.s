.syntax unified
.section .text
.extern print
.extern input
.extern to_upper
.global get_guess
.type get_guess, %function

@ void get_guess(char *buf)
@   Prompts user for guess.
get_guess:
    push    {r4, lr}
    mov     r4, r0

    ldr     r0, =.LGG_prompt    @ print(.LGG_prompt);
    bl      print

    mov     r0, r4              @ input(buf, 5);
    mov     r1, #5
    bl      input

    mov     r0, r4              @ to_upper(buf);
    bl      to_upper

    pop     {r4, pc}

.section .rodata
.LGG_prompt:
    .asciz  "\n> "