@echo off
setlocal

rmdir /s /q libcv

rmdir /s /q build
mkdir build
cd build
cmake -D BUILD_SHARED_LIBS=ON ^
-D CMAKE_INSTALL_PREFIX=..\libcv ^
-D BUILD_LIST=calib3d,core,features2d,highgui,imgcodecs,imgproc,video,videoio ^
-D BUILD_opencv_world=ON ^
-D CMAKE_CXX_STANDARD=20 ^
-G "Visual Studio 17 2022" ^
..
for /f "tokens=2 delims==" %%a in ('wmic cpu get NumberOfLogicalProcessors /value ^| find "="') do set /a LOGICAL_CORES=%%a-1
cmake --build . --config debug -j %LOGICAL_CORES%
cmake --build . --config release -j %LOGICAL_CORES%
cmake --build . --config debug --target install
cmake --build . --config release --target install
cd ..

exit /b