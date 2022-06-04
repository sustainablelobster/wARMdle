.syntax unified
.section .text

.extern strlen

.global print
.type print, %function

@ int32_t print(const char *str)
@   Prints str to STDOUT.
@   Returns number of bytes written, -1 if error.
print:
    push    {r4, r7, lr}
    mov     r4, r0

    bl      strlen          @ uint32_t len = strlen(str);
    mov     r2, r0

    mov     r0, #1          @ int32_t written = write(STDOUT_FILENO, str, len);
    mov     r1, r4
    mov     r7, #0x04
    svc     #0

    pop     {r4, r7, pc}    @ return written;
