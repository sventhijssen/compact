#ifndef lint
static char rcsid[] = "$Header: alloc.c,v 1.2 93/02/22 11:54:08 kenm Exp $";
static char copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

#include <stdlib.h>
#include "util.h"

void *u_malloc(size)
int size;
{
	void *p;

	if(size < 0) u_crash("u_malloc: Illegal size");
	if(size == 0) return(NIL);
	p = malloc(size);
	if(!p) u_crash("u_malloc: Out of memory");
	return(p);
}

void *u_realloc(p, size)
void *p;
int size;
{
	void *q;

	if(size < 0) u_crash("u_realloc: Illegal size");
	if(!p) return(u_malloc(size));
	q = realloc(p, size);
	if(!q) u_crash("u_realloc: Out of memory");
	return(q);
}

void u_free(p)
void *p;
{
	if(!p) return;
	if((int)p & 0x3) u_crash("u_free: misalligned free");
	free(p);
}

void *u_calloc(nelem, elsize)
int nelem, elsize;
{
	if(nelem == 0 || elsize == 0) return(NIL);
	if(nelem < 0 || elsize < 0) u_crash("u_calloc: bad size");
	return(calloc(nelem, elsize));
}

char *u_strsave(str)
char *str;
{
	int len;
	char *p;
	len = strlen(str);
	p = u_malloc(len + 1);
	strcpy(p, str);
	return(p);
}
