#include "tabela_hash.h"

NODO* tabela[TAMANHO_TABELA];

void hashInit() {
    for (int i = 0; i < TAMANHO_TABELA; i++) {
        tabela[i] = 0;
    }
}

int hashAddress (char* msg) {
    int address = 1;
    for (int i = 0; i < TAMANHO_TABELA; i++) {
        address = (address * msg[i]) % TAMANHO_TABELA + 1;
    }
    return address-1;
}

NODO* hashFind(char* msg) {
    NODO* nodo;
    int address = hashAddress(msg);
    for (nodo=tabela[address]; nodo; nodo = nodo->next) {
        if (strcmp(nodo->msg, msg) == 0) {
            return nodo;
        }
    }
    return 0;
}

NODO* hashInsert(char* msg, int type) {
    NODO* novo_nodo;
    int address = hashAddress(msg);

    if ((novo_nodo = hashFind(msg) != 0 )) {
        return novo_nodo;
    }
    novo_nodo = (NODO*) calloc(1, sizeof(NODO));
    novo_nodo->type = type;
    novo_nodo->msg = (char*) calloc(strlen(msg)+1, sizeof(char));
    strcpy(novo_nodo->msg, msg);
    novo_nodo->next = tabela[address];
    tabela[address] = novo_nodo;

    return novo_nodo;
}

void hashPrint() {
    NODO* nodo;
    for (int i = 0; i < TAMANHO_TABELA; i++) {
        for (nodo = tabela[i]; nodo; nodo = nodo->next) {
            printf("Tabela[%d]: %s\n", i, nodo->msg);
        }
    }
}