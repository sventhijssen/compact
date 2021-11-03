#ifndef lint
static char rcsid[] = "$Header: main.c,v 1.4 93/05/17 15:57:33 kenm Exp $";
static char copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

#include <stdio.h>
#include <sys/param.h>
#define DECL /**/
#include "nets.h"
#include "token.h"

char dbg[256] = { 0 };

static void report();

static void usage()
{
	fprintf(stderr, "Usage: erprt [-flags] file.edif\n");
	fprintf(stderr, "Flags:\n");
	fprintf(stderr, "       v   - verbose\n");
	exit(1);
}

main(argc, argv)
int argc;
char *argv[];
{
	FILE *fp, *tfp;
	view *vp;
	char *cp;
	char *home;
	int rc;
	char pathbuf[MAXPATHLEN+1];

	home = u_findhome(argv[0]);
	if(argc == 1) usage();
	if(argc > 1 && argv[1][0] == '-') {
		for(cp = argv[1] + 1; *cp; cp++) dbg[*cp & 0xff] = 1;
		argc--; argv++;
	}
	if(argc != 2) u_crash("Wrong number of args");

	/* initialization */
	netlist_init();

	sprintf(pathbuf, "%s/../lib/iwls93.e", home);
	fp = fopen(pathbuf, "r");
	if(fp) {
		printf("Loading lib %s\n", pathbuf);
		ep_startparse(fp);
		fclose(fp);
	}

	fp = fopen(argv[1], "r");
	if(!fp) u_crash("Can't open input file '%s'", argv[1]);

	ep_startparse(fp);
	vp = findview(findcell(findlibrary("user_lib"), "top"), "netlist");
	if(!vp) u_crash("Can't find user_lib:top.netlist to convert");

	report(vp);

	ep_clearnametab();
	exit(rc ? 1 : 0);
}

static float areatotal;
static int numinsts;

static property *findprop(name, plist)
char *name;
property *plist;
{
	property *p;

	for(p = plist; p; p=p->next) {
		if(!strcmp(p->name, name)) break;
	}
	return(p);
}

static void totalarea(vp)
view *vp;
{
	hashtable *iht;
	int iidx;
	instance *ip;
	property *p;

	p = findprop("area", vp->proplist);
	if(p) {
		numinsts++;
		switch(p->kind) {
		case 'i': areatotal += p->u.i; break;
		case 'f': areatotal += p->u.f; break;
		}
	}
	iht = &vp->u.nl.insthash;
	foreachentry(iht, iidx, instance *, ip) {
		totalarea(ip->instof);
	}
}

static library *userlp;
static float defaultcap, defaultmaxcap;

static int stopflatten(vp)
view *vp;
{
	return (vp->cellp->lp != userlp);
}

static float net_cap(np)
net *np;
{
	conn *cnp;
	float cap;
	property *p;

	cap = 0.0;
	for(cnp = np->conns; cnp; cnp=cnp->nnext) {
		if(cnp->ip->instof->viewtype == VIEW_PORT) {
			if(cnp->ip->instof->u.portdir != 'i')
				cap += defaultcap;
		} else {
			p = findprop("cap", cnp->port->proplist);
			if(p) {
				switch(p->kind) {
				case 'i': cap += p->u.i; break;
				case 'f': cap += p->u.f; break;
				}
			}
		}
	}
	return(cap);
}

static float net_maxcap(np)
net *np;
{
	conn *cnp;
	float maxcap, mc;
	property *p;
	int foundmax;

	maxcap = 1e20; /* large */
	foundmax = FALSE;
	for(cnp = np->conns; cnp; cnp=cnp->nnext) {
		if(cnp->ip->instof->viewtype == VIEW_PORT) {
			if(cnp->ip->instof->u.portdir == 'o') continue;
			mc = defaultmaxcap;
		} else {
			p = findprop("maxcap", cnp->port->proplist);
			if(!p) continue;
			switch(p->kind) {
			case 'i': mc = p->u.i; break;
			case 'f': mc = p->u.f; break;
			default: continue;
			}
		}
		if(mc < maxcap) maxcap = mc;
		foundmax = TRUE;
	}
	return(maxcap);
}

