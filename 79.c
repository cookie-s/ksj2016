#include <stdio.h>
#include <string.h>

#define MIN(X,Y) ((X)>(Y)?(Y):(X))

#define DBSIZE 5000

int graph[DBSIZE][DBSIZE];
char names[DBSIZE][100]={};
int dis[DBSIZE];
int dec[DBSIZE];

int hash(const char *s) {
    int res=0;
    while(*s) res+=(*s++)*11, res%=DBSIZE;
    return (res+DBSIZE) % DBSIZE;
}

int namedb(const char *name) {
    int i=hash(name);
    if(strlen(names[i]) || !strcmp(names[i], name)) {
        strcpy(names[i], name);
        return i;
    }
    i++;
    while(i!=hash(name) && names[i][0] && strcmp(names[i], name)) i++;
    if(i==hash(name)) return -1;
    strcpy(names[i], name);
    return i;
}

int main(void) {
    memset(graph, 0x77, sizeof(graph));
    memset(dis, 0x77, sizeof(dis));

    char src[100],end[100];
    scanf("%s%s",src,end);
    while(1) {
        char s[100],t[100];
        int c;
        if(!~scanf("%s%s%d",s,t,&c)) break;

        int si = namedb(s),ti = namedb(t);
        graph[si][ti] = graph[ti][si] = MIN(c, graph[si][ti]);
    }
    int srci = namedb(src);
    int endi = namedb(end);
    dis[srci] = 0;
    while(1) {
        int mini=DBSIZE;
        for(int i=0; i<DBSIZE; i++)
            if(!dec[i] && dis[i] < dis[mini]) mini=i;
        if(mini==DBSIZE)
            break;
        dec[mini] = 1;
        if(mini == endi) {
            int route[1000];
            route[0] = endi;
            int i=1;
            for(;;i++) {
                int s=0;
                for(s=0; s<DBSIZE; s++)
                    if(dec[s] && dis[route[i-1]] == dis[s] + graph[s][route[i-1]])
                        break;
                //printf("%s -> %s : %d\n", names[s], names[route[i-1]], graph[s][route[i-1]]);
                route[i] = s;
                if(s == srci)
                    break;
            }
            for(int j=i; j>=0; j--)
                printf("%s\n",names[route[j]]);
            return 0;
        }
        for(int i=0; i<DBSIZE; i++)
            if(!dec[i] && dis[i] > dis[mini] + graph[mini][i])
                dis[i] = dis[mini] + graph[mini][i];
    }
    printf("(not found)\n");
    return 0;
}
