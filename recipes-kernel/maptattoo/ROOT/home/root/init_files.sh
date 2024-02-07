#!/bin/sh -e

EPDC_FILE="/mnt/onboard/.EPDC_PANEL.txt"
if [ -e ${EPDC_FILE} ]
then
	mapfile file < ${EPDC_FILE}
	vcom_u=$(fw_printenv vcom)
	panel_u=$(fw_printenv panel)
	vcom_f=${file[0]}
	panel_f=${file[1]}
	
	if [ $vcom_u = "vcom="$vcom_f ]
	then
		echo "VCOM already set."
	else
		if [$vcom_f = ""]
		then
			echo "VCOM Default value"
		else
			echo "Setting VCOM."
			fw_setenv vcom $vcom_f
		fi
	fi
	
	if [ $panel_u = "panel="$panel_f ]
	then
		echo "Panel already set."
	else
	
		echo "Setting Panel."
		fw_setenv panel $panel_f
	fi
	
else
	echo "2600000">${EPDC_FILE}
	echo "ED060XH2C1">>${EPDC_FILE}	
fi


UUID_FILE="/mnt/onboard/UUID.txt"
if [ -e ${UUID_FILE} ]
then
	echo "UUID file already exist."
else
	echo "Creating UUID file."
	hex_uuid=$(hexdump /sys/bus/nvmem/devices/imx-ocotp0/nvmem)
	uuid="${hex_uuid:23:4}${hex_uuid:18:4}${hex_uuid:33:4}${hex_uuid:28:4}"
	echo $uuid >${UUID_FILE} 


fi

bootdelay=$(fw_printenv bootdelay)
if [ $bootdelay != "bootdelay=0" ]
then
	fw_setenv bootdelay 0
fi

reset_settings=$(fw_printenv reset_settings)
if [ $reset_settings = "reset_settings=yes" ]
then
	cp /home/root/settings.bkup /mnt/onboard/DATA/settings.seg
	rm /home/root/.lastparameters
	
fi

exit 0
