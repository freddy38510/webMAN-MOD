#!/bin/sh

#[ -f EP0001-UPDWEBMOD_00-0000000000000000.pkg ] && rm EP0001-UPDWEBMOD_00-0000000000000000.pkg || :
#[ -f webMAN_MOD_1.45.xx_Updater.pkg ] && rm webMAN_MOD_1.45.xx_Updater.pkg || :

make clean

echo -ne "\033]0;Building pkg...\007"

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
mv EP0001-UPDWEBMOD_00-0000000000000000.pkg webMAN_MOD_1.45.xx_Updater.pkg
rm -rf build
echo -ne "\033]0;You can close terminal\007"
