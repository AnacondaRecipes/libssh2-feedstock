#!/bin/bash

# We use a repackaged cmake from elsewhere to break a build cycle.
export PATH=${PREFIX}/cmake-bin/bin:${PATH}

mkdir build && cd build

make -j${CPU_COUNT}
# ctest  # fails on the docker image
make install

# We use a repackaged cmake from elsewhere to break a build cycle.
export PATH=${PREFIX}/cmake-bin/bin:${PATH}

for _shared in OFF ON; do
  mkdir build-${_shared}
  pushd build-${_shared}
    cmake -DCMAKE_INSTALL_PREFIX=${PREFIX}  \
          -DBUILD_SHARED_LIBS=${_shared}    \
          -DCMAKE_INSTALL_LIBDIR=lib        \
          -DCRYPTO_BACKEND=OpenSSL \
          -DENABLE_ZLIB_COMPRESSION=ON \
          -D CMAKE_INSTALL_RPATH=$PREFIX/lib \
          $SRC_DIR
    make -j${CPU_COUNT} ${VERBOSE_CM}
    make install
  popd
done
