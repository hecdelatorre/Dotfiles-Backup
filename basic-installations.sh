#!/bin/bash

# Check if fzf is installed
if ! command -v fzf &> /dev/null
then
    echo "fzf could not be found, installing now..."
    sudo apt update
    sudo apt install -y fzf
fi

# Check if the .config folder exists, if it does not exist, create it.
config="$HOME/.config/"
if [ ! -d "$config" ]; then
  mkdir "$config"
fi

# Check if the tipography folder exists, in case it does not exist, create it.
tipography_folder="$HOME/.local/share/fonts"
if [ ! -d "$tipography_folder" ]; then
  mkdir -p "$tipography_folder"
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

# Function to copy kitty configuration
copy_kitty_configuration() {
  if [ -d "$config/kitty" ]; then
      rm -rf "$config/kitty"
  fi
  sudo apt install -y kitty
  curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/config-files/kitty.tar.xz | tar Jxf - -C "$config"
}

# Function to copy xterm configuration
copy_xterm_configuration() {
  tipography_ibm="$tipography_folder/IBM-Plex-Sans"
  if [ ! -d "$tipography_ibm" ]; then
    curl -fsSL https://github.com/IBM/plex/releases/download/v6.4.0/OpenType.zip -o tem.zip
    unzip -q tem.zip 
    rm -f tem.zip 
    mv -f OpenType "$tipography_ibm"
  fi
  sudo apt install -y xterm
  curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/config-files/.Xresources | tee "$HOME/.Xresources"
  xrdb -merge ~/.Xresources
}

# Main menu
while true; do
  choice=$(echo -e "Change sources.list\nInstall BSPWM\nInstall Openbox\nInstall General Apps\nCopy kitty terminal configuration\nCopy xterm terminal configuration\nExit" | fzf --reverse)

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
    "Copy kitty terminal configuration")
      copy_kitty_configuration
      ;;
    "Copy xterm terminal configuration")
      copy_xterm_configuration
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
