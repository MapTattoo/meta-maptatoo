SUMMARY = "Maptattoo TPS65185 driver recipe"
DESCRIPTION = "Recipe created by bitbake-layers"
LICENSE = "MIT"


FILESEXTRAPATHS:prepend := "${THISDIR}:"
SRC_URI += "file://maptattoo_V238_1_0.patch;striplevel=0"
SRC_URI += "file://fragment.cfg"




do_configure:append() {
        #this is run from
        #./tmp/work/imx6qsabresd-poky-linux-gnueabi/linux-imx/3.10.53-r0/git
        #./tmp/work/imx6sllevk-poky-linux-gnueabi/linux-imx/5.10.52+gitAUTOINC+a11753a89e-r0/git
        cat ../fragment.cfg >> ${B}/.config
}






#SRC_URI += "file://maptattoo_defconfig"
#unset KBUILD_DEFCONFIG

#do_configure_prepend () {
#        cp "${WORKDIR}/maptattoo_defconfig" "${B}/.config"  
#}
