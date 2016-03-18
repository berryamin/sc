# Makefile $Revision: 7.16 $
#
# 1) Select the proper EXDIR (path), MANDIR, MANEXT, LIBDIR, SIGVOID,
#	REGEX, DFLT_PAGER, and FMOD. Most of the other things aren't
#	normally changed (see the comments with each)
# 2) Select the proper machine/compiler/OS section of code
#	for MS-DOS look for the pattern 'MS-DOS'
# 3) make install
# 4) If you have the command 'file' that uses /etc/magic add the line:
#	38	string		Spreadsheet	sc file


# Specify the name of the program.
# All documentation and installation keys on this value.
# 
name=sc
NAME=SC

# The base directory where everything should be installed.  If you're
# packaging this with an O/S, for example, you'll probably want to change
# this to /usr.  Otherwise, /usr/local is probably more appropriate, unless
# you're replacing the vendor-supplied version.
prefix=/usr

# This is where the install step puts it.
EXDIR=${prefix}/bin

# This is where the man page goes.
MANDIR=${prefix}/man/man1
MANEXT=1
MANMODE=644

# This is where the library file (tutorial) goes.
#LIBDIR=/usr/local/share/$(name) # reno
LIBDIR=${prefix}/lib/$(name)
LIBRARY=-DLIBDIR=\"${LIBDIR}\"

# Set SIMPLE for lex.c if you don't want arrow keys or lex.c blows up
#SIMPLE=-DSIMPLE
SIMPLE=

# Set BROKENCURSES if your curses has the nl/nonl bug
# if it does and you don't set BROKENCURSES, the display will
# be staggered across the screen. Also try IDLOKBAD below.
#BROKENCURSES=-DBROKENCURSES
BROKENCURSES=

# Set USELOCALE to enable country-dependent display of decimal points,
# local character recognition in words, and local @date() format.
#USELOCALE=
USELOCALE=-DUSELOCALE

# Set DOBACKUPS if you would like a backup copy of a source file on a save
#DOBACKUPS=
DOBACKUPS=-DDOBACKUPS

# Set SIGVOID if signal routines are type void.
# use: SIGVOID=-DSIGVOID for:
#	System 5.3, SunOS 4.X, VMS, BSD4.4 (reno), and ANSI C Compliant systems
# use: SIGVOID=		for:
#  BSD systems (excluding reno, BSD4.4), and the UNIXPC 'cc'
#SIGVOID=
SIGVOID=-DSIGVOID

# Set IEEE_MATH if you need setsticky() calls in your signal handlers
#
#IEEE_MATH=-DIEEE_MATH
IEEE_MATH=

# The -ffloat-store compiler option is necessary for compiling interp.c to
# prevent spurious "Still changing after x iterations" errors, intermittent
# problems with the @round function, comparisons failing when they shouldn't,
# and potentially other similar problems due to FPU registers having greater
# precision than doubles in memory.  This is known to be necessary for GCC
# on x86 processors/FPUs, and probably others.
FLOAT_STORE=-ffloat-store

# Set RINT=-DRINT if you do not have rint() in math.h
# Set RINT=	on/with (they have rint):
#	SunOS 4.0.3c compiler
#	BSD4.4 (reno)
#RINT=-DRINT
RINT=

# If your system supports POSIX.2 regular expressions, REGEX should be
# set to -DREGCOMP.  Otherwise, set REGEX to -DREGCMP if you have the
# regcmp/regex regular expression routines (most System V based systems
# do) or to -DRE_COMP if you have the re_comp/re_exec regular expression
# routines (most BSD based systems do).  If your system has no support for
# regular expressions, leave REGEX unset.
#REGEX=
#REGEX=-DREGCMP
#REGEX=-DRE_COMP
REGEX=-DREGCOMP

# This is the name of a pager like "more".
# "pg" may be appropriate for SYSV.
#DFLT_PAGER=-DDFLT_PAGER=\"more\"	# generic && reno
DFLT_PAGER=-DDFLT_PAGER=\"less\"

# This is the name of the history file.  If undefined, the history will
# not be saved.
HISTORY_FILE=-DHISTORY_FILE=\"~/.sc_history\"

# this is the name to save back ups in
SAVE=-DSAVENAME=\"$(NAME).SAVE\"

