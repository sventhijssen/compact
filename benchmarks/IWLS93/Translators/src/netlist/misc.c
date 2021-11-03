#ifndef lint
static char rcsid[] = "$Header: misc.c,v 1.2 93/02/22 12:04:54 kenm Exp $";
static char copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

#define RCSHEADERS
#include "nets.h"
#include "token.h"

extern ep_name *ep_getname();

library *findlibrary(name)
char *name;
{
	return((library *)hashfind(&libhash, name));
}

cell *findcell(lp, name)
library *lp;
char *name;
{
	if(!lp) return(NIL);
	return((cell *)hashfind(&lp->cellhash, name));
}

view *findview(cellp, name)
cell *cellp;
char *name;
{
	if(!cellp) return(NIL);
	return((view *)hashfind(&cellp->viewhash, name));
}

void deletenet(np)
net *np;
{
	hashdelete(&np->owner->u.nl.nethash, np);
	u_free((char *)np);
}

void deleteinstance(ip)
instance *ip;
{
	conn *ptp;
	for(ptp = ip->ports; ptp; ptp=ptp->inext) {
		unhook(ptp);
	}
	hashdelete(&ip->owner->u.nl.insthash, ip);
	while(ip->ports) {
		ptp = ip->ports;
		ip->ports = ptp->inext;
		u_free((char *)ptp);
	}
	u_free((char *)ip);
}

void hookup(ptp, np)
conn *ptp;
net *np;
{
	ptp->np = np;
	ptp->nnext = np->conns;
	np->conns = ptp;
}

void unhook(ptp)
conn *ptp;
{
	net *np;
	conn **cnpp;

	if(!ptp->np) return;
	for(cnpp = &ptp->np->conns; *cnpp != ptp; cnpp = &(*cnpp)->nnext);
	*cnpp = ptp->nnext;
	ptp->np = NIL;
}

void mergenets(tonp, fromnp)
net *tonp, *fromnp;
{
	conn *cnp;

	if(tonp == fromnp) return;
	while(1) {
		cnp = fromnp->conns;
		if(!cnp) break;
		unhook(cnp);
		hookup(cnp, tonp);
	}
	deletenet(fromnp);
}

setprimtype(vp)
view *vp;
{
	char *cp, *cname;
	int len, ch;

	vp->primtype = PRIM_NOTPRIM;
	if(!vp->cellp->lp->external) return;
	if(strcasecmp(vp->cellp->lp->h.name, "PRIMLIB")) return;
	cname = cp = vp->cellp->h.name;
	ch = cname[0];
	if(isupper(ch)) ch = tolower(ch);
	switch(ch) {
	case 'a':
		if(!strncasecmp(cname, "AND", 3)) vp->primtype = PRIM_AND;
		break;
	case 'o':
		if(!strncasecmp(cname, "OR", 2)) vp->primtype = PRIM_OR;
		break;
	case 'x':
		if(!strncasecmp(cname, "XOR", 3)) vp->primtype = PRIM_XOR;
		break;
	case 'i':
		if(!strcasecmp(cname, "INV")) vp->primtype = PRIM_INV;
		break;
	case 't':
		if(!strcasecmp(cname, "TRI")) vp->primtype = PRIM_TRI;
		else if(!strcasecmp(cname, "TRUE")) vp->primtype = PRIM_TRUE;
		break;
	case 'd':
		if(!strcasecmp(cname, "DFF")) vp->primtype = PRIM_DFF;
		else if(!strcasecmp(cname, "DFFR")) vp->primtype = PRIM_DFFR;
		else if(!strcasecmp(cname, "DFFS")) vp->primtype = PRIM_DFFS;
		else if(!strcasecmp(cname, "DFFSR")) vp->primtype = PRIM_DFFSR;
		else if(!strcasecmp(cname, "DC")) vp->primtype = PRIM_DC;
		break;
	case 'l':
		if(!strcasecmp(cname, "LATCH")) vp->primtype = PRIM_LATCH;
		else if(!strcasecmp(cname, "LATCHR")) vp->primtype = PRIM_LATCHR;
		else if(!strcasecmp(cname, "LATCHS")) vp->primtype = PRIM_LATCHS;
		else if(!strcasecmp(cname, "LATCHSR")) vp->primtype = PRIM_LATCHSR;
		break;
	case 'f':
		if(!strcasecmp(cname, "FALSE")) vp->primtype = PRIM_FALSE;
		break;
	case 'm':
		if(!strcasecmp(cname, "MUX2")) vp->primtype = PRIM_MUX2;
		break;
	case 'b':
		if(!strcasecmp(cname, "BUF")) vp->primtype = PRIM_BUF;
		break;
	}
}

net *addnet(vp)
view *vp;
{
	char buf[16];
	static int nid = 0;
	ep_name *namep;
	net *np;

	sprintf(buf, "_N_%d", nid++);
	np = ZTNEW(net, 1);
	namep = ep_getname(buf);
	np->h.name = namep->str;
	np->conns = NIL;
	np->owner = vp;
	hashinsert(&vp->u.nl.nethash, np);
	return(np);
}

instance *addinstance(vp, instof)
view *vp;
view *instof;
{
	instance *ip, *pip;
	hashtable *ph;
	conn *ptp, **tptp;
	int hidx;
	char buf[32];
	static int iid = 0;
	ep_name *namep;

	ip = ZTNEW(instance, 1);
	sprintf(buf, "_I_%d", iid++);
	namep = ep_getname(buf);
	ip->h.name = namep->str;
	ip->instof = instof;
	ip->owner = vp;
	ip->ports = NIL;

	ph = &instof->u.nl.porthash;
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
	hashinsert(&vp->u.nl.insthash, ip);
	return(ip);
}

fixncinsthash(ht)
hashtable *ht;
{
	conn *ptp;
	instance *ip;
	net *np;
	int hidx;

	foreachentry(ht, hidx, instance *, ip) {
		for(ptp = ip->ports; ptp; ptp=ptp->inext) {
			if(ptp->np) continue;
			fprintf(stderr, "Warning: unconnected pin in %s:%s.%s, pin %s.%s\n",
				ip->owner->cellp->lp->h.name, ip->owner->cellp->h.name,
				ip->owner->h.name, ip->h.name, ptp->port->h.name);
			np = addnet(ip->owner);
			hookup(ptp, np);
		}
	}
}

fixnc(vp)
view *vp;
{
	/* if the library is external then ports may be legally unconnected */
	if(vp->cellp->lp->external) return;
	fixncinsthash(&vp->u.nl.porthash);
	fixncinsthash(&vp->u.nl.insthash);
}

int isprimitive(vp)
view *vp;
{
	return(vp->cellp->lp->external);
}
