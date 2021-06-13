#include <stdlib.h>
#include <stdio.h>
typedef struct nulo {
	struct nulo * sig;
	char tipo [20];
	char nombre [20];
	int linea;
} simbolo;
simbolo * crear() {
	return NULL;
};
void insertar(p_t,s)
simbolo **p_t;
simbolo * s;
{
	s->sig = (*p_t);
	(*p_t) = s;
};
simbolo * buscar(t,nombre)
simbolo * t;
char nombre[20];
{
	while ( (t != NULL) && (strcmp(nombre, t->nombre)) )
		t = t->sig;
	return (t);
};
void imprimir(t)
simbolo * t;
{
	while (t != NULL) {
		printf("%-15s %-15s %3d\n", t->tipo,t->nombre,t->linea);
		t = t->sig;
	}
};
