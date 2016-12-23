.globl ntimes

.section .text
ntimes:
    std %r31, -8(%r1)
    std %r30, -16(%r1)
    mflr %r0
    std %r0, 16(%r1)
    stdu %r1, -48(%r1)

    mr %r31, %r3 # n
    mr %r30, %r4 # f
    mr %r3, %r5 # x

loop:
    and. %r31, %r31, %r31
    beq loop_exit

    mtctr %r30
    bctrl

    subi %r31, %r31, 1
    b loop

loop_exit:
    ld %r1, 0(%r1)
    ld %r0, 16(%r1)
    mtlr %r0
    ld %r31, -8(%r1)
    ld %r30, -16(%r1)
    blr

