#!/bin/bash

echo 121 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio121/direction
echo 1 > /sys/class/gpio/gpio121/value
sleep 0.05
echo 0 > /sys/class/gpio/gpio121/value 

rmmod g_mass_storage

up_value=$(fw_printenv up_value)
if [ $up_value = "up_value=0" ]
then
	/home/root/maptattoo usb "Please connect MAPTATTOO to your computer. MAPTATTOO will appear as a  USB thumb drive and you can start uploading and downloading files. When you are done, just turn MAPTATTOO off."
fi



sh /home/root/loadcharts.sh




export HFILE_PATH=/home/root/TCD

touch /tmp/MAPTATTOO_STARTED
echo "0" > /tmp/MAPTATTOO_STARTED

if grep -q /dev/mmcblk0p6 /proc/mounts; then
        mysize=$(stat --format=%s "/mnt/onboard/DATA/settings.seg")
        if [ $mysize -ge 200 ]; then
                sed -i 's/\r//g' /mnt/onboard/DATA/settings.seg
                cp /mnt/onboard/DATA/settings.seg /home/root
        fi
        mysize=$(stat --format=%s "/home/root/.maptattoo.gpx")
        if [ $mysize -ge 2 ]; then
                cp /home/root/.maptattoo.gpx /mnt/onboard/DATA
        fi
fi 




while :
do
	if grep -q /dev/mmcblk0p6 /proc/mounts; then
        /home/root/maptattoo 2> /dev/null
        pgmExit=$?
        hasStarted=`cat /tmp/MAPTATTOO_STARTED`
        if [ $hasStarted -eq 0 ]; then
        	/home/root/maptattoo usb "Your MAPTATTOO has not started properly. Please refer to our documentation to troubleshoot: https://www.maptattoo.com/doc/troubleshooting/"
        fi
	else
        /home/root/maptattoo textoff "Your MAPTATTOO could not access your data. Try and restart. If it does not solve the issue, contact our support."
        break
    fi
	case $pgmExit in
		1) 
			umount /mnt/onboard
			sleep 8;;
		2)
			cp /home/root/*.log /mnt/onboard/DATA
			cp /home/root/TRACES/* /mnt/onboard/DATA/TRACES
			cp /home/root/settings.seg /mnt/onboard/DATA/settings.seg
			rm /home/root/TRACES/*
			/home/root/maptattoo usb "Please connect MAPTATTOO to your computer. MAPTATTOO will appear as a  USB thumb drive and you can start uploading and downloading files. When you are done, just turn MAPTATTOO off.";;
		9) break;;
	esac 
	sleep 1

done
