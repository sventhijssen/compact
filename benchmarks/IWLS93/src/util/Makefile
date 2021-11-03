# $Header: Makefile,v 1.5 93/05/16 18:27:16 kenm Exp $
# Copyright (C) 1993 Mentor Graphics Corporation

SRCS = alloc.c crash.c hash.c time.c home.c openr.c
OBJS = alloc.o crash.o hash.o time.o home.o openr.o
CFLAGS = -g $(XCFLAGS)
LIB = util.a

lib $(LIB): $(OBJS)
	ar cr $(LIB) $(OBJS)
	ranlib $(LIB)

clean:; /bin/rm -f $(OBJS) $(LIB)

###
alloc.o: util.h
hash.o: util.h hash.h
openr.o: util.h
