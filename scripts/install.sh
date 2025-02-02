#!/bin/env bash

# author: Raxen001
# email: raxen001@tutamail.com
# notes
# https://github.com/JaKooLit/Fedora-Hyprland/blob/main/install-scripts/Global_functions.sh
# https://github.com/smittix/fedorable/blob/main/fedorable.sh

# TODO:
#   INSTALL PRETTIERD
#   INSTALL oxker
#   INSTALL NVIDIA, AMD INSTALL
echo "!IMPORTANT this script was made by Raxen when he thought"
echo "He was only using to use Fedora based distros"

# set parallel downloads
echo "max_parallel_downloads=20" >> /etc/dnf/dnf.conf
sudo dnf update -y # and reboot if you are not on the latest kernel
pkgs=(
	alacritty
	zsh
	neovim
	gopass
	mpv
	fzf
	ripgrep
	jq
	hugo
	tldr
	linux-firmware
	acpi
	nnn
	fd-find
	)
nvidia_pkgs=(
	akmod-nvidia
	xorg-x11-drv-nvidia-cuda 
	)
copr=(
	zellij
	hack-nerd-fonts
	)
# flatpaks aren't all here
flatpak=(
	cafe.avery.Delfin
	com.github.iwalton3.jellyfin-media-player
	com.github.taiko2k.tauonmb
	com.github.tchx84.Flatseal
	com.mattjakeman.ExtensionManager
	# com.quexten.Goldwarden
	com.rtosta.zapzap
	com.tutanota.Tutanota
	dev.vencord.Vesktop
	io.github.flattool.Warehouse
	io.gitlab.gregorni.Letterpress
	it.fabiodistasio.AntaresSQL
	org.chromium.Chromium
	org.chromium.Chromium.Codecs
	org.freedesktop.Platform
	org.freedesktop.Platform.GL.default
	org.freedesktop.Platform.GL.default
	org.freedesktop.Platform.GL.default
	)
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
for app in "${flatpak[@]}";
do
	flatpak install flathub "$app"
done

# TODO:
# INSTALL 
# 	zsh & chsh
#	RPMFUSION
#	MULTIMEDIA CODECS
# 	NVIDIA
# 	COPR - (ZELLIJ, HACK NERD FONTS)
#	PACKAGES
#	FLATPAKS
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager --enable fedora-cisco-openh264
sudo dnf update @core
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf update @sound-and-video
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld
sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
sudo dnf swap mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686
sudo dnf swap mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686
sudo dnf install libva-nvidia-driver.{i686,x86_64}
sudo dnf install rpmfusion-nonfree-release-tainted
sudo dnf --repo=rpmfusion-nonfree-tainted install "*-firmware"


nvidia=$(lspci | grep "VGA" | grep "NVIDIA")
if [[ -n $nvidia ]]; then
    echo "Nvidia card is present $nvidia"
fi
amd=$(lspci | grep "VGA" | grep "AMD")
if [[ -n $amd ]]; then
    echo "Nvidia card is present $amd"
fi
