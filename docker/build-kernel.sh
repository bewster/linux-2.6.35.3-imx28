#!/bin/bash

cd /workspace

if [ -f "publish.version" ]; then
  echo "Image has been previously published.  Skipping build."
  echo "NOTE: To build new version, delete the file 'publish.version'"
  exit 1
fi

(
  echo "Set the default configuration"
  make ts7600_defconfig
  if [ $? -ne "0" ] ; then
    echo "Failed to install kernel headers to $LOCALPATH"
    exit 1
  else
    ln -sf initramfs.cpio-ts7600 initramfs.cpio
  fi
) &&\

(
  echo "Build the kernel"
  make
  if [ $? -ne "0" ] ; then
    echo "Failed to build the kernel"
    exit 1
  fi
) &&\

(
  echo "Build the bootstream"
  ./build_bootstream
  if [ $? -ne "0" ] ; then
    echo "Failed to build the bootstream"
    exit 1
  fi
) &&\

(
  echo "Publish the kernel"
  ./publish
)
