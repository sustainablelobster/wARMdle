.syntax     unified
.extern     strlen
.global     print
.type       print, %function

.section    .text
@ void print(const char *str)
@   Prints str to STDOUT.
@
@   Register usage:
@       r4 - const char *str - string to print
print:
    push    {r4, r7, lr}
    mov     r4, r0

    bl      strlen          @ uint32_t len = strlen(str);
    mov     r2, r0

    mov     r0, #1          @ write(STDOUT_FILENO, str, len);
    mov     r1, r4
    mov     r7, #0x04
    svc     #0

    pop     {r4, r7, pc}    @ return written;
