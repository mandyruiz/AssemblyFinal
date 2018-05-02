NAME=EscapeEH8

all: EscapeEH8

clean:
	rm -rf EscapeEH8 EscapeEH8.o

EscapeEH8: EscapeEH8.asm
	nasm -f elf -F dwarf -g EscapeEH8.asm
	gcc -g -m32 -o EscapeEH8 EscapeEH8.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
