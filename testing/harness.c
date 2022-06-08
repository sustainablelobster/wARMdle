#include <stdint.h>

extern int32_t print();
extern void print_title();
extern void print_empty_row();
extern void print_guess(const char *, const char *);
extern const char *rand_word();
extern int32_t input(char *, uint32_t);
extern void to_upper(char *);
extern void clear_screen();
extern int32_t guess_valid(char *);
extern int32_t strcmp(const char *, const char *);

extern void draw_screen(int turn, char guesses[6][6], const char *answer);

int main() {
    const char *answer = rand_word(); 
    char guesses[6][6];
    int32_t player_won = 0;

    int i = 0;
    for (; i < 6; i++) {
        if (player_won) {
            break;
        }

        int32_t last_guess_invalid = 0;

        while (1) {
            draw_screen(i, guesses, answer);

            if (last_guess_invalid) {
                print("\n\"");
                print(guesses[i]);
                print("\" not in word list");
            } 

            print("\n> ");
            input(guesses[i], 5);
            to_upper(guesses[i]);

            if (guess_valid(guesses[i])) {
                break;
            } else {
                last_guess_invalid = 1;
            }
        }

        if (strcmp(guesses[i], answer)) {
            player_won = 1;
        }
    }

    draw_screen(i, guesses, answer);
    if (player_won) {
        print("\nGOOOOOOOOOOOAL!\n");
    } else {
        print("\nThe word was: ");
        print(answer);
        print("\n");
    }

    return 0;
}