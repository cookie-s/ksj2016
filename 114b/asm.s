.globl print_cwd

.section .data
buf:
    .space 1024 # 1024bytes確保

.section .text
print_cwd:
    mflr %r0
    std %r0, 16(%r1)
    stdu %r1, -32(%r1)

    li %r0, 182 # getcwd
    addis %r3, %r2, buf@toc@ha
    addi  %r3, %r3, buf@toc@l
    sc
    # man 2 getcwd だとbufが帰ってくるっぽいのに、実際のところはサイズが帰ってきている気がする。

    li %r0, 4 # write
    li %r3, 1 # stdout
    addis %r4, %r2, buf@toc@ha
    addi  %r4, %r4, buf@toc@l
    li %r5, 1024
    sc

    ld %r1, 0(%r1)
    ld %r0, 16(%r1)
    mtlr %r0
    blr
