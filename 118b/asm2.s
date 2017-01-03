    .abiversion 2
    .globl msg
 
    .section ".message1", "a", @progbits
    .ascii " w"
    .section ".message2", "a", @progbits
    .ascii "o,"
 
    .section ".rodata", "a", @progbits
msg:
    .section ".data", "aw", @progbits
    .ascii "!\n"
