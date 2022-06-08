AS=arm-linux-gnueabihf-as
LD=arm-linux-gnueabihf-ld

all: run

run: warmdle
	qemu-arm -L /usr/arm-linux-gnueabihf ./warmdle

warmdle: game.o utils.o
	$(LD) game.o utils.o -o warmdle

game.o: ../game/*.s
	$(AS) ../game/*.s -o game.o

utils.o: ../utils/*.s
	$(AS) ../utils/*.s -o utils.o

clean:
	rm -f warmdle *.o
