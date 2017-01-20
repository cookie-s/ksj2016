head:

# e_ident
.byte 0x7F # EI_MAG[0]: ELFMAG0
.byte 0x45 # EI_MAG[1]: ELFMAG1
.byte 0x4c # EI_MAG[2]: ELFMAG2
.byte 0x46 # EI_MAG[3]: ELFMAG3
.byte 2 # EI_CLASS: ELFCLASS64
.byte 1 # EI_DATA:ELFDATA2LSB
.byte 1 # EI_VERSION: EV_CURRENT
.byte 0 # EI_OSABI
.byte 0 # EI_ABIVERSION
.byte 0 # EI_PAD
.byte 0
.byte 0
.long 0

# e_type
.word 2 # ET_EXEC

# e_machine
.word 21 # EM_PPC64 http://www.sco.com/developers/gabi/2000-07-17/ch4.eheader.html

# e_version
.long 1 # EV_CURRENT

# e_entry
.word entry@l
.word entry@h
.word entry@higher
.word entry@highest

# e_phoff
.word (ph - head)@l
.word (ph - head)@h
.word (ph - head)@higher
.word (ph - head)@highest

# e_shoff
.long 0
.long 0

# e_flags
.long 2

# e_ehsize
.word 0x40

# e_phentsize
.word 56

# e_phnum
.word 1

# e_shentsize
.word 0

# e_shnum
.word 0

# e_shstrndx
.word 0 # SHN_UNDEF

endh:

ph: # http://www.mcs.anl.gov/OpenAD/OpenADFortTkExtendedDox/structElf64__Phdr.html
.long 1 # p_type: PT_LOAD
.long 7
.long 0 # p_offset: 0
.long 0
.word head@l # p_vaddr
.word head@h
.word head@higher
.word head@highest
.word head@l # p_paddr
.word head@h
.word head@higher
.word head@highest
.long (end-head) # p_filesz
.long 0
.long (end-head) # p_memsz
.long 0
#.long 0 # p_alignなんだけど、
#.long 0 # まあ、動くので....ケチらせて...

entry:
li %r0, 4      # write
li %r5, (end-head)    # count
lis %r4, head@ha# buf
#addi %r4, %r4, head@l # どうせゼロ。
li %r3, 1      # fd
sc

li %r0, 1      # exit
li %r3, 0      # status
sc

end:
