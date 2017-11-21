set PATH=%PREFIX%\cmake-bin\bin;%PATH%

<<<<<<< HEAD
mkdir build && cd build

cmake -G "%CMAKE_GENERATOR%" ^
		  -D BUILD_SHARED_LIBS=ON ^
			-D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
			-D ENABLE_ZLIB_COMPRESSION=ON ^
			-D CMAKE_BUILD_TYPE=Release ^
			%SRC_DIR%
IF %ERRORLEVEL% NEQ 0 exit 1

cmake --build . --config Release --target INSTALL
IF %ERRORLEVEL% NEQ 0 exit 1
=======
set CFLAGS=
set CXXFLAGS=

mkdir build
pushd build
  cmake .. -G "%CMAKE_GENERATOR%"                     ^
           -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%  ^
           -DCMAKE_BUILD_TYPE=Release               ^
           -DBUILD_SHARED_LIBS=ON
  cmake --build . --config Release --target INSTALL
popd
>>>>>>> remove vc features; use VS cmake generator; output shared libs
