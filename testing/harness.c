#include <stdio.h>
#include <stdint.h>

extern uint32_t mod(uint32_t, uint32_t);
extern int32_t print(const char *);
extern int32_t rand();
extern uint32_t strlen(const char *);
extern const char *rand_word();

int main() {
    printf("mod(31, 7): %d\n", mod(31, 7));
    print("Hello from print()!\n");
    printf("rand(): %d\n", rand());
    printf("strlen(\"Hello\"): %d\n", strlen("Hello"));
    printf("rand_word(): %s\n", rand_word());
    return 0;
}