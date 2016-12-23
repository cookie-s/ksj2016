.abiversion 2
.globl _start

.rodata
your_name:
    .asciz "Your name: "
hello:
    .asciz "Hello, "

.data
    .space 1
buf:
    .space 65536

.text
_start:
    std  %r31, -8(%r1) # 誰のためでもないけどまあ一応退避。
    stdu %r1, -48(%r1) # stack frame

ask:
    li %r0, 4 # write
    li %r3, 1 # stdout
    addis %r4, %r2, your_name@ha
    addi  %r4, %r4, your_name@l
    li %r5, 11 # count
    sc

    li %r31, 0 # counter

read_128:
    addis %r4, %r2, buf@ha
    addi  %r4, %r4, buf@l
    add   %r4, %r4, %r31
    lbz %r5, -1(%r4)
    cmpwi %r5, 10 # LF
    beq say

    li %r0, 3 # read
    li %r3, 0 # stdin
    li %r5, 128 # count
    sc
    add %r31, %r31, %r3
    bge read_128

say:
    li %r0, 4 # write
    li %r3, 1 # stdout
    addis %r4, %r2, hello@ha
    addi  %r4, %r4, hello@l
    li %r5, 7 # count
    sc

    li %r0, 4 # write
    li %r3, 1 # stdout
    addis %r4, %r2, buf@ha
    addi  %r4, %r4, buf@l
    mr %r5, %r31 # count
    sc

    li %r0, 1 # exit
    li %r3, 0 # success
    sc
