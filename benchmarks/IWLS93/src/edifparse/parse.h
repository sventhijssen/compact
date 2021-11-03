#ifndef PARSE_H
#define PARSE_H

#if !(defined lint) && (defined RCSHEADERS)
static char parse_rcsid[] = "$Header: parse.h,v 1.3 93/02/22 12:01:28 kenm Exp $";
static char parse_copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

/* description of keyword actions */

#ifndef DECL
#define DECL extern
#endif

typedef struct _ep_keyword {
	char *name;
	struct _ep_keyword *hashnext;
	char *operands;
	int (*f)(); /* function to call */
	char *data; /* generic data pointer for f */
	struct _ep_keyword *alias;
} ep_keyword;

typedef struct _ep_reference {
	char *library;
	char *cell;
	char *view;
} ep_reference;

/* count arg for repeat type keywords */
#define SD_FIRST -1
#define SD_LAST -2

#define SD_MAXARGS 10

DECL int ep_edifversion[3];
DECL int ep_ediflevel;

DECL int (*ep_emsgp)(); /* for printing error messages */

extern ep_keyword
	*ep_findkey(),
	*ep_addkey(),
	*ep_ignorekey(),
	*ep_aliaskey();

DECL ep_keyword
	*epkey_ediflevel,
	*epkey_technology,
	*epkey_interface,
	*epkey_property;

DECL struct _ep_keyword *ep_tkey; /* keyword used to get value */
DECL struct _ep_keyword *ep_tkeyfirst; /* keyword when SD_FIRST */
DECL struct _ep_reference ep_tcref, ep_tvref, ep_tlref;
#endif
