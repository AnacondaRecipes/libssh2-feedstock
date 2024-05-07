set PATH=%PREFIX%\cmake-bin\bin;%PATH%

set CFLAGS=
set CXXFLAGS=

mkdir build
pushd build
  cmake .. -GNinja                           ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%  ^
    -DCMAKE_BUILD_TYPE=Release               ^
    -DBUILD_SHARED_LIBS=ON                   ^
    -D BUILD_STATIC_LIBS=OFF                 ^
    -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -D CMAKE_PREFIX_PATH=%LIBRARY_PREFIX%    ^
    -D ENABLE_ZLIB_COMPRESSION=ON            ^
    -D BUILD_EXAMPLES=OFF                    ^
    -D BUILD_TESTING=OFF

  ninja
  IF %ERRORLEVEL% NEQ 0 exit 1
  ninja install
  IF %ERRORLEVEL% NEQ 0 exit 1
popd
