SUMMARY = "Disable Backlight at boot"
DESCRIPTION = "Recipe created by bitbake-layers"
LICENSE = "MIT"

SYSTEMD_AUTO_ENABLE:systemd-backlight = "disable"
SYSTEMD_AUTO_ENABLE:systemd-networkd = "disable"

