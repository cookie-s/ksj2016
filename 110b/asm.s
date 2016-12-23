.globl fib


fib:
    cmpwi %r3, 1
    beq ret1
    blt ret0    # fib(-1)は0です。

    #  0 | r1
    #  8 | cr
    # 12 | (align)
    # 16 | lr
    # 24 | r2
    # 32 | two local variables
    # 48 | (next stack frame)

    std %r31, -8(%r1)
    std %r30, -16(%r1) # これはスタックフレームから見れば+32の位置。

    mflr %r0
    std %r0, 16(%r1)
    stdu %r1, -48(%r1)

    mr %r31, %r3 # 引数を退避
    subi %r3, %r31, 1
    bl fib  # fib(n-1)

    mr %r30, %r3 # 第一の結果を退避
    subi %r3, %r31, 2
    bl fib  # fib(n-2)

    add %r3, %r3, %r30 # ２つの結果を加算、これを戻り値に。

    ld %r1, 0(%r1)
    ld %r0, 16(%r1)
    mtlr %r0

    ld %r31, -8(%r1)  # 非揮発性レジスタを戻しておく。
    ld %r30, -16(%r1)
    blr

ret0:
    li %r3, 0
    blr
ret1:
    li %r3, 1
    blr
