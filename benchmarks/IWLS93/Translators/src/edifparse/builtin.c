#ifndef lint
static char rcsid[] = "$Header: builtin.c,v 1.3 93/02/22 12:01:20 kenm Exp $";
static char copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

#include "util.h"
#include "token.h"
#include "parse.h"

int epk_eat(keystr)
char *keystr;
{
	while(1) {
		ep_getoptarg(keystr);
		if(ep_tkind == T_EOF || ep_tkind == T_END) break;
	}
	if(ep_tkind == T_END) {
		ep_tkind = T_NULL;
		return(SUCCESS);
	} else {
		ep_tkind = T_NULL;
		return(FAIL);
	}
}


/*
 * eat tokens until we find a T_END at a balanced location
 * this is used in error recovery, and in ignoring keywords
 * we don't care about.
 */
int epk_ignore()
{
	int count;

	count = 1;
	do {
		ep_gettoken(e_fp);
		if(ep_tkind == T_LPAR) count++;
		else if(ep_tkind == T_RPAR) count--;
	} while(count && ep_tkind!=EOF);
	ep_tkind = T_NULL;
	ep_tkey = NIL;
	return(SUCCESS);
}

int epk_edifversion(a,b,c)
int a,b,c;
{
	ep_edifversion[0] = a;
	ep_edifversion[1] = b;
	ep_edifversion[2] = c;
	ep_tkind = T_NULL;
	return(SUCCESS);
}

int epk_ediflevel(level)
int level;
{
	ep_ediflevel = level;
	ep_tkind = T_NULL;
	return(SUCCESS);
}

int epk_timestamp(year,month,day,hour,minute,second)
int year,month,day,hour,minute,second;
{
	ep_tkind = T_NULL;
	printf("timestamp year %d, month %d, day %d, hour %d, minute %d, sec %d\n", year,month,day,hour,minute,second);
	return(SUCCESS);
}

int epk_rename(name, rename)
ep_name *name;
char *rename;
{
	u_free(rename);
	ep_tkind = T_NAME;
	ep_tname = name;
	return(SUCCESS);
}

int epk_property(n)
ep_name *n;
{
	property *p;
	static char prop[] = "property";
	ep_setctx("property/");
	if(FAIL == ep_getarg(prop)) return(FAIL);
	if(ep_tkind != T_PROPERTY) {
		ep_perr("property: missing value");
		return(FAIL);
	}
	p = ep_property;
	ep_popctx();
	ep_getoptarg(prop);
	if(ep_tkind != T_END) {
		ep_perr("property: extra args");
		return(epk_ignore());
	}
	p->name = n->str;
	ep_property = p;
	ep_tkind = T_PROPERTY;
	return(SUCCESS);
}

/* read a number */
int epk_e(i1, i2)
int i1, i2;
{
	static double d;

	d = i1;
	if(i2 < -35 || i2 > 35) {
		ep_perr("e: exponent out of range -35 to 35");
		return(FAIL);
	}
	while(i2 > 0) {
		d *= 10.0;
		i2--;
	}
	while(i2 < 0) {
		d *= .1;
		i2++;
	}
	ep_tkind = T_DOUBLE;
	ep_tdouble = d;
	return(SUCCESS);
}

int epk_string(str)
char *str;
{
	property *p;
	p = TNEW(property, 1);
	p->kind = 's';
	p->u.s = u_strsave(ep_tbuf);
	ep_property = p;
	ep_tkind = T_PROPERTY;
	return(SUCCESS);
}

int epk_integer(i)
int i;
{
	property *p;
	p = TNEW(property, 1);
	p->kind = 'i';
	p->u.i = i;
	ep_property = p;
	ep_tkind = T_PROPERTY;
	return(SUCCESS);
}

int epk_number(dp)
double *dp;
{
	property *p;
	p = TNEW(property, 1);
	p->kind = 'f';
	p->u.f = *dp;
	ep_property = p;
	ep_tkind = T_PROPERTY;
	return(SUCCESS);
}

static int inlib = FALSE;
static int incell = FALSE;
static int inview = FALSE;

