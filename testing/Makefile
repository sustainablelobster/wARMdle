CC=arm-linux-gnueabihf-gcc
AS=arm-linux-gnueabihf-as

all: run

run: harness
	qemu-arm -L /usr/arm-linux-gnueabihf ./harness

harness: harness.c game.o utils.o
	$(CC) harness.c game.o utils.o -Wall -g -o harness

game.o: ../game/*.s
	$(AS) ../game/*.s -o game.o

utils.o: ../utils/*.s
	$(AS) ../utils/*.s -o utils.o

clean:
	rm -f harness *.o