# path to crypt, do not define if you don't have crypt
# most systems
#CRYPT=-DCRYPT_PATH=\"/bin/crypt\"
# BSD
# CRYPT=-DCRYPT_PATH=\"/usr/bin/crypt\"
# other people?
#CRYPT=-DCRYPT_PATH=\"/usr/local/bin/crypt\"

# If you get errors about fmod being undefined when you try to
# compile, then define NO_FMOD (most likely BSD4.3 and Mt Xinu).
#FMOD=-DNO_FMOD
FMOD=

# If your system doesn't have notimeout() in curses define NONOTIMEOUT
#NO_NOTIMEOUT=-DNONOTIMEOUT
NO_NOTIMEOUT=

# flags for lint
LINTFLAGS=-abchxv

# Format of quick reference guide generated by $(name)qref
# Leave undefined for normal text output.
#QREF_FMT=
QREF_FMT=-DTROFF

# *** SPECIAL NOTES ***
# For ULTRIX: define the BSD4.2 section and SIGVOID above
#	tdw@cl.cam.ac.uk tested on Ultrix 3.1C-0
# HP-UX 7.0: Do NOT use -O
#	(known broken, try sc's boolean operators if you wish)
#
# **** SYSV curses bugs... ****
# Try setting IDLOKBAD to fix (with an empty spreadsheet):
#	a) Redrawing the bottom half of the screen when you
#		move between row 9 <-> 10
#	b) the highlighted row labels being trash when you
#		move between row 9 <-> 10
#	c) On an xterm on Esix Rev. D+ from eating lines
#		 -goto (or move) a few lines (or more) past the bottom
#		 of the screen, goto (or move) to the top line on the
#		 screen, move upward and the current line is deleted, the
#		 others move up even when they should not, check by
#		 noticing the rows become 2, 3, 40, 41, 42... (etc).
#	Known systems/terminfos w/ curses problems:
#	{Esix Rev. D+, AT&T SysV3.2.1}:at386-m,xterm, HP-UX7.0:(not sure)
#IDLOKISBAD=-DIDLOKBAD
IDLOKISBAD=

# If you don't have idlok() in your curses define NOIDLOK
#NO_IDLOK=-DNOIDLOK
NO_IDLOK=

# If moving right off the screen causes the screen to not redraw
# properly, define RIGHT_CBUG to get around a curses problem on some
# boxes, this forces screen redraws when going right off the screen
#RIGHTBUG=-DRIGHT_CBUG
RIGHTBUG=

# IF you have problems w/ your yacc try bison, Berkeley yacc, or
# some other yacc. Some systems don't allow you to
# increase the number of terminals (mostly AT&T), SCO's does though.
# YACC=yacc
# NOTE: Do not use with bison 1.16! Get a new version....
YACC=bison -y

# MS-DOS needs y_tab instead of the normal y.tab
#YTAB=y_tab
YTAB=y.tab

# Command to use to make temporary copies of some source files.
#LN=ln -s
#LN=cp
LN=ln

#### SYSTEM DEFINES ####

#########################################
# Use this for system AIX V3.1
#CFLAGS= -O -DSYSV2 -DCHTYPE=int -DNLS
#LDFLAGS=
#LIB=-lm -lPW -lcurses

#########################################
# Use this for system V.2 (includes: HP-UX 7.05, UNIXPC)
#CFLAGS= -O -DSYSV2 
#LDFLAGS=
#LIB=-lm -lPW -lcurses
# with gcc on a Sequent also use:
#CC=att gcc
#CFLAGS=  -DSYSV2 -g -pipe -traditional

#########################################
# Use this for system V.3
#CFLAGS=  -DSYSV3 -O
#LDFLAGS= -s
#CFLAGS=  -DSYSV3 -g
#LDFLAGS= -g
#LIB=-lm -lncurses -lfl
# with gcc also use:
#CC=gcc
#CFLAGS=  -DSYSV3 -O -pipe
# debugging bison (bison 1.16 is broken)
#CFLAGS=  -DSYSV3 -g -pipe -traditional
#YACC=bison -y -v -t -l

#########################################
# Use this for system V.4
#CFLAGS=  -DSYSV4 -DSYSV3 -O
#LDFLAGS= -s
#LIB=-lm -lcurses -lgen
# with gcc also use:
#CC=gcc
#CFLAGS=  -DSYSV3 -O -pipe