static void capreport(vp)
view *vp;
{
	hashtable *nht, *iht;
	int nidx;
	net *np;
	conn *cnp;
	property *p;
	int *cnttable = NIL;
	float *captable = NIL;
	float cap, maxcap;
	int cnttablesize = 0;
	int i, cnt, bigcnt, numconns, numnets;
	double v, totalcap;

	nht = &vp->u.nl.nethash;
	bigcnt = 0;
	numnets = numconns = 0;
	foreachentry(nht, nidx, net *, np) {
		for(cnt = 0, cnp = np->conns; cnp; cnp=cnp->nnext) cnt++;
		if(cnt > bigcnt) bigcnt = cnt;
		if(cnt >= cnttablesize) {
			i = cnttablesize;
			cnttablesize = cnt + 10;
			cnttable = (int *)u_realloc((void *)cnttable,
				cnttablesize * sizeof(int));
			while(i < cnttablesize) cnttable[i++] = 0;
		}
		cnttable[cnt]++;
		numnets++;
		numconns += cnt;
	}
	if(numnets == 0) {
		printf("No nets in netlist!\n");
		return;
	}
	captable = TNEW(float, numnets);
	i = 0;
	totalcap = 0.0;
	foreachentry(nht, nidx, net *, np) {
		cap = net_cap(np);
		maxcap = net_maxcap(np);
		if(cap > maxcap) {
			printf("Maximum cap violation on net %s, limit %g, cap %g\n", np->h.name, maxcap, cap);
		}
		captable[i++] = cap;
		totalcap += cap;
	}

	v = (double)numconns / numnets;
	printf("Average capacitance per net:  %g\n", totalcap / numnets);
	printf("Number of nets:  %d, Number of connections:  %d\n",
		numnets, numconns);
	printf("Average number of connections per net:  %g\n", v);
	if(dbg['v']) {
		printf("count number of nets\n");
		printf("----- --------------\n");
		for(i = 0; i <= bigcnt; i++) {
			printf("%5d %8d\n", i, cnttable[i]);
		}
	}
}

double getportprop(vp, pinname, propname, dflt)
view *vp;
char *pinname, *propname;
double dflt;
{
	instance *pt;
	property *p;
	pt = (instance *)hashfind(&vp->u.nl.porthash, pinname);
	if(!pt) return(dflt);
	p = findprop(propname, pt->proplist);
	if(!p) return(dflt);
	switch(p->kind) {
	case 'i': return(p->u.i);
	case 'f': return(p->u.f);
	}
	return(dflt);
}

static void getdefaultcapvalues()
{
	library *lp;
	cell *cellp;
	view *vp;

	defaultcap = 0.01;
	defaultmaxcap = 5.0;

	lp = findlibrary("iwls93");
	cellp = lp ? findcell(lp, "ffp") : NIL;
	vp = cellp ? findview(cellp, "interface") : NIL;
	if(vp && vp->viewtype == VIEW_NETLIST) {
		defaultcap = getportprop(vp, "d", "cap", 0.01);
		defaultmaxcap = getportprop(vp, "q", "maxcap", 5.0);
	} else {
		printf("Could not find iwls93:ffp.interface to get default loading values\n");
	}
	if(dbg['v']) {
		printf("Default output port cap: %g\n", defaultcap);
		printf("Default input port maxcap: %g\n", defaultmaxcap);
	}
}

static void report(vp)
view *vp;
{

	getdefaultcapvalues();

	userlp = vp->cellp->lp;
	flatten(vp, stopflatten);

	areatotal = 0;
	numinsts = 0;
	totalarea(vp);
	printf("Number of instances: %d, Total area: %g\n",
		numinsts, areatotal);
	capreport(vp);
}
