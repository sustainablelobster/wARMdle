#include <stdint.h>
#include <stdio.h>

extern void print_guess(const char *, const char *);
extern char *rand_word();

int main() {
    char *answer = rand_word();
    printf("Answer: %s\n", answer);
    print_guess("CRANE", answer);
    puts("");
    return 0;
}
