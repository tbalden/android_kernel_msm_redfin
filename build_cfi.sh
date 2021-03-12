#!/bin/bash

echo
echo "Clean Build Directory"
echo 

#make clean && make mrproper
#rm -rf ./out_cfi

echo
echo "Issue Build Commands"
echo

mkdir -p out_cfi
export ARCH=arm64
export SUBARCH=arm64
BASE_PATH=/home/android/pixel
EXT_UTILS=$BASE_PATH/wahoo-kernel-tools/bin
export CLANG_PATH=$BASE_PATH/clang-10/bin
export PATH=${CLANG_PATH}:${EXT_UTILS}:${PATH}
export DTC_EXT=$EXT_UTILS/dtc-aosp
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=$BASE_PATH/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CROSS_COMPILE_COMPAT=$BASE_PATH/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-


export CLANG_AR=$CLANG_PATH/llvm-ar
export CLANG_CC=$CLANG_PATH/clang
export CLANG_LD=$CLANG_PATH/ld.lld
export CLANG_LDLTO=$CLANG_PATH/ld.lld
export CLANG_NM=$CLANG_PATH/llvm-nm


echo "Generating binary conversions"
#cd binaries
#./convert
#cd ..

echo
echo "Set DEFCONFIG"
echo 

make CC=$CLANG_CC LD=$CLANG_LD LDLTO=$CLANG_LD AR=$CLANG_AR NM=$CLANG_NM OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip O=out_cfi cleanslate_cfi_defconfig


echo
echo "Build The Good Stuff"
echo 

make CC=$CLANG_CC LD=$CLANG_LD LDLTO=$CLANG_LD AR=$CLANG_AR NM=$CLANG_NM OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip O=out_cfi -j4