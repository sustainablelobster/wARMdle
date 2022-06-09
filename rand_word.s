.syntax unified
.section .text
.extern rand
.extern mod
.extern word_list
.extern word_list_len
.global rand_word
.type rand_word, %function

.arm
@ const char *rand_word()
@   Returns a random word from the word list
rand_word:
    push    {lr}
    
    bl      rand                 @ uint32_t rand_num = rand();
    ldr     r1, =word_list_len   @ rand_num %= word_list_len;
    ldr     r1, [r1]             @ rand_num *= 6;
    bl      mod
    mov     r1, #6
    mul     r1, r0, r1

    ldr     r0, =word_list      @ return word_list[rand_num];
    add     r0, r1
    pop     {pc}
