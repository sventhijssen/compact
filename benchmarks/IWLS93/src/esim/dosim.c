#ifndef lint
static char rcsid[] = "$Header: dosim.c,v 1.4 93/05/18 15:35:32 kenm Exp $";
static char copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

#define RCSHEADERS
#include "nets.h"
#include <varargs.h>

extern long lrand48();

static int dotrace = TRUE;

/* encodings are important for function macros */
#define V_HI  3 /* 1 */
#define V_LO  0 /* 0 */
#define V_X   1 /* indeterminate value */
#define V_Z   5 /* hi-impedance */
#define V_E   2 /* bad value */

#define and(a, b) (3 & ((a) & (b)))
#define or(a, b)  (3 & ((a) | (b)))
#define not(a)    (3 >> ((a) & 3))
#define buffer(a) ((a) & 3)

static void addevent();

static hashtable *ih, *nh, *ph;

typedef struct _event {
	conn *ptp; /* output to change at time */
	struct _event *next;
	int time;
	int value;
} event;

static event *eventlist;
static int curtime, errcnt;
#define TIMESCALE 10

#define NUMPORTTYPES 3
static view *porttypes[NUMPORTTYPES];

fatal(va_alist)
va_dcl
{
	va_list args;
	char *fmt;

	va_start(args);
	fprintf(stderr, "@%d: Fatal Error - ", curtime);
	fmt = va_arg(args, char *);
	vfprintf(stderr, fmt, args);
	va_end(args);
	fputc('\n', stderr);
	fflush(stderr);
	exit(2);
}

char vname(v)
int v;
{
	int ch;
	switch(v) {
	case V_HI:  ch = '1'; break;
	case V_LO:  ch = '0'; break;
	case V_Z:   ch = 'Z'; break;
	case V_X:   ch = 'X'; break;
	default:    ch = 'E'; break;
	}
	return(ch);
}

static sim_reset(vp, seed)
view *vp;
int seed;
{
	int hidx;
	net *np;
	conn *cnp;
	instance *ip;
	int i, v;

	eventlist = NIL;
	curtime = -1;
	errcnt = 0;

	porttypes[0] = &inport;
	porttypes[1] = &biport;
	porttypes[2] = &outport;

	ih = &vp->u.nl.insthash;
	nh = &vp->u.nl.nethash;
	ph = &vp->u.nl.porthash;

	foreachentry(nh, hidx, net *, np) {
		np->u.simval = V_X;
		for(cnp = np->conns; cnp; cnp=cnp->nnext)
			cnp->u.simval = V_X;
	}
	if(seed > 1) {
		srand48((long) seed);
	}

	foreachentry(ih, hidx, instance *, ip) {
		ip->u.state.val = V_X;
		ip->u.state.init = FALSE;

		switch(ip->instof->primtype) {
		case PRIM_TRUE:
			addevent(ip->ports, -1, V_HI);
			break;
		case PRIM_FALSE:
			addevent(ip->ports, -1, V_LO);
			break;
		case PRIM_DC:
			addevent(ip->ports, -1, V_X);
			break;
		case PRIM_LATCH:
		case PRIM_LATCHR:
		case PRIM_LATCHS:
		case PRIM_LATCHSR:
		case PRIM_DFF:
		case PRIM_DFFR:
		case PRIM_DFFS:
		case PRIM_DFFSR:
			if(seed >= 0) {
				if(seed > 1) v = lrand48() & 1;
				else v = seed;
				ip->u.state.init = TRUE;
				ip->u.state.val = v ? V_HI : V_LO;
				addevent(ip->ports, -1, ip->u.state.val);
			}
			break;
		}
	}

	foreachentry(ph, hidx, instance *, ip) {
		ip->u.state.val = V_E;
	}

}

static void printhead()
{
	int pti, hidx;
	view *pt;
	instance *pp;
	int maxlen, row, col;

	maxlen = 0;
	foreachentry(ph, hidx, instance *, pp) {
		row = strlen(pp->h.name);
		if(row > maxlen) maxlen = row;
	}

	fputs("time    signals\n", stdout);
	fputs("===============\n", stdout);
	for(row = 0; row <= maxlen; row++) {
		fputs("        ", stdout);
		for(pti = 0; pti < NUMPORTTYPES; pti++) {
			pt = porttypes[pti];
			col = -1;
			if(pti != 0) fputs("  ", stdout);
			foreachentry(ph, hidx, instance *, pp) {
				if(pp->instof == pt) {
					if(++col == 8) {
						col = 0;
						fputc(' ', stdout);
					}
					if(row < strlen(pp->h.name)) {
						fputc(pp->h.name[row], stdout);
					} else if(row != maxlen) {
						fputc(' ', stdout);
					} else {
						fputc('-', stdout);
					}
				}
			}
		}
		fputc('\n', stdout);
	}
}

