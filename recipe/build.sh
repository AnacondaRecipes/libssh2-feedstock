#!/bin/bash

<<<<<<< HEAD
<<<<<<< HEAD
# We use a repackaged cmake from elsewhere to break a build cycle.
export PATH=${PREFIX}/cmake-bin/bin:${PATH}

mkdir build && cd build

cmake -D CMAKE_INSTALL_PREFIX=$PREFIX \
      -D BUILD_SHARED_LIBS=OFF \
      -D CRYPTO_BACKEND=OpenSSL \
      -D CMAKE_INSTALL_LIBDIR=lib \
      -D ENABLE_ZLIB_COMPRESSION=ON \
      $SRC_DIR

make -j${CPU_COUNT}
# ctest  # fails on the docker image
make install

cmake -D CMAKE_INSTALL_PREFIX=$PREFIX \
      -D BUILD_SHARED_LIBS=ON \
      -D CRYPTO_BACKEND=OpenSSL \
      -D CMAKE_INSTALL_LIBDIR=lib \
      -D ENABLE_ZLIB_COMPRESSION=ON \
      -D CMAKE_INSTALL_RPATH=$PREFIX/lib \
      $SRC_DIR

make -j${CPU_COUNT}
# ctest  # fails on the docker image
make install
=======
mkdir cycle-breaker
pushd cycle-breaker
  if [[ $(uname) == Darwin ]]; then
    curl -SLO https://cmake.org/files/v3.8/cmake-3.8.2-Darwin-x86_64.tar.gz
    tar -xf cmake-3.8.2-Darwin-x86_64.tar.gz
    export PATH=${PWD}/cmake-3.8.2-Darwin-x86_64/CMake.app/Contents/bin:${PATH}
  elif [[ $(uname) == Linux ]]; then
    if [[ $(uname -m) == x86_64 ]]; then
      wget https://cmake.org/files/v3.8/cmake-3.8.2-Linux-x86_64.tar.gz
      tar -xf cmake-3.8.2-Linux-x86_64.tar.gz
      export PATH=${PWD}/cmake-3.8.2-Linux-x86_64/bin:${PATH}
    elif [[ $(uname -m) == i686 ]]; then
      # There is no binary release of cmake for linux-32
      declare -a _cmake_and_deps
      _base_url=https://repo.continuum.io/pkgs/free/linux-32
      _cmake_and_deps+=(cmake-3.6.3-0)
      _cmake_and_deps+=(curl-7.54.1-0)
      _cmake_and_deps+=(expat-2.1.0-0)
      _cmake_and_deps+=(krb5-1.13.2-0)
      _cmake_and_deps+=libssh2-1.8.0-0)
      _cmake_and_deps+=(ncurses-5.9-10)
      _cmake_and_deps+=(openssl-1.0.2l-0)
      _cmake_and_deps+=(xz-5.2.3-0)
      _cmake_and_deps+=(zlib-1.2.11-0)
      _cmake_and_deps+=(bzip2-1.0.6-3)
      for _pkg in "${_cmake_and_deps[@]}"; do
        wget ${_base_url}/${_pkg}.tar.bz2
        tar -xf ${_pkg}.tar.bz2
      done
      export PATH=${PWD}/bin:${PATH}
    else
      echo "Please figure out where to get a pre-build binary of CMake for your platform:"
      uname -a
      echo "This is necessary to break a dependency cycle."
      exit 1
    fi
  fi
popd

=======
>>>>>>> Use cmake-binary to break dependency cycle
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
>>>>>>> Break build cycle using a binary cmake
