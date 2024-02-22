#!/bin/bash

# Check if fzf is installed
if ! command -v fzf &> /dev/null
then
    echo "fzf could not be found, installing now..."
    sudo apt update
    sudo apt install -y fzf
fi

# Common packages
common_packages=(
  # System utilities
  sudo
  xorg
  ssh
  git
  numlockx
  systemd-timesyncd
  p7zip
  p7zip-full
  lhasa
  lzip
  lzma
  lzop
  lzd
  zstd
  xz-utils
  zutils
  openvpn
  tree
  unace
  w3m
  xclip
  gnome-disk-utility
  gparted

  # Desktop environment
  lxappearance

  # Multimedia
  pulseaudio
  volumeicon-alsa
  pavucontrol
  smplayer

  # File managers
  pcmanfm

  # Text editors
  vim
  nano

  # Terminal emulator
  xterm

  # Application launcher
  rofi

  # Compositor
  picom

  # Image viewer
  feh
  mirage

  # Screen capture
  scrot

  # Screen locker
  xautolock
  slock

  # Network
  network-manager
  network-manager-gnome
  avahi-daemon
  gvfs-backends
  gvfs-fuse
  cifs-utils
  smbclient

  # Themes and icons
  numix-gtk-theme
  numix-icon-theme

  # Fonts
  fonts-firacode
  fonts-noto-cjk
  fonts-open-sans

  # Programming
  python3
  python3-pip
  python3-venv
  python3-tk
  default-jdk
  default-jdk-headless
  default-jre
  default-jre-headless

  # Document viewer
  evince

  # Archive manager
  engrampa

  # Window manager
  lxdm
)

# BSPWM-specific packages
bspwm_packages=(
  bspwm
  sxhkd
  polybar
)

# Openbox-specific packages
openbox_packages=(
  openbox
  tint2
  menu
)

# General apps
general_apps=(
  ssh
  git
  aria2
  axel
  ranger
  vim
  neovim
  kitty
  nano
  tree
  xterm
  fonts-firacode
  fonts-noto-cjk
  fonts-open-sans
  python3
  python3-pip
  python3-venv
  python3-tk
  default-jdk
  default-jdk-headless
  default-jre
  default-jre-headless
  firefox-esr
)

# Function to install packages
install_packages() {
  sudo apt update
  sudo apt install -y "${@}"
}

# Function to change sources.list
change_sources_list() {
  choice=$(echo -e "linuxdebian.mx - Powered by Last Dragon - AMD64\ndeb.debian.org\nReturn to main menu" | fzf --reverse)

  case $choice in
    "linuxdebian.mx - Powered by Last Dragon - AMD64")      
      echo "
deb http://repo.linuxdebian.mx/debian/ bookworm main non-free-firmware non-free contrib
deb-src http://repo.linuxdebian.mx/debian/ bookworm main non-free-firmware non-free contrib

deb http://security.debian.org/debian-security bookworm-security main non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main non-free-firmware

deb http://repo.linuxdebian.mx/debian/ bookworm-updates main non-free-firmware contrib
deb-src http://repo.linuxdebian.mx/debian/ bookworm-updates main non-free-firmware contrib
" | sudo tee /etc/apt/sources.list
      sudo apt update    
      ;;
    "deb.debian.org")
      echo "
deb http://deb.debian.org/debian/ bullseye main non-free contrib
deb-src http://deb.debian.org/debian/ bullseye main non-free contrib

deb http://security.debian.org/debian-security bullseye-security main contrib non-free
deb-src http://security.debian.org/debian-security bullseye-security main contrib non-free

deb http://deb.debian.org/debian/ bullseye-updates main contrib non-free
deb-src http://deb.debian.org/debian/ bullseye-updates main contrib non-free
" | sudo tee /etc/apt/sources.list
      sudo apt update
      ;;
    "Return to main menu")
      return 0
      ;;
    *)
      echo "Invalid choice. Please enter a valid option."
      ;;
  esac
}

# Main menu
while true; do
  choice=$(echo -e "Change sources.list\nInstall BSPWM\nInstall Openbox\nInstall General Apps\nExit" | fzf --reverse)

  case $choice in
    "Change sources.list")
      change_sources_list
      ;;
    "Install BSPWM")
      install_packages "${common_packages[@]}" "${bspwm_packages[@]}"
      ;;
    "Install Openbox")
      install_packages "${common_packages[@]}" "${openbox_packages[@]}"
      ;;
    "Install General Apps")
      install_packages "${general_apps[@]}"
      ;;
    "Exit")
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please enter a valid option."
      ;;
  esac
done
