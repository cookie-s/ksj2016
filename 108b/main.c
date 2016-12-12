#include <assert.h>
#include <stdio.h>
#include <math.h>

double saturate(double x);

int main(void) {
    assert( saturate(-3.4) == 0.0 );
    assert( saturate(0.375) == 0.375 );
    assert( saturate(1.5) == 1.0 );
    assert( signbit(saturate(-5.78)) == 0 );
    assert( signbit(saturate(-0.0)) == 0 );
    assert( saturate(-INFINITY) == 0.0 );
    assert( saturate(INFINITY) == 1.0 );
    assert( isnan(saturate(NAN)) != 0 );
    printf("you passed all tests\n");
    return 0;
}
