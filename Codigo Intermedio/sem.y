%{
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
extern int yylineno;
#include "tablasimb.c"
#define YYERROR_VERBOSE 0
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
    }
    |
    error LA C LC {
        yyerror("Se esperaba sentencia de inicio startPrevebot");
    }
    |
    SP error C LC {
        yyerror("Se esperaba llave de apertura {");
    }
    |
    SP LA C error {
        yyerror("Se esperaba llave de cierre }");
    };
C : MV C | MV
;
MV : TR | AA | SS | DR | TRS | ALT | ACT 
;
TR : TRN DOT DIR {
        printf("call %s%s%s\n", $1, $2, $3);
    };
AA : ED2 PAR1 {
        printf("call %s\n", $1);
    };
SS : SE DOT TIG1 PAR2 {
        printf("call %s%s%s\n", $1, $2, $3);
    };
DR : OCD PAR4 {
        printf("call %s\n", $1);
    };
TRS : TS DOT TIG2 PAR3 {
        printf("call %s%s%s\n", $1, $2, $3);
    };
ALT : AL TP {
        if(strcmp($2,"(")==0){
            printf("call %s\n",$1);
        }else{
            printf("call %s%s\n",$1,$2);
        }
    };
ACT : NA1 PAR1 {
        printf("call %s\n", $1);
    }
    |
    NA2 PAR2 {
        char linea[100];
        sprintf(linea,"%s%s",$1,$2);
        strcpy($$,linea);
    };
TP : PAR3 | DOT MS {
        if(strcmp($1,".")==0){
            char linea[100];
            sprintf(linea,"%s%s", $1, $2);
            strcpy($$,linea);
        }
    };
MS : CLN PAR2 {
        strcpy($$,$1);
    }
    |
    LBT PAR2 {
        strcpy($$,$1);
    }
    |
    TIG1 PAR4 {
        strcpy($$,$1);
    };
DIR : ED1 PAR1 
;
PAR1 : PA NUM PC PTC {
        printf("param %d\n", $2);
    };
PAR2 : PA PC PTC 
;
PAR3 : PA ST PC PTC {
        printf("param %s\n", $2);
    };
PAR4 : PA NUM PC PTC {
        printf("param %d\n", $2);
    }
    |
    PA BIN PC PTC {
        printf("param %d\n", $2);
    }
    |
    PA error PC PTC {
        yyerror("Se esperaba un numero o un valor boleano");
    }
    |
    error NUM PC PTC {
        yyerror("Se esperaba un parentesis de apertura (");
    }
    |
    error BIN PC PTC {
        yyerror("Se esperaba un parentesis de apertura (");
    }
    |
    PA NUM error PTC {
        yyerror("Se esperaba un parentesis de cierre )");
    }
    |
    PA BIN error PTC {
        yyerror("Se esperaba un parentesis de cierre )");
    }
    |
    PA NUM PC error {
        yyerror("Se esperaba un punto y coma ;");
    }
    |
    PA BIN PC error {
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
