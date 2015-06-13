#!/bin/bash

apt-get install libgl1-mesa-dev:armhf
apt-get install libglew-dev:armhf
apt-get install libglfw-dev:armhf

apt-get install libxrandr-dev:armhf
apt-get install libxi-dev:armhf
apt-get install libfontconfig1-dev:armhf

GLFW_VERSION="3.0.4"
GLFW_SOURCE="https://codeload.github.com/glfw/glfw/tar.gz/${GLFW_VERSION}"
GLFW_ZIP="glfw${GLFW_VERSION}.tar.gz"
GLFW_INSTALL="glfw_install"
GLFW_SRCDIR="glfw-${GLFW_VERSION}"
GLFW_DESTDIR="glfw_dest"

install_glfw_dep()
{
   apt-get install xorg-dev
   apt-get install libglu1-mesa-dev
   apt-get install cmake
   apt-get install curl
}

clean_tmp_file()
{
  rm -rf ${GLFW_INSTALL}
}

make_and_install()
{
  mkdir $GLFW_DESTDIR
  cd $GLFW_DESTDIR
  env DEB_TARGET_GNU_SYSTEM=linux-gnueabihf DEB_HOST_MULTIARCH=arm-linux-gnueabihf DEB_TARGET_GNU_CPU=arm DEB_HOST_ARCH_ENDIAN=little DEB_BUILD_ARCH_OS=linux DEB_HOST_GNU_TYPE=arm-linux-gnueabihf DEB_TARGET_ARCH_CPU=arm DEB_TARGET_GNU_TYPE=arm-linux-gnueabihf DEB_BUILD_ARCH_CPU=amd64 DEB_HOST_ARCH_OS=linux DEB_HOST_GNU_SYSTEM=linux-gnueabihf DEB_HOST_GNU_CPU=arm DEB_HOST_ARCH_CPU=arm DEB_TARGET_ARCH_ENDIAN=little DEB_BUILD_MULTIARCH=x86_64-linux-gnu DEB_TARGET_ARCH=armhf DEB_BUILD_GNU_CPU=x86_64 DEB_BUILD_GNU_SYSTEM=linux-gnu DEB_BUILD_ARCH_ENDIAN=little DEB_TARGET_MULTIARCH=arm-linux-gnueabihf DEB_TARGET_ARCH_OS=linux DEB_BUILD_ARCH=amd64 DEB_HOST_ARCH_BITS=32 DEB_TARGET_ARCH_BITS=32 DEB_BUILD_GNU_TYPE=x86_64-linux-gnu DEB_BUILD_ARCH_BITS=64 DEB_HOST_ARCH=armhf cmake "../${GLFW_SRCDIR}" -G "Unix Makefiles" -DBUILD_SHARED_LIBS=ON
  make
  make install
  ldconfig
  cd ..
}

install_glfw()
{
  echo glw_version ${GLFW_VERSION}
  echo glfw_download_size ${GLFW_SOURCE}
  echo glfw_zip_file ${GLFW_ZIP}
  #install_glfw_dep
  mkdir $GLFW_INSTALL
  cd $GLFW_INSTALL
  curl -o $GLFW_ZIP $GLFW_SOURCE
  tar xzf ${GLFW_ZIP}
  make_and_install
  cd ..
  clean_tmp_file
}


install_glfw