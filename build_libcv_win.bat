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
cmake --build . -- -j $(($(wmic cpu get NumberOfLogicalProcessors) - 1)) --config debug
cmake --build . -- -j $(($(wmic cpu get NumberOfLogicalProcessors) - 1)) --config release
cmake --build .  --target install --config debug
cmake --build .  --target install --config release
cd ..

exit /b