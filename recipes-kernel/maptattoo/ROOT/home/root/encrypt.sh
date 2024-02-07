#!/bin/sh -e

FILES="/mnt/onboard/CHARTS/*/*.dec"
echo ${FILES}


UUID_FILE="/mnt/onboard/UUID.txt"
if [ -e ${UUID_FILE} ]
then
	uuid=$(cat ${UUID_FILE})
else
	hex_uuid=$(hexdump /sys/bus/nvmem/devices/imx-ocotp0/nvmem)
	uuid="${hex_uuid:23:4}${hex_uuid:18:4}${hex_uuid:33:4}${hex_uuid:28:4}"
	echo $uuid >${UUID_FILE}
fi

for FILE in ${FILES}; do
	~/./maptattoo text $FILE" CHARTS Encryption started."
	OUTFILE="${FILE[@]/.dec/}-${uuid:0:4}-${uuid:4:4}-${uuid:8:4}-${uuid:12:4}.key"
	imxutil -e -o ${OUTFILE} -p $uuid ${FILE}
	rm ${FILE}

done;

~/./maptattoo text "Encryption DONE."

exit 0
