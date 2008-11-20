SOURCE:=$(wildcard debianmeeting*.tex)
DVIFILES:=$(SOURCE:%.tex=%.dvi)
PDFFILES:=$(SOURCE:%.tex=%.pdf)
RELEASEFILES:=$(SOURCE:%.tex=%.release-stamp)

all: build_check

build_check: 2005 2006 2007 2008
	# check that pre-commit hook is installed.
	# if this fails, please do:
	# cp git-pre-commit.sh .git/hooks/pre-commit
	diff -u .git/hooks/pre-commit git-pre-commit.sh
	[ -x .git/hooks/pre-commit ]
	## end of linting stuff

2005:
	make -C 2005-resume
2006:
	make -C 2006-resume
2007:
	make -C 2007-resume
2008:
	make -C 2008-resume

publish: $(RELEASEFILES)
	# this gives error when I am not the owner of the
	# file, but fixes all files that I am the owner
	-ssh alioth.debian.org chmod 664 /var/lib/gforge/chroot/home/groups/tokyodebian/htdocs/pdf/*.pdf

clean:
	make -C 2005-resume clean
	make -C 2006-resume clean
	make -C 2007-resume clean
	make -C 2008-resume clean
	

deb:
	-rm ../*.deb
	debian/rules local-make-orig
	debuild -us -uc -i'.*pdf$$|.git'

listtopic:
	lgrep dancersection *-{natsu,fuyu}.tex | sed -n 's/\\dancersection{\([^}]*\)}.*/\1/p'

.PHONY: clean all publish listtopic

check-syntax:
	$(CC) -c -O2 -Wall $(CHK_SOURCES) -o/dev/null $(shell pkg-config --cflags gtk+-2.0)
