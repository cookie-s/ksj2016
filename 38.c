/* result
 *  RAND_MAX: 2147483647
 *  PI: 3.141453
 */

#include <stdlib.h>
#include <stdio.h>
#include <time.h>

double square(double x) {
    return x * x;
}

int main(void) {
    srand((unsigned) time(NULL));
    printf("RAND_MAX: %d\n", RAND_MAX);
    
    int cnt;
    for(int i=0; i<100000000; i++) {
        double x = (double)rand() / RAND_MAX;
        double y = (double)rand() / RAND_MAX;
        if(square(x) + square(y) <= 1) cnt++;
    }
    printf("PI: %f\n", (double)cnt*4/100000000);
    return 0;
}
