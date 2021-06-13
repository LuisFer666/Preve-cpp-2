%{
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
extern int yylineno;
#include "tablasimb.c"
#define YYERROR_VERBOSE 1
simbolo * t;
simbolo * v;
int yyerror(char *s);
%}
%union{
  int numero;
  char cadena[30];
  bool boleano;
}
%token <cadena> SP NA1 NA2 CLN LBT AL TS OCD SE TIG1 TIG2 TRN ED1 ED2 LA LC ST PA PTC DOT PC
%token <numero> NUM
%token <boleano> BIN

%type <cadena> C MV TR DIR AA PAR1 SS PAR2 DR PAR4 TRS PAR3 ALT TP ACT MS

%start SEN 
%%

SEN : SP LA C LC {
        printf("Linea %d - SEN valida - %s %s %s %s\n", yylineno, $1, $2, $3, $4);
    };
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
    t = crear();
	yyparse();
	printf("Lineas compiladas: %d \n",yylineno);
	printf("Tabla de simbolos:\n");
	imprimir(t);
    return 0;
}
int yyerror(char *s){
    printf("Error de sintaxis: %s (Linea: %d)\n",s, yylineno);
    return 0;
}
