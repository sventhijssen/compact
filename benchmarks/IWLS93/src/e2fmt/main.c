#ifndef lint
static char rcsid[] = "$Header: main.c,v 1.5 93/05/17 15:56:30 kenm Exp $";
static char copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

#include <sys/param.h>
#include <stdio.h>
#define DECL /**/
#define RCSHEADERS
#include "nets.h"
#include "token.h"

char dbg[256] = { 0 };
extern int ex_verbose;

static void usage()
{
	fprintf(stderr, "Usage: e2fmt -[flags] <file1>.e <file2>.e ...\n");
	fprintf(stderr, "Flags:   l  - load iwls93/bin/../lib/iwls93.e\n");
	fprintf(stderr, "         f  - Flatten the hierarchy\n");
	fprintf(stderr, "         s  - write slif\n");
	fprintf(stderr, "         b  - write blif\n");
	fprintf(stderr, "         e  - write edif\n");
	fprintf(stderr, "You must select exactly one of s b or e\n");
	exit(1);
}

main(argc, argv)
int argc;
char *argv[];
{
	FILE *fp, *ofp;
	view *vp;
	char *cp;
	int apos;
	int ostatus;

	if(argc <= 1) usage();
	apos = 1;
	if(argc > 1 && argv[1][0] == '-') {
		for(cp = argv[1] + 1; *cp; cp++) dbg[*cp & 0xff] = 1;
		apos++;
	}
	if((dbg['b'] + dbg['e'] + dbg['s']) != 1) {
		fprintf(stderr, "Error: Output format must be selected\n");
		usage();
	}

	if(argc - apos <= 0) {
		fprintf(stderr, "Error: Not enough args\n");
		usage();
	}
	if(dbg['d']) ex_verbose = TRUE;

	/* initialization */
	netlist_init();

	if(dbg['l']) {
		char *home;
		char pathbuf[MAXPATHLEN+1];

		home = u_findhome(argv[0]);
		sprintf(pathbuf, "%s/../lib/iwls93.e", home);
		fp = fopen(pathbuf, "r");
		if(fp) {
			fprintf(stderr, "Loading lib %s\n", pathbuf);
			ep_startparse(fp);
			fclose(fp);
		}
	}

	for(; apos < argc; apos++) {
		ostatus = u_openr(argv[apos], &fp);
		if(ostatus == OPEN_FAIL)
			u_crash("Can't open input file '%s'", argv[apos]);
		ep_startparse(fp);
		u_closer(fp, ostatus);
	}

	vp = findview(findcell(findlibrary("user_lib"), "top"), "netlist");
	if(!vp) u_crash("Can't find user_lib:top.netlist to convert");

	ofp = stdout;
	if(!dbg['e']) {
		fprintf(ofp, "#\n# Written by e2fmt %s",
			u_timestring(u_currenttime()));
	}
	if(dbg['f']) flatten(vp, isprimitive);
	if(dbg['b']) writeblif(ofp, vp);
	else if(dbg['s']) writeslif(ofp, vp);
	else writeedif(ofp, vp);

	fclose(ofp);
	ep_clearnametab();
	exit(0);
}
