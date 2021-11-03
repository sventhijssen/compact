#ifndef lint
static char rcsid[] = "$Header: flatten.c,v 1.2 93/02/22 12:04:52 kenm Exp $";
static char copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

#include "nets.h"

void dissolve(tip)
instance *tip;
{
	hashtable *ht;
	instance *ip, *pip, *cip;
	net *np;
	conn *ptp, *cptp;
	int hidx;
	view *vp = tip->owner;
	view *instof = tip->instof;

	ht = &instof->u.nl.nethash;
	foreachentry(ht, hidx, net *, np) {
		np->u.rep = NIL;
	}
	for(ptp = tip->ports; ptp; ptp=ptp->inext) {
		pip = ptp->port;
		np = pip->ports->np;
		if(np->u.rep) {
			/* need to short two nets together */
			mergenets(np->u.rep, ptp->np);
		} else {
			np->u.rep = ptp->np;
		}
	}
	ht = &instof->u.nl.nethash;
	foreachentry(ht, hidx, net *, np) {
		if(!np->u.rep) np->u.rep = addnet(vp);
	}
	ht = &instof->u.nl.insthash;
	foreachentry(ht, hidx, instance *, ip) {
		cip = addinstance(vp, ip->instof);
		ptp = ip->ports;
		cptp = cip->ports;
		while(ptp) {
			hookup(cptp, ptp->np->u.rep);
			ptp=ptp->inext;
			cptp = cptp->inext;
		}
	}
	deleteinstance(tip);
}

flatten(vp, testfunc)
view *vp;
int (*testfunc)();
{
	instance *dissolve_list;
	int dissolved_one;
	hashtable *ht;
	instance *ip;
	int hidx;

	if((*testfunc)(vp)) return;
	do {
		dissolve_list = NIL;
		ht = &vp->u.nl.insthash;
		foreachentry(ht, hidx, instance *, ip) {
			if(!(*testfunc)(ip->instof)) {
				ip->u.next = dissolve_list;
				dissolve_list = ip;
			}
		}
		dissolved_one = NIL != dissolve_list;
		while(dissolve_list) {
			ip = dissolve_list;
			dissolve_list = ip->u.next;
			dissolve(ip);
		}

	} while(dissolved_one);
}

