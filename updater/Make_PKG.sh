#!/bin/sh

[ -f EP0001-UPDWEBMOD_00-0000000000000000.pkg ] && rm EP0001-UPDWEBMOD_00-0000000000000000.pkg || :
[ -f webMAN_MOD_1.45.xx_Updater.pkg ] && rm webMAN_MOD_1.45.xx_Updater.pkg || :

echo -e "1. Standard icons"
echo -e "2. KMZ icons"
 
tput bold
read -p "Enter your choice [1-2] " choice
tput clear
tput sgr0

[ $choice = "1" ] && 
cp -R icons/standard/* pkgfiles/USRDIR/; echo -ne "\033]0;Building pkg with standard icons\007" || 
cp -R icons/kzm/* pkgfiles/USRDIR/; echo -ne "\033]0;Building pkg with KMZ icons\007"

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
[ -f webMAN_MOD_1.43.xx_Updater.pkg ] && rm webMAN_MOD_1.43.xx_Updater.pkg || :
[ -f webMAN_MOD_1.45.xx_Updater.pkg ] && rm webMAN_MOD_1.45.xx_Updater.pkg || :
rm -rf build

[ $choice = "1" ] && mv EP0001-UPDWEBMOD_00-0000000000000000.pkg webMAN_MOD_1.45.xx_Updater.pkg ||
mv EP0001-UPDWEBMOD_00-0000000000000000.pkg webMAN_MOD_1.45.xx_Updater_KMZ_icons.pkg
ls -o webMAN_MOD*.pkg

echo -ne "\033]0;Finished\007"
