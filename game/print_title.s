.syntax unified
.section .text
.extern print
.global print_title
.type print_title, %function

@ void print_title()
@   Prints title to screen.
print_title:
    push    {lr}

    ldr     r0, =.LPT_title    @ print(.LPT_title);
    bl      print

    pop     {pc}


.section .rodata
.LPT_title:
    .ascii  "             _     ___   __  __      _   _       \n"
    .ascii  " __ __ __   /_\\   | _ \\ |  \\/  |  __| | | |  ___ \n"
    .ascii  " \\ V  V /  / _ \\  |   / | |\\/| | / _` | | | / -_)\n"
    .asciz  "  \\_/\\_/  /_/ \\_\\ |_|_\\ |_|  |_| \\__,_| |_| \\___|\n\n"




                                                 

