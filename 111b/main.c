#include <assert.h>
#include <stdio.h>

typedef struct myuint128 {
    unsigned long digit0;
    unsigned long digit1;
} myuint128_t;

myuint128_t add128(myuint128_t a, myuint128_t b) {
    myuint128_t res;
    __asm__ (
            "addc %0, %2, %3\n\t" // 加算して、carryも書き換える
            "adde %1, %4, %5\n\t" // carryを考慮しながら加算
            : "=r"(res.digit0), "=r"(res.digit1)  // ともに書き込み専用。addc,addeはオペランドにレジスタしか許さない。
            : "r"(a.digit0), "r"(b.digit0), "r"(a.digit1), "r"(b.digit1) // すべて読み込み専用。レジスタ制約をつける。
            : "ca" // addcによってcaは書き換わる。
            );
    return res;
}

int eq128(myuint128_t a, myuint128_t b) {
    return (a.digit0 == b.digit0) && (a.digit1 == b.digit1);
}

int main(void) {
    assert( eq128(
                add128( (myuint128_t){0xA05F44019BD79748UL, 0x0000000000003995UL}, (myuint128_t){0x7B6F88EC052868B8UL, 0x0000000000009A2CUL}),
                (myuint128_t){0x1BCECCEDA1000000UL, 0x000000000000D3C2UL}
                ));
    assert( eq128(
                add128((myuint128_t){0xBEAED78ACDC6F714UL, 0x1934D10F478850D4UL}, (myuint128_t){0xE69D35AFE6995719UL, 0x0805961D75476A77UL}),
                (myuint128_t){0xA54C0D3AB4604E2DUL, 0x213A672CBCCFBB4CUL}
                ));
    assert( eq128(
                add128((myuint128_t){0xD97482C3148C06ADUL, 0x81981582D4ED6486UL}, (myuint128_t){0xEFBBAA3E5DD5089FUL, 0x8FE78CB9DAD947E9UL}),
                (myuint128_t){0xC9302D0172610F4CUL, 0x117FA23CAFC6AC70UL}
                ));
    printf("you passed all tests.\n");
    return 0;
}
