.syntax unified
.section .text

.global flush_stdin
.type flush_stdin, %function

@ void flush_stdin()
@   Clear STDIN buffer.
flush_stdin:
    push    {r4, r7, r11}   @ char buf[4];
    mov     r11, sp
    sub     sp, #4

    eor     r0, r0          @ int32_t og_flags = fcntl(STDIN_FILENO, F_GETFL);
    mov     r1, #1
    mov     r7, #0x37
    svc     #0
    mov     r4, r0

    eor     r0, r0          @ fcntl(STDIN_FILENO, F_SETFL, og_flags | O_NONBLOCK);
    mov     r1, #4
    orr     r2, r4, #04000
    mov     r7, #0x37
    svc     #0

@ loop
0:
    eor     r0, r0          @ while(read(STDIN_FILENO, buf, 4) == 4)
    mov     r1, sp          @   // loop
    mov     r2, #4
    mov     r7, #0x03
    svc     #0
    cmp     r0, #4
    beq     0b

    eor     r0, r0          @ fcntl(STDIN_FILENO, F_SETFL, og_flags);
    mov     r1, #4
    mov     r2, r4
    mov     r7, #0x37
    svc     #0

    add     sp, #4          @ return;
    pop     {r4, r7, r11}
    bx      lr
