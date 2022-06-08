.syntax unified
.section .text
.extern print
.global print_end_msg
.type print_end_msg, %function

@ void print_end_msg(int32_t player_won, const char *answer)
@   Print message to player informing them that their guess is not on wordlist.
print_end_msg:
    push    {r4, lr}
    mov     r4, r1

    cmp     r0, #1                  @ if (player_won) {
    beq     .LPEM_player_won        @   print(.LPEM_win);
                                    @ } else {
    ldr     r0, =.LPEM_lose_open    @   print(.LPEM_lose_open);
    bl      print                   @   print(answer);
    mov     r0, r4                  @   print(.LPEM_lose_close);
    bl      print                   @ }
    ldr     r0, =.LPEM_lose_close
    bl      print
    b       .LPEM_return

.LPEM_player_won:
    ldr     r0, =.LPEM_win
    bl      print

.LPEM_return:
    pop     {r4, pc}


.section .rodata
.LPEM_win:
    .asciz  "\nYOU WIN!\n"

.LPEM_lose_open:
    .asciz  "\nThe word was \""

.LPEM_lose_close:
    .asciz  "\"\n"