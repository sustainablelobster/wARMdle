.syntax     unified
.extern     guess_list
.extern     guess_list_len
.global     guess_valid
.type       guess_valid, %function

.section    .text
@ int32_t guess_valid(const char *guess)
@   Returns 1 if guess is in valid guess list, 0 if not.
@
@   Register usage:
@       r4 - const char *guess - player's guess
@       r5 - const char guess_list[][6] - list of valid guesses
@       r6 - int32_t counter - loop counter
@       r7 - const int32_t guess_list_len - length of guess_list
guess_valid:
    push    {r4 - r7, lr}
    mov     r4, r0
    ldr     r5, =guess_list
    eor     r6, r6
    ldr     r7, =guess_list_len
    ldr     r7, [r7]

loop:
    cmp     r6, r7              @ int32_t is_valid = 0;
    eoreq   r0, r0              @ int32_t i = 0;
    beq     return              @ while (i < guess_list_len) { 
    mov     r0, r4              @   if (strcmp(guess, guess_list[i])) {
    mov     r1, r5              @       is_valid = 1;
    bl      strcmp              @       break;
    cmp     r0, #1              @   }
    beq     return              @   i++;
    add     r5, #6              @ }
    add     r6, #1
    b       loop

return:
    pop     {r4 - r7, pc}       @ return is_valid;
