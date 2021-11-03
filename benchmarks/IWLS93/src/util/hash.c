#ifndef lint
static char rcsid[] = "$Header: hash.c,v 1.2 93/02/22 11:54:11 kenm Exp $";
static char copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

#define RCSHEADERS
#include "util.h"
#include "hash.h"

static int computehash(ht, name)
hashtable *ht;
register char *name;
{
	register unsigned int sum, sum2;

	sum = sum2 = 0;
	while(*name) {
		sum += sum + sum + *name++;
		if(!*name) break;
		sum2 += *name++;
	}
	sum ^= sum2;
	sum &= ht->tmask;
	return((int)sum);
}

void hashinit(ht)
hashtable *ht;
{
	int i;
	ht->tsize = 32; /* auto-resize later */
	ht->tmask = ht->tsize - 1;
	ht->count = 0;
	ht->table = TNEW(hashentry *, ht->tsize);
	for(i = 0; i < ht->tsize; i++) ht->table[i] = NIL;
}

hashentry *hashfind(ht, name)
hashtable *ht;
char *name;
{
	register hashentry *he;

	for(he = ht->table[computehash(ht, name)]; he; he = he->next) {
		if(!strcmp(he->name, name)) break;
	}
	return(he);
}

int hashinsert_f(ht, nhe)
hashtable *ht;
hashentry *nhe;
{
	int h;
	hashentry *he;
	char *name;

	h = computehash(ht, nhe->name);
	name = nhe->name;
	for(he = ht->table[h]; he; he = he->next) {
		if(!strcmp(he->name, name)) break;
	}
	if(he) return(FAIL);
	nhe->next = ht->table[h];
	ht->table[h] = nhe;
	ht->count++;
	return(SUCCESS);
}

int hashdelete_f(ht, nhe)
hashtable *ht;
hashentry *nhe;
{
	int h;
	hashentry **phe;

	h = computehash(ht, nhe->name);
	for(phe = &ht->table[h]; *phe; phe = &(*phe)->next) {
		if(*phe == nhe) {
			*phe = nhe->next;
			ht->count--;
			return(SUCCESS);
		}
	}
	return(FAIL);
}


