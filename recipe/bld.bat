set PATH=%PREFIX%\cmake-bin\bin;%PATH%

mkdir build
pushd build
  cmake .. -G "NMake Makefiles"                     ^
           -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%  ^
           -DCMAKE_BUILD_TYPE=Release               ^
           -DBUILD_SHARED_LIBS=OFF
  cmake --build . --config Release --target INSTALL
popd
