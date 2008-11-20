SOURCE:=$(wildcard debianmeeting*.tex)
DVIFILES:=$(SOURCE:%.tex=%.dvi)
PDFFILES:=$(SOURCE:%.tex=%.pdf)
RELEASEFILES:=$(SOURCE:%.tex=%.release-stamp)

all: 2005 2006 2007 2008

build_check:
	# check that pre-commit hook is installed.
	# if this fails, please do:
	# cp git-pre-commit.sh .git/hooks/pre-commit
	diff -u .git/hooks/pre-commit git-pre-commit.sh
	[ -x .git/hooks/pre-commit ]
	## end of linting stuff

2005: build_check
	make -C 2005-resume
2006: build_check
	make -C 2006-resume
2007: build_check
	make -C 2007-resume
2008: build_check
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

.PHONY: clean all publish

check-syntax:
	$(CC) -c -O2 -Wall $(CHK_SOURCES) -o/dev/null $(shell pkg-config --cflags gtk+-2.0)
