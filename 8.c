#include<stdio.h>
int main(void) {
    int x,y;
    scanf("%d%d",&x,&y);
    for(;x<=y; x++)
        if(!(x%15)) puts("FizzBuzz");
        else if(!(x%5)) puts("Buzz");
        else if(!(x%3)) puts("Fizz");
        else printf("%d\n",x);
    return 0;
}
