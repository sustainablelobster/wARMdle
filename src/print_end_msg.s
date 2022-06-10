.syntax     unified
.extern     print
.global     print_end_msg
.type       print_end_msg, %function

.section .rodata
win_msg:
    .asciz  "\nYOU WIN!\n"

lose_msg_open:
    .asciz  "\nThe word was \""

lose_msg_close:
    .asciz  "\"\n"


.section .text
@ void print_end_msg(int32_t player_won, const char *answer)
@   Print message to player informing them that their guess is not on wordlist.
@
@   Register usage:
@       r4 - const char *answer - word player was trying to guess
print_end_msg:
    push    {r4, lr}
    mov     r4, r1

    cmp     r0, #1                  @ if (player_won) {
    beq     player_won              @   print(win_msg);
                                    @ } else {
    ldr     r0, =lose_msg_open      @   print(lose_msg_open);
    bl      print                   @   print(answer);
    mov     r0, r4                  @   print(lose_msg_close);
    bl      print                   @ }
    ldr     r0, =lose_msg_close
    bl      print

    b       return

player_won:
    ldr     r0, =win_msg
    bl      print

return:
    pop     {r4, pc}
