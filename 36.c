/*
 * mallocをsubstrでしたにもかかわらず、
 * その先頭からずれたポインタを返している限り、
 * substr外ではfreeすべき位置の追いようがなくなる。
 * substr内でfreeするわけにもいかないので、
 * ちょうど返すポインタと同じ位置でmallocすべきということになる。
 * 別にwhile内で'a'を探す作業は、strcpy先でなくとも、
 * s[i]で探すことで事足りる。
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
 
char *substr(char *s)
{
    int i = 0;
    char *p;
 
    p = malloc(strlen(s) + 1);
    while (s[i] != '\0') {
        if (s[i] == 'a')
