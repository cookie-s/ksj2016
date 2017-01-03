main: asm1.o asm2.o
	ld -T script.ld -I/lib64/ld64.so.2 asm1.o asm2.o -o main

asm1.o: asm1.s
	as asm1.s -o asm1.o

asm2.o: asm2.s
	as asm2.s -o asm2.o

clean:
	rm *.o main

