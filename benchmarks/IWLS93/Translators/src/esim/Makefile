# $Header: Makefile,v 1.8 93/05/16 18:48:46 kenm Exp $
# Copyright (C) 1993 Mentor Graphics Corporation

SRCS = dosim.c main.c
OBJS = dosim.o main.o
INCDIRS = -I../util -I../edifparse -I../netlist
CFLAGS = -O2 $(XCFLAGS) -I../util -I../edifparse -I../netlist
PROG = esim
INSTDIR = ../../bin
LIBS = ../edifparse/edifparse.a ../netlist/netlist.a ../util/util.a
TAGSRCS = $(SRCS) ../util/*.c ../netlist/*.c

prog $(PROG): $(OBJS) $(LIBS)
	-/bin/rm -f $(PROG)
	$(CC) $(CFLAGS) $(OBJS) $(LIBS) -o $(PROG).new
	mv -f $(PROG).new $(PROG)

install: $(PROG)
	-/bin/rm -rf $(INSTDIR)/$(PROG)
	cp $(PROG) $(INSTDIR)/$(PROG)
	chmod 775 $(INSTDIR)/$(PROG)

tags: $(TAGSRCS)
	ctags $(TAGSRCS)

clean:; /bin/rm -f $(PROG) $(OBJS)

saber:;
	#load -C $(SRCS) $(INCDIRS) $(LIBS)

###
dosim.o: ../netlist/nets.h ../util/util.h ../util/hash.h \
	../edifparse/eprop.h
main.o: ../netlist/nets.h ../util/util.h ../util/hash.h \
	../edifparse/eprop.h ../edifparse/token.h
