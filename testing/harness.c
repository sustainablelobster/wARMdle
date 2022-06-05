#include <stdint.h>
#include <stdio.h>

extern int32_t guess_valid(const char *);

int main() {
    printf("Valid guess: %d\n", guess_valid("NIKAU"));
    printf("Invalid guess: %d\n", guess_valid("12345"));
    printf("Invalid guess: %d\n", guess_valid("NIKAu"));
    printf("Valid guess: %d\n", guess_valid("DEATH"));
    return 0;
}
