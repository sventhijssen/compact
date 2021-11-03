#ifndef lint
static char rcsid[] = "$Header: main.c,v 1.7 93/05/17 15:57:53 kenm Exp $";
static char copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

#include <stdio.h>
#include <sys/param.h>
#include <string.h>
#define DECL /**/
#include "nets.h"
#include "token.h"

char dbg[256] = { 0 };
extern int ex_verbose;

static void usage()
{
	fprintf(stderr, "Usage: esim [-flags] netlist.e [patterns.tv]\n");
	fprintf(stderr, "Flags:\n");
	fprintf(stderr, "    s   - silent, suppresses trace\n");
	fprintf(stderr, "    r0  - reset all state to 0\n");
	fprintf(stderr, "    r1  - reset all state to 1\n");
	fprintf(stderr, "    r%%d - random init with seed\n");
	fprintf(stderr, "patterns.tv defaults to netlist.tv\n");
	fprintf(stderr, "A .Z suffix for the netlist or test pattern file\n");
	fprintf(stderr, "will trigger automatic decompression\n");
	exit(1);
}

main(argc, argv)
int argc;
char *argv[];
{
	FILE *fp, *tfp;
	view *vp;
	char *cp, *zcp;
	char *home;
	char *tvfile;
	int rc, c;
	int seed = -1;
	int status;		/* file is compressed--need to pclose it */
	char strbuf[MAXPATHLEN+1];

	home = u_findhome(argv[0]);
	if(argc == 1) usage();
	if(argc > 1 && argv[1][0] == '-') {
		for(cp = argv[1] + 1; *cp; cp++) {
			c = *cp & 0xff;
			switch(c) {
			case 's':
			case 'd':
				dbg[c & 0xff] = 1;
				break;
			case 'r':
				seed = 0;
				cp++;
				while(*cp && isdigit(*cp)) {
					seed = seed * 10 + *cp++ - '0';
				}
				--cp;
				break;
			default:
				u_crash("Unknown flag %c", c);
			}
		}
		argc--; argv++;
	}
	if(argc == 2) {
		tvfile = u_malloc(strlen(argv[1]) + 8);
		strcpy(tvfile, argv[1]);
		cp = strrchr(tvfile, '.');
		if(cp && !strcmp(cp, ".Z")) *cp = 0;
		cp = strrchr(tvfile, '.');
		if(!cp) cp = tvfile + strlen(tvfile);
		strcpy(cp, ".tv");
	} else if(argc == 3) {
		tvfile = argv[2];
	}
	if(dbg['d']) ex_verbose = TRUE;

	/* initialization */
	netlist_init();

	sprintf(strbuf, "%s/../lib/iwls93.e", home);
	status = u_openr(strbuf, &fp);
	if(status != OPEN_FAIL) {
		printf("Loading lib %s\n", strbuf);
		ep_startparse(fp);
		u_closer(fp, status);
	}

	status = u_openr(argv[1], &fp);
	if(status == OPEN_FAIL) {
		u_crash("Can't open input file '%s'", argv[1]);
	}

	ep_startparse(fp);

	u_closer(fp, status);

	vp = findview(findcell(findlibrary("user_lib"), "top"), "netlist");
	if(!vp) u_crash("Can't find user_lib:top.netlist to convert");

	flatten(vp, isprimitive);

	status = u_openr(tvfile, &tfp);
	if(status == OPEN_FAIL) {
		u_crash("Can't open test pattern input file %s", tvfile);
	}

	rc = dosim(vp, tfp, !dbg['s'], seed);

	u_closer(tfp, status);

	ep_clearnametab();
	exit(rc ? 1 : 0);
}
