.syntax unified
.section .text
.extern strcpy
.extern strchr
.extern color_print
.global print_guess
.type print_guess, %function

@ void print_guess(const char *guess, const char *answer)
@   Prints guess to screen with appropriate highlighting.
print_guess:
    push    {r4 - r8, lr}
    mov     r4, r0
    ldr     r5, =answer_cpy
    ldr     r6, =letter_box 
    eor     r7, r7   

    mov     r0, r1          @ strcpy(answer, answer_cpy)
    mov     r1, r5
    bl      strcpy

@ loop
0:
    cmp     r7, #5          @ int32_t i = 0;
    beq     2f              @ int32_t color;
                            @ char *match;
    ldrb    r0, [r4, r7]    @ while (i < 5) {
    cmp     r0, #' '        @   if (guess[i] == ' ') {
    moveq   r8, #0          @       color = 0;
    beq     1f              @   } else if (guess[i] == answer_cpy[i]) {
                            @       answer_cpy[i] = '#';
    ldrb    r1, [r5, r7]    @       color = 1;
    cmp     r0, r1          @   } else if (match = strchr(answer_cpy, guess[i])) {
    moveq   r8, #1          @       *match = '#';
    moveq   r0, #'#'        @       color = 2;
    strbeq  r0, [r5, r7]    @   } else {
    beq     1f              @       color = 3;
                            @   }
    mov     r1, r0          @   letter_box[1] = guess[i];
    ldr     r0, =answer_cpy @   color(letter_box, color);
    bl      strchr          @   i++;
    cmp     r0, #0          @ }
    movne   r8, #2
    movne   r1, #'#'
    strbne  r1, [r0]
    moveq   r8, #3

@ print letter
1:
    ldrb    r0, [r4, r7]
    strb    r0, [r6, #1]

    mov     r0, r6
    mov     r1, r8
    bl      color_print

    add     r7, #1
    b       0b

@ return
2:
    pop     {r4 - r8, pc}

.section .data
letter_box:
    .asciz  "[ ]"

answer_cpy:
    .asciz  "     "
