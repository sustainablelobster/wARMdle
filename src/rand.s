.syntax     unified
.global     rand
.type       rand, %function

.section    .rodata
urandom:
    .asciz "/dev/urandom"


.section    .text
@ int32_t rand()
@   Returns a random integer.
@
@   Register usage:
@       r4 - int32_t fd - /dev/urandom file descriptor
@       sp - char buf[4] - temporary buffer to hold urandom data
rand:
    push    {r4, r7, r11}
    mov     r11, sp
    sub     sp, #4

    ldr     r0, =urandom           @ int32_t fd = open("/dev/urandom", O_RDONLY);
    eor     r1, r1                 
    mov     r7, #0x05
    svc     #0                     
    mov     r4, r0

    mov     r1, sp                 @ char buf[4];
    mov     r2, #4                 @ read(fd, buf, 4);
    mov     r7, #0x03
    svc     #0

    mov     r0, r4                 @ close(fd);
    mov     r7, #0x06
    svc     #0

    ldr     r0, [sp]               @ int32_t rand_num = (int32_t) buf[0];
    add     sp, #4                 @ return rand_num;
    pop     {r4, r7, r11}
    bx      lr
