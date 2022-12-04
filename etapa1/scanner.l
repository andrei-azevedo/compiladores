%{
    #include "tokens.h"
    #include "main.c"
    #include "tabela_hash.c"

    int linha = 1;
    int running = 1;

    int getLineNumber() {
        return linha;
    }

    int isRunning() {
        return running;
    }
    
    void initMe() {
        hashInit();
    }
%}

%x COMMENT

%%

inte        { return KW_INTE; }
cara        { return KW_CARA; }
real        { return KW_REAL; }
se          { return KW_SE; }
entaum      { return KW_ENTAUM; }
senaum      { return KW_SENAUM; }
enquanto    { return KW_ENQUANTO; }
entrada     { return KW_ENTRADA; }
escreva     { return KW_ESCREVA; }
retorne     { return KW_RETORNE; }

[-;()=\[\]{}+*/] { return yytext[0]; }

"<="        { return OPERATOR_LE; }
">="        { return OPERATOR_GE; }
"=="        { return OPERATOR_EQ; }
"!="        { return OPERATOR_DIF; }

['].[']             { hashInsert(yytext, LIT_CHAR);     return LIT_CHAR; }
["].*["]            { hashInsert(yytext, LIT_STRING);   return LIT_STRING; }
[0-9]+              { hashInsert(yytext, LIT_INTEIRO);  return LIT_INTEIRO; }
[0-9]+(".")[0-9]+   { hashInsert(yytext, LIT_FLOAT);    return LIT_FLOAT; }

[a-z._][a-zA-Z0-9._]+ { hashInsert(yytext, TK_IDENTIFIER);    return TK_IDENTIFIER; }

[ \t]
"\n"            { ++linha; }
"//".*
"/*"            { BEGIN(COMMENT); }
.               { return TOKEN_ERROR; }

<COMMENT>"*/"   { BEGIN(INITIAL); }
<COMMENT>"\n"   { ++linha; }
<COMMENT>.


%%

int yywrap() {
    running = 0;
    return 1;
}