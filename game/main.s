.syntax unified
.section .text
.extern rand_word
.extern draw_screen
.extern print_bad_guess
.extern get_guess
.extern guess_valid
.extern print_end_msg
.global _start
.type   _start, %function
.type   main, %function 

@ int32_t _start()
@   Entry point of program.
_start:
    bl      main            @ main();

    eor     r0, r0          @ exit(0);
    mov     r7, #0x01
    svc     #0

@ void main()
@   Play game.
main:
    push    {r4 - r9, lr}   @ char guesses[6][6];
    ldr     r4, =guesses    @ int32_t turn = 0;
    eor     r5, r5          @ int32_t last_guess_valid = 1;
    mov     r6, #1          @ int32_t player_won = 0;
    eor     r7, r7

    bl      rand_word       @ const char *answer = rand_word();
    mov     r8, r0

.LMAIN_loop:
    mov     r0, r5          @ while (turn < 6 && !player_won) {
    mov     r1, r4          @   draw_screen(turn, guesses, answer);
    mov     r2, r8          @   char *guess = guesses[turn];
    bl      draw_screen     @   
                            @   if (!last_guess_valid) {
    cmp     r5, #6          @       print_bad_guess(guess);
    bge     .LMAIN_end      @   }
    cmp     r7, #1          @
    bge     .LMAIN_end      @   get_guess(guess);
                            @   last_guess_valid = guess_valid(guess);   
    mov     r9, #6          @   
    mul     r9, r5          @   if (last_guess_valid) {
    add     r9, r4          @       turn++;
                            @   }
    cmp     r6, #0          @
    moveq   r0, r9          @   player_won = strcmp(guess, answer);
    bleq    print_bad_guess @ }

    mov     r0, r9
    bl      get_guess

    mov     r0, r9
    bl      guess_valid
    mov     r6, r0
    add     r5, r6

    mov     r0, r9
    mov     r1, r4
    bl      strcmp
    mov     r7, r0

    b       .LMAIN_loop

.LMAIN_end:
    mov     r0, r7          @ draw_screen(turn, guesses, answer);
    mov     r1, r4          @ print_end_msg(player_won, answer);
    bl      print_end_msg

    pop     {r4 - r9, pc}


.section .bss
    .lcomm  guesses, 36
