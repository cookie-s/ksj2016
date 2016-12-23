.abiversion 2
.globl _start

.rodata
path:
    .asciz "/etc/passwd"

.text
_start:
    li %r0, 5       # open
    addis %r3, 0,   path@ha
    addi  %r3, %r3, path@l
    li %r4, 0       # flags: O_RDONLY
    sc

    li %r0, 90      # mmap
    mr %r7, %r3     # fd: return value
    li %r3, 0       # addr: NULL
    lis %r4, 1      # length: 65536
    li %r5, 1       # prot: PROT_READ
    li %r6, 2       # flags: MAP_SHARED
    li %r8, 0       # offset: 0
    sc

    li %r0, 4       # write
    mr %r4, %r3     # buf: return value
    li %r3, 1       # fd: stdout
    lis %r5, 1      # count: 65536
    sc

    li %r0, 1       # exit
    li %r3, 0       # status: EXIT_SUCCESS
    sc