/*
 * Print an output line at the end of a time point if there
 * has been a change
 */
static void printout()
{
	int col;
	int hidx, doprint;
	instance *pp;
	int pti;
	view *pt;

	if((curtime % TIMESCALE) != (TIMESCALE - 1)) return;
	doprint = FALSE;
	foreachentry(ph, hidx, instance *, pp) {
		if(pp->u.state.val != pp->ports->np->u.simval) {
			doprint = TRUE;
			goto brk; /* break and foreachentry don't match */
		}
	}
brk:
	if(!doprint) return;
	fflush(stderr);
	fprintf(stdout, "@%-6d:", curtime/TIMESCALE);
	for(pti = 0; pti < NUMPORTTYPES; pti++) {
		pt = porttypes[pti];
		col = -1;
		if(pti != 0) fputs("  ", stdout);
		foreachentry(ph, hidx, instance *, pp) {
			pp->u.state.val = pp->ports->np->u.simval;
			if(pp->instof == pt) {
				if(++col == 8) {
					col = 0;
					fputc(' ', stdout);
				}
				fputc(vname(pp->u.state.val), stdout);
			}
		}
	}
	fputc('\n', stdout);
	fflush(stdout);
}

static event *free_ev = NIL;

static void addevent(ptp, time, value)
conn *ptp;
int time;
int value;
{
	event *e, **ep, *te;

	ep = &eventlist;
	while(te = *ep) {
		if(te->ptp == ptp) { /* event cancellation */
			*ep = te->next;
			te->next = free_ev;
			free_ev = te;
		} else {
			if(te->time > time) break;
			ep = &te->next;
		}
	}
	e = free_ev;
	if(e) free_ev = e->next;
	else e = TNEW(event, 1);
	e->ptp = ptp;
	e->time = time;
	e->value = value;
	e->next = te;
	*ep = e;
}

static void ueof()
{
	fatal("Unexpected EOF file in test pattern file");
}

int sim_getc(tfp)
FILE *tfp;
{
	register int ch;
	while(1) {
		ch = getc(tfp);
		if(ch != '#') return(ch);
		do {
			ch = getc(tfp);
			if(ch == EOF) ueof();
		} while(ch != '\n');
	}
}


int eatspace(tfp)
FILE *tfp;
{
	register int ch;
	do {
		ch = sim_getc(tfp);
		if(ch == EOF) ueof();
	} while(isspace(ch));
	return(ch);
}

instance *getname(tfp)
FILE *tfp;
{
	int ch;
	char *cp;
	instance *pp;
	char namebuf[1024];

	cp = namebuf;
	ch = eatspace(tfp);
	*cp++ = ch;
	while(1) {
		ch = sim_getc(tfp);
		if(ch == EOF) ueof();
		if(isspace(ch)) break;
		*cp++ = ch;
	}
	*cp = 0;
	pp = (instance *)hashfind(ph, namebuf);
	if(!pp) fatal("Can't find port %s", namebuf);
	return(pp);
}

