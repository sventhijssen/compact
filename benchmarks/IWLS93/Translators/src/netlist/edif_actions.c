#ifndef lint
static char rcsid[] = "$Header: edif_actions.c,v 1.2 93/02/22 12:04:48 kenm Exp $";
static char copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

#include <varargs.h>
#include "nets.h"

int ex_verbose = FALSE;

static library *curlib = NIL;
static cell *curcell = NIL;
static view *curview = NIL;
static int viewredef = FALSE;
static net *curnet = NIL;

/*VARARGS*/
void dprintf(va_alist)
va_dcl
{
	va_list args;
	char *fmt;

	va_start(args);
	if(ex_verbose) {
		fprintf(stderr, "DBG: ");
		fmt = va_arg(args, char *);
		vfprintf(stderr, fmt, args);
		fflush(stderr);
	}
	va_end(args);
}

int ex_startlibrary(libtype, libname)
char *libtype;
char *libname;
{
	library *lp;
	dprintf("Starting library %s(%s)\n", libname, libtype);
	lp = (library *)hashfind(&libhash, libname);
	if(!lp) {
		lp = ZTNEW(library, 1);
		lp->h.name = libname;
		hashinit(&lp->cellhash);
		hashinsert(&libhash, lp);
		lp->external = !strcasecmp(libtype, "external");
	}
	curlib = lp;
	return(SUCCESS);
}

int ex_endlibrary(plist)
property *plist;
{
	property *p;
	dprintf("Ending library %s\n", curlib->h.name);
	while(plist) {
		p = plist;
		plist = p->next;
		p->next = curlib->proplist;
		curlib->proplist = p;
	}
	curlib = NIL;
	return(SUCCESS);
}

int ex_startcell(cellname)
char *cellname;
{
	cell *cellp;
	dprintf("Starting cell %s\n", cellname);
	cellp = (cell *)hashfind(&curlib->cellhash, cellname);
	if(!cellp) {
		cellp = ZTNEW(cell, 1);
		cellp->h.name = cellname;
		cellp->lp = curlib;
		hashinit(&cellp->viewhash);
		hashinsert(&curlib->cellhash, cellp);
	}
	curcell = cellp;
	return(SUCCESS);
}

int ex_endcell(plist)
property *plist;
{
	property *p;
	dprintf("Ending cell %s\n", curcell->h.name);
	while(plist) {
		p = plist;
		plist = p->next;
		p->next = curcell->proplist;
		curcell->proplist = p;
	}
	curcell = NIL;
	return(SUCCESS);
}

int ex_design(designname, libname, cellname)
char *designname, *libname, *cellname;
{
	dprintf("design %s (cellref %s (libraryref %s))\n",
		designname, libname, cellname);
	return(SUCCESS);
}

int ex_startview(viewname)
char *viewname;
{
	view *vp;
	dprintf("startview %s\n", viewname);
	vp = (view *)hashfind(&curcell->viewhash, viewname);
	if(!vp) {
		vp = ZTNEW(view, 1);
		vp->h.name = viewname;
		hashinsert(&curcell->viewhash, vp);
		hashinit(&vp->u.nl.porthash);
		hashinit(&vp->u.nl.insthash);
		hashinit(&vp->u.nl.nethash);
		vp->cellp = curcell;
		vp->proplist = NIL;
		setprimtype(vp);
		viewredef = FALSE;
	} else {
		viewredef = TRUE;
	}
	curview = vp;
	return(SUCCESS);
}

int ex_endview(plist)
property *plist;
{
	property *p;
	dprintf("endview %s\n", curview->h.name);
	while(plist) {
		p = plist;
		plist = p->next;
		p->next = curview->proplist;
		curview->proplist = p;
	}
	fixnc(curview);
	curview = NIL;
	return(SUCCESS);
}

