#include<stdio.h>
void reverse(int a[], int n) {
    n--;
    for(int i=0; i<n/2; i++) {
        int t;
        t = a[i];
        a[i] = a[n-i];
        a[n-i] = t;
    }
    return;
}

int main(int argc, char *argv[])
{
    int a[5] = {0, 0, 0, 0, 0};
    int i;

    for (i = 0; i < 5; i++)
        scanf("%d", &a[i]);

    reverse(a, 5);

    for (i = 0; i < 5; i++)
        printf("%d\n", a[i]);

    return 0;
}
