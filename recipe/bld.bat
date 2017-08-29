mkdir cycle-breaker
pushd cycle-breaker
  if %ARCH% == 32 goto skip_64
  powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://cmake.org/files/v3.8/cmake-3.8.2-win64-x64.zip', 'cmake.zip') }"
  unzip cmake.zip
  set PATH=%CD%\cmake-3.8.2-win64-x64\bin;%PATH%
  goto done
:skip_64
  powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://cmake.org/files/v3.8/cmake-3.8.2-win32-x86.zip', 'cmake.zip') }"
  unzip cmake.zip
  set PATH=%CD%\cmake-3.8.2-win32-x86\bin;%PATH%
:done
popd

mkdir build
pushd build
  cmake .. -G "NMake Makefiles"                     ^
           -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%  ^
           -DCMAKE_BUILD_TYPE=Release               ^
           -DBUILD_SHARED_LIBS=OFF
  cmake --build . --config Release --target INSTALL
popd
