findCharvPos()
{   
    str=$1
    str_find=$2
    pos=`echo "$str" | awk -F ${str_find} '{print length($0)-length($NF)}'`
    echo $pos
}


for FILE in {/mnt/onboard/*.zip,/mnt/onboard/*/*.zip}; do
	echo "FILE= ${FILE}";
	vPos=$( findCharvPos "$FILE" "/" )
	uPos=$( findCharvPos "$FILE" "_" )
	#echo "vPos= $vPos"
	#echo "uPos= $uPos"
	chartname=${FILE:${vPos}:6}
	#echo "chartname= ${chartname}"
	if [ $uPos -ge 5 ]; then
		#good zip
		~/maptattoo text "We are preparing your charts for $chartname. Please wait..."
		if [ -d "/mnt/onboard/CHARTS/$chartname" ]; then
			rm -r "/mnt/onboard/CHARTS/$chartname"
		fi
		mkdir "/mnt/onboard/CHARTS/$chartname"
		unzip "${FILE}" -d "/mnt/onboard/CHARTS/$chartname"
		rm "${FILE}"
	fi
done;
