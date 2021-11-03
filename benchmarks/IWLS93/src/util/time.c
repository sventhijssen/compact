#ifndef lint
static char rcsid[] = "$Header: time.c,v 1.3 93/02/22 11:54:13 kenm Exp $";
static char copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

#ifdef _HPUX_SOURCE
#include <time.h>
#else
#include <sys/time.h>
#endif

long u_currenttime()
{
	struct timeval t;

	gettimeofday(&t, (struct timezone *)0);
	return(t.tv_sec);
}

char *u_timestring(time)
long time;
{
	return(ctime(&time));
}
