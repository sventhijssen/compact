# $Header: Makefile,v 1.4 93/05/16 18:28:13 kenm Exp $
# Copyright (C) 1993 Mentor Graphics Corporation

SRCS = main.c
OBJS = main.o
INCDIRS = -I../util -I../edifparse -I../netlist
CFLAGS = -O2 $(XCFLAGS) -I../util -I../edifparse -I../netlist
PROG = erprt
INSTDIR = ../../bin
LIBS = ../edifparse/edifparse.a ../netlist/netlist.a ../util/util.a

prog $(PROG): $(OBJS) $(LIBS)
	-/bin/rm -f $(PROG)
	$(CC) $(CFLAGS) $(OBJS) $(LIBS) -o $(PROG).new
	mv -f $(PROG).new $(PROG)

install: $(PROG)
	-/bin/rm -rf $(INSTDIR)/$(PROG)
	cp $(PROG) $(INSTDIR)/$(PROG)
	chmod 775 $(INSTDIR)/$(PROG)

tags:; ctags $(SRCS) ../util/*.c ../netlist/*.c

clean:; /bin/rm -f $(OBJS) $(PROG)

saber:;
	#load -C $(SRCS) $(INCDIRS) $(LIBS)

###
main.o: ../netlist/nets.h ../util/util.h ../util/hash.h \
	../edifparse/eprop.h ../edifparse/token.h
