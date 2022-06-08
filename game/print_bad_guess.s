.syntax unified
.section .text
.extern print
.global print_bad_guess
.type print_bad_guess, %function

@ void print_bad_guess(const char *bad_guess)
@   Print message to player informing them that their guess is not on wordlist.
print_bad_guess:
    push    {r4, lr}
    mov     r4, r0

    ldr     r0, =.LPBG_msg_open     @ print(.LPBG_msg_open);
    bl      print
    mov     r0, r4                  @ print(bad_guess);
    bl      print
    ldr     r0, =.LPBG_msg_close    @ print(.LPBG_msg_close);
    bl      print

    pop     {r4, pc}


.section .rodata
.LPBG_msg_open:   
    .asciz  "\n\""

.LPBG_msg_close:
    .asciz  "\" not in word list"