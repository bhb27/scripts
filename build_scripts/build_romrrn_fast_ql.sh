#!/bin/bash
# simple build sh ... alias br='/home/user/source_folder/device/motorola/quark/rootdir/etc/sbin/build.sh'

#timer counter
START=$(date +%s.%N);
START2="$(date)";
echo -e "\n build start $(date)\n";

#source tree folder yours machine source folder
FOLDER_L=~/android/Q;

echo -e "\nCommit?\n 1 = Yes\n"
read -r input1
echo -e "\nYou choose: $input1"

echo -e "\nMake clean?\n 1 = Yes\n"
read -r input2
echo -e "\nYou choose: $input2"

echo -e "\nMake boot or a ROM?\n 1 = Boot\n"
read -r input4
echo -e "\nYou choose: $input4"

cd $FOLDER_L || exit;

if [ "$input1" == "1" ]; then

	# changes to make the ROM the way I prefer

	folder="frameworks/base/";
	echo -e "\\n	In Folder $folder \\n"

	cd $folder || exit;
	git fetch https://github.com/fgl27/android_frameworks_base/ lineage-17.1 && git cherry-pick 79ea94f03b6f830278ddc315eb7f6c2a4c5ebf95^..0bd3bbd8fd4df54f8b03a8ddc75d0ef593134e3b
	cd - &> /dev/null || exit;

	echo -e "\\n	out Folder $folder"

	folder="packages/apps/Settings";
	echo -e "\\n	In Folder $folder \\n"

	cd $folder || exit;
	git fetch https://github.com/fgl27/android_packages_apps_Settings/ lineage-17.1 && git cherry-pick eb0197525076336b874fc8cfdc1b0a021a20092c^..b083dab2371bb996728c4e4e73449b1850448f55
	cd - &> /dev/null || exit;

	echo -e "\\n	out Folder $folder"

	folder="packages/apps/Updater";
	echo -e "\\n	In Folder $folder \\n"

	cd $folder || exit;
	git fetch https://github.com/fgl27/android_packages_apps_Updater/ lineage-17.1 && git cherry-pick 3eb8c4d89efde0a8676f11bff68d33fa5475da6e
	cd - &> /dev/null || exit;

	echo -e "\\n	out Folder $folder"

	#Disable nfc by default
	
	folder="packages/apps/Nfc";
	echo -e "\\n	In Folder $folder \\n"

	cd $folder || exit;
	git fetch https://github.com/fgl27/android_packages_apps_Nfc/ cm-14.1 && git cherry-pick 8314ecd4ff33f8d51228314849b6b9f88fae34cd
	cd - &> /dev/null || exit;

	echo -e "\\n	out Folder $folder"

	#Dialer: prevent touch events when the screen is off
	
	folder="packages/apps/Dialer";
	echo -e "\\n	In Folder $folder \\n"

	cd $folder || exit;
	git fetch https://github.com/fgl27/android_packages_apps_Dialer-1/ lineage-16.0 && git cherry-pick e04721c759828361ca243a021433146d51ed32bf
	cd - &> /dev/null || exit;

	echo -e "\\n	out Folder $folder"

	#Media updates
	folder="hardware/qcom-caf/apq8084/media";
	echo -e "\\n	In Folder $folder \\n"

	cd $folder || exit;
	git fetch https://github.com/fgl27/android_hardware_qcom_media lineage-16.0-caf-8084 && git cherry-pick 1b209940f1e72e247d1c627479e0b517aa62083f
	cd - &> /dev/null || exit;

	echo -e "\\n	out Folder $folder"

	#change rom type name
	folder="vendor/lineage";
	echo -e "\\n	In Folder $folder \\n"

	cd $folder || exit;
	git fetch https://github.com/fgl27/android_vendor_resurrection/ lineage-16.0_test  && git cherry-pick fc0d0a362c5b665896a75f539a66930cb276e885
	cd - &> /dev/null || exit;

	echo -e "\\n	out Folder $folder"

	folder="build/make";
	echo -e "\\n	In Folder $folder \\n"

	cd $folder || exit;
	git fetch https://github.com/fgl27/android_build/ lineage-17.1 && git cherry-pick 11e66bd490fb38b1c4ed1ab16abc03453fa21657^..da6edfd8d41393a689a6fe0664ceab57805c3837
	cd - &> /dev/null || exit;

	echo -e "\\n	out Folder $folder"

	folder="lineage-sdk";
	echo -e "\\n	In Folder $folder \\n"

	cd $folder || exit;
	git fetch https://github.com/fgl27/android_lineage-sdk/ lineage-17.1 && git cherry-pick 505a29852a9c85c4d72bcb8dfe506f1fe3c2b8cb
	cd - &> /dev/null || exit;

	echo -e "\\n	out Folder $folder"

	#prevent spam logs from wifi
	folder="system/connectivity/wificond/";
	echo -e "\\n	In Folder $folder \\n"

	cd $folder || exit;
	git fetch https://github.com/fgl27/system_connectivity_wificond/ master && git cherry-pick 95f35dd9ea309b1a544d762ac7e7b886a182fa54
	cd - &> /dev/null || exit;

	echo -e "\\n	out Folder $folder"

	#Missing old ril changes
	folder="hardware/ril";
	echo -e "\\n	In Folder $folder \\n"

	cd $folder || exit;
	git fetch https://github.com/LineageOS/android_hardware_ril lineage-16.0-caf && git cherry-pick b475875975d1b576511df391f75125593b3353ac
	cd - &> /dev/null || exit;

	echo -e "\\n	out Folder $folder"

	#Temp Missing sepolicy
	folder="device/qcom/sepolicy-legacy";
	echo -e "\\n	In Folder $folder \\n"

	cd $folder || exit;
	git fetch "https://github.com/LineageOS/android_device_qcom_sepolicy" refs/changes/19/268119/1 && git cherry-pick FETCH_HEAD
	cd - &> /dev/null || exit;

	echo -e "\\n	out Folder $folder"

	#Temp Fix WFD
	folder="frameworks/av";
	echo -e "\\n	In Folder $folder \\n"

	cd $folder || exit;
	git fetch "https://github.com/LineageOS/android_frameworks_av" refs/changes/98/266398/1 && git cherry-pick FETCH_HEAD
	git fetch "https://github.com/LineageOS/android_frameworks_av" refs/changes/99/266399/1 && git cherry-pick FETCH_HEAD
	git fetch "https://github.com/LineageOS/android_frameworks_av" refs/changes/00/266400/1 && git cherry-pick FETCH_HEAD
	git fetch "https://github.com/LineageOS/android_frameworks_av" refs/changes/01/266401/1 && git cherry-pick FETCH_HEAD
	git fetch "https://github.com/LineageOS/android_frameworks_av" refs/changes/02/266402/1 && git cherry-pick FETCH_HEAD
	git fetch "https://github.com/LineageOS/android_frameworks_av" refs/changes/03/266403/1 && git cherry-pick FETCH_HEAD
	git fetch "https://github.com/LineageOS/android_frameworks_av" refs/changes/04/266404/1 && git cherry-pick FETCH_HEAD
	git fetch "https://github.com/LineageOS/android_frameworks_av" refs/changes/05/266405/1 && git cherry-pick FETCH_HEAD
	git fetch "https://github.com/LineageOS/android_frameworks_av" refs/changes/06/266406/1 && git cherry-pick FETCH_HEAD
	cd - &> /dev/null || exit;

	echo -e "\\n	out Folder $folder"

fi

#Set Branch and update kernel and vendor before build
cd kernel/motorola/apq8084/
git checkout Q
git pull origin Q
cd - &> /dev/null || exit;

cd vendor/motorola/
git checkout Q
git pull origin Q
cd - &> /dev/null || exit;

# build SU
#export WITH_SU=true
export BUILD_USERNAME="fgl";
export BUILD_HOSTNAME="27";

export KBUILD_BUILD_USER="$BUILD_USERNAME"
export KBUILD_BUILD_HOST="$BUILD_HOSTNAME"

# Start the build
. build/envsetup.sh
if [ "$input2" == "1" ]; then
	make clean
fi

lunch lineage_quark-userdebug

if [ "$input4" == "1" ]; then
	time mka bootimage -j8 2>&1 | tee quark.txt
else
	time mka bacon -j8 2>&1 | tee quark.txt
fi

# final time display
END2="$(date)";
END=$(date +%s.%N);
echo -e "\nBuild start $START2";
echo -e "Build end   $END2 \n";
echo -e "\nTotal time elapsed: $(echo "($END - $START) / 60"|bc ):$(echo "(($END - $START) - (($END - $START) / 60) * 60)"|bc ) (minutes:seconds). \n";
