#ifndef EPROP_H
#define EPROP_H

#if !(defined lint) && (defined RCSHEADERS)
static char eprop_rcsid[] = "$Header: eprop.h,v 1.3 93/02/22 12:01:25 kenm Exp $";
static char eprop_copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

typedef struct _property {
	char *name;
	struct _property *next;
	int kind; /* 'i' - int, 's' - string, 'f' - double */
	union {
		double f;
		int i;
		char *s;
	} u;
} property;

#endif
