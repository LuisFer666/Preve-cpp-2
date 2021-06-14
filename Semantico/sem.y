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
SEN : error LA C LC {
        yyerror("Se esperaba sentencia de inicio startPrevebot");
    };
SEN : SP error C LC {
        yyerror("Se esperaba llave de apertura {");
    };
SEN : SP LA C error {
        yyerror("Se esperaba llave de cierre }");
    };
C : MV C | MV
;
MV : TR | AA | SS | DR | TRS | ALT | ACT
;
TR : TRN DOT DIR {
        printf("Linea %d - TR valida - %s %s %s\n", yylineno, $1, $2, $3);
    };
AA : ED2 PAR1 {
        printf("Linea %d - AA valida - %s %s\n", yylineno, $1, $2);
    };
SS : SE DOT TIG1 PAR2 {
        printf("Linea %d - SS valida - %s %s %s %s\n", yylineno, $1, $2, $3, $4);
    };
DR : OCD PAR4 {
        printf("Linea %d - DR valida - %s %s\n", yylineno, $1, $2);
    };
TRS : TS DOT TIG2 PAR3 {
        printf("Linea %d - TRS valida - %s %s %s %s\n", yylineno, $1, $2, $3, $4);
    };
ALT : AL TP {
        printf("Linea %d - ALT valida - %s %s\n", yylineno, $1, $2);
    };
ACT : NA1 PAR1 | NA2 PAR2 {
        printf("Linea %d - ACT valida - %s %s\n", yylineno, $1, $2);
    };
TP : PAR3 | DOT MS {
        printf("Linea %d - TP valida - %s %s\n", yylineno, $1, $2);
    };
MS : CLN PAR2 | LBT PAR2 | TIG1 PAR4 {
        printf("Linea %d - MS valida - %s %s\n", yylineno, $1, $2);
    };
DIR : ED1 PAR1 {
        printf("Linea %d - DIR valida - %s %s\n", yylineno, $1, $2);
    };
PAR1 : PA NUM PC PTC {
        printf("Linea %d - PAR1 valida - %s %d %s %s\n", yylineno, $1, $2, $3, $4);
    };
PAR2 : PA PC PTC {
        printf("Linea %d - PAR2 valida - %s %s %s\n", yylineno, $1, $2, $3);
    };
PAR3 : PA ST PC PTC {
        printf("Linea %d - PAR3 valida - %s %s %s %s\n", yylineno, $1, $2, $3, $4);
    };
PAR4 : PA NUM PC PTC | PA BIN PC PTC {
        printf("Linea %d - PAR4 valida - %s %d %s %s\n", yylineno, $1, $2, $3, $4);
    };
PAR4 : PA error PC PTC {
        yyerror("Se esperaba un numero o un valor boleano");
    };
PAR4 : error NUM PC PTC {
        yyerror("Se esperaba un parentesis de apertura (");
    };
PAR4 : error BIN PC PTC {
        yyerror("Se esperaba un parentesis de apertura (");
    };
PAR4 : PA NUM error PTC {
        yyerror("Se esperaba un parentesis de cierre )");
    };
PAR4 : PA BIN error PTC {
        yyerror("Se esperaba un parentesis de cierre )");
    };
PAR4 : PA NUM PC error {
        yyerror("Se esperaba un punto y coma ;");
    };
PAR4 : PA BIN PC error {
        yyerror("Se esperaba un punto y coma ;");
    };
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
