#ifndef lint
static char rcsid[] = "$Header: crash.c,v 1.2 93/02/22 11:54:10 kenm Exp $";
static char copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

#include <varargs.h>
#include <stdio.h>

void u_crash(va_alist)
va_dcl
{
	va_list args;
	char *fmt;

	va_start(args);
	fprintf(stderr, "Fatal Error: ");
	fmt = va_arg(args, char *);
	vfprintf(stderr, fmt, args);
	va_end(args);
	fputc('\n', stderr);
	fflush(stderr);
	exit(1);
}
