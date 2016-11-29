#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef char* String;
typedef struct tnode *BTree;
struct tnode {
    String key;
    String value;
    BTree left;
    BTree right;
};

BTree btree_insert(BTree btree, const String word, const String tango) {
    if(!btree) {
        BTree res = (BTree)malloc(sizeof(struct tnode));
        res->key    = (String)malloc(strlen(word)+1);
        res->value  = (String)malloc(strlen(tango)+1);
        strcpy(res->key, word);
        strcpy(res->value, tango);
        res->left = res->right = NULL;
        return res;
    }

    if(strcmp(btree->key, word) == 0) {
        free(btree->value);
        btree->value  = (String)malloc(strlen(tango)+1);
        strcpy(btree->value, tango);
    } else if(strcmp(btree->key, word) < 0)
        btree->right = btree_insert(btree->right, word, tango);
    else
        btree->left  = btree_insert(btree->left, word, tango);

    return btree;
}

BTree btree_delete(BTree btree, const String word) {
    if(!btree) return btree;
    if(strcmp(btree->key, word) == 0) {
        BTree prev = NULL, next = btree->right;
        if(!next) return btree->left;

        while(next->left) {
            prev = next;
            next = next->left;
        }
        if(!prev) return next;
        prev->left = next->right;
        btree->key = next->key;
        btree->value = next->value;
        free(next);
        return btree;
    } else if(strcmp(btree->key, word) < 0)
        btree_delete(btree->right, word);
    else
        btree_delete(btree->left, word);

    return btree;
}

String btree_search(const BTree btree, const String word) {
    if(!btree) return NULL;

    if(strcmp(btree->key, word) == 0)
        return btree->value;
    if(strcmp(btree->key, word) <  0)
        return btree_search(btree->right, word);
    else
        return btree_search(btree->left, word);
}

void btree_free(BTree btree) {
    if(!btree) return;
    btree_free(btree->left);
    btree_free(btree->right);
    free(btree);
    return;
}

void btree_showall(BTree btree, int depth) {
    for(int i=0; i<depth; i++)
        printf("-");
    printf("%s\n", btree ? btree->key : "NULL");
    if(btree)
        btree_showall(btree->left, depth+1), btree_showall(btree->right, depth+1);
    return;
}

int main(void) {
    BTree btree = NULL;
    while(1) {
        char command[10];
        scanf("%s", command);
        if(!strcmp(command, "quit")) break;

        char word[100], tango[100];
        scanf("%s", word);
        // btree_showall(btree, 1);
        if(!strcmp(command, "insert")) {
            scanf("%s", tango);
            btree = btree_insert(btree, word, tango);
        } else if(!strcmp(command, "delete")) {
            btree = btree_delete(btree, word);
        } else if(!strcmp(command, "search")) {
            String res = btree_search(btree, word);
            printf( "%s\n", res ? res : "(not found)" );
        }
    }

    btree_free(btree);
    btree = NULL;
    return 0;
}
