#include <stdio.h>

#define TAMANHO_TABELA 65521

typedef struct nodo {
    int type;
    char* msg;
    struct nodo* next;
} NODO;

void hashInit();
int hashAddress(char* msg);
NODO* hashFind(char* msg);
NODO* hashInsert(char* msg, int type);
void hashPrint();