void readinput(tfp)
FILE *tfp;
{
	int ch, v;
	int time, delay;
	instance *pp;

	while(1) {
		ch = eatspace(tfp);
		switch(ch) {
		case 't': /* time command */
			ch = eatspace(tfp);
			if(ch == EOF) ueof();
			if(!isdigit(ch)) fatal("Bad t (time) command");
			time = 0;
			while(isdigit(ch)) {
				time = time * 10 + ch - '0';
				ch = sim_getc(tfp);
				if(ch == EOF) ueof();
			}
			time *= TIMESCALE;
			if(isspace(ch)) ch = eatspace(tfp);
			if(ch != ';') fatal("Bad t (time) command - missing ;");
			if(time <= curtime)
				fatal("Bad t (time) command - time should advance");
			addevent((conn *)0, time, V_E);
			return; /* until read event comes up */
		case 'f': /* force command */
		case 'q': /* quick force command for clocks */
			delay = ch == 'q' ? 1 : (TIMESCALE/2);
			pp = getname(tfp);
			if(!pp) return;
			if(pp->instof->u.portdir == 'o')
				fatal("Can't force output port %s", pp->h.name);
			ch = eatspace(tfp);
			switch(ch) {
			case '0': v = V_LO; break;
			case '1': v = V_HI; break;
			case 'X': v = V_X; break;
			case 'Z': v = V_Z; break;
			default:
				fatal("Unknown force value %c", ch);
			}
			addevent(pp->ports, curtime + delay, v);
			ch = eatspace(tfp);
			if(ch != ';') fatal("Bad force command - expected ;");
			break;
		case 'c': /* check command */
			pp = getname(tfp);
			if(!pp) return;
			if(pp->instof->u.portdir == 'i') 
				fatal("Can't check input port %s", pp->h.name);
			ch = eatspace(tfp);
			switch(ch) {
			case '0': v = V_LO; break;
			case '1': v = V_HI; break;
			case 'X': v = V_X; break;
			case 'Z': v = V_Z; break;
			default:
				fatal("Unknown check value %c", ch);
			}
			if(v != pp->ports->np->u.simval) {
				fprintf(stdout, "@%d: Mismatch for port %s, expected %c, got %c\n",
					curtime/TIMESCALE, pp->h.name, ch, vname(pp->ports->np->u.simval));
				errcnt++;
			}
			ch = eatspace(tfp);
			if(ch != ';') fatal("Bad check command - expected ;");
			break;
		case 'e': /* end command */
		case EOF:
			return;
		default:
			fprintf(stderr, "@%d: Unknown command %c at time %d\n", curtime/TIMESCALE, ch);
			exit(2);
		}
	}
}

