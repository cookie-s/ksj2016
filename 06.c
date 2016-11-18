#include<stdio.h>
int main(void) {
    int a,b,c,res=0;
    scanf("%d%d%d",&a,&b,&c);
    res+= a==b;
    res+= b==c;
    res+= c==a;
    res-= a==b && b==c;
    printf("%c\n",'C'-res);
    return 0;
}
