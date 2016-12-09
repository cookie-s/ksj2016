.globl mystrcat

mystrcat:
    subi %r5, %r3, 1 # %r3は戻り値にするので、%r5にコピー。

find_tail: # strlen的な。\0を探して、その位置を%r5が指す。
    lbzu %r6, 1(%r5)    # %r5をインクリメントしつつ%r6にロード。
    and. %r6, %r6, %r6  # %r6がゼロだったら次へ。
    bne find_tail

    subi %r4, %r4, 1 # 辻褄合わせ。
    subi %r5, %r5, 1
concat:
    lbzu %r6, 1(%r4)
    stbu %r6, 1(%r5) # (%r4+1)から(%r5+1)に1byteコピー。
    and. %r6, %r6, %r6 # コピーした内容が0だったら抜ける。
    bne concat

ret:
    blr # 戻る。%r3は初めから変わっていない。
