101b: 101b_c.o 101b_a.o
	ld -I/lib64/ld64.so.2 101b_c.o 101b_a.o /usr/lib/powerpc64le-linux-gnu/crt*.o /usr/lib/powerpc64le-linux-gnu/libc.so -o 101b

101b.i: 101b.c
	cpp 101b.c -o 101b.i

101b_c.s: 101b.i
	cc -S 101b.i -o 101b_c.s

101b_c.o: 101b_c.s
	as 101b_c.s -o 101b_c.o

101b_a.o: 101b.s
	as 101b.s -o 101b_a.o

clean:
	rm 101b_c.s 101b_c.o 101b_a.o 101b.i 101b

