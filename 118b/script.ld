/* elf64-powerpc64le を指定 */
OUTPUT_FORMAT("elf64-powerpcle", "elf64-powerpcle",
          "elf64-powerpcle")
OUTPUT_ARCH(powerpc:common64)
 
/* ELFヘッダのエントリポイントは_startを指すように指定 */
ENTRY(_start)
 
/* プログラムヘッダ (ローダが参照するヘッダ) */
PHDRS
{
  /* textセグメント (ELFヘッダとプログラムヘッダも一緒にロードする) */
  text PT_LOAD FILEHDR PHDRS FLAGS (5);
  /* dataセグメント */
  data PT_LOAD FLAGS (6);
  /* bssセグメント */
  bss PT_LOAD FLAGS (6);
}
 
 
/* セクションヘッダ (リンカが参照するヘッダ) */
SECTIONS
{
 
  /* VMAを移動する */
  /* PowerPC64では通常 0x10000000 以降にプログラムをロードする */
  /* また、ELFヘッダとプログラムヘッダもtextセグメントと同時にロードするため、VMAをSIZEOF_HEADERSにするとページ境界に揃えてロードできる */
  . = SEGMENT_START("text", 0x10000000) + SIZEOF_HEADERS;
 
  /* 入力: 全てのファイルの.textセクション */
  /* 出力: .textセクション */
  /* 出力: textセグメント */
  .text : { *(.text) } :text
 
  /* textとdataは別のページにロードしたいので、0x10000だけ間を空ける */
  . = . + 0x10000;
 

  /* 入力: 各ファイルの各セクションを順番に。 */
  /* 出力: .dataセクション */
  /* 出力: dataセグメント */
  .data : { asm1.o(.rodata) asm1.o(.message2) asm2.o(.message2) asm2.o(.message1) asm1.o(.message1) asm1.o(.data) asm2.o(.data) asm1.o(.bss) } :data

}
