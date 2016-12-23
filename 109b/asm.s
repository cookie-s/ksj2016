.globl puts_twice

.section .text

puts_twice:
    mflr %r0             # link registerの内容を%r0へ。
    std %r0, 16(%r1)     # それをスタック上に退避。（callerのスタックフレーム上）
    stdu %r1, -48(%r1)   # 48bytesのスタックフレームを確保。元のスタックフレーム先頭アドレスも同時に退避される。

    #  0 | saved sp
    #  8 | for puts to save cr register
    # 12 | (align)
    # 16 | for puts to save link register
    # 24 | for saving toc base
    # 32 | for saving one local variable
    
    std %r3, 32(%r1) # %r3をputsに破壊されるとつらい
    bl puts
    nop

    ld %r3, 32(%r1)
    bl puts
    nop

    ld %r1, 0(%r1)  # スタックフレームを巻き戻し
    ld %r0, 16(%r1) # 戻り先を読み込み
    mtlr %r0        # link registerにセット
    blr             # 戻る
