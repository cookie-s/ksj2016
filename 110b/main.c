#include <assert.h>
#include <stdio.h>

int fib(int);

int main(void) {
    assert( fib(5) == 5 );
    assert( fib(15) == 610 );
    assert( fib(42) == 267914296 );
    printf("you passed all tests.\n");
    return 0;
}
