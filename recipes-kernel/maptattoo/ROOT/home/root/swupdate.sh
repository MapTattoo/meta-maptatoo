#!/bin/sh -e

FILE=(/mnt/onboard/*.swu)
n=${#FILE[@]}

if [ $n -ge 2 ]
then
	echo "Multiple update files detected."
	for f in ${FILE[@]}
	do
		rm $f
	done
	~/./maptattoo textoff "Mulitple update files detected. Removing all update files. Please only add 1 upgrade file at a time. You can restart your device."
fi


TRY_COUNT_FILE=~/count_file.txt
try_count=$(cat $TRY_COUNT_FILE)

if [ -e ${FILE} ]
then
	try_count=$((try_count+1))
	echo $try_count>$TRY_COUNT_FILE
	
	if [ $try_count -ge 3 ]
	then
		rm $FILE
		echo 0 > $TRY_COUNT_FILE
		~/./maptattoo textoff "Update file corrupted detected. File deleted. Please restart your device and try again."
	fi
		 
	echo "Update file detected."
	~/./maptattoo text "Updating. Please do not turn off your device. This can take several minutes."

	bootSource=$(fw_printenv bootslot)
	bootslot="bootslot=dualA"
	
	uboot_version=$(fw_printenv "u-boot_version")
	update_version="u-boot_version=238.1.0"
	
	echo $bootSource
	echo $uboot_version
	
	if [ $uboot_version = $update_version ]
	then
		if [ $bootSource = $bootslot ]
		then
			echo "Updating bootB."
			timeout 600 swupdate -e u-boot_ok,bootA -k ~/public.pem -i $FILE || ~/./maptattoo textoff "ERROR: Update failed. Please restart your device."
		else
			echo "Updating bootA."
			timeout 600 swupdate -e u-boot_ok,bootB -k ~/public.pem -i $FILE || ~/./maptattoo textoff "ERROR: Update failed. Please restart your device."
		fi
	else
		if [ $bootSource = $bootslot ]
		then
			echo "Updating bootB."
			timeout 600 swupdate -e u-boot_old,bootA -k ~/public.pem -i $FILE || ~/./maptattoo textoff "ERROR: Update failed. Please restart your device."
		else
			echo "Updating bootA."
			timeout 600 swupdate -e u-boot_old,bootB -k ~/public.pem -i $FILE || ~/./maptattoo textoff "ERROR: Update failed. Please restart your device."
		fi
	fi
	
	echo "Updates done, removing file."
	rm ${FILE}
	echo "File removed."
	
	echo 0 > $TRY_COUNT_FILE
	
	~/./maptattoo textoff "Your MAPTATTOO is up to date. Please restart your device."
fi


exit 0
