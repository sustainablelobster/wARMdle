.syntax unified
.section .text
.extern strcpy
.extern strchr
.extern print
.global print_guess
.type print_guess, %function

@ void print_guess(const char *guess, const char *answer)
@   Prints guess to screen with appropriate highlighting.
print_guess:
    push    {r4 - r7, lr}           @ char answer_cpy[6];
    mov     r4, r0                  @ char letter_box[4] = "[ ]";
    ldr     r5, =answer_cpy
    ldr     r6, =.Lpg_letter_box

    mov     r0, r1                  @ strcpy(answer, answer_cpy);
    mov     r1, r5
    bl      strcpy
    eor     r7, r7

.Lpg_match_loop:
    ldrb    r0, [r4, r7]            @ for (int32_t i = 0; i < 5; i++) {
    ldrb    r1, [r5, r7]            @   if (guess[i] == answer_cpy[i]) {
    cmp     r0, r1                  @       answer_cpy[i] = '=';
    bne     .Lpg_match_loop_cont    @   }
                                    @ }
    mov     r0, #'='
    strb    r0, [r5, r7]

.Lpg_match_loop_cont:
    add     r7, #1
    cmp     r7, #5
    blt     .Lpg_match_loop
    eor     r7, r7

.Lpg_print_loop:
    ldrb    r0, [r5, r7]        @ for (int32_t i = 0; i < 5; i++) {
    cmp     r0, #'='            @   const char *color;
    ldreq   r0, =.Lpg_correct   @   char *strchr_ret = strchr(answer_cpy, guess[i]);
    beq     .Lpg_print          @   if (answer_cpy[i] == '=') {
                                @       color = 6f; // green (correct);
    mov     r0, r5              @   } else if (strchr_ret) {
    ldrb    r1, [r4, r7]        @       color = 7f; // red (almost correct)
    bl      strchr              @       *strchr_ret = '~'; 
    mov     r1, r0              @   } else {
    cmp     r0, #0              @       color = 8f; // gray (incorrect)
    ldreq   r0, =.Lpg_incorrect @   }
    beq     .Lpg_print          @   print(color);
                                @   letter_box[i] = guess[i];
    mov     r0, #'~'            @   print(letter_box);
    strb    r0, [r1]            @ }
    ldr     r0, =.Lpg_misplace

@ print and prep next loop iteration
.Lpg_print:
    bl      print
    ldrb    r0, [r4, r7]
    strb    r0, [r6, #1]
    mov     r0, r6
    bl      print

    add     r7, #1
    cmp     r7, #5
    blt     .Lpg_print_loop

    ldr     r0, =.Lpg_default
    bl      print

    pop     {r4 - r7, pc}


.section .bss
    .lcomm  answer_cpy, 6


.section .data
.Lpg_letter_box:
    .asciz  "[ ]"


.section .rodata
.Lpg_default:
    .byte   0x1b
    .ascii  "[39m"
    .byte   0x1b
    .asciz  "[49m"

.Lpg_correct:
    .byte   0x1b
    .ascii  "[97m"
    .byte   0x1b
    .asciz  "[42m"

.Lpg_misplace:
    .byte   0x1b
    .ascii  "[97m"
    .byte   0x1b
    .asciz  "[41m"

.Lpg_incorrect:
    .byte   0x1b
    .ascii  "[97m"
    .byte   0x1b
    .asciz  "[100m"
