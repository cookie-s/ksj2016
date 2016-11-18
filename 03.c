#include<stdio.h>
int main(void) {
    int x,y;
    scanf("%d%d",&x,&y);
    printf("%d\n",(int)(100.*x/y+0.5));
    return 0;
}
