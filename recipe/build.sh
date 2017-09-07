#!/bin/bash

mkdir build
pushd build
  for _shared in "OFF ON"; do
    cmake -DCMAKE_INSTALL_PREFIX=${PREFIX}  \
          -DBUILD_SHARED_LIBS=${_shared}    \
          -DCMAKE_INSTALL_LIBDIR=lib        \
          ..
    make -j${CPU_COUNT} ${VERBOSE_CM}
    make install
  done
popd
