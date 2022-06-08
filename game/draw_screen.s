.syntax unified
.section .text
.extern print
.extern print_title
.extern print_guess
.extern print_empty_row
.extern clear_screen
.global draw_screen
.type draw_screen, %function

@ void draw_screen(int32_t turn, char guesses[6][6], const char *answer)
@   Prints game screen.
draw_screen:
    push    {r4 - r7, lr}
    mov     r4, r0
    mov     r5, r1
    mov     r6, r2
    eor     r7, r7

    bl      clear_screen
    bl      print_title

.LDS_loop:
    cmp     r4, r7
    ble     .LDS_print_empty
    
    mov     r0, #6
    mul     r0, r7
    add     r0, r5
    mov     r1, r6
    bl      print_guess
    b       .LDS_next_iter

.LDS_print_empty:
    bl      print_empty_row

.LDS_next_iter:
    add     r7, #1
    cmp     r7, #6
    blt     .LDS_loop

    pop    {r4 - r7, pc}
