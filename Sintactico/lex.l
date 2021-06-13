%option noyywrap
%option yylineno
%{
    #include <stdio.h>
    #include "sin.h"
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
BIN 0|1

%%
{SP} { return SP;}
{NA1} { return NA1;}
{NA2} { return NA2;}
{CLN} { return CLN;}
{LBT} { return LBT;}
{AL} { return AL;}
{TS} { return TS;}
{OCD} { return OCD;}
{SE} { return SE;}
{TIG1} { return TIG1;}
{TIG2} { return TIG2;}
{TRN} { return TRN;}
{ED1} { return ED1;}
{ED2} { return ED2;}
{BIN} { return BIN;}
{ParenA} { return PA;}
{ParenC} { return PC;}
{LlavA} { return LA;}
{LlavC} { return LC;}
{Punto} { return DOT;}
{PunComa} { return PTC;}
{Comilla}{Todo}*{Comilla} { return ST;}
{Coment}{Todo}* { /* Ignora comentario en linea */}
{Coment2a}{Todito}*{Coment2c} { /* Ignora comentario en bloque */}

{Numero}+ { return NUM; }
{Blank}* { /* Ignora los blank porque a Owen le da ansiedad */}
%%