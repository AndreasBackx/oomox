#!/usr/bin/env bash
#set -x
set -ueo pipefail

# @TODO: mb rewrite it as a Makefile

srcdir=$(readlink -e "$1")
#pkgdir=$(readlink -e "$2")
pkgdir="${2}"

if [[ -d "${pkgdir}/opt/oomox" ]] ; then
	rm -r "${pkgdir}/opt/oomox"
fi
mkdir -p "${pkgdir}/opt/oomox"

cd "${srcdir}"
cp -prf \
	./CREDITS \
	./LICENSE \
	./README.md \
	./colors \
	./gui.sh \
	./oomox_gui \
	./plugins \
	./po \
	./po.mk \
	./terminal_templates \
		"${pkgdir}/opt/oomox"
rm -rf "${pkgdir}/opt/oomox/plugins/theme_materia/materia-theme/".git*
rm -rf "${pkgdir}/opt/oomox/plugins/theme_oomox/gtk-theme/".git*
rm -rf "${pkgdir}/opt/oomox/plugins/theme_oomox/gtk-theme/".editorconfig
rm -rf "${pkgdir}/opt/oomox/plugins/theme_oomox/gtk-theme/".*.yml
rm -r "${pkgdir}/opt/oomox/plugins/theme_oomox/gtk-theme/"{D,d}ocker*
rm -r "${pkgdir}/opt/oomox/plugins/theme_oomox/gtk-theme/"maintenance*
rm -r "${pkgdir}/opt/oomox/plugins/theme_oomox/gtk-theme/"screenshot*
rm -r "${pkgdir}/opt/oomox/plugins/theme_oomox/gtk-theme/"test*
rm -rf "${pkgdir}/opt/oomox/plugins/icons_archdroid/archdroid-icon-theme/".git*
rm -rf "${pkgdir}/opt/oomox/plugins/icons_gnomecolors/gnome-colors-icon-theme/".git*
rm -rf "${pkgdir}/opt/oomox/plugins/oomoxify/".git*

cd "${pkgdir}/opt/oomox/"
# will update ./po and produce ./locale dir:
make -f po.mk install
rm "${pkgdir}/opt/oomox/po.mk"

mkdir -p "${pkgdir}/usr/bin/"
cp "${srcdir}/packaging/bin/"* "${pkgdir}/usr/bin/"

mkdir -p "${pkgdir}/usr/share/applications/"
cp "${srcdir}/packaging/com.github.actionless.oomox.desktop" "${pkgdir}/usr/share/applications/"

mkdir -p "${pkgdir}/usr/share/icons/hicolor/"{64x64,128x128,666x666}/apps/
install -Dp -m 644 "${srcdir}/packaging/com.github.actionless.oomox-64.png"  "${pkgdir}/usr/share/icons/hicolor/64x64/apps/com.github.actionless.oomox.png"
install -Dp -m 644 "${srcdir}/packaging/com.github.actionless.oomox-128.png" "${pkgdir}/usr/share/icons/hicolor/128x128/apps/com.github.actionless.oomox.png"
install -Dp -m 644 "${srcdir}/packaging/com.github.actionless.oomox-666.png" "${pkgdir}/usr/share/icons/hicolor/666x666/apps/com.github.actionless.oomox.png"

exit 0
