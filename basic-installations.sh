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

enter_continue() {
  echo "Press Enter to continue..."
  read
}

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
  submenu=(
    "linuxdebian.mx - Powered by Last Dragon - AMD64"
    "deb.debian.org"
    "Return to main menu"
  )
  choice=$(printf "%s\n" "${submenu[@]}" | fzf --reverse)

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
# Create pictures folder
create_pictures() {
if [ ! -d $HOME/Pictures ]; then
  mkdir -p $HOME/Pictures
fi
curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/config-files/w.jpg > "$HOME/Pictures/wallpaper.jpg"
}

# Copy BSPWM configuration files
copy_bswm_configuration() {
  if [ -d "$config/bspwm" ]; then
    rm -rf "$config/bspwm"
  fi
  if [ -d "$config/sxhkd" ]; then
    rm -rf "$config/sxhkd"
  fi
  if [ -d "$config/polybar" ]; then
    rm -rf "$config/polybar"
  fi
  if [ -d "$config/picom" ]; then
    rm -rf "$config/picom"
  fi
  curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/config-files/bspwm-sxhkd-polybar-picom.tar.xz | tar Jxf - -C "$config"
  cp -f /etc/X11/xinit/xinitrc  "$HOME/.xinitrc"
  create_pictures
  echo "Restart to see changes"
}

# Copy Openbox configuration files
copy_openbox_configuration() {
  if [ -d "$config/openbox" ]; then
    rm -rf "$config/openbox"
  fi
  if [ -d "$config/tint2" ]; then
    rm -rf "$config/tint2"
  fi
  if [ -d "$config/picom" ]; then
    rm -rf "$config/picom"
  fi
  curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/config-files/openbox-tint2-picom.tar.xz | tar Jxf - -C "$config"
  cp -f /etc/X11/xinit/xinitrc  "$HOME/.xinitrc"
  create_pictures
  echo "Restart to see changes"
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
  curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/config-files/.Xresources > "$HOME/.Xresources"
  xrdb -merge ~/.Xresources
}

# function to copy vim and neovim configuration
copy_vim_neovim_configuration() {
  if [ -d "$config/nvim" ]; then
      rm -rf "$config/nvim"
  fi
  sudo apt install -y vim neovim
  curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/config-files/.vimrc > "$HOME/.vimrc"
  curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/config-files/nvim.tar.xz | tar Jxf - -C "$config"
  echo -e "Install vim plug for neovim from this site run PlugInstall\nhttps://github.com/junegunn/vim-plug"
  echo -e "Install nodejs for coc\nhttps://github.com/nodesource/distributions?tab=readme-ov-file#debian-and-ubuntu-based-distributions"
}

# Main menu
menu=(
  "1 Change sources.list"
  "2 Install BSPWM"
  "3 Install Openbox"
  "4 Install General Apps"
  "5 Copy kitty terminal configuration"
  "6 Copy xterm terminal configuration"
  "7 Copy vim and neovim configuration"
  "8 Exit"
)

while true; do
  choice=$(printf "%s\n" "${menu[@]}" | fzf --reverse)

  case $choice in
    "1 Change sources.list")
      change_sources_list
      ;;
    "2 Install BSPWM")
      install_packages "${common_packages[@]}" "${bspwm_packages[@]}"
      copy_bswm_configuration
      enter_continue
      ;;
    "3 Install Openbox")
      install_packages "${common_packages[@]}" "${openbox_packages[@]}"
      copy_openbox_configuration
      enter_continue
      ;;
    "4 Install General Apps")
      install_packages "${general_apps[@]}"
      ;;
    "5 Copy kitty terminal configuration")
      copy_kitty_configuration
      ;;
    "6 Copy xterm terminal configuration")
      copy_xterm_configuration
      ;;
    "7 Copy vim and neovim configuration")
      copy_vim_neovim_configuration
      enter_continue
      ;;
    "8 Exit")
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please enter a valid option."
      ;;
  esac
done