int epk_library(keystr, libname)
char *keystr;
ep_name *libname;
{
	property *plist = NIL;

	libname->flags |= N_LIBNAME;
	if(FAIL == ex_startlibrary(keystr, libname->str)) {
		epk_ignore();
		return(FAIL);
	}
	inlib = TRUE;
	while(1) {
		ep_getoptarg(keystr);
		if(ep_tkind == T_EOF || ep_tkind == T_END) break;
		if(ep_tkind == T_PROPERTY) {
			ep_property->next = plist;
			plist = ep_property;
			ep_property = NIL;
		}
	}
	inlib = FALSE;
	if(ep_tkind == T_EOF) return(FAIL);
	ep_tkind = T_NULL;
	return(ex_endlibrary(plist));
}

int epk_cell(cellname)
ep_name *cellname;
{
	property *plist = NIL;

	if(!inlib) return(ep_perr_ignore("cell: not inside a library!"));
	if(incell) return(ep_perr_ignore("cell: can't be nested"));
	cellname->flags |= N_CELLNAME;
	if(FAIL == ex_startcell(cellname->str)) {
		ep_perr("Error adding cell");
		return(FAIL);
	}
	inlib = FALSE;
	incell = TRUE;
	while(1) {
		ep_getoptarg("cell");
		if(ep_tkind == T_EOF || ep_tkind == T_END) break;
		if(ep_tkind == T_PROPERTY) {
			ep_property->next = plist;
			plist = ep_property;
			ep_property = NIL;
		}
	}
	incell = FALSE;
	inlib = TRUE;
	if(ep_tkind == T_EOF) return(FAIL);
	ep_tkind = T_NULL;
	return(ex_endcell(plist));
}

epk_view(viewname)
ep_name *viewname;
{
	property *plist = NIL;
	if(!incell) return (ep_perr_ignore("view: not inside a cell!"));
	if(inview) return (ep_perr_ignore("view: can't be nested"));
	viewname->flags |= N_VIEWNAME;
	if(FAIL == ex_startview(viewname->str)) {
		ep_perr("Error adding view");
		return(FAIL);
	}
	incell = FALSE;
	inview = TRUE;
	while(1) {
		ep_getoptarg("view");
		if(ep_tkind == T_EOF || ep_tkind == T_END) break;
		if(ep_tkind == T_PROPERTY) {
			ep_property->next = plist;
			plist = ep_property;
			ep_property = NIL;
		}
	}
	inview = FALSE;
	incell = TRUE;
	if(ep_tkind == T_EOF) return(FAIL);
	ep_tkind = T_NULL;
	return(ex_endview(plist));
}

int epk_libraryref(libname)
ep_name *libname;
{
	if(!(libname->flags & N_LIBNAME)) {
		ep_perr("libraryref: Unknown library name '%s'", libname->str);
		return(FAIL);
	}
	ep_tlref.library = libname->str;
	ep_tkind = T_LREF;
	return(SUCCESS);
}

int epk_cellref(cellname, libref)
ep_name *cellname;
ep_reference *libref;
{
	if(!(cellname->flags & N_CELLNAME)) {
		ep_perr("cellref: Unknown cell name '%s'", cellname->str);
		return(FAIL);
	}
	ep_tcref.library = libref->library;
	ep_tcref.cell = cellname->str;
	ep_tkind = T_CREF;
	return(SUCCESS);
}

int epk_viewref(viewname, cellref)
ep_name *viewname;
ep_reference *cellref;
{
	if(!(viewname->flags & N_VIEWNAME)) {
		ep_perr("viewref: Unknown view name '%s'", viewname->str);
		return(FAIL);
	}
	ep_tvref.library = cellref->library;
	ep_tvref.cell = cellref->cell;
	ep_tvref.view = viewname->str;
	ep_tkind = T_VREF;
	return(SUCCESS);
}

int epk_design(designname, cellref)
ep_name *designname;
ep_reference *cellref;
{
	ep_tkind = T_NULL;
	return(ex_design(designname->str, cellref->library, cellref->cell));
}

property *ep_getproplist(keystr)
char *keystr;
{
	property *plist = NIL;
	while(1) {
		ep_getoptarg(keystr);
		if(ep_tkind == T_EOF || ep_tkind == T_END) break;
		if(ep_tkind == T_PROPERTY) {
			ep_property->next = plist;
			plist = ep_property;
			ep_property = NIL;
		}
	}
	return(plist);
}

