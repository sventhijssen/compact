/*
 * parse an edif token
 */
#ifndef lint
static char rcsid[] = "$Header: token.c,v 1.3 93/02/22 12:02:09 kenm Exp $";
static char copyright[] = "Copyright (C) 1993 Mentor Graphics Corporation";
#endif

#include <ctype.h>
#include "util.h"
#undef DECL
#define DECL /**/
#include "token.h"

static int printtokens = FALSE;

int ep_pos = 0; /* position in ep_tbuf */
int ep_tokenpushed = FALSE;
int ep_shiftdir = -1;

static ep_getc(fp)
FILE *fp;
{
	int ch;
	ch = getc(fp);
	if(ch=='\n') ep_line++;
	return(ch);
}

static void ep_ungetc(ch,fp)
int ch;
FILE *fp;
{
	if(ch=='\n') ep_line--;
	ungetc(ch,fp);
}

static void ep_addc(ch)
int ch;
{
	if(ep_pos >= ep_tlen) {
		ep_tlen = ep_pos + 128;
		ep_tbuf = u_realloc(ep_tbuf,ep_tlen);
	}
	ep_tbuf[ep_pos++] = ch;
}

static void ep_sizesbuf(len)
{
	if(len >= ep_tlen) {
		ep_tlen = len + 128;
		ep_tbuf = u_realloc(ep_tbuf,ep_tlen);
	}
}

static void ep_printtoken(fp)
FILE *fp;
{
	fprintf(fp, "*Token - ");
	switch(ep_tkind) {
	case T_ERROR: fprintf(fp,"Error\n"); break;
	case T_EOF:   fprintf(fp,"Eof\n"); break;
	case T_LPAR:  fprintf(fp,"Lpar\n"); break;
	case T_RPAR:  fprintf(fp,"Rpar\n"); break;
	case T_QSTR:  fprintf(fp,"Quoted str '%s'\n", ep_tbuf); break;
	case T_INT:   fprintf(fp,"Int %d\n",ep_tint); break;
	case T_DOUBLE: fprintf(fp,"Double %g\n", ep_tdouble); break;
	case T_NULL:  fprintf(fp,"Null\n"); break;
	case T_NAME:  
		fprintf(fp,"Name ");
		if(ep_tname->flags & N_LIBNAME) fputc('L', fp);
		if(ep_tname->flags & N_CELLNAME) fputc('C', fp);
		if(ep_tname->flags & N_VIEWNAME) fputc('V', fp);
		if(!ep_tname->flags) fputc('N', fp);
		fprintf(fp, " '%s'\n", ep_tname->str);
		break;
	default:      fprintf(fp,"Unknown token type %d\n", ep_tkind); break;
	}
}

/*
 * Get one token
 * Token information is stored in globals
 */
ep_gettoken()
{
	FILE *fp;
	int i,ch;
	int sign;

	fp = e_fp;
	if(ep_tokenpushed) {
		ep_tokenpushed = FALSE;
		if(printtokens) ep_printtoken(stdout);
		return(ep_tkind);
	}
	ep_pos = 0;
	ep_tkind = T_ERROR;
	do { ch = ep_getc(fp); } while(isspace(ch));
	switch(ch) {
	case '(':
		ep_tkind = T_LPAR;
		break;
	case ')':
		ep_tkind = T_RPAR;
		break;
	case '"':
		do {
			ch = ep_getc(fp);
			switch(ch) {
			case EOF: goto earlyeof;
			case '%': /* ascii character notation */
				ch = ep_getc(fp);
				while(1) {
					i = 0;
					while(ch != EOF && isspace(ch))
						ch = ep_getc(fp);
					if(ch == EOF) goto earlyeof;
					if(ch == '%') break;
					if(!isdigit(ch)) {
						ep_perr("asciiCharacter: expected digit");
						goto exit;
					}
					while(isdigit(ch)) {
						i *= 10;
						i += ch - '0';
						ch = ep_getc(fp);
					}
					ep_addc(i & 0xff);
				}
				break;
			case '\f': /* form feed */
			case '\r': /* carriage return */
			case '\n': /* newline */
				continue;
			case '"':
				break;
			default:
				ep_addc(ch);
			}
		} while(ch!='"');
		ep_addc(0);
		ep_tkind = T_QSTR;
		break;
	case EOF:
		ep_tkind = T_EOF;
		break;
	default:
		sign = ch == '-';
		if(sign || isdigit(ch)) {
			if(sign) {
				ch = ep_getc(fp);
				if(!isdigit(ch)) {
					ep_tkind = T_ERROR;
					break;
				}
			}
			ep_tint = 0;
			do {
				ep_tint = ep_tint * 10 + ch - '0';
				ch = ep_getc(fp);
			} while(isdigit(ch));
			ep_ungetc(ch,fp);
			ep_tkind = T_INT;
			if(sign) ep_tint = -ep_tint;
		} else {
			while(1) {
				if(ep_shiftdir > 0) {
					if(islower(ch)) ch = toupper(ch);
				} else if(ep_shiftdir < 0) {
					if(isupper(ch)) ch = tolower(ch);
				}
				ep_addc(ch);
				ch = ep_getc(fp);
				if(isspace(ch)) break;
				if(ch==EOF) break;
				if(ch=='(' || ch==')') break;
			}
			ep_ungetc(ch,fp);
			ep_addc(0);
			ep_tname = ep_getname(ep_tbuf);
			ep_tkind = T_NAME;
		}
		break;
	}
exit:;
	if(printtokens) ep_printtoken(stdout);
	return(ep_tkind);
earlyeof:
	ep_perr("EOF in string");
	ep_tkind = T_NULL;
	goto exit;
}

