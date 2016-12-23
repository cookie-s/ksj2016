#include <assert.h>
#include <stdio.h>

int ntimes(int,int(*)(int),int);

static int doub(int x) {
    return x * 2;
}
static int collatz_step(int x) {
    return x % 2 == 0 ? x / 2 : x * 3 + 1;
}

int main(void) {
    assert(ntimes(4, doub, 3) == 48);
    assert(ntimes(77, collatz_step, 27) == 9232);
    assert(ntimes(0, collatz_step, 27) == 27);
    printf("you passed all tests.\n");
    return 0;
}
