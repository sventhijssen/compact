#ifndef lint
static char rcsid[] = "$Header: wr_blif.c,v 1.3 93/02/22 12:29:55 kenm Exp $";
static char copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

#include <stdio.h>
#include "nets.h"

extern char *pinnetname();

writeblif(fp, vp)
FILE *fp;
view *vp;
{
	netlist *nl;
	int hidx,  i, j, xsize, t;
	int linepos;
	instance *pip, *ip;
	hashtable *iht, *pht;
	conn *ptp;
	int cnt;
	char *gtype, *nname;
	char *edge;

	nl = &vp->u.nl;
	fprintf(fp, "############################################\n");
	fprintf(fp, ".model %s\n", vp->cellp->h.name);
	pht = &nl->porthash;
	linepos = ftell(fp);
	fprintf(fp, ".inputs");
	foreachentry(pht, hidx, instance *, pip) {
		switch(pip->instof->u.portdir) {
		case 'i':
			if(ftell(fp) - linepos > 70) {
				fputs("\\\n", fp);
				linepos = ftell(fp);
			}
			fprintf(fp, " %s", pip->h.name);
			break;
		case 'o':
			break;
		default:
			u_crash("bad port direction for %s found\n", pip->h.name);
			/*NOTREACHED*/
		}
	}
	fputc('\n', fp);
	linepos = ftell(fp);
	fprintf(fp, ".outputs");
	foreachentry(pht, hidx, instance *, pip) {
		if(pip->instof->u.portdir == 'o') {
			if(ftell(fp) - linepos > 70) {
				fputs("\\\n", fp);
				linepos = ftell(fp);
			}
			fprintf(fp, " %s", pip->h.name);
		}
	}
	fputc('\n', fp);
	fprintf(fp, "# connect ports to nets with different names\n");
	foreachentry(pht, hidx, instance *, pip) {
		nname = pip->ports->np->h.name;
		if(strcmp(pip->h.name, nname)) {
			if(pip->instof->u.portdir == 'i') {
				fprintf(fp, ".names %s %s\n", pip->h.name, nname);
			} else {
				fprintf(fp, ".names %s %s\n", nname, pip->h.name);
			}
			fprintf(fp, "1  1\n");
		}
	}
	iht = &nl->insthash;
	foreachentry(iht, hidx, instance *, ip) {
		fprintf(fp, "# instance %s\n", ip->h.name);
		cnt = 0;
		switch(ip->instof->primtype) {
		case PRIM_MUX2:
			fprintf(fp, ".names");
			fprintf(fp, " %s %s %s  %s\n", pinnetname(ip, "in0"),
			   pinnetname(ip, "in1"), pinnetname(ip, "sel"),
			   pinnetname(ip, "out"));
			break;
		case PRIM_TRUE:
		case PRIM_FALSE:
		case PRIM_DC:
		case PRIM_AND:
		case PRIM_OR:
		case PRIM_INV:
		case PRIM_BUF:
		case PRIM_XOR:
			fprintf(fp, ".names");
			for(ptp = ip->ports; ptp; ptp=ptp->inext) {
				if(ptp->port->h.name[0] == 'i') {
					fprintf(fp, " %s", ptp->np->h.name);
					cnt++;
				}
			}
			for(ptp = ip->ports; ptp; ptp=ptp->inext) {
				if(ptp->port->h.name[0] == 'o') {
					fprintf(fp, "  %s", ptp->np->h.name);
				}
			}
			fprintf(fp, "\n");
			break;
		default:
			break;
		}
		switch(ip->instof->primtype) {
		case PRIM_TRUE:
			/* all cases generate 1 */
			fputs("  1\n", fp);
			break;
		case PRIM_FALSE:
			fputs("  0\n", fp);
			break;
			break;
		case PRIM_DC:
			fputs("  -\n", fp);
			break;
		case PRIM_AND:
			for(i = 0; i < cnt; i++) fputc('1', fp);
			fputs("  1\n", fp);
			break;
		case PRIM_OR:
			for(i = 0; i < cnt; i++) {
				for(j = 0; j < cnt; j++) {
					fputc((i == j)? '1': '-', fp);
				}
				fputs("  1\n", fp);
			}
			break;
		case PRIM_INV:
			fputs("0  1\n", fp);
			break;
		case PRIM_BUF:
			fputs("1  1\n", fp);
			break;
		case PRIM_XOR:
			xsize = 1 << cnt;
			for(i = 0; i < xsize; i++) {
				j = 0; t = i;
				while(t) { t = t & (t - 1); j++; }
				if(j & 1) {
					for(j = 0; j < cnt; j++) {
					    fputc((i & (1 << j))? '1':'0', fp);
					}
					fputs("  1\n", fp);
				}
			}
			break;
		case PRIM_MUX2:
			fputs("1-0  1\n", fp);
			fputs("-11  1\n", fp);
			break;
		case PRIM_LATCH:
		case PRIM_DFF:
			edge = (ip->instof->primtype == PRIM_DFF) ? "re" : "ah";
			fprintf(fp, ".latch %s %s %s %s 2\n",
				pinnetname(ip, "in"), pinnetname(ip,"out"),
				edge, pinnetname(ip, "clk"));
			break;
		default:
			linepos = ftell(fp);
			fprintf(fp, ".gate %s", ip->instof->cellp->h.name);
			for(ptp = ip->ports; ptp; ptp=ptp->inext) {
				if(ftell(fp) - linepos > 70) {
					fputs("\\\n", fp);
					linepos = ftell(fp);
				}
				fprintf(fp," %s=%s", ptp->port->h.name,
					ptp->np->h.name);
			}
			fputs("\n", fp);
			break;
		}
	}
	fprintf(fp, ".end\n");
	foreachentry(iht, hidx, instance *, ip) {
		if(ip->instof->primtype == PRIM_NOTPRIM) writeblif(fp, ip->instof);
	}
}
