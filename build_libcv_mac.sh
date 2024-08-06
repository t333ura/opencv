#!/opt/homebrew/bin/zsh -e

rm -rf libcv

rm -rf build_arm64
mkdir build_arm64
cd build_arm64
cmake -D BUILD_SHARED_LIBS=ON \
-D CMAKE_INSTALL_PREFIX=../libcv/arm64 \
-D BUILD_LIST=calib3d,core,features2d,highgui,imgcodecs,imgproc,video,videoio \
-D BUILD_opencv_world=ON \
-D CMAKE_CXX_STANDARD=17 \
-D CMAKE_OSX_ARCHITECTURES=arm64 \
..
cmake --build -- -j $(($(sysctl -n hw.logicalcpu) - 1)) --config release
cmake --build . --target install --config release
cd ..

rm -rf build_x86_64
mkdir build_x86_64
cd build_x86_64
cmake -D BUILD_SHARED_LIBS=ON \
-D CMAKE_INSTALL_PREFIX=../libcv/x86_64 \
-D BUILD_LIST=calib3d,core,features2d,highgui,imgcodecs,imgproc,video,videoio \
-D BUILD_opencv_world=ON \
-D CMAKE_CXX_STANDARD=17 \
-D CMAKE_OSX_ARCHITECTURES=x86_64 \
..
cmake --build -- -j $(($(sysctl -n hw.logicalcpu) - 1)) --config release
cmake --build . --target install --config release
cd ..
