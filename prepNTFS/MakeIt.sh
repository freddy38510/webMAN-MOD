#!/bin/sh

# Check libraries
[ -f $PS3DEV/portlibs/ppu/lib/libcobra.a ] && : || (echo "Installing libcobra"; cd lib/cobralib_psl1ght_src; sh MakeIt.sh;)
[ -f $PS3DEV/portlibs/ppu/lib/libntfs_ext.a ] && : || (echo "Installing libntfs"; cd lib/libntfs_ext_src; sh MakeIt.sh;)

cd ./
make pkg
