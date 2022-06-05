.syntax unified
.section .text
.extern print
.global clear_screen
.type clear_screen, %function

@ void clear_screen()
@   Clears terminal screen.
clear_screen:
    push    {lr}

    ldr     r0, =clear_code @ print(clear_code)
    bl      print

    pop     {pc}


.section .data
clear_code:
    .byte   0x1b            @ const char *clear_code = "\e[1;1H\e[2J";
    .ascii  "[1;1H"
    .byte   0x1b
    .asciz  "[2J"
