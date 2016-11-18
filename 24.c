#include <stdio.h>

int strcmp(const char *a, const char *b) {
    while(*a && *b) {
        if(*a-*b) return *a-*b;
        a++, b++;
    }
    return *a-*b;
}

int main(int argc, char *argv[])
{
    char s[100] = "";
    char t[100] = "";

    scanf("%99s", s);
    scanf("%99s", t);

    if(!strcmp(s,t))
        puts("OK");
    else
        puts("NG");

    return 0;
}
