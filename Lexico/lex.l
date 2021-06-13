%option noyywrap
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
Palabra (startPrevebot)|(turn)|(right)|(left)|(straight)|(stop)|(back)|(sense)|(door)|(battery)|(obstacle)|(carry)|(openDoor)|(closeDoor)|(transport)|(medicine)|(cloth)|(sample)|(alert)|(clean)|(lowBattery)|(upload)|(see)|(listen)|(talk)|(screen)
Blank [\n\t ]
Coment \/\/
Coment2a \/\*
Coment2c \*\/

%%
{Blank}* { printf("Enter, tab o espacio\n");}
{Coment2a}{Todito}*{Coment2c} { printf("\nComentario de bloque %s\n\n", yytext);}
{Numero}+ { printf("Numero: %s \n", yytext);}
{LlavA} { printf("Llave que abre: %s \n", yytext);}
{LlavC} { printf("Llave que cierra: %s\n", yytext);}
{ParenA} { printf("Parentesis que abre: %s\n", yytext);}
{ParenC} { printf("Parentesis que cierra: %s\n", yytext);}
{Punto} { printf("Punto: %s\n", yytext);}
{PunComa} { printf("Punto y coma: %s\n", yytext);}
{Palabra} { printf("Palabra reservada: %s \n", yytext);}
{Comilla}{Todo}*{Comilla} { printf("String: %s \n", yytext);}
{Coment}{Todo}* { printf("Comentario en linea: %s\n", yytext);}
%%

int main(){
    yylex();
    return 0;
}