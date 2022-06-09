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

    ldr     r0, =.LDS_clear     @ print(.LDS_clear);
    bl      print

    ldr     r0, =.LDS_title     @ print(.LDS_title);
    bl      print

.LDS_loop:
    ldr     r0, =.LDS_indent    @ for (int32_t i = 0; i < 6; i++) {
    bl      print               @   print(.LDS_indent);
                                @
    cmp     r4, r7              @   if (i < turn) {
    ble     .LDS_print_empty    @       print_guess(guess[i], answer);
                                @       continue;
    mov     r0, #6              @   }
    mul     r0, r7              @
    add     r0, r5              @   print(.LDS_empty_row);
    mov     r1, r6              @ }
    bl      print_guess
    b       .LDS_next_iter

.LDS_print_empty:
    ldr     r0, =.LDS_empty_row
    bl      print

.LDS_next_iter:
    add     r7, #1
    cmp     r7, #6
    blt     .LDS_loop

    pop     {r4 - r7, pc}


.section .rodata
.LDS_clear:
    .byte   0x1b
    .ascii  "[1;1H"
    .byte   0x1b
    .asciz  "[2J"

.LDS_title:
    .ascii  "             _     ___   __  __      _   _       \n"
    .ascii  " __ __ __   /_\\   | _ \\ |  \\/  |  __| | | |  ___ \n"
    .ascii  " \\ V  V /  / _ \\  |   / | |\\/| | / _` | | | / -_)\n"
    .asciz  "  \\_/\\_/  /_/ \\_\\ |_|_\\ |_|  |_| \\__,_| |_| \\___|\n\n"

.LDS_indent:
    .asciz  "                 "

.LDS_empty_row:
    .asciz  "[ ][ ][ ][ ][ ]\n"
