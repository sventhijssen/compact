#if !(defined lint) && (defined RCSHEADERS)
static char util_rcsid[] = "$Header: util.h,v 1.3 93/03/02 01:11:16 drickel Exp $";
static char util_copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif


#include <stdio.h>

#ifndef DECL
#define DECL extern
#endif

#define TRUE 1
#define FALSE 0
#define NIL 0
#define FAIL 0
#define SUCCESS 1

#define OPEN_FAIL	0
#define OPEN_FILE	1
#define OPEN_PIPE	2

extern void *u_malloc(), *u_realloc(), *u_calloc();
extern void u_free();
extern char *u_strsave();
extern long u_currenttime();
extern char *u_timestring();
extern char *u_findhome();

#define ZTNEW(typ,cnt) ((typ *)u_calloc((cnt),sizeof(typ)))
#define TNEW(typ,cnt) ((typ *)u_malloc(((cnt)*sizeof(typ))))
