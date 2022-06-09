AS=arm-linux-gnueabihf-as
LD=arm-linux-gnueabihf-ld

all: run

run: warmdle
	qemu-arm -L /usr/arm-linux-gnueabihf ./warmdle

warmdle: ../*.o
	$(LD) ../*.o --no-dynamic-linker -o warmdle

clean:
	rm -f warmdle *.o
