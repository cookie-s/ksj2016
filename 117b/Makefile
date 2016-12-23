.PHONY: all

all: main

main.o: asm.s
	as asm.s -o main.o

main: main.o
	ld main.o -o main
