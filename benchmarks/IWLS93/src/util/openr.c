#ifndef lint
static char rcsid[] = "$Header: openr.c,v 1.2 93/03/02 01:10:54 drickel Exp $";
static char copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

#include <string.h>
#include <stdio.h>
#include <sys/param.h>
#include "util.h"

/*
 * open a file for reading.  handle compressed (.Z) files.  return TRUE if
 * we popened the file
 */
u_openr(path, fpp)
char *path;
FILE **fpp;
{
	char *cp;
	FILE *fp;
	static char strbuf[MAXPATHLEN+20];
	static char zfile[MAXPATHLEN+3];	/* ick */
	int compressed;

	cp = strrchr(path, '.');
	if(!cp || strcmp(cp, ".Z")) {
		fp = fopen(path, "r");
		if(fp) {
			*fpp = fp;
			return(OPEN_FILE);
		}
		strcpy(zfile, path);
		strcat(zfile, ".Z");
		cp = zfile;
	} else {
		cp = path;
	}
	sprintf(strbuf, "uncompress -c \'%s\'", cp);
	fp = popen(strbuf, "r");
	if(fp) {
		*fpp = fp;
		return(OPEN_PIPE);
	}
	*fpp = NULL;
	return(OPEN_FAIL);
}

u_closer(fp, mode)
FILE *fp;
int mode;
{
	switch(mode) {
	case OPEN_FAIL:
		break;
	case OPEN_FILE:
		return(fclose(fp));
	case OPEN_PIPE:
		return(pclose(fp));
	default:
		u_crash("Unknown close mode %d", mode);
		break;
	}
}
