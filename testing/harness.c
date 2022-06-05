#include <stdint.h>
#include <stdio.h>

extern int32_t string_cmp(const char *, const char *);

int main() {
    printf("Same string: %d\n", string_cmp("hello", "hello"));
    printf("Different lengths: %d\n", string_cmp("hell", "hello"));
    printf("Same length, different strings: %d\n", string_cmp("hello", "hella"));

    return 0;
}
