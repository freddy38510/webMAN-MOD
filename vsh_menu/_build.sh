#!/bin/sh
[ -f wm_vsh_menu.sprx ] && rm wm_vsh_menu.sprx || :
[ -f wm_vsh_menu.prx ] && rm wm_vsh_menu.prx || :
[ -f wm_vsh_menu.sym ] && rm wm_vsh_menu.sym || :

[ -d data ] && rm -rf data || :
cp -R ../data data

make

rm -rf data

[ -f wm_vsh_menu.prx ] && rm wm_vsh_menu.prx || :
[ -f wm_vsh_menu.sym ] && rm wm_vsh_menu.sym || :

make clean
