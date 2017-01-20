.PHONY: all test

all: main

main: main.o # http://stackoverflow.com/questions/13132138/purest-way-to-assemble-compile-a-file-with-no-other-elf-object-bloat
	ld main.o -o main --oformat=binary

main.o: asm.s
	as asm.s -o main.o

test:
	./main | diff - ./main && echo 'main is quine.' && wc ./main