#########################################
# Microport
#CFLAGS= -DSYSV2 -O -DUPORT -Ml
#LDFLAGS=-Ml
#LIB=-lm -lcurses -lPW

#########################################
# Use this for BSD 4.2
#CFLAGS= -O -DBSD42
#LDFLAGS=
#LIB=-lm -lcurses -ltermcap
# with gcc also use:
#CC=gcc

#########################################
# Use this for Sequent boxes
#CC=atscc
#CFLAGS=-O -DBSD42
#LDFLAGS= 
#LIB=-lm -lcurses  -ltermcap
#PSCLIB=-lseq
# with gcc also use:
#CC=gcc
#CFLAGS= -O -DBSD42 -pipe

#########################################
# Use this for BSD 4.3
#CFLAGS= -O -DBSD43	#-O or -g
#LDFLAGS=	# -lg might help if -g used in CFLAGS
#LIB=-lm -lcurses -ltermcap

#########################################
# Use this for SunOS 4.X if you have the System V package installed.
# This will link with the System V curses which is preferable to the
# BSD curses (especially helps scrolling on slow (9600bps or less)
# serial lines).
#
# Be sure to define SIGVOID and REGEX (to -DRE_COMP) above.
# 
#CC=/usr/5bin/cc
#CFLAGS= -O -DSYSV3 
#LDFLAGS=
#LIB=-lm -lcurses 

#########################################
# Use this for system III (XENIX)
#CFLAGS= -O -DSYSIII
#LDFLAGS= -i
#LIB=-lm -lcurses -ltermcap

#########################################
# Use this for XENIX Version 2.3
#CFLAGS= -O -DSYSIII -DXENIX2_3
#LDFLAGS= -i
#LIB=-lm -lcurses -ltermcap

#########################################
# Use this for VENIX
#CFLAGS= -DVENIX -DBSD42 -DV7
#LDFLAGS= -z -i 
#LIB=-lm -lcurses -ltermcap

#########################################
# For SCO Unix V rel. 3.2.0
#       -compile using rcc, cc does not cope with gram.c
#       -edit /usr/include/curses.h, rcc does not understand #error
#       -link: make CC=cc, rcc's loader gets unresolved __cclass, __range
#               (rather strange,?)
#CC=rcc
#CC=cc
#CC=gcc -fstrength-reduce
#SIGVOID=-DSIGVOID
#CFLAGS= -O -DSYSV3
#LDFLAGS=
#LIB=-lm -lcurses -ltinfo -lPW
#YACC=yacc -Sm10000

#########################################
# Use this for SCO Unix 3.2.2 and ODT 1.1
#CC=cc
#CFLAGS= -O -DSYSV3
#LDFLAGS=
#LIB=-lm -lcurses -lPW -lmalloc -lc_s
#YACC=yacc -Sm10000

#########################################
# Use this for MS-DOS, Microsoft C 5.1 and NDMAKE
#CC=cl
#CFLAGS= -AL -O -Fo$*.o
#LDFLAGS=/noi /st:0x4000
#LIB=lcurses
#YACC=bison -y
#
#.SUFFIXES : .o .c
#.c.o:
#	$(CC) $(CFLAGS) -c $*.c

#########################################
# Use this for MS-DOS with DJGPP
# REGEX should also be undefined (see above) unless a separate REGEX library
# is installed (gdb includes one, but may result in file conflicts with
# existing DJGPP files).
#CC=gcc
# Only use -Wall for testing, since it produces warnings that are of no
# real effect on the reliability of the program, but may concern some
# people who don't understand them.
#CFLAGS=-DSYSV3 -O2 -Wall -UMSDOS
#CFLAGS=-DSYSV3 -O2 -UMSDOS
#LIB=-lm -lpdcurses

#########################################
# Use this for Linux
CC=gcc
# Only use -Wall for testing, since it produces warnings that are of no
# real effect on the reliability of the program, but may concern some
# people who don't understand them.
#CFLAGS=-DSYSV3 -O2 -Wall -pipe
CFLAGS=-DSYSV3 -O2 -pipe
LIB=-lm -lncurses

# All of the source files
SRC=Makefile abbrev.c cmds.c color.c crypt.c eres.sed frame.c format.c gram.y \
	help.c interp.c lex.c pipe.c psc.c range.c sc.c sc.h screen.c sort.c \
	sres.sed version.c vi.c vmtbl.c xmalloc.c

