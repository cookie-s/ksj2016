#include <stdio.h>
#include <assert.h>

void swap_gt(int *x, int *y);

int main(void) {
    int x, y;
    assert( (x= 1, y= 2, swap_gt(&x, &y), x == 1 && y == 2) );
    assert( (x=10, y= 2, swap_gt(&x, &y), x == 2 && y ==10) );
    assert( (x=-1, y= 2, swap_gt(&x, &y), x ==-1 && y == 2) );
    assert( (x=-1, y=-2, swap_gt(&x, &y), x ==-2 && y ==-1) );
    printf("you passed the tests!\n");
    return 0;
}
