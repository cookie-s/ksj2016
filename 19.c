#include<stdio.h>

int main(void) {
    int c,r=0;
    while((c=getchar())!=EOF) r+=(c=='a');
    printf("%d\n",r);
    return 0;
}
