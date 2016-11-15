/*
 * 問題点
 *  NULL文字を終端に入れることを忘れている。
 *  そのため、不要な文字列が出力されてしまうし、
 *  スタック上でsの直後に機密なデータ（例えば他のlocal variables, stack canary, return address）が入っていた場合、
 *  それが漏れる可能性もある。
 *
 *  以下、２つ修正案を示す。
 *  一つ目は修正箇所を最小にしたもの、
 *  二つ目は無駄にスタックを取らないものである。
 */


#include<stdio.h>

//#define MODE_0

#ifdef MODE_0
int main(void) {
    char s[10];
    int c;
    int i = 0;

    c = getchar();
    while((c != EOF) && (i < 9)) {
        s[i++] = c;
        c = getchar();
    }
    s[i] = 0;

    printf("%s\n", s);

    return 0;
}
#else
int main(void) {
    int i;
    char c;
    for(i=0,c=getchar(); i<9 && c-EOF; i++,c=getchar()) {
        printf("%c",c);
    }
    return 0;
}
#endif
