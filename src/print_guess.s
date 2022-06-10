.syntax unified
.section .text
.extern strcpy
.extern strchr
.extern print
.global print_guess
.type print_guess, %function

.section .data
letter_box:
    .asciz  "[ ]"


.section .rodata
green_color_code:
    .byte   0x1b
    .ascii  "[97m"
    .byte   0x1b
    .asciz  "[42m"

red_color_code:
    .byte   0x1b
    .ascii  "[97m"
    .byte   0x1b
    .asciz  "[41m"

gray_color_code:
    .byte   0x1b
    .ascii  "[97m"
    .byte   0x1b
    .asciz  "[100m"

default_color_newline:
    .byte   0x1b
    .ascii  "[39m"
    .byte   0x1b
    .asciz  "[49m\n"


.section    .text
@ void print_guess(const char *guess, const char *answer)
@   Prints guess to screen with appropriate highlighting.
print_guess:
    push    {r4 - r6, r11, lr}      @ char answer_cpy[6];
    mov     r11, sp
    sub     sp, #8
    
    mov     r4, r0                  @ char letter_box[4] = "[ ]";
    ldr     r5, =letter_box

    mov     r0, r1                  @ strcpy(answer, answer_cpy);
    mov     r1, sp
    bl      strcpy

    eor     r6, r6

match_loop:
    ldrb    r0, [r4, r6]            @ for (int32_t i = 0; i < 5; i++) {
    ldrb    r1, [sp, r6]            @   if (guess[i] == answer_cpy[i]) {
    cmp     r0, r1                  @       answer_cpy[i] = '=';
    bne     match_loop_cont         @   }
                                    @ }
    mov     r0, #'='
    strb    r0, [sp, r6]

match_loop_cont:
    add     r6, #1
    cmp     r6, #5
    blt     match_loop

    eor     r6, r6

print_loop:
    ldrb    r0, [sp, r6]            @ for (int32_t i = 0; i < 5; i++) {
    cmp     r0, #'='                @   const char *color;
    ldreq   r0, =green_color_code   @   char *strchr_ret = strchr(answer_cpy, guess[i]);
    beq     print_letter            @   if (answer_cpy[i] == '=') {
                                    @       color = 6f; // green (correct);
    mov     r0, sp                  @   } else if (strchr_ret) {
    ldrb    r1, [r4, r6]            @       color = 7f; // red (almost correct)
    bl      strchr                  @       *strchr_ret = '~';
                                    @   } else {     
    mov     r1, r0                  @       color = 8f; // gray (incorrect)
    cmp     r0, #0                  @   }   
    ldreq   r0, =gray_color_code    @   
    beq     print_letter            @   print(color);
                                    @   letter_box[i] = guess[i];
    mov     r0, #'~'                @   print(letter_box);
    strb    r0, [r1]                @ }
    ldr     r0, =red_color_code

print_letter:
    bl      print

    ldrb    r0, [r4, r6]
    strb    r0, [r5, #1]
    mov     r0, r5
    bl      print

    add     r6, #1
    cmp     r6, #5
    blt     print_loop

    ldr     r0, =default_color_newline
    bl      print

    add     sp, #8
    pop     {r4 - r6, r11, pc}
