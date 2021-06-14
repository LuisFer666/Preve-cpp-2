%{
#include <stdio.h>
extern int yylineno;
%}
%token SP NA1 NA2 CLN LBT AL TS OCD SE TIG1 TIG2 TRN ED1 ED2 BIN LA LC ST PA PTC DOT NUM  PC
%start SEN 
%%

SEN : SP LA C LC {printf("Linea %d - SP valida\n", yylineno);}
;
C : MV C | MV
;
MV : TR | AA | SS | DR | TRS | ALT | ACT
;
TR : TRN DOT DIR {printf("Linea %d - TR valida\n", yylineno);}
;
AA : ED2 PAR1 {printf("Linea %d - AA valida\n", yylineno);}
;
SS : SE DOT TIG1 PAR2 {printf("Linea %d - SS valida\n", yylineno);}
;
DR : OCD PAR4 {printf("Linea %d - DR valida\n", yylineno);}
;
TRS : TS DOT TIG2 PAR3 {printf("Linea %d - TRS valida\n", yylineno);}
;
ALT : AL TP {printf("Linea %d - ALT valida\n", yylineno);}
;
ACT : NA1 PAR1 | NA2 PAR2 {printf("Linea %d - ACT valida\n", yylineno);}
;
TP : PAR3 | DOT MS
;
MS : CLN PAR2 | LBT PAR2 | TIG1 PAR4
;
DIR : ED1 PAR1
;
PAR1 : PA NUM PC PTC
;
PAR2 : PA PC PTC
;
PAR3 : PA ST PC PTC
;
PAR4 : PA BIN PC PTC
;

%%

#include "lex.c"

int main(){
    yyparse();
    return 0;
}
int yyerror(char *s){
    printf("Error: %s (%d)\n",s, yylineno);
    return 0;
}
