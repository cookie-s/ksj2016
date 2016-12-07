#include <assert.h>
#include <stdio.h>

int enlarge(int);

int main(void) {
    assert( enlarge(0) == 1 );
    assert( enlarge(-1) == -2 );
    assert( enlarge(100) == 101 );
    assert( enlarge(-100) == -101 );
    assert( enlarge(0x7FFFFFFE) == 0x7FFFFFFF );
    assert( enlarge(0x80000001) == 0x80000000 );
    printf("if you reach here, it means you passed the tests!\n");
    return 0;
}
