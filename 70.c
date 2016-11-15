#include<stdio.h>
#include<string.h>
#include<stdlib.h>

typedef char *String;
typedef struct lnode *List;
struct lnode {
    String data;
    List next;
};

void remove_list(List list) {
    free(list);
}

List append_list(List list, const String s) {
    if(!list) {
        List cur = (List)malloc(sizeof(struct lnode));
        cur->next = NULL;
        cur->data = s;
        return cur;
    }

    List cur = (List)malloc(sizeof(struct lnode));
    cur->next = list;
    cur->data = s;
    return cur;
}

int main(void) {
    char s[100];
    List list=NULL;

    while(~scanf("%99s",s)) {
        String ss = (String)malloc(strlen(s)+1);
        strcpy(ss, s);
        list = append_list(list, ss);
    }

    while(list) {
        String ss;
        ss = list->data;
        printf("%s\n",ss);
        free(ss);
        list = list->next;
    }

    remove_list(list);
    return 0;
}
