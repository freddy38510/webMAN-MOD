#!/bin/sh

# Check python 2.7
if [[ $(python --version 2>&1) == *2\.7\.* ]]; then python="python";
elif [[ $(python2 --version 2>&1) == *2\.7\.* ]]; then python="python2";
elif [[ $(python2.7 --version 2>&1) == *2\.7\.* ]]; then python="python2.7";
else echo "Python 2.7 is required";
fi

# Check PS3DEV env
if [ -z "$PS3DEV" ]; then
  echo "Please set PS3DEV in your environment. export PS3DEV=<path>"
fi

# Check pkg.py
if ! type "pkg.py" > /dev/null; then
  echo "Missing pkg.py in" $PS3DEV"/bin";
fi

PKG=$PS3DEV/bin/pkg.py
CONTENTID=UP0001-PKGLAUNCH_00-0000000000000000
PKG_DIR=./pkg/
PKG_NAME=./$CONTENTID.pkg

$python $PKG --contentid $CONTENTID $PKG_DIR $PKG_NAME
