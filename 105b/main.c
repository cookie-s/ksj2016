#include <assert.h>
#include <stdio.h>

int prime_factor(int);

int main(void) {
    assert( prime_factor(6) == 2 );
    assert( prime_factor(299) == 13 );
    assert( prime_factor(307) == 307 );
    assert( prime_factor(0x7FFFFFFE) == 2 );
    printf( "you reaches last test.\n" );
    assert( prime_factor(0x7FFFFFFF) == 0x7FFFFFFF ); // this is Mersenne prime.
    printf( "you passed all tests!\n" );
    return 0;
}
