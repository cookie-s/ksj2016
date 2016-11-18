#include <stdio.h>

void strcpy(char *dst, const char *src) {
    while(*dst++ = *src++);
}

void reverse(char a[][10], int k)
{
    int i;
    char tmp[10];

    for (i = 0; i < (k - 1) / 2; i++) {
        strcpy(tmp,a[i]);
        strcpy(a[i],a[k - i - 1]);
        strcpy(a[k - i - 1],tmp);
    }
}

int main(int argc, char *argv[])
{
    char a[5][10] = {"", "", "", "", ""};
    int i;

    for (i = 0; i < 5; i++)
        scanf("%9s", a[i]);

    reverse(a, 5);

    for (i = 0; i < 5; i++)
        printf("%s\n", a[i]);

    return 0;
}
