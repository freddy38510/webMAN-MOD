#!/bin/sh

# Check libraries
#[ -f $PS3DEV/portlibs/ppu/lib/libcobra.a ] && : || (echo "Installing libcobra"; cd lib/cobralib_psl1ght_src; sh MakeIt.sh;)
#[ -f $PS3DEV/portlibs/ppu/lib/libntfs_ext.a ] && : || (echo "Installing libntfs"; cd lib/libntfs_ext_src; sh MakeIt.sh;)

# Check PS3 KEYS
if [ -z $PS3 ]; then
	echo -e "Missing PS3 environment...\n(You need to export PS3 path to a folder containing keys)";
	while [ ! ${finished} ]
	do
		read -r -p "Copy webMAN-MOD's data folder (contains keys) to $PS3DEV/bin ? [y/N] " response
		if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
			echo -e "Copying "$(cd ../data"$1";pwd)" to $PS3DEV/bin/ ...";
			cp -rf ../data $PS3DEV/bin/;
			finished=true;
		elif [[ $response =~ ^([nN][oO]|[nN])$ ]]; then
    			echo -e "Export PS3 environment. The path to keys are needed for scetool to work";
			finished=true;
		else
			echo "Invalid input";
		fi
	done
	sleep 4
	clear
	while [ ! ${finished2} ]
	do
		read -r -p "Export PS3 path to $PS3DEV/bin/data ? [y/N] " response2
		if [[ $response2 =~ ^([yY][eE][sS]|[yY])$ ]]; then
			echo -e "export PS3=$PS3DEV/bin/data";
			export PS3="$PS3DEV/bin/data";
			finished2=true;
		elif [[ $response2 =~ ^([nN][oO]|[nN])$ ]]; then
    			echo -e "Export PS3 environment. The path to keys are needed for scetool to work"
			finished2=true;
		else
			echo "Invalid input";
		fi
	done
	sleep 4
	clear
fi

#make clean
make pkg
