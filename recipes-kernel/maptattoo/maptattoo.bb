SUMMARY = "Maptattoo Soft Recipe"
DESCRIPTION = "Recipe created by bitbake-layers"
LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}:"

SRC_URI += "file://ROOT/"

RDEPENDS:${PN} += "bash"

INSANE_SKIP_${PN} += " ldflags"
INHIBIT_PACKAGE_STRIP ="1"
INHIBIT_SYSROOT_STRIP ="1"
SOLIBS = ".so"
FILES_SOLIBSDEV = ""

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install() {
	install -d ${D}/home/root/
	install -m 744 "${WORKDIR}/ROOT/home/root/maptattoo.sh" "${D}/home/root/"
	install -m 744 "${WORKDIR}/ROOT/home/root/maptattoo" "${D}/home/root/"
	install -m 444 "${WORKDIR}/ROOT/home/root/public.pem" "${D}/home/root/"
#	install -m 744 "${WORKDIR}/ROOT/home/root/encrypt.sh" "${D}/home/root/"
	install -m 666 "${WORKDIR}/ROOT/home/root/settings.seg" "${D}/home/root/"
	install -m 666 "${WORKDIR}/ROOT/home/root/settings.bkup" "${D}/home/root/"
	install -m 744 "${WORKDIR}/ROOT/home/root/loadcharts.sh" "${D}/home/root/"
	install -m 666 "${WORKDIR}/ROOT/home/root/count_file.txt" "${D}/home/root/"
	install -m 744 "${WORKDIR}/ROOT/home/root/mount.sh" "${D}/home/root/"
	install -m 744 "${WORKDIR}/ROOT/home/root/swupdate.sh" "${D}/home/root/"
	install -m 744 "${WORKDIR}/ROOT/home/root/init_files.sh" "${D}/home/root/"
	
	install -d ${D}/home/root/TCD/
	install -m 666 "${WORKDIR}/ROOT/home/root/TCD/CHS.tcd" "${D}/home/root/TCD/"
	install -m 666 "${WORKDIR}/ROOT/home/root/TCD/NOAA.tcd" "${D}/home/root/TCD/"
	
	install -d ${D}/home/root/TRACES/
	
	install -d ${D}${base_libdir}/firmware/imx/epdc/
	
	install -m 644 "${WORKDIR}/ROOT/lib/firmware/imx/epdc/epdc_E60U4_R307.fw" "${D}${base_libdir}/firmware/imx/epdc/"
	install -m 644 "${WORKDIR}/ROOT/lib/firmware/imx/epdc/epdc_E60U6_R411.fw" "${D}${base_libdir}/firmware/imx/epdc/"
	install -m 644 "${WORKDIR}/ROOT/lib/firmware/imx/epdc/epdc_E60U6_R415.fw" "${D}${base_libdir}/firmware/imx/epdc/"
	
	install -d ${D}/usr/lib/
	install -m 644 "${WORKDIR}/ROOT/usr/lib/libgdal.so.20" "${D}/usr/lib/"
	install -m 644 "${WORKDIR}/ROOT/usr/lib/libmupdf.a" "${D}/usr/lib/"
	install -m 644 "${WORKDIR}/ROOT/usr/lib/libmupdf-third.a" "${D}/usr/lib/"
	install -m 644 "${WORKDIR}/ROOT/usr/lib/libpng16.so.16" "${D}/usr/lib/"
	install -m 644 "${WORKDIR}/ROOT/usr/lib/libtcd.so.1" "${D}/usr/lib/"
	install -m 644 "${WORKDIR}/ROOT/usr/lib/libxtide.so.1" "${D}/usr/lib/"
	install -m 644 "${WORKDIR}/ROOT/usr/lib/libz.so" "${D}/usr/lib/"

	install -d ${D}/usr/bin/
	install -m 744 "${WORKDIR}/ROOT/usr/bin/imxutil" "${D}/usr/bin/"	
	install -m 744 "${WORKDIR}/ROOT/usr/bin/timezone21.bin" "${D}/usr/bin/"

	install -d ${D}/usr/share/
	cp -r "${WORKDIR}/ROOT/usr/share/zoneinfo/" "${D}/usr/share/"
}

FILES:${PN} += "/home/root/*"
FILES:${PN} += "/home/root/TCD/*"
FILES:${PN} += "${base_libdir}/firmware/imx/epdc/*"
FILES:${PN} += "/usr/lib/*"
FILES:${PN} += "/usr/bin/*"
FILES:${PN} += "/usr/share/*"
