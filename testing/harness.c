#include <stdint.h>
#include <stdio.h> 
extern int32_t print();
extern void print_title();
extern void print_empty_row();
extern void print_guess(const char *, const char *);
extern const char *rand_word();
extern int32_t input(char *, uint32_t);
extern void to_upper(char *);
extern void clear_screen();
extern int32_t guess_valid(char *);

extern void draw_screen(int turn, char guesses[6][6], const char *answer);

int main() {
    const char *answer = rand_word(); 
    char guesses[6][6];

    

    for (int i = 0; i < 6; i++) {
        int32_t last_guess_invalid = 0;

        while (1) {
            draw_screen(i, guesses, answer);

            if (last_guess_invalid) {
                print("\n\"");
                print(guesses[i]);
                print("\" is not in word list.");
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
    }

    return 0;
}