int ex_port(name, dir, plist)
char *name;
int dir;
property *plist;
{
	conn *ptp;
	instance *ip;
	instance *ptpip;

	dprintf("port %s %c\n", name, dir);
	if(viewredef) {
		if(hashfind(&curview->u.nl.porthash, name)) return(SUCCESS);
		fprintf(stderr, "Mismatched port names in redef of %s:%s.%s\n",
			curlib->h.name, curcell->h.name, curview->h.name);
		return(FAIL);
	}
	ip = ZTNEW(instance, 1);
	ip->h.name = name;
	ip->proplist = plist;
	switch(dir) {
	case 'i':
		ip->instof = &inport;
		ptpip = &outportinst;
		break;
	case 'o':
		ip->instof = &outport;
		ptpip = &inportinst;
		break;
	case 'b':
		ip->instof = &biport;
		ptpip = &biportinst;
		break;
	}
	ip->owner = curview;

	ip->ports = ptp = ZTNEW(conn, 1);
	ptp->np = NIL;
	ptp->ip = ip;
	ptp->port = ptpip;
	ptp->inext = NIL;
	ptp->nnext = NIL;

	hashinsert(&curview->u.nl.porthash, ip);
	return(SUCCESS);
}

int ex_instance(name, libname, cellname, viewname, plist)
char *name, *libname, *cellname, *viewname;
property *plist;
{
	instance *ip, *pip;
	view *vp;
	hashtable *ph;
	conn *ptp, **tptp;
	int hidx;

	dprintf("instance %s of %s:%s.%s\n", name, libname, cellname, viewname);
	if(hashfind(&curview->u.nl.insthash, name)) {
		fprintf(stderr, "Duplicate instance name %s in view %s:%s.%s\n",
			name, curlib->h.name, curcell->h.name, curview->h.name);
		return(FAIL);
	}
	vp = findview(findcell(findlibrary(libname), cellname), viewname);
	if(!vp) {
		fprintf(stderr, "Instance %s of nonexistant view %s:%s.%s\n",
			name, libname, cellname, viewname);
		return(FAIL);
	}
	ip = ZTNEW(instance, 1);
	ip->h.name = name;
	ip->instof = vp;
	ip->owner = curview;
	ip->ports = NIL;
	ip->proplist = plist;

	ph = &vp->u.nl.porthash;
	tptp = &ip->ports;
	foreachentry(ph, hidx, instance *, pip) {
		ptp = ZTNEW(conn, 1);
		ptp->np = NIL;
		ptp->ip = ip;
		ptp->port = pip;
		ptp->inext = NIL;
		ptp->nnext = NIL;
		*tptp = ptp;
		tptp = &ptp->inext;
	}
	hashinsert(&curview->u.nl.insthash, ip);

	return(SUCCESS);
}

int ex_startnet(name)
char *name;
{
	net *np;
	dprintf("net %s\n", name);
	if(hashfind(&curview->u.nl.nethash, name)) {
		fprintf(stderr, "Duplicate net name %s in view %s:%s.%s\n",
			name, curlib->h.name, curcell->h.name, curview->h.name);
		return(FAIL);
	}
	np = ZTNEW(net, 1);
	np->h.name = name;
	np->conns = NIL;
	np->owner = curview;
	hashinsert(&curview->u.nl.nethash, np);
	curnet = np;
	return(SUCCESS);
}

int ex_endnet(plist)
property *plist;
{
	dprintf("endnet %s\n", curnet->h.name);
	curnet->proplist = plist;
	curnet = NIL;
	return(SUCCESS);
}

int ex_join(pname, iname)
char *pname;
char *iname;
{
	instance *ip, *pip;
	conn *ptp;

	if(!curnet) return(SUCCESS);
	dprintf(" join to %s.%s\n", iname ? iname : "$", pname);
	if(iname) {
		ip = (instance *)hashfind(&curview->u.nl.insthash, iname);
		if(!ip) {
			fprintf(stderr, "join for net %s to %s.%s failed - no such instance\n",
				curnet->h.name, iname, pname);
			return(FAIL);
		}
		for(ptp = ip->ports; ptp; ptp=ptp->inext) {
			if(!strcmp(ptp->port->h.name, pname)) break;
		}
		if(!ptp) {
			fprintf(stderr, "join for net %s to %s.%s failed - no such port\n",
				curnet->h.name, iname, pname);
			return(FAIL);
		}
	} else {
		ip = (instance *)hashfind(&curview->u.nl.porthash, pname);
		if(!ip) {
			fprintf(stderr, "join for net %s to $.%s failed\n",
				curnet->h.name, pname);
			return(FAIL);
		}
		ptp = ip->ports;
	}
	if(ptp->np) {
		fprintf(stderr, "join for net %s to %s.%s failed - already connected\n",
			curnet->h.name, iname, pname);
		
	}
	hookup(ptp, curnet);
	return(SUCCESS);
}
