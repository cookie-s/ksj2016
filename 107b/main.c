#include <assert.h>
#include <string.h>
#include <stdio.h>

const char *hello(void);

int main(void) {
    assert( !strcmp(hello(), "Hello, world!") );
    puts( hello() );
    return 0;
}
