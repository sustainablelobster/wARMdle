#include <stdint.h>
#include <stdio.h>

extern void print_guess(const char *, const char *);

int main() {
    print_guess("masts", "makos");
    puts("");
    return 0;
}
