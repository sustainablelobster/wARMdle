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

        while (1) {
            draw_screen(i, guesses, answer);

            print("\n> ");
            input(guesses[i], 5);
            to_upper(guesses[i]);

            if (!guess_valid(guesses[i])) {
                print("\"");
                print(guesses[i]);
                print("\" not in word list.\n");
            } else {
                break;
            }
        }
    }

    return 0;
}
