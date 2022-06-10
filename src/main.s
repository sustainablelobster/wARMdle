.syntax     unified
.extern     draw_screen
.extern     get_guess
.extern     guess_valid
.extern     print_bad_guess
.extern     print_end_msg
.extern     rand_word
.global     _start
.type       _start, %function
.type       main, %function 

.section    .text
@ int32_t _start()
@   Entry point of program.
_start:
    bl      main                @ main();

    eor     r0, r0              @ exit(0);
    mov     r7, #0x01
    svc     #0

@ void main()
@   Play game.
@
@   Register usage:
@       sp - char guesses[6][6] - player guesses
@       r4 - int32_t turn - current turn (0 - 5)
@       r5 - int32_t last_guess_valid - 1 if last guess is on guess_list, else 0
@       r6 - int32_t player_won - 1 if player guessed answer, else 0
@       r7 - const char *answer - word player is trying to guess
@       r8 - char *guess - the current guess
main:
    push    {r4 - r8, r11, lr}
    mov     r11, sp
    sub     sp, #36             @ char guesses[6][6];

    eor     r4, r4              @ int32_t turn = 0;
    mov     r5, #1              @ int32_t last_guess_valid = 1;
    eor     r6, r6              @ int32_t player_won = 0;

    bl      rand_word           @ const char *answer = rand_word();
    mov     r7, r0

loop:
    mov     r0, r4              @ while (turn < 6 && !player_won) {
    mov     r1, sp              @   draw_screen(turn, guesses, answer);
    mov     r2, r7              @   char *guess = guesses[turn];
    bl      draw_screen         @   
                                @   if (!last_guess_valid) {
    cmp     r4, #6              @       print_bad_guess(guess);
    bge     end                 @   }
    cmp     r6, #1              @
    bge     end                 @   get_guess(guess);
                                @   last_guess_valid = guess_valid(guess);   
    mov     r8, #6              @   
    mul     r8, r4              @   if (last_guess_valid) {
    add     r8, sp              @       turn++;
                                @   }
    cmp     r5, #0              @
    moveq   r0, r8              @   player_won = strcmp(guess, answer);
    bleq    print_bad_guess     @ }

    mov     r0, r8
    bl      get_guess

    mov     r0, r8
    bl      guess_valid
    mov     r5, r0
    add     r4, r5

    mov     r0, r7
    mov     r1, r8
    bl      strcmp
    mov     r6, r0

    b       loop

end:
    mov     r0, r6              @ draw_screen(turn, guesses, answer);
    mov     r1, r7              @ print_end_msg(player_won, answer);
    bl      print_end_msg

    add     sp, #36
    pop     {r4 - r8, r11, pc}
