SOURCE:=$(wildcard debianmeeting*.tex)
DVIFILES:=$(SOURCE:%.tex=%.dvi)
PDFFILES:=$(SOURCE:%.tex=%.pdf)
RELEASEFILES:=$(SOURCE:%.tex=%.release-stamp)

all: $(PDFFILES)

publish: $(RELEASEFILES)
	# this gives error when I am not the owner of the
	# file, but fixes all files that I am the owner
	-ssh alioth.debian.org chmod 664 /var/lib/gforge/chroot/home/groups/tokyodebian/htdocs/pdf/*.pdf

%.release-stamp: %.pdf
	touch $@
	scp $< alioth.debian.org:/var/lib/gforge/chroot/home/groups/tokyodebian/htdocs/pdf/

%.pdf: %.dvi
	umask 002 ; dvipdfmx $< 

%.dvi: %.tex
	## start of linting stuff
	# check kanji-code of the tex file.
	iconv -f iso-2022-jp -t iso-2022-jp < $< > /dev/null
	TEXINPUTS=:`pwd`/../ platex $< # create draft input
	-mendex $(<:%.tex=%)
	TEXINPUTS=:`pwd`/../ platex $< # create draft content with correct spacing for index and toc
	-mendex $(<:%.tex=%) # recreate index with correct page number
	TEXINPUTS=:`pwd`/../ platex $< # recreate toc with correct page number

clean:
	-rm *.dvi *.aux *.toc *~ *.log *.waux *.out _whizzy_* *.snm *.nav *.jqz *.ind *.ilg *.idx *.idv *.lg *.xref *.4ct *.4tc *.css
	-touch $(RELEASEFILES)

listtopic:
	lgrep dancersection *-{natsu,fuyu}.tex | sed -n 's/\\dancersection{\([^}]*\)}.*/\1/p'

.PHONY: clean all publish listtopic
