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

inte        { hashInsert(yytext, KW_INTE);      return KW_INTE; }
cara        { hashInsert(yytext, KW_CARA);      return KW_CARA; }
real        { hashInsert(yytext, KW_REAL);      return KW_REAL; }
se          { hashInsert(yytext, KW_SE);        return KW_SE; }
entaum      { hashInsert(yytext, KW_ENTAUM);    return KW_ENTAUM; }
senaum      { hashInsert(yytext, KW_SENAUM);    return KW_SENAUM; }
enquanto    { hashInsert(yytext, KW_ENQUANTO);  return KW_ENQUANTO; }
entrada     { hashInsert(yytext, KW_ENTRADA);   return KW_ENTRADA; }
escreva     { hashInsert(yytext, KW_ESCREVA);   return KW_ESCREVA; }
retorne     { hashInsert(yytext, KW_RETORNE);   return KW_RETORNE; }

[-;()=\[\]{}+*/] { return yytext[0]; }

"<="        { hashInsert(yytext, OPERATOR_LE); return OPERATOR_LE; }
">="        { hashInsert(yytext, OPERATOR_GE); return OPERATOR_GE; }
"=="        { hashInsert(yytext, OPERATOR_EQ); return OPERATOR_EQ; }
"!="        { hashInsert(yytext, OPERATOR_DIF); return OPERATOR_DIF; }

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
    hashPrint();
    running = 0;
    return 1;
}