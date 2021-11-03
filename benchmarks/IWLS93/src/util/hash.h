#ifndef HASHENTRY
#define HASHENTRY

#if !(defined lint) && (defined RCSHEADERS)
static char hash_rcsid[] = "$Header: hash.h,v 1.2 93/02/22 11:54:13 kenm Exp $";
static char hash_copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

typedef struct _hashentry {
	char *name;
	struct _hashentry *next;
} hashentry;

typedef struct _hashtable {
	int tsize;
	int tmask;
	int count;
	struct _hashentry **table;
} hashtable;

#define hashinsert(ht, he) hashinsert_f(ht, (hashentry *)he)
#define hashdelete(ht, he) hashdelete_f(ht, (hashentry *)he)

#define foreachentry(Zht, Zidx, Ztype, Zvar) \
	for(Zidx = 0; Zidx < (Zht)->tsize; Zidx++) \
		for(Zvar = (Ztype)((Zht)->table[Zidx]); Zvar; Zvar=(Ztype)(Zvar->h.next))

#endif
