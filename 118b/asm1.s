    .abiversion 2
    .globl _start
    .section ".text", "ax", @progbits
_start:
    li %r0, 4
    li %r3, 1
    lis %r4, msg@ha
    addi %r4, %r4, msg@l
    li %r5, 14
    sc
 
    li %r0, 1
    li %r3, 0
    sc
 
    .section ".message2", "a", @progbits
    .ascii "ll"
    .section ".message1", "a", @progbits
    .ascii "or"
 
    .section ".rodata", "a", @progbits
    .ascii "He"
    .section ".data", "aw", @progbits
    .ascii "ld"
    .section ".bss", "aw", @nobits
    .long 0
