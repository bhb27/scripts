#!/bin/bash
# this files in under bluid forlder in a kernel that I build https://github.com/bhb27/BHB27Kernel/blob/NEW/build/how_to_build_this.sh
##############################################################################################
#
# how to build BHB27 kernel, kernel for Moto MAXX apq8084
# the things to edit here are:
#
# $CROSS_COMPILE, path to yours toolchain
# $FOLDER path of the kernel tree on your build machine
# and $ZIPNAME name of the install zip
#
# you may config ./bashrc so the kernel can be build with one command on the terminal by:
#
# placing a line like this... alias bk='home/your_user/kernel_folder/build/how_to_build_this.sh' ... ex..
# alias bk='/home/fella/m/kernel1/motorola/apq8084/build/how_to_build_this.sh'
# place it to the end of ./bashrc file that is hide under home *after save ./bashrc restart the terminal
#
# Is need the below lib and bin on the build machine so "sudo apt-get install" the below if you don't, most ROM need this also, if you use the machine for ROM build you must have it
#
#sudo apt-get update
#sudo apt-get install ccache lzop liblz4-* lzma* liblzma*
# + is need java 
#sudo apt-get install  openjdk-7-jre openjdk-7-jdk
# Check the /build/build_log.txt for error and warning...
#
# Extras...
#
# to compile wifi from a outside folder, tested but need to make some changes if will use it, like cp qcacld-2.0 to temp folder so it get clean before it build...
#
# make -j4 -C temp M=/home/fella/qcacld-2.0 O=/home/fella/tempp ARCH=arm CROSS_COMPILE=/home/fella/m/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin/arm-linux-androideabi- KCFLAGS=-mno-android modules WLAN_ROOT=/home/fella/qcacld-2.0 MODNAME=wlan BOARD_PLATFORM=apq8084 CONFIG_QCA_CLD_WLAN=m WLAN_OPEN_SOURCE=1
#
##############################################################################################
#timer counter
START=$(date +%s.%N);
START2="$(date)";
echo -e "\nBHB27-Kernel build start $(date)\n";

#kernel folder yours folder
FOLDER=/home/bhb27/android/apq8084/;
cd $FOLDER;

# CROSS_COMPILE toolchain folder
export CROSS_COMPILE=/home/bhb27/android/m/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin/arm-eabi-

#kernel zip name
ZIPNAME="BHB27-Kernel-V202-3-M_T.zip";

#arch and out folder
export ARCH=arm
export KBUILD_OUTPUT=./build/temp

# Clean temp directory
echo -e "\nCleaning temp directory\n";
rm -rf ./build/temp
rm -rf ./build/bhbkernel/modules/*
mkdir ./build/temp

# Making started
make clean && make mrproper

# change -j4 to -j# number of cores to do the job... the log.txt here are the build logs to check if error stop the kernel build
time make quark_defconfig && time make -j4 2>&1 | tee ./build/build_log.txt && ./build/dtbToolCM -2 -o ./build/temp/arch/arm/boot/dt.img -s 4096 -p ./build/temp/scripts/dtc/ ./build/temp/arch/arm/boot/dts/
lz4 -9 ./build/temp/arch/arm/boot/dt.img

# check if kernel build ok
if [ ! -e ./build/temp/arch/arm/boot/zImage ]; then
	echo -e "\n${bldred}Kernel Not build! Check build_log.txt${txtrst}\n"
	grep -B 3 -C 6 -r error: build/build_log.txt
	grep -B 3 -C 6 -r warn build/build_log.txt
	exit 1;
else if [ ! -e ./build/temp/arch/arm/boot/dt.img.lz4 ]; then
	echo -e "\n${bldred}dtb Not build! Check build_log.txt${txtrst}\n"
	grep -B 3 -C 6 -r error: build/build_log.txt
	grep -B 3 -C 6 -r warn build/build_log.txt
	exit 1;
else
	# moving modules to zip folder
	cd ./build/temp
	find  -iname '*.ko' -exec cp -rf '{}' ../bhbkernel/modules/ \;
	cd -
	# strip modules 
	${CROSS_COMPILE}strip --strip-unneeded ./build/bhbkernel/modules/*
	mkdir ./build/bhbkernel/modules/qca_cld
	mv ./build/bhbkernel/modules/wlan.ko ./build/bhbkernel/modules/qca_cld/qca_cld_wlan.ko
fi;
fi;

# check if wifi build ok
if [ ! -e ./build/bhbkernel/modules/qca_cld/qca_cld_wlan.ko ]; then
	echo -e "$\n{bldred}Wifi module not build check build_log.txt${txtrst}\n"
	grep -B 3 -C 6 -r error: build/build_log.txt
	grep -B 3 -C 6 -r warn build/build_log.txt
	exit 1;
else
	cp -rf ./build/temp/arch/arm/boot/zImage ./build/bhbkernel/zImage
	cp -rf ./build/temp/arch/arm/boot/dt.img.lz4 ./build/bhbkernel/dtb
	rm -rf ./build/bhbkernel/*.zip
	cd ./build/bhbkernel/
	zip -r9 BHB27-Kernel * -x README .gitignore modules/.gitignore ZipScriptSign/* ZipScriptSign/bin/* how_to_build_this.sh
	mv BHB27-Kernel.zip ./ZipScriptSign
	./ZipScriptSign/sign.sh test BHB27-Kernel.zip
	rm -rf ./ZipScriptSign/BHB27-Kernel.zip
	mv ./ZipScriptSign/BHB27-Kernel-signed.zip ./$ZIPNAME
	cd -
	echo -e "\nKernel Build OK zip file at... $FOLDER build/bhbkernel/$ZIPNAME \n";
fi;

# final time display *cosmetic...
END2="$(date)";
END=$(date +%s.%N);
echo -e "\nBuild start $START2";
echo -e "Build end   $END2 \n";
echo -e "\n${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($END - $START) / 60"|bc ):$(echo "(($END - $START) - (($END - $START) / 60) * 60)"|bc ) (minutes:seconds). ${txtrst}\n";

