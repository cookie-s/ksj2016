.globl swap_gt

# swap_gt の始まり
swap_gt:
    lwz %r5, 0(%r3) # %r5に第一引数（これはアドレス）の中身をロード
    lwz %r6, 0(%r4) # %r5,%r6を適当に一時データ保管用に使った。
    cmpw %r5, %r6   # %r5と%r6を比較。
    ble ret         # もし %5 > %6 つまり *(&x) > *(&y) でなければ、retに飛んですぐ戻る。
    stw %r6, 0(%r3) # 条件を満たすので、swapする。%r3の指す先に、%r6の中身をストア。
    stw %r5, 0(%r4)
ret:
    blr
