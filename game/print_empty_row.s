.syntax unified
.section .text
.extern print
.global print_empty_row
.type print_empty_row, %function

@ void print_empty_row()
@   Prints an empty row to screen.
print_empty_row:
    push    {lr}

    ldr     r0, =.Lper_empty_row    @ print(.Lper_empty_row);
    bl      print

    pop     {pc}


.section .rodata
.Lper_empty_row:
    .asciz  "[ ][ ][ ][ ][ ]\n"