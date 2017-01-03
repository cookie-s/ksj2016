#include <stdio.h>
#include <string.h>

#define MIN(X,Y) ((X)>(Y)?(Y):(X))

int main(void) {
    char start[100], end[100];
    int minc=0x7FFFFFFF;
    char s[100], d[100];
    char res[100];
    int c;
    scanf("%s%s",start,end);
    while(~scanf("%s%s%d",s,d,&c)) {
        if(c < minc) {
            if(!strcmp(s,start))
                minc = c, strcpy(res, d);
            if(!strcmp(d,start))
                minc = c, strcpy(res, s);
        }
    }
    printf("%s\n",res);
    return 0;
}
