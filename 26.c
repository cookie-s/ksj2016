#include<stdio.h>

void sort2(int *x, int *y) {
    if(*x > *y) {
        int t;
        t = *x;
        *x = *y;
        *y = t;
    }
}

void sort3(int *x, int *y, int *z) {
    sort2(x, y);
    sort2(y, z);
    sort2(x, y);
}

int main(int argc, char *argv[])
{
    int x[3] = {0, 0, 0};
    int i;

    for (i = 0; i < 3; i++)
        scanf("%d", &x[i]);

    sort3(&x[0], &x[1], &x[2]);

    for (i = 0; i < 3; i++)
        printf("%d\n", x[i]);

    return 0;
}
