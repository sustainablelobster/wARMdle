.syntax     unified
.extern     print
.extern     print_empty_row
.extern     print_guess
.extern     print_title
.global     draw_screen
.type       draw_screen, %function

.section    .rodata
clear_code:
    .byte   0x1b
    .ascii  "[1;1H"
    .byte   0x1b
    .asciz  "[2J"

title:
    .ascii  "             _     ___   __  __      _   _       \n"
    .ascii  " __ __ __   /_\\   | _ \\ |  \\/  |  __| | | |  ___ \n"
    .ascii  " \\ V  V /  / _ \\  |   / | |\\/| | / _` | | | / -_)\n"
    .asciz  "  \\_/\\_/  /_/ \\_\\ |_|_\\ |_|  |_| \\__,_| |_| \\___|\n\n"

row_indent:
    .asciz  "                 "

empty_row:
    .asciz  "[ ][ ][ ][ ][ ]\n"


.section    .text
@ void draw_screen(int32_t turn, char guesses[6][6], const char *answer)
@   Prints game screen.
@
@   Register usage:
@       r4 - int32_t turn - current game turn (0-5)
@       r5 - char guesses[6][6] - player guesses
@       r6 - char *answer - word player is trying to guess
@       r7 - int32_t counter - count for print_row_loop
draw_screen:
    push    {r4 - r7, lr}
    mov     r4, r0
    mov     r5, r1
    mov     r6, r2
    eor     r7, r7

    ldr     r0, =clear_code     @ print(clear_code);
    bl      print

    ldr     r0, =title          @ print(title);
    bl      print

print_row_loop:
    ldr     r0, =row_indent     @ for (int32_t i = 0; i < 6; i++) {
    bl      print               @   print(row_indent);
                                @
    cmp     r4, r7              @   if (i < turn) {
    ble     print_empty_row     @       print_guess(guess[i], answer);
                                @       continue;
    mov     r0, #6              @   }
    mul     r0, r7              @
    add     r0, r5              @   print(empty_row);
    mov     r1, r6              @ }
    bl      print_guess
    b       continue

print_empty_row:
    ldr     r0, =empty_row
    bl      print

continue:
    add     r7, #1
    cmp     r7, #6
    blt     print_row_loop

    pop     {r4 - r7, pc}
