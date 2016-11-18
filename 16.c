#include<stdio.h>

void mul(int l[][3], int r[][2], int a[][2], int n)
{
    for(int i=0; i<n; i++)
        for(int j=0; j<2; j++)
            for(int k=0; k<3; k++)
                a[i][j] += l[i][k] * r[k][j];
}

int main(void) {
    int a[2][3], b[3][2], c[2][2]={};
    for(int i=0; i<2; i++)
        for(int j=0; j<3; j++)
            scanf("%d", &a[i][j]);
    for(int j=0; j<3; j++)
        for(int i=0; i<2; i++)
            scanf("%d", &b[j][i]);

    mul(a, b, c, 2);

    for(int i=0; i<2; i++)
        for(int j=0; j<2; j++)
            printf("%d%c", c[i][j], j==1 ? '\n' : ' ');
    return 0;
}
