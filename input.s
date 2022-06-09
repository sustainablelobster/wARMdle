.syntax unified
.section .text
.extern flush_stdin
.extern trim_newline
.global input
.type input, %function

@ int32_t input(char *buf, uint32_t count)
@   Read up to count bytes from STDIN into buf.
@   buf must be at least count+1 bytes large, to allow for null terminator.
@   STDIN is then flushed.
@   Returns number of bytes read, -1 if error.
input:
    push    {r4, r7, lr}
    mov     r4, r0

    mov     r2, r1          @ int32_t bytes_read = read(STDIN_FILENO, buf, count);
    mov     r1, r0          @ if (bytes_read == -1)
    eor     r0, r0          @   goto .LINP_return;
    mov     r7, #0x03
    svc     #0
    cmp     r0, #-1
    beq     .LINP_return

    eor     r1, r1          @ buf[bytes_read] = 0;
    strb    r1, [r4, r0]

    mov     r0, r4          @ trim_newline(buf);
    bl      trim_newline
    
    mov     r4, r0          @ flush_stdin();
    bl      flush_stdin
    mov     r0, r4

.LINP_return:
    pop     {r4, r7, pc}    @ return bytes_read;
