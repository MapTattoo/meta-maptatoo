FILESEXTRAPATHS:prepend := "${THISDIR}:"
SRC_URI += "file://rc.local"

do_install:append() {
        #this is run from
        #./tmp/work/imx6sllevk-poky-linux-gnueabi/u-boot-imx/2022.04-r0/image/etc
        echo "/dev/mmcblk0 0xC0000 0x2000" > ${D}${sysconfdir}/fw_env.config
        echo "${MACHINE} ${SWU_HW_REV}" > ${D}${sysconfdir}/hwrevision
        install -m 744 "${WORKDIR}/rc.local" ${D}${sysconfdir}/rc.local
}