void simoutput(e)
event *e;
{
	conn *ptp;
	instance *ip;
	net *np;
	int v, iv;
	conn *cnp, *i0, *i1, *sel, *clk, *set, *reset;
	int islatch, delay;
	char *pn;

	ptp = e->ptp;
	if(ptp->u.simval == e->value) return;
	ptp->u.simval = e->value;
	iv = V_Z;
	np = ptp->np;
	for(cnp = np->conns; cnp; cnp=cnp->nnext) {
		if(cnp->port->instof == &inport) continue;
		v = cnp->u.simval;
		if(iv == V_Z) {
			iv = v;
			continue;
		}
		if(v == V_Z) continue;
		if(v != iv) iv = V_X;
	}
	if(iv == np->u.simval) return;
	np->u.simval = iv;
	for(cnp = np->conns; cnp; cnp=cnp->nnext) {
		if(cnp->port->instof == &outport) continue; 
		if(cnp->port->instof == &biport) continue; 
		ip = cnp->ip;
		v = V_E; /* output value */
		islatch = FALSE;
		delay = 0;
		switch(ip->instof->primtype) {
		case PRIM_TRUE:		/* out */
			v = V_HI;
			break;
		case PRIM_FALSE:	/* out */
			v = V_LO;
			break;
		case PRIM_DC:		/* out */
			v = V_X;
			break;
		case PRIM_AND:		/* out, in0, in1 ... */
			v = V_HI;
			for(ptp = ip->ports; ptp; ptp=ptp->inext) {
				if(ptp->port->h.name[0] == 'i') {
					v = and(v, ptp->np->u.simval);
				}
			}
			break;
		case PRIM_OR:		/* out, in0, in1 ... */
			v = V_LO;
			for(ptp = ip->ports; ptp; ptp=ptp->inext) {
				if(ptp->port->h.name[0] == 'i') {
					v = or(v, ptp->np->u.simval);
				}
			}
			break;
		case PRIM_XOR:		/* out, in0, in1 ... */
			v = V_LO;
			for(ptp = ip->ports; ptp; ptp=ptp->inext) {
				if(ptp->port->h.name[0] == 'i') {
					iv = ptp->np->u.simval;
					v = or(and(v,not(iv)), and(not(v), iv));
				}
			}
			break;
		case PRIM_INV:		/* out, in */
			ptp = ip->ports;
			if(ptp->port->h.name[0] == 'o') ptp = ptp->inext;
			v = not(ptp->np->u.simval);
			break;
		case PRIM_BUF:		/* out, in */
			ptp = ip->ports;
			if(ptp->port->h.name[0] == 'o') ptp = ptp->inext;
			v = buffer(ptp->np->u.simval);
			break;
		case PRIM_MUX2:		/* out, in0, in1, sel */
			for(ptp = ip->ports; ptp; ptp=ptp->inext) {
				pn = ptp->port->h.name;
				if(pn[0] == 'i') {
					if(pn[2] == '0') i0 = ptp;
					else i1 = ptp;
				} else if(pn[0] == 's') sel = ptp;
			}
			switch(sel->np->u.simval) {
			case V_LO: v = buffer(i0->np->u.simval); break;
			case V_HI: v = buffer(i1->np->u.simval); break;
			default:
				v = buffer(i0->np->u.simval);
				iv = buffer(i1->np->u.simval);
				if(v != iv) v = V_X;
				break;
			}
			break;
		case PRIM_TRI:		/* out, in, en */
			for(ptp = ip->ports; ptp; ptp=ptp->inext) {
				pn = ptp->port->h.name;
				if(pn[0] == 'e') sel = ptp;
				else if(pn[0] == 'i') i0 = ptp;
			}
			switch(sel->np->u.simval) {
			case V_LO: v = V_Z; break;
			case V_HI: v = buffer(i0->np->u.simval); break;
			default:   v = V_X; break;
			}
			break;
		case PRIM_LATCH:	/* out, in, clk */
		case PRIM_LATCHR:	/* out, in, clk, reset */
		case PRIM_LATCHS:	/* out, in, clk, set */
		case PRIM_LATCHSR:	/* out, in, clk, set, reset */
			islatch = TRUE;
			/*FALLTHROUGH*/
		case PRIM_DFF:		/* out, in, clk */
		case PRIM_DFFR:		/* out, in, clk, reset */
		case PRIM_DFFS:		/* out, in, clk, set */
		case PRIM_DFFSR:	/* out, in, clk, set, reset */
			delay = 1;
			set = reset = NIL;
			for(ptp = ip->ports; ptp; ptp=ptp->inext) {
				pn = ptp->port->h.name;
				switch(pn[0]) {
				case 'c': clk = ptp; break;
				case 'i': i0 = ptp; break;
				case 's': set = ptp; break;
				case 'r': reset = ptp; break;
				}
			}

			if(islatch) {
				iv = clk->np->u.simval;
			} else {
				iv = and(clk->np->u.simval, not(clk->u.simval));
				clk->u.simval = clk->np->u.simval;
			}
			if(ip->u.state.init) {
				if(iv == V_HI) {
					ip->u.state.init = FALSE;
				} else {
					iv = V_LO; /* no change */
				}
			}

			v = ip->u.state.val;
			switch(iv) {
			case V_LO: break;
			case V_HI: v = buffer(i0->np->u.simval); break;
			default:
				iv = buffer(i0->np->u.simval);
				if(v != iv) v = V_X;
				break;
			}
			if(set) {
				switch(set->np->u.simval) {
				case V_HI: v = V_HI; break;
				case V_LO: break;
				default:
					if(v != V_HI) v = V_X;
					break;
				}
			}
			if(reset) {
				switch(set->np->u.simval) {
				case V_HI: v = V_LO; break;
				case V_LO: break;
				default:
					if(v != V_LO) v = V_X;
					break;
				}
			}
			if(set && reset) {
				if(V_LO != and(set->np->u.simval, reset->np->u.simval))
					v = V_X;
			}
			ip->u.state.val = v;
			break;
		default:		/* ports */
			if(!ISPORT(ip))
				fatal("Found non primitive %s- no model!", ip->instof->cellp->h.name);
			if(ip->instof == &outport) continue;
			v = ip->ports->u.simval;
			break;
		}
		for(ptp = ip->ports; ptp; ptp=ptp->inext) {
			if(ptp->port->instof != &inport) break;
		}
		if(!ptp) {
			fprintf(stderr, "Can't find gate output pin\n");
			exit(2);
		}
		addevent(ptp, curtime + delay, v);
	}
}

dosim(vp, tfp, trace, seed)
view *vp;
FILE *tfp;
int trace;
int seed;
{
	event *e;

	dotrace = trace;
	sim_reset(vp, seed);
	if(dotrace) printhead();
	addevent(NIL, -1, 0); /* read input */
	while(eventlist) {
		while(eventlist && eventlist->time == curtime) {
			e = eventlist;
			eventlist = e->next;
			if(e->ptp) simoutput(e);
			else readinput(tfp);
			e->next = free_ev;
			free_ev = e;
		}
		if(dotrace) printout();
		++curtime;
	}
	/* force out final values */
	curtime += TIMESCALE - (curtime % TIMESCALE) - 1;
	if(dotrace) printout();
	fprintf(stdout, "%d error%s found\n", errcnt, errcnt==1?"":"s");
	while(free_ev) {
		e = free_ev;
		free_ev = e->next;
		u_free((void *)e);
	}
	return(errcnt);
}