int epk_port(name, dir)
ep_name *name;
int dir;
{
	property *plist;
	plist = ep_getproplist("port");
	ep_tkind = T_NULL;
	return(ex_port(name->str, dir, plist));
}

int epk_direction(dir)
ep_name *dir;
{
	int dirc;
	char *s;
	s = dir->str;
	if(!strcasecmp(s, "INPUT")) dirc = 'i';
	else if(!strcasecmp(s, "OUTPUT")) dirc = 'o';
	else if(!strcasecmp(s, "INOUT")) dirc = 'b';
	else {
		ep_perr("Unknown direction %s", s);
		return(FAIL);
	}
	ep_tkind = T_DIRECTION;
	ep_tint = dirc;
	return(SUCCESS);
}

int epk_instance(name, vref)
ep_name *name;
ep_reference *vref;
{
	property *plist;
	plist = ep_getproplist("port");
	ex_instance(name->str, vref->library, vref->cell, vref->view, plist);
	ep_tkind = T_NULL;
	return(SUCCESS);
}

int epk_net(name)
ep_name *name;
{
	property *plist;
	ex_startnet(name->str);
	if(FAIL == ep_getarg("net")) return(FAIL);
	plist = ep_getproplist("port");
	ex_endnet(plist);
	ep_tkind = T_NULL;
	return(SUCCESS);
}

int epk_joined()
{
	ep_setctx("joined/");
	while(1) {
		ep_getoptarg("joined");
		if(ep_tkind == T_EOF || ep_tkind == T_END) break;
	}
	ep_popctx();
	ep_tkind = T_NULL;
	return(SUCCESS);
}

int epk_joined_portref(pname)
ep_name *pname;
{
	char *iname;
	if(FAIL == ep_getoptarg("joined/portref")) return(FAIL);
	if(ep_tkind == T_NAME) {
		iname = ep_tname->str;
		ep_getoptarg("joined/portref");
	} else {
		iname = NIL;
	}
	if(ep_tkind != T_END) {
		return(ep_perr_ignore("joined/portref: expected 2 args"));;
	}
	ep_tkind = T_NULL;
	return(ex_join(pname->str, iname));
}

int epk_instanceref(iname)
ep_name *iname;
{
	ep_tkind = T_NAME;
	ep_tname = iname;
	return(SUCCESS);
}

epk_init()
{
	static int beenhere = FALSE;

	if(beenhere) return;
	beenhere = TRUE;
	ep_ignorekey("written");
	ep_ignorekey("program");
	ep_ignorekey("status");
	ep_ignorekey("version");
	ep_ignorekey("comment");
	ep_ignorekey("owner");
	ep_ignorekey("keywordmap");
	ep_ignorekey("technology");
	ep_ignorekey("celltype");
	ep_ignorekey("viewtype");

	ep_addkey("edif", "kc", epk_eat);
	ep_addkey("edifversion", "iii", epk_edifversion);
	epkey_ediflevel = ep_addkey("ediflevel","i", epk_ediflevel);
	ep_addkey("timestamp","iiiiii", epk_timestamp);
	ep_addkey("rename","nq", epk_rename);

	ep_addkey("external", "knc", epk_library);
	ep_addkey("library", "knc", epk_library);
	ep_addkey("cell", "nc", epk_cell);
	ep_addkey("view", "nc", epk_view);
	ep_addkey("design", "nC", epk_design);

	ep_addkey("cellref", "nL", epk_cellref);
	ep_addkey("viewref", "nC", epk_viewref);
	ep_addkey("libraryref", "n", epk_libraryref);

	ep_addkey("interface", "kc", epk_eat);
	ep_addkey("contents", "kc", epk_eat);
	ep_addkey("port", "ndc", epk_port);
	ep_addkey("direction", "n", epk_direction);
	ep_addkey("instance", "nVc", epk_instance);
	ep_addkey("net", "nc", epk_net);
	ep_addkey("joined", "c", epk_joined);
	ep_addkey("joined/portref", "nc", epk_joined_portref);
	ep_addkey("joined/instanceref", "n", epk_instanceref);

	epkey_property = ep_addkey("property", "nc", epk_property);
	ep_addkey("property/number",  "f", epk_number);
	ep_addkey("property/string",  "q", epk_string);
	ep_addkey("property/integer", "i", epk_integer);
	ep_addkey("property/e", "ii", epk_e);
}
