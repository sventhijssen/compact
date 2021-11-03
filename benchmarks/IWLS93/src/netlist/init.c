#ifndef lint
static char rcsid[] = "$Header: init.c,v 1.2 93/02/22 12:04:53 kenm Exp $";
static char copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

#include "nets.h"

cell inportcell, outportcell, biportcell;

netlist_init()
{
	hashinit(&libhash);

	inport.cellp = &inportcell;
	inport.h.name = inportcell.h.name = "input";
	inport.u.portdir = 'i';
	inportinst.instof = &inport;
	inport.viewtype = VIEW_PORT;

	outport.cellp = &outportcell;
	outport.h.name = outportcell.h.name = "output";
	outport.u.portdir = 'o';
	outportinst.instof = &outport;
	outport.viewtype = VIEW_PORT;

	biport.cellp = &biportcell;
	biport.h.name = biportcell.h.name = "inout";
	biport.u.portdir = 'b';
	biportinst.instof = &biport;
	biport.viewtype = VIEW_PORT;
}
