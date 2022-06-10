.syntax     unified
.extern     print
.global     print_bad_guess
.type       print_bad_guess, %function

.section    .rodata
msg_open:   
    .asciz  "\n\""

msg_close:
    .asciz  "\" not in word list"


.section    .text
@ void print_bad_guess(const char *bad_guess)
@   Print message to player informing them that their guess is not on wordlist.
@
@   Register usage:
@       r4 - const char *bad_guess - invalid guess to print
print_bad_guess:
    push    {r4, lr}
    mov     r4, r0

    ldr     r0, =msg_open     @ print(msg_open);
    bl      print
    
    mov     r0, r4            @ print(bad_guess);
    bl      print

    ldr     r0, =msg_close    @ print(msg_close);
    bl      print

    pop     {r4, pc}
