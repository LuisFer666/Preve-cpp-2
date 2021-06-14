%option noyywrap
%option yylineno
%{
    #include <stdio.h>
    #include <string.h>
    #include <stdbool.h>
    #include "sem.h"
    void insertatoken(char tipo[], char var[], int num);
%}
Numero [0-9]
Todo .
Todito [\n\t\32-\41\43-\46\48-\255]
LlavA \{
LlavC \}
ParenA \(
ParenC \)
Punto \.
PunComa \;
Comilla \"
Blank [\n\t ]
Coment \/\/
Coment2a \/\*
Coment2c \*\/

SP startPrevebot
NA1 see|listen|talk|screen
NA2 upload
CLN clean
LBT lowBattery
AL alert
TS transport
OCD openDoor|closeDoor
SE sense
TIG1 door|battery|obstacle|carry
TIG2 medicine|cloth|sample
TRN turn
ED1 right|left
ED2 straight|back
BIN true|false

%%
{SP} {
        insertatoken("Reservada",yytext,yylineno);
        strcpy(yylval.cadena,yytext);
        return SP;
    }
{NA1} { 
        insertatoken("Reservada",yytext,yylineno);
        strcpy(yylval.cadena,yytext);
        return NA1;
    }
{NA2} {
        insertatoken("Reservada",yytext,yylineno);
        strcpy(yylval.cadena,yytext);
        return NA2;
    }
{CLN} {
        insertatoken("Reservada",yytext,yylineno);
        strcpy(yylval.cadena,yytext);
        return CLN;
    }
{LBT} {
        insertatoken("Reservada",yytext,yylineno);
        strcpy(yylval.cadena,yytext);
        return LBT;
    }
{AL} {
        insertatoken("Reservada",yytext,yylineno);
        strcpy(yylval.cadena,yytext);
        return AL;
    }
{TS} {
        insertatoken("Reservada",yytext,yylineno);
        strcpy(yylval.cadena,yytext);
        return TS;
    }
{OCD} {
        insertatoken("Reservada",yytext,yylineno);
        strcpy(yylval.cadena,yytext);
        return OCD;
    }
{SE} {
        insertatoken("Reservada",yytext,yylineno);
        strcpy(yylval.cadena,yytext);
        return SE;
    }
{TIG1} {
        insertatoken("Reservada",yytext,yylineno);
        strcpy(yylval.cadena,yytext);
        return TIG1;
    }
{TIG2} {
        insertatoken("Reservada",yytext,yylineno);
        strcpy(yylval.cadena,yytext);
        return TIG2;
    }
{TRN} {
        insertatoken("Reservada",yytext,yylineno);
        strcpy(yylval.cadena,yytext);
        return TRN;
    }
{ED1} {
        insertatoken("Reservada",yytext,yylineno);
        strcpy(yylval.cadena,yytext);
        return ED1;
    }
{ED2} {
        insertatoken("Reservada",yytext,yylineno);
        strcpy(yylval.cadena,yytext);
        return ED2;
    }
{BIN} {
        insertatoken("Boolean",yytext,yylineno);
        if(strcmp(yytext,"true") == 0){
            yylval.boleano = 1;
        }else if(strcmp(yytext, "false") == 0){
            yylval.boleano = 0;
        }
        return BIN;
    }
{ParenA} {
        strcpy(yylval.cadena,yytext);
        return PA;
    }
{ParenC} {
        strcpy(yylval.cadena,yytext);
        return PC;
    }
{LlavA} {
        strcpy(yylval.cadena,yytext);
        return LA;
    }
{LlavC} {
        strcpy(yylval.cadena,yytext);
        return LC;
    }
{Punto} {
        strcpy(yylval.cadena,yytext);
        return DOT;
    }
{PunComa} {
        strcpy(yylval.cadena,yytext);
        return PTC;
    }
{Comilla}{Todo}*{Comilla} {
        insertatoken("String",yytext,yylineno);
        strcpy(yylval.cadena,yytext);
        return ST;
    }
{Numero}+ {
        insertatoken("Integer",yytext,yylineno);
        yylval.numero = atoi(yytext);
        return NUM;
    }

{Coment}{Todo}* { /* Ignora comentario en linea */ ; }
{Coment2a}{Todito}*{Coment2c} { /* Ignora comentario en bloque */ ; }
{Blank}* { /* Ignora espacios, tabulaciones y enters */ ; }
%%

void insertatoken(char tipo[], char var[], int num)
{
	v=(simbolo *) malloc(sizeof(simbolo));
	strcpy(v->tipo,tipo);
	strcpy(v->nombre,var);
	v->linea = num;
	insertar(&t, v);
}