#include <assert.h>
#include <stdio.h>
#include <string.h>

char *mystrcat(char*, const char*);

int main(void) {
    char s[1000];
    assert( (strcpy(s, "pine"), !strcmp("pineapple", mystrcat(s, "apple"))) );
    assert( (strcpy(s, ""), !strcmp("apple", mystrcat(s, "apple"))) );
    assert( (strcpy(s, "pine"), !strcmp("pine", mystrcat(s, ""))) );
    assert( (strcpy(s, ""), !strcmp("", mystrcat(s, ""))) );
    assert( (strcpy(s, "uwaaaaaaaaaaaaaaaaaa"), !strcmp("uwaaaaaaaaaaaaaaaaaahyaaaaaaaaaaaaaaaaaaaa", mystrcat(s, "hyaaaaaaaaaaaaaaaaaaaa"))) );
    printf("%s\n", (strcpy(s, "pen"), mystrcat(s, "pineapple"), mystrcat(s, "apple"), mystrcat(s, "pen")));
    return 0;
}
