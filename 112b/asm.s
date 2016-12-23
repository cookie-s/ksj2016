.globl mmul

.section .text

# start mmul
mmul:
    # %r3 : m
    # %r4 : n
    # %r5 : p
    # %r6 : a[m][n]
    # %r7 : b[n][p]
    # %r8 : c[m][p]
    
clear:
    li %r9, 0 # %r9 for 0...m loop counter
clear_m_loop:
    li %r10, 0 # %r10 for 0...p loop counter
clear_p_loop:
    mullw %r11, %r9, %r5
    add  %r11, %r11, %r10
    mulli %r11, %r11, 8 # sizeof(double)
    add  %r11, %r11, %r8 # &c[%r9][%r10] == c + sizeof(double)*(%r9 * p + %r10)
    li %r12, 0 # 0x0000000000000000 is 0.0
    std %r12, 0(%r11)

    addi %r10, %r10, 1
    cmpw %r10, %r5
    blt clear_p_loop

    addi %r9, %r9, 1
    cmpw %r9, %r3
    blt clear_m_loop

mmul_main:
    li %r9, 0 # m
mmul_main_m_loop:
    li %r10, 0 # p
mmul_main_p_loop:
    li %r11, 0 # n
mmul_main_n_loop:
    mullw %r12, %r9, %r4
    add  %r12, %r12, %r11
    mulli %r12, %r12, 8
    add %r12, %r12, %r6
    lfd %f0, 0(%r12) # a[%9][%11]

    mullw %r12, %r11, %r5
    add  %r12, %r12, %r10
    mulli %r12, %r12, 8
    add %r12, %r12, %r7
    lfd %f1, 0(%r12) # b[%11][%r10]
    fmul %f0, %f0, %f1

    mullw %r12, %r9, %r5
    add  %r12, %r12, %r10
    mulli %r12, %r12, 8
    add  %r12, %r12, %r8
    lfd %f1, 0(%r12) # c[%r9][%r10]
    fadd %f0, %f0, %f1
    stfd %f0, 0(%r12)

    addi %r11, %r11, 1
    cmpw %r11, %r4
    blt mmul_main_n_loop

    addi %r10, %r10, 1
    cmpw %r10, %r5
    blt mmul_main_p_loop

    addi %r9, %r9, 1
    cmpw %r9, %r3
    blt mmul_main_m_loop

ret:
    blr
# end of mmul
