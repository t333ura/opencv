#!/bin/bash -e

rm -rf libcv

rm -rf build
mkdir build
cd build
cmake -D BUILD_SHARED_LIBS=ON \
-D CMAKE_INSTALL_PREFIX=../libcv \
-D BUILD_LIST=calib3d,core,features2d,highgui,imgcodecs,imgproc,video,videoio \
-D BUILD_opencv_world=ON \
-D CMAKE_CXX_STANDARD=20 \
-G 'Visual Studio 17 2022' \
..
cmake --build . -- -j $(($(nproc) - 1)) --config release
cmake --build .  --target install --config release
cd ..
