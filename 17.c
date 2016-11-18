#include<stdio.h>
int gcd(int x, int y) {
    if(y==0) return x;
    if(x < y) return gcd(y, x);
    return gcd(y, x%y);
}
int main(int argc, char *argv[])
{
    int x = 1, y = 1;

    scanf("%d%d", &x, &y);

    printf("%d\n", gcd(x, y));

    return 0;
}
