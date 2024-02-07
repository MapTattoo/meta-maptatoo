#!/bin/sh -e

minus_value=$(fw_printenv minus_value)
up_value=$(fw_printenv up_value)

#minus and plus key are swaped (+ and up are used)
if [ $minus_value = "minus_value=0" ] -a [ $up_value = "up_value=0" ]
then
	/home/root/maptattoo text "We are formatting your data partition. Please wait."
	mkfs -t vfat /dev/mmcblk0p6
fi


if [ -d "/mnt/onboard" ]
then
    echo "Directory /mnt/onboard exists."
else
    mkdir /mnt/onboard
fi

mount /dev/mmcblk0p6 /mnt/onboard 2>&1


outmount=$(dmesg | grep -i "(mmcblk0p6): Volume was not properly unmounted")


if [ ${#outmount} -gt 0 ]; then
        umount /mnt/onboard
        fsck -y /dev/mmcblk0p6
        mount /dev/mmcblk0p6 /mnt/onboard
fi


exit 0