# The objects
OBJS=abbrev.o cmds.o color.o crypt.o format.o frame.o gram.o help.o interp.o \
	lex.o pipe.o range.o sc.o screen.o sort.o version.o vi.o vmtbl.o \
	xmalloc.o

# The documents in the Archive
DOCS=CHANGES README sc.doc psc.doc tutorial.sc VMS_NOTES torev build.com

all:	$(name) p$(name) $(name)qref

$(name):$(PAR)  $(OBJS)
	$(CC) ${LDFLAGS} ${OBJS} ${LIB} -o $(name)

# Alternative link for MS-DOS
#$(name):	$(OBJS)
#	link ${LDFLAGS} ${OBJS},$(name),,${LIB};

gram.c:	gram.y
	$(YACC) -d gram.y
	mv $(YTAB).c gram.c

$(YTAB).h:	gram.y

p$(name):	psc.c pvmtbl.o pxmalloc.o
	$(CC) $(CFLAGS) ${LDFLAGS} -o p$(name) psc.c pvmtbl.o pxmalloc.o ${PSCLIB}

# Alternative link for MS-DOS (NB: MSC 5.1 has no getopt.c)
#p$(name):	psc.o pvmtbl.o pxmalloc.o getopt.o
#	link ${LDFLAGS} psc.o pvmtbl.o pxmalloc.o getopt.o,p$(name);

qhelp.c: help.c
	-rm -f qhelp.c
	${LN} help.c qhelp.c

$(name)qref:	qhelp.c sc.h
	$(CC) $(CFLAGS) $(LDFLAGS) -DQREF $(QREF_FMT) -DSCNAME=\"$(NAME)\" -o $(name)qref qhelp.c

# Alternative link for MS-DOS
#$(name)qref:	qhelp.c sc.h
#	$(CC) -AL -O -Foqhelp.o -c -DQREF -DSCNAME=\"$(name)\" qhelp.c
#	link ${LDFLAGS} qhelp.o,$(name)qref;

pvmtbl.c: vmtbl.c
	-rm -f pvmtbl.c
	${LN} vmtbl.c pvmtbl.c

pvmtbl.o: sc.h pvmtbl.c
	$(CC) ${CFLAGS} -c -DPSC pvmtbl.c

pxmalloc.c: xmalloc.c
	-rm -f pxmalloc.c
	${LN} xmalloc.c pxmalloc.c

# Objects

abbrev.o: abbrev.c sc.h
	$(CC) ${CFLAGS} ${DFLT_PAGER} -c abbrev.c

cmds.o: cmds.c sc.h
	$(CC) ${CFLAGS} ${DOBACKUPS} ${CRYPT} -c cmds.c

color.o: color.c sc.h

crypt.o: crypt.c sc.h
	$(CC) ${CFLAGS} ${CRYPT} ${DOBACKUPS} -c crypt.c

format.o: format.c

frame.o: frame.c sc.h

gram.o:	sc.h $(YTAB).h gram.c
	$(CC) ${CFLAGS} ${USELOCALE} -c gram.c
	sed < gram.y > experres.h -f eres.sed
	sed < gram.y > statres.h -f sres.sed

help.o: help.c sc.h
	$(CC) ${CFLAGS} ${CRYPT} -c help.c

interp.o:	interp.c sc.h
	$(CC) ${CFLAGS} ${FLOAT_STORE} ${IEEE_MATH} ${SIGVOID} ${RINT} \
	${REGEX} ${FMOD} -c interp.c

lex.o:	sc.h $(YTAB).h gram.o lex.c
	$(CC) ${CFLAGS} ${SIMPLE} ${IEEE_MATH} ${LIBRARY} ${SIGVOID} \
	${NO_NOTIMEOUT} -c lex.c

pipe.o: pipe.c sc.h

pxmalloc.o: sc.h pxmalloc.c
	$(CC) ${CFLAGS} -c -DPSC pxmalloc.c

qhelp.o: qhelp.c sc.h
	$(CC) ${CFLAGS} ${CRYPT} -c qhelp.c

range.o: range.c sc.h

sc.o:	sc.h sc.c
	$(CC) ${CFLAGS} ${DFLT_PAGER} ${SIGVOID} ${SAVE} -c sc.c

