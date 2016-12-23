#include <string.h>
#include <stdio.h>

void puts_twice(const char*);

int main(void) {
    char s[10]={};
    puts("output empty string...");
    puts_twice(s);
    puts("output Hello!");
    strcpy(s, "Hello!");
    puts_twice(s);
    return 0;
}
