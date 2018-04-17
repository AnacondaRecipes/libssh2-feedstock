set PATH=%PREFIX%\cmake-bin\bin;%PATH%

set CFLAGS=
set CXXFLAGS=

mkdir build
pushd build
  cmake .. -G "%CMAKE_GENERATOR%"                     ^
           -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%  ^
           -DCMAKE_BUILD_TYPE=Release               ^
			     -DENABLE_ZLIB_COMPRESSION=ON ^
           -DBUILD_SHARED_LIBS=ON
  cmake --build . --config Release --target INSTALL
IF %ERRORLEVEL% NEQ 0 exit 1
popd