screen.o:	sc.h screen.c
	$(CC) ${CFLAGS} ${BROKENCURSES} ${IDLOKISBAD} ${RIGHTBUG} ${SIGVOID} \
	${NO_IDLOK} -c screen.c

sort.o: sort.c sc.h

vi.o: vi.c sc.h
	$(CC) ${CFLAGS} ${REGEX} ${HISTORY_FILE} -c vi.c

# other stuff

clean:
	rm -f *.o *res.h $(YTAB).h debug core gram.c $(name).1 p$(name).1 \
	y.output pxmalloc.c pvmtbl.c qhelp.c tags

distclean:
	rm -f *.o *res.h $(YTAB).h $(name) p$(name) debug core gram.c \
	$(name).1 $(name).man p$(name).man p$(name).1 y.output $(name)qref \
	pxmalloc.c pvmtbl.c qhelp.c tags

shar: ${SRC} ${DOCS}
	shar -c -m 64000 -f shar ${DOCS} ${SRC}

sshar: ${SRC}
	shar -c -m 1000000 -f shar ${SRC}

lint: sc.h sc.c lex.c gram.c interp.c cmds.c color.c crypt.c frame.c pipe.c \
	range.c help.c vi.c version.c xmalloc.c format.c vmtbl.c
	lint ${LINTFLAGS} ${CFLAGS} ${SIMPLE} sc.c lex.c gram.c interp.c \
	cmds.c color.c crypt.c frame.c pipe.c range.c help.c vi.c version.c \
	xmalloc.c format.c vmtbl.c -lcurses -lm 
	make lintqref

lintqref: help.c
	lint ${LINTFLAGS} ${CFLAGS} ${SIMPLE} -DQREF help.c

lintpsc: psc.c vmtbl.c
	lint ${LINTFLAGS} ${CFLAGS} ${SIMPLE} -DPSC psc.c vmtbl.c

$(name).1:	sc.doc torev
	name=$(name) NAME=$(NAME) LIBDIR=$(LIBDIR) sh torev sc.doc > $(name).1

$(name).man:	$(name).1
	nroff -man $(name).1 > $(name).man

p$(name).1:	psc.doc torev
	name=$(name) NAME=$(NAME) LIBDIR=$(LIBDIR) sh torev psc.doc > p$(name).1

p$(name).man:	p$(name).1
	nroff -man p$(name).1 > p$(name).man

install: $(EXDIR)/$(name) $(EXDIR)/$(name)qref $(EXDIR)/p$(name) \
	 $(LIBDIR)/tutorial $(MANDIR)/$(name).$(MANEXT) \
	 $(MANDIR)/p$(name).$(MANEXT)

$(EXDIR)/$(name): $(name)
	cp $(name) $(EXDIR)
	strip $(EXDIR)/$(name)

$(EXDIR)/$(name)qref: $(name)qref
	cp $(name)qref $(EXDIR)
	strip $(EXDIR)/$(name)qref

$(EXDIR)/p$(name): p$(name)
	cp p$(name) $(EXDIR)
	strip $(EXDIR)/p$(name)

$(LIBDIR)/tutorial: tutorial.sc $(LIBDIR)
	-mkdir -p $(LIBDIR)/plugins
	cp tutorial.sc $(LIBDIR)/tutorial.$(name)
	chmod $(MANMODE) $(LIBDIR)/tutorial.$(name)

$(LIBDIR):
	mkdir $(LIBDIR)

$(MANDIR)/$(name).$(MANEXT): $(name).1
	cp $(name).1 $(MANDIR)/$(name).$(MANEXT)
	chmod $(MANMODE) $(MANDIR)/$(name).$(MANEXT)

$(MANDIR)/p$(name).$(MANEXT): p$(name).1
	cp p$(name).1 $(MANDIR)/p$(name).$(MANEXT)
	chmod $(MANMODE) $(MANDIR)/p$(name).$(MANEXT)

uninstall:
	rm -f $(EXDIR)/$(name)
	rm -f $(EXDIR)/$(name)qref
	rm -f $(EXDIR)/p$(name)
	rm -rf $(LIBDIR)
	rm -f $(MANDIR)/$(name).$(MANEXT)
	rm -f $(MANDIR)/p$(name).$(MANEXT)

files:
	@find $(DOCS) $(SRC) -print
