.globl saturate

.section .rodata
.align 8
lower_bound: # 下限
    .double 0.0
upper_bound: # 上限
    .double 1.0

.section .text
saturate:
    addis %r3, %r2, lower_bound@toc@ha
    addi  %r3, %r3, lower_bound@toc@l
    lfd %f2, 0(%r3) # %f2に下限を入れる
    addis %r3, %r2, upper_bound@toc@ha
    addi  %r3, %r3, upper_bound@toc@l
    lfd %f3, 0(%r3) # %f3に上限を入れる

    fcmpu %cr0, %f1, %f2
    bun ret # NaNならそのままリターン
    ble ret_lb # 下限以下なので下限を返す

    fcmpu %cr0, %f1, %f3
    bge ret_ub
    b   ret # 範囲に収まっているのでそのままリターン
    
ret_lb:
    fmr %f1, %f2
    b   ret
ret_ub:
    fmr %f1, %f3
    b   ret
ret:
    blr
