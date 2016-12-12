.globl hello

.section .rodata
str_hello:
    .asciz "Hello, world!"  # NULLで終了された文字列を配置


.section .text
hello:
    addis %r3, %r2, str_hello@toc@ha # %r2にstr_hello(TOC base)の上位16bitを左シフトした値を加算したものを%r3にセット
    addi  %r3, %r3, str_hello@toc@l  # %r3にstr_hello(TOC base)の下位16bitを加算
    blr
