#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>

#define DB_SIZE 30

typedef char* String;
typedef struct Datum Datum;
struct Datum {
    String key;
    String value;
};

Datum hashdb[DB_SIZE]; // global hash database

int hashdb_hash(const String key);
void hashdb_insert(const String word, const String tango);
void hashdb_delete(const String word);
String hashdb_search(const String word);

int hashdb_hash(const String key) {
    int res=0;
    for(int i=0; i<strlen(key); i++)
        res += key[i];
    return res;
}

void hashdb_insert(const String word, const String tango) {
    int pos = hashdb_hash(word) % DB_SIZE;
    hashdb_delete(word);
    if(!hashdb[pos].key || !hashdb[pos].key[0]) {
        if(hashdb[pos].key) free(hashdb[pos].key);
        hashdb[pos].key = (String)malloc(strlen(word)+1);
        hashdb[pos].value = (String)malloc(strlen(tango)+1);
        strcpy(hashdb[pos].key, word);
        strcpy(hashdb[pos].value, tango);
        return;
    }
    for(int i=(pos+1)%DB_SIZE; i!=pos; i=(i+1)%DB_SIZE)
        if(!hashdb[i].key || !hashdb[i].key[0]) {
            if(hashdb[i].key) free(hashdb[i].key);
            hashdb[i].key = (String)malloc(strlen(word)+1);
            hashdb[i].value = (String)malloc(strlen(tango)+1);
            strcpy(hashdb[i].key, word);
            strcpy(hashdb[i].value, tango);
            return;
        }
    assert(0); // When you reach here, DB_SIZE has to be increased.
    return;
}

void hashdb_delete(const String word) {
    int pos = hashdb_hash(word) % DB_SIZE;
    if(hashdb[pos].key && !strcmp(hashdb[pos].key, word)) {
        hashdb[pos].key[0] = 0; // this indicates this datum was deleted.
        free(hashdb[pos].value);
        hashdb[pos].value = NULL;
        return;
    }
    for(int i=(pos+1)%DB_SIZE; i!=pos; i=(i+1)%DB_SIZE)
        if(hashdb[i].key && !strcmp(hashdb[i].key, word)) {
            hashdb[i].key[0] = 0;
            free(hashdb[i].value);
            hashdb[i].value = NULL;
            return;
        }
}

String hashdb_search(const String word) {
    int pos = hashdb_hash(word) % DB_SIZE;
    if(hashdb[pos].key && !strcmp(hashdb[pos].key, word)) {
        return hashdb[pos].value;
    }
    for(int i=(pos+1)%DB_SIZE; i!=pos; i=(i+1)%DB_SIZE)
        if(hashdb[i].key && !strcmp(hashdb[i].key, word))
            return hashdb[i].value;
    return NULL;
}

void hashdb_free(void) {
    for(int i=0; i<DB_SIZE; i++) {
        if(hashdb[i].key) free(hashdb[i].key), hashdb[i].key = NULL;
        if(hashdb[i].value) free(hashdb[i].value), hashdb[i].value = NULL;
    }
}

int main(void) {
    memset(hashdb, 0, sizeof(hashdb));
    while(1) {
        char command[10];
        scanf("%s", command);
        if(!strcmp(command, "quit")) break;

        char word[100], tango[100];
        scanf("%s", word);
        if(!strcmp(command, "insert")) {
            scanf("%s", tango);
            hashdb_insert(word, tango);
        } else if(!strcmp(command, "delete")) {
            hashdb_delete(word);
        } else if(!strcmp(command, "search")) {
            String res = hashdb_search(word);
            printf( "%s\n", res ? res : "(not found)" );
        }
    }

    hashdb_free();
    return 0;
}
