#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
       #include <fcntl.h>

extern uint32_t mod(uint32_t, uint32_t);
extern int32_t print(const char *);
extern int32_t rand();
extern uint32_t strlen(const char *);
extern const char *rand_word();
extern int32_t input(char *, uint32_t);
extern void to_upper(char *);

int main() {
    printf("mod(31, 7): %d\n", mod(31, 7));
    print("Hello from print()!\n");
    printf("rand(): %d\n", rand());
    printf("strlen(\"Hello\"): %d\n", strlen("Hello"));
    printf("rand_word(): %s\n", rand_word());

    // input() test
    char buf[6];
    print("Enter five-letter word: ");
    input(buf, 5);
    printf("Got: %s\n", buf);

    // to_upper() test
    to_upper(buf);
    printf("to_upper(buf): %s\n", buf);
    return 0;
}
