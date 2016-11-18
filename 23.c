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

    scanf("%99s", s);

    if(!strcmp(s,"yes"))
        puts("OK");
    else
        puts("NG");

    return 0;
}
