#ifndef TOKEN_H
#define TOKEN_H

#if !(defined lint) && (defined RCSHEADERS)
static char token_rcsid[] = "$Header: token.h,v 1.4 93/02/22 12:01:29 kenm Exp $";
static char token_copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif


#ifndef DECL
#define DECL extern
#endif
#include "eprop.h"

/* file to parse from */
DECL FILE *e_fp;

/* Current token info */
DECL int ep_tkind;	/* token kind */
DECL char *ep_tbuf;  DECL int ep_tlen; /* string buffer and length */
DECL property *ep_property;
#if 0
DECL char *ep_tname; DECL int ep_tnamelen; /* result of rename */
#endif
DECL long ep_tint;	/* integer token value */
DECL double ep_tdouble; /* double token value */
DECL char *ep_tcharp;   /* generic pointer value */
DECL int ep_tokenpushed; /* indicates that a token has been pushed back */

DECL int ep_line;	/* line number in file */
DECL int ep_ecnt;	/* number of errors in file */

typedef struct _ep_name {
	struct _ep_name *hashnext;
	char flags;
#define N_LIBNAME 1
#define N_CELLNAME 2
#define N_VIEWNAME 4

#define NAMESTRSIZE 3
	char str[NAMESTRSIZE];
} ep_name;

DECL struct _ep_name *ep_tname;

extern ep_name *ep_getname();

/* token type */
#define T_EOF	0
#define T_LPAR	1
#define T_RPAR	2
#define T_QSTR	4
#define T_INT	5
#define T_ALIST	6
#define T_CHARP 7
#define T_DOUBLE 8
#define T_NULL	9
#define T_RENAME 10
#define T_VREF 11
#define T_CREF 12
#define T_LREF 13
#define T_END 14
#define T_NAME 15
#define T_DIRECTION 16
#define T_PROPERTY 17
#define T_ERROR	18

#endif
