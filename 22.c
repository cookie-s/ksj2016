#include <stdio.h>

int main(int argc, char *argv[])
{
    char s1[100] = "";
    char s2[100];
    int i,j;

    scanf("%99s", s1);

    i=j=0;
    while(s1[++i]);
    while(s2[j++]=s1[--i]);
    s2[++j]=0;

    printf("%s\n", s2);

    return 0;
}
