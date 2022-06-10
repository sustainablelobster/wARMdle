.syntax     unified
.extern     strlen
.global     strcmp
.type       strcmp, %function

.section    .text
@ int32_t strcmp(const char *s1, const char *s2)
@   Return 1 if s1 and s2 are the same, 0 otherwise.
@
@   Register usage:
@       r4 - const char *s1
@       r5 - const char *s2
@       r6 - uint32_t s1_len;
strcmp:
    push    {r4 - r6, lr}    
    mov     r4, r0
    mov     r5, r1

    bl      strlen              @ uint32_t s1_len = strlen(s1);
    mov     r6, r0

    mov     r0, r5              @ uint32_t s2_len = strlen(s2);
    bl      strlen

    cmp     r0, r6              @ if (s1_len != s2_len)
    eorne   r0, r0              @   return 0;
    bne     return
    
    mov     r0, #1              @ int32_t equal = 1;       

loop:
    ldrb    r1, [r4]            @ while (*s1 != 0) {
    cmp     r1, #0              @   if (*s1 != *s2) {
    beq     return              @       equal = 0;
    ldrb    r2, [r5]            @       break;
    cmp     r1, r2              @   }
    eorne   r0, r0              @
    bne     return              @   s1++;
    add     r4, #1              @   s2++;
    add     r5, #1              @ }
    b       loop

return:
    pop     {r4 - r6, pc}       @ return equal;
