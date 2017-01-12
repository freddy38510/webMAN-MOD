#!/bin/sh
if [ "$(uname)" == "Linux" ]; then
	[ -f Makefile.bak ] && (mv Makefile Makefile.win; mv Makefile.bak Makefile) || :
fi
make clean
make
