#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>

typedef struct lnode {
    int data;
    struct lnode *next;
} *List;


List stack_new() {
    List res = (List)malloc(sizeof(struct lnode));
    res->data = 0;
    res->next = res;
    return res;
}
List stack_push(List list, int val) {
    List res = (List)malloc(sizeof(struct lnode));
    res->data = val;
    res->next = list;
    return res;
}

int stack_read(List list) {
    // if empty, return zero
    return list->data;
}

List stack_pop(List list) {
    // if empty, nothing happens
    List res = list->next;
    if(res != list) free(list);
    return res;
}

int stack_isempty(List list) {
    return (list == list->next);
}

int main(void) {
    List stack = stack_new();
    char cmd[10];
    while(~scanf("%9s",cmd)) {
        int res=0;
        switch(cmd[0]) {
            case '+':
                res = stack_read(stack);
                res+= stack_read(stack=stack_pop(stack));
                stack = stack_pop(stack);
                break;
            case '-':
                res-= stack_read(stack);
                res+= stack_read(stack=stack_pop(stack));
                stack = stack_pop(stack);
                break;
            case '*':
                res = stack_read(stack);
                res*= stack_read(stack=stack_pop(stack));
                stack = stack_pop(stack);
                break;
            case '=':
                goto print_result;
                break;
            default:
                if(isdigit(cmd[0])) res=atoi(cmd);
                else {
                    printf("(unknown command)\n");
                    continue;
                }
        }
        stack = stack_push(stack, res);
    }
print_result:
    if(!stack_isempty(stack)) printf("%d\n", stack_read(stack));

    while(!stack_isempty(stack)) stack = stack_pop(stack);
    free(stack);

    return 0;
}
