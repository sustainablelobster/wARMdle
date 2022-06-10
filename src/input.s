.syntax     unified
.extern     flush_stdin
.extern     trim_newline
.global     input
.type       input, %function

.section    .text
@ void input(char *buf, uint32_t count)
@   Read up to count bytes from STDIN into buf, then flush STDIN.
@   buf must be at least count+1 bytes large to allow for null terminator.
@
@   Register usage:
@       r4 - char *buf - buffer to store input   
input:
    push    {r4, r7, lr}
    mov     r4, r0

    mov     r2, r1          @ int32_t bytes_read = read(STDIN_FILENO, buf, count);
    mov     r1, r0
    eor     r0, r0
    mov     r7, #0x03
    svc     #0

    eor     r1, r1          @ buf[bytes_read] = 0;
    strb    r1, [r4, r0]

    mov     r0, r4          @ trim_newline(buf);
    bl      trim_newline
    
    bl      flush_stdin     @ flush_stdin();

    pop     {r4, r7, pc}    @ return bytes_read;
