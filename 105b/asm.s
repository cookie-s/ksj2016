.globl prime_factor

prime_factor:
    xor %r4, %r4, %r4  # %r4をゼロクリア。これをループのカウンタとする。
    addi %r4, %r4, 2   # %r4を2にセット。

check_two: # あとあと奇数だけチェックするために、2だけチェックする。
    andi. %r5, %r3, 1    # 最下位ビットをとる。この結果EQが立てば、引数は偶数。
    beq ret       # 偶数ならば2を返す。

    subi %r4, %r4, 1   # %r4を1にセット。次の加算のための辻褄合わせ。

loop:
    addi %r4, %r4, 2   # 偶素数は2だけなので、カウンタを次の奇数にする。
    divw %r5, %r3, %r4
    mullw %r5, %r5, %r4
    cmpw %r5, %r3      # (%r3/%r4)*%r4 == %r3 をチェック。このとき、%r3は%r4で割り切れる。
    bne  loop

ret:
    mr  %r3, %r4       # 結果は%r4に入っているので、これを返す。
    blr
