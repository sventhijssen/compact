# $Header: Makefile,v 1.4 93/02/22 13:39:45 kenm Exp $
# Copyright (C) 1993 Mentor Graphics Corporation

SRCS = builtin.c parse.c token.c
OBJS = builtin.o parse.o token.o
CFLAGS = -g $(XCFLAGS) -I../util
LIB = edifparse.a

lib: $(LIB)

$(LIB): $(OBJS)
	/bin/rm -rf $(LIB)
	ar cr $(LIB) $(OBJS)
	ranlib $(LIB)

clean:; /bin/rm -f $(OBJS)

###
builtin.o: ../util/util.h token.h eprop.h parse.h
parse.o: ../util/util.h token.h eprop.h parse.h
token.o: ../util/util.h token.h eprop.h
