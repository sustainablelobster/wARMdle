.syntax unified
.section .text
.global rand
.type rand, %function

@ int32_t rand()
@   Returns a random integer, -1 if error.
rand:
    push    {r7, r11}
    mov     r11, sp
    sub     sp, #4

    ldr     r0, =urandom    @ int32_t rand_num; 
    eor     r1, r1          @ int32_t fd = open("/dev/urandom", O_RDONLY);
    mov     r7, #0x05       @ if (fd == -1) {
    svc     #0              @   rand_num = -1;
    cmp     r0, #-1         @   goto 0f;
    beq     0f              @ }
    mov     r3, r0

    mov     r1, sp          @ char buf[4];
    mov     r2, #4          @ ssize_t bytes_read = read(fd, buf, 4);
    mov     r7, #0x03       @ if (bytes_read != 4) {
    svc     #0              @   rand_num = -1;
    cmp     r0, #4          @   goto 0f;
    movne   r0, #-1         @ }
    bne     0f

    mov     r0, r3          @ close(fd);
    mov     r7, #0x06
    svc     #0

    ldr     r0, [sp]        @ rand_num = (int32_t)(buf[0]);
    cmp     r0, #-1         @ if (rand_num == -1) 
    subeq   r0, #1          @   rand_num--;

@ local return
0:
    add     sp, #4          @ return rand_num;
    pop     {r7, r11}
    bx      lr


.section .data
urandom:
    .asciz "/dev/urandom"
