#include<stdio.h>

int main(void) {
    int n,a[3]={1,1,0};
    scanf("%d",&n);
    n--;
    for(int i=2; i<=n; i++)
        a[i%3] = a[(i+1)%3] + a[(i+2)%3];
    printf("%d\n", a[n%3]);
    return 0;
}
