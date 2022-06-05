.syntax unified
.section .text
.extern print
.global color_print
.type color_print, %function

@ void color_print(const char *str, int32_t color)
@   Prints str to STDOUT with background color.
@   Colors:
@       1 - green
@       2 - orangish
@       3 - gray
@       ? - default
@   Returns number of bytes written, -1 if error.
color_print:
    push    {r4, r7, lr}
    mov     r4, r0

    cmp     r1, #1              @ const char *color_code;
    ldreq   r0, =green          @
    beq     0f                  @ switch (color) {
    cmp     r1, #2              @   case 1:
    ldreq   r0, =orangish       @       color_code = green;
    beq     0f                  @       break;
    cmp     r1, #3              @   case 2:
    ldreq   r0, =gray           @       color_code = orangish;
    beq     0f                  @       break;
    ldr     r0, =default        @   case 3:
                                @       color_code = gray;
                                @       break;
                                @   default:
                                @       color_code = default;
                                @ }

@ print
0:
    bl      print               @ print(color_code);
    mov     r0, r4              @ print(str);
    bl      print               @ print(default);
    ldr     r0, =default
    bl      print

    pop     {r4, r7, pc}        @ return;


.section .data
green:
    .byte   0x1b
    .ascii  "[97m"
    .byte   0x1b
    .asciz  "[42m"

orangish:
    .byte   0x1b
    .ascii  "[97m"
    .byte   0x1b
    .asciz  "[43m"

gray:
    .byte   0x1b
    .ascii  "[97m"
    .byte   0x1b
    .asciz  "[100m"

default:
    .byte   0x1b
    .ascii  "[39m"
    .byte   0x1b
    .asciz  "[49m"
