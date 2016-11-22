#include<stdio.h>
#include<string.h>
#include<stdlib.h>

typedef char *String;
typedef struct lnode *DblList;
struct lnode {
    DblList prev;
    String data;
    DblList next;
};

void remove_list(DblList list) {
    if(list) free(list);
}

void swapdata_list(DblList alist, DblList blist) {
    const String tmp = alist->data;
    alist->data = blist->data;
    blist->data = tmp;
}

DblList append_list(DblList list, const String s) {
    if(!list) {
        DblList cur = (DblList)malloc(sizeof(struct lnode));
        cur->prev = NULL;
        cur->next = NULL;
        cur->data = s;
        return cur;
    }

    DblList cur = (DblList)malloc(sizeof(struct lnode));
    cur->prev = NULL;
    cur->next = list;
    cur->data = s;
    list->prev = cur;
    return cur;
}

void quick_sort(DblList list, DblList tail) {
    if(!list || !tail) return;
    if(list == tail) return;

    DblList a = list, b = tail;
    const String pivot = list->data;

    while(a != b) {
        while(a != b && strcmp(a->data, pivot)<0)
            a = a->next;
        while(a != b && strcmp(b->data, pivot)>=0)
            b = b->prev;
        swapdata_list(a, b);
    }
    //a = list;
    while(strcmp(a->data, pivot)<0)
        a = a->next;
    if(a == list) {
        quick_sort(a->next, tail);
    } else {
        quick_sort(list, a->prev);
        quick_sort(a, tail);
    }
}

int main(void) {
    char s[100];
    DblList list=NULL, tail=NULL;

    while(~scanf("%99s",s)) {
        String ss = (String)malloc(strlen(s)+1);
        strcpy(ss, s);
        list = append_list(list, ss);
        if(!tail) tail = list;
    }

    quick_sort(list, tail);
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
