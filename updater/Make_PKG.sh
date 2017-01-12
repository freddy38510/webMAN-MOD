#!/bin/sh

[ -f EP0001-UPDWEBMOD_00-0000000000000000.pkg ] && rm EP0001-UPDWEBMOD_00-0000000000000000.pkg || :
#[ -f webMAN_MOD_1.45.xx_Updater.pkg ] && rm webMAN_MOD_1.45.xx_Updater.pkg || :

clear

echo -e "1. standard"
echo -e "2. kmz"
echo -e "3. metalification"
echo -e "4. rebugification"
 
tput bold

while [ ! ${finished} ]
do
	read -p "Choose your theme [1-4] " choice
	tput clear
	tput sgr0

	if [ $choice -eq 1 ]
	then
		yes |"cp" -rf themes/standard_theme/* pkgfiles/USRDIR;
		echo -ne "\033]0;Building pkg with standard theme\007";
		[ -f webMAN_MOD_1.45.xx_Updater.pkg ] && rm webMAN_MOD_1.45.xx_Updater.pkg || :
		finished=true;
	elif [ $choice -eq 2 ]
	then
		yes |"cp" -rf themes/kmz_theme/* pkgfiles/USRDIR;
		echo -ne "\033]0;Building pkg with kzm theme\007";
		[ -f webMAN_MOD_1.45.xx_Updater_kmz_theme.pkg ] && rm webMAN_MOD_1.45.xx_Updater_kmz_theme.pkg || :
		finished=true
	elif [ $choice -eq 3 ]
	then
		yes |"cp" -rf themes/metalification_theme/* pkgfiles/USRDIR;
		echo -ne "\033]0;Building pkg with metalification theme\007";
		[ -f webMAN_MOD_1.45.xx_Updater_metalification_theme.pkg ] && rm webMAN_MOD_1.45.xx_Updater_metalification_theme.pkg || :
		finished=true
	elif [ $choice -eq 4 ]
	then
		yes |"cp" -rf themes/rebugification_theme/* pkgfiles/USRDIR;
		echo -ne "\033]0;Building pkg with rebugification theme\007";
		[ -f webMAN_MOD_1.45.xx_Updater_rebugification_theme.pkg ] && rm webMAN_MOD_1.45.xx_Updater_rebugification_theme.pkg || :
		finished=true
	else
		echo "Invalid number";
	fi
done
clear
make clean
make pkg

mv build/pkg build/EP0001-UPDWEBMOD_00-0000000000000000
wine param_sfo_editor.exe "build\EP0001-UPDWEBMOD_00-0000000000000000\PARAM.SFO" "ATTRIBUTE" 133 2>&1

echo "ContentID = EP0001-UPDWEBMOD_00-0000000000000000" >>package.conf
echo "Klicensee = 000000000000000000000000000000000000" >>package.conf
echo "PackageVersion = 01.00" >>package.conf
echo "DRMType = Free" >>package.conf
echo "ContentType = GameExec" >>package.conf

wine psn_package_npdrm.exe -n package.conf "build\EP0001-UPDWEBMOD_00-0000000000000000" 2>&1 

rm package.conf
#[ -f webMAN_MOD_1.45.xx_Updater.pkg ] && rm webMAN_MOD_1.45.xx_Updater.pkg || :
rm -rf build

[ $choice = "1" ] && mv EP0001-UPDWEBMOD_00-0000000000000000.pkg webMAN_MOD_1.45.xx_Updater.pkg && echo "webMAN_MOD_1.45.xx_Updater.pkg built" || :
[ $choice = "2" ] && mv EP0001-UPDWEBMOD_00-0000000000000000.pkg webMAN_MOD_1.45.xx_Updater_kmz_theme.pkg && echo "webMAN_MOD_1.45.xx_Updater_kmz_theme.pkg built" || :
[ $choice = "3" ] && mv EP0001-UPDWEBMOD_00-0000000000000000.pkg webMAN_MOD_1.45.xx_Updater_metalification_theme.pkg && echo "webMAN_MOD_1.45.xx_Updater_metalification_theme.pkg built" && rm pkgfiles/USRDIR/icon_wm_bdv.png && rm pkgfiles/USRDIR/icon_wm_ps3xtr.png && rm pkgfiles/USRDIR/icon_wm_sacd.png || :
[ $choice = "4" ] && mv EP0001-UPDWEBMOD_00-0000000000000000.pkg webMAN_MOD_1.45.xx_Updater_rebugification_theme.pkg && echo "webMAN_MOD_1.45.xx_Updater_rebugification_theme.pkg built" && rm pkgfiles/USRDIR/icon_wm_bdv.png && rm pkgfiles/USRDIR/icon_wm_ps3xtr.png && rm pkgfiles/USRDIR/icon_wm_sacd.png || :

read -r -p "Do you want to build a new pkg with an other theme ? [y/N] " response
case $response in
    [yY][eE][sS]|[yY]) 
	sh Make_PKG.sh 2>&1
        ;;
    *)
	yes |"cp" -rf themes/standard_theme/* pkgfiles/USRDIR;
	make clean
	echo -ne "\033]0;Finished\007";
        ;;
esac
