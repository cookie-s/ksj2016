#include<stdio.h>
#include<string.h>
int main(void) {
    int a;
    scanf("%d",&a);
    while(!(a%10)) a/=10;
    while(a) printf("%d",a%10), a/=10;
    printf("\n");
    return 0;
}
