#include <stdio.h>
int main(void) { 
    int res=0;
    for(int k=0; k<4; k++)
        for(int i=0; i<4; i++) {
            int s;
            scanf("%d",&s);
            if(k==i) res += s;
        }

    printf("%d\n", res);
}
