export MINSDKVERSION=29
for ABI in armeabi-v7a	 arm64-v8a	x86	x86_64	
do
    rm -rvf build
    mkdir -v build
    cd build
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake     -DANDROID_ABI=$ABI       -DANDROID_PLATFORM=android-$MINSDKVERSION ..
    if ! cmake --build .
    then
        exit
    fi
    mkdir -p ../libs/$ABI
    mv -v rt-neural-generic/rt-neural-generic.so ../libs/$ABI/
    cd ..
done

cp -rv libs/* ~/projects/amp-rack/app/src/main/jniLibs/
echo finished build at `date`
