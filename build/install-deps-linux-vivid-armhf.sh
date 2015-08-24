#!/bin/bash

# Change directory to the location of this script
cd $(dirname ${BASH_SOURCE[0]})

if [ ! $(command -v apt-get) ]; then
  echo "Not a .deb package system. Please install dependencies manually"
  exit 0
fi

#install g++-4.9
#sudo add-apt-repository ppa:ubuntu-toolchain-r/test
#sudo apt-get update

#try to remove glfw2
#sudo apt-get remove libglfw2

DEPENDS='libx11-dev:armhf'
DEPENDS+=' libxmu-dev:armhf'
DEPENDS+=' libglu1-mesa-dev:armhf'
DEPENDS+=' libgl2ps-dev:armhf'
DEPENDS+=' libxi-dev:armhf'
DEPENDS+=' g++-4.9'
DEPENDS+=' libzip-dev:armhf'
DEPENDS+=' libpng12-dev:armhf'
DEPENDS+=' libcurl4-gnutls-dev:armhf'
DEPENDS+=' libfontconfig1-dev:armhf'
DEPENDS+=' libsqlite3-dev:armhf'
DEPENDS+=' libglew-dev:armhf'
DEPENDS+=' libssl-dev:armhf'
DEPENDS+=' libglfw3-dev:armhf'

MISSING=
echo "Checking for missing packages ..."
for i in $DEPENDS; do
    if ! dpkg-query -W --showformat='${Status}\n' $i | grep "install ok installed" > /dev/null; then
        MISSING+="$i "
    fi
done

if [ -n "$MISSING" ]; then
    TXTCOLOR_DEFAULT="\033[0;m"
    TXTCOLOR_GREEN="\033[0;32m"
    echo -e $TXTCOLOR_GREEN"Missing packages: $MISSING.\nYou may be asked for your password for package installation."$TXTCOLOR_DEFAULT
    apt-get --force-yes --yes install $MISSING
fi
