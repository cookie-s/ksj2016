#define MAX(X,Y) ((X)>(Y)?(X):(Y))
#include<stdio.h>
int main(void) {
    int a,b,c,d;
    scanf("%d%d%d%d",&a,&b,&c,&d);
    printf("%d\n",MAX(a,MAX(b,MAX(c,d))));
    return 0;
}
