#include<stdio.h>
int main(void) {
    int a,w,d,pad;
    scanf("%d",&a);
    w=2*a-1;
    for(d=1,pad=w/2; d<=a; d++,pad--) {
        int i;
        for(i=0; i<pad; i++)
            printf(" ");
        for(i=0; i<2*d-1; i++)
            printf("*");
        printf("\n");
    }
    return 0;
}
