#ifndef lint
static char rcsid[] = "$Header: home.c,v 1.5 93/06/03 18:48:58 drickel Exp $";
static char copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

#include <sys/param.h>
#include <sys/file.h>
#include <string.h>
#include "util.h"
#ifdef _HPUX_SOURCE
#include <unistd.h>
#else
extern char *getwd();
#endif

extern char *getenv();

static char *home = NIL;

char *u_getwd()
{
	char *d;
	char curdir[MAXPATHLEN+2];
#ifdef _HPUX_SOURCE
	d = getcwd(curdir, MAXPATHLEN);
#else
	d = getwd(curdir);
#endif
	if(!d) u_crash("Can't find current directory!");
	return(u_strsave(d));
}

/*
 * Figure out where the program executable is stored
 */
char *u_findhome(argv0)
char *argv0;
{
	char *pp;
	char *xpath;
	char *cp;
	int len;
	char pathbuf[MAXPATHLEN+2];

	pp = getenv("IWLSLIB");
	if(pp && pp[0]) {
		home = u_strsave(pp);
		len = strlen(home);
		if(len > 1 && home[len-1] == '/') home[len-1] = 0;
		return(home);
	}
	pp = argv0;
	if(pp[0] == '/') {
		home = u_strsave(pp);
		cp = strrchr(home, '/');
		*cp = 0;
		return(home);
	}
	if(!strncmp(pp, "../", 3) || !strncmp(pp, "./", 2)) {
		cp = u_getwd();
		strcpy(pathbuf, cp);
		u_free(cp);
		while(1) {
			if(!strncmp(pp, "../", 3)) {
				pp += 3;
				cp = strrchr(pathbuf, '/');
				if(!cp) u_crash("Illegal prog path %s", argv0);
				if(cp == pathbuf) cp++;
				*cp = 0;
			} else if(!strncmp(pp, "./", 2)) {
				pp += 2;
			} else {
				break;
			}
		}
		home = u_malloc(strlen(pathbuf) + strlen(pp) + 2);
		sprintf(home, "%s/%s", pathbuf, pp);
		cp = strrchr(home, '/');
		if(cp) *cp = 0;
		return(home);
	}
	/* we have to search the path */
	xpath = getenv("PATH");
	while(*xpath) {
		if(*xpath == ':') {
			xpath++;
			continue;
		}
		cp = pathbuf;
		if(xpath[0] == '.' && xpath[1] == 0) {
			++ xpath;
			cp = u_getwd();
			strcpy(pathbuf, cp);
			u_free(cp);
			cp = pathbuf + strlen(pathbuf);
		}
		while(*xpath && *xpath != ':') {
			*cp++ = *xpath++;
		}
		if(cp[-1] != '/') *cp++ = '/';
		strcpy(cp, pp);
		if(!access(pathbuf, X_OK)) {
			return(u_findhome(pathbuf));
		}
	}
	u_crash("Can't find location of executable %s", argv0);
	/*NOTREACHED*/
}
