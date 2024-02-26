#!/bin/bash

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    echo "fzf could not be found, installing now..."
    sudo apt update
    sudo apt install -y fzf
fi

# Check and create configuration directories if they don't exist
CONFIG_DIR="$HOME/.config"
FONTS_DIR="$HOME/.local/share/fonts"

if [ ! -d "$CONFIG_DIR" ]; then
    mkdir -p "$CONFIG_DIR"
fi

if [ ! -d "$FONTS_DIR" ]; then
    mkdir -p "$FONTS_DIR"
fi

# Function to prompt user to press Enter to continue
enter_continue() {
    echo "Press Enter to continue..."
    read
}

# Define arrays of packages
COMMON_PACKAGES=(
    # System utilities
    sudo xorg ssh git numlockx systemd-timesyncd p7zip p7zip-full lhasa lzip lzma lzop lzd zstd xz-utils zutils openvpn tree unace w3m xclip gnome-disk-utility gparted
    # Desktop environment
    lxappearance
    # Multimedia
    pulseaudio volumeicon-alsa pavucontrol smplayer
    # File managers
    pcmanfm
    # Text editors
    vim nano
    # Terminal emulator
    xterm
    # Application launcher
    rofi
    # Compositor
    picom
    # Image viewer
    feh mirage
    # Screen capture
    scrot
    # Screen locker
    xautolock slock
    # Network
    network-manager network-manager-gnome avahi-daemon gvfs-backends gvfs-fuse cifs-utils smbclient
    # Themes and icons
    numix-gtk-theme numix-icon-theme
    # Fonts
    fonts-firacode fonts-noto-cjk fonts-open-sans
    # Programming
    python3 python3-pip python3-venv python3-tk default-jdk default-jdk-headless default-jre default-jre-headless
    # Document viewer
    evince
    # Archive manager
    engrampa
    # Window manager
    lxdm
)

# BSPWM-specific packages
BSPWM_PACKAGES=(
    bspwm sxhkd polybar
)

# Openbox-specific packages
OPENBOX_PACKAGES=(
    openbox tint2 menu
)

# General apps
GENERAL_APPS=(
    ssh git zsh aria2 axel ranger vim neovim kitty nano tree xterm fonts-firacode fonts-noto-cjk fonts-open-sans python3 python3-pip python3-venv python3-tk default-jdk default-jdk-headless default-jre default-jre-headless firefox-esr
)

# Function to install packages
install_packages() {
    sudo apt update
    sudo apt install -y "${@}"
}

# Function to change sources.list
change_sources_list() {
    # Array of repository options
    SUBMENU=(
        "linuxdebian.mx - Powered by Last Dragon - AMD64"
        "deb.debian.org"
        "Return to main menu"
    )
    # Prompt user to choose a repository
    choice=$(printf "%s\n" "${SUBMENU[@]}" | fzf --reverse)

    case $choice in
        "linuxdebian.mx - Powered by Last Dragon - AMD64")
            echo "Updating sources.list with linuxdebian.mx repository..."
            # Update sources.list with linuxdebian.mx repository
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
            echo "Updating sources.list with deb.debian.org repository..."
            # Update sources.list with deb.debian.org repository
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

# Create pictures folder and download wallpaper
create_pictures() {
    if [ ! -d "$HOME/Pictures" ]; then
        mkdir -p "$HOME/Pictures"
    fi
    curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/config-files/w.jpg > "$HOME/Pictures/wallpaper.jpg"
}

# Copy BSPWM configuration files
copy_bspwm_configuration() {
    # Remove existing configuration directories
    CONFIG_BSPWM="$CONFIG_DIR/bspwm"
    CONFIG_SXHKD="$CONFIG_DIR/sxhkd"
    CONFIG_POLYBAR="$CONFIG_DIR/polybar"
    CONFIG_PICOM="$CONFIG_DIR/picom"

    if [ -d "$CONFIG_BSPWM" ]; then
        rm -rf "$CONFIG_BSPWM"
    fi
    if [ -d "$CONFIG_SXHKD" ]; then
        rm -rf "$CONFIG_SXHKD"
    fi
    if [ -d "$CONFIG_POLYBAR" ]; then
        rm -rf "$CONFIG_POLYBAR"
    fi
    if [ -d "$CONFIG_PICOM" ]; then
        rm -rf "$CONFIG_PICOM"
    fi

    # Copy configuration files and set wallpaper
    curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/config-files/bspwm-sxhkd-polybar-picom.tar.xz | tar Jxf - -C "$CONFIG_DIR"
    cp -f /etc/X11/xinit/xinitrc "$HOME/.xinitrc"
    create_pictures
    echo "Restart to see changes"
}

# Copy Openbox configuration files
copy_openbox_configuration() {
    # Remove existing configuration directories
    CONFIG_OPENBOX="$CONFIG_DIR/openbox"
    CONFIG_TINT2="$CONFIG_DIR/tint2"
    CONFIG_PICOM="$CONFIG_DIR/picom"

    if [ -d "$CONFIG_OPENBOX" ]; then
        rm -rf "$CONFIG_OPENBOX"
    fi
    if [ -d "$CONFIG_TINT2" ]; then
        rm -rf "$CONFIG_TINT2"
    fi
    if [ -d "$CONFIG_PICOM" ]; then
        rm -rf "$CONFIG_PICOM"
    fi

    # Copy configuration files and set wallpaper
    curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/config-files/openbox-tint2-picom.tar.xz | tar Jxf - -C "$CONFIG_DIR"
    cp -f /etc/X11/xinit/xinitrc "$HOME/.xinitrc"
    create_pictures
    echo "Restart to see changes"
}

# Function to copy kitty configuration
copy_kitty_configuration() {
    FONT_FIRACODE_NERDFONT="$FONTS_DIR/FiraFontNF"
    if [ ! -d "$FONT_FIRACODE_NERDFONT" ]; then
        mkdir "$FONT_FIRACODE_NERDFONT"
        curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip -o temp.zip
        unzip -q temp.zip -d "$FONT_FIRACODE_NERDFONT"
        rm -f temp.zip 
    fi

    CONFIG_KITTY="$CONFIG_DIR/kitty"

    if [ -d "$CONFIG_KITTY" ]; then
        rm -rf "$CONFIG_KITTY"
    fi

    # Install kitty and copy configuration files
    sudo apt install -y kitty
    curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/config-files/kitty.tar.xz | tar Jxf - -C "$CONFIG_DIR"
}

# Function to copy xterm configuration
copy_xterm_configuration() {
    # Check and install IBM Plex Sans font
    FONT_IBM="$FONTS_DIR/IBM-Plex-Sans"
    if [ ! -d "$FONT_IBM" ]; then
        curl -fsSL https://github.com/IBM/plex/releases/download/v6.4.0/OpenType.zip -o temp.zip
        unzip -q temp.zip 
        rm -f temp.zip 
        mv -f OpenType "$FONT_IBM"
    fi

    # Install xterm and copy configuration files
    sudo apt install -y xterm
    curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/config-files/.Xresources > "$HOME/.Xresources"
    xrdb -merge ~/.Xresources
}

# Function to copy vim and neovim configuration
copy_vim_neovim_configuration() {
    # Remove existing neovim configuration directory
    CONFIG_NVIM="$CONFIG_DIR/nvim"

    if [ -d "$CONFIG_NVIM" ]; then
        rm -rf "$CONFIG_NVIM"
    fi

    # Install vim, neovim, and copy configuration files
    sudo apt install -y vim neovim
    curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/config-files/.vimrc > "$HOME/.vimrc"
    curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/config-files/nvim.tar.xz | tar Jxf - -C "$CONFIG_DIR"
    echo -e "Install vim plug for neovim from this site run PlugInstall\nhttps://github.com/junegunn/vim-plug"
    echo -e "Install nodejs for coc\nhttps://github.com/nodesource/distributions?tab=readme-ov-file#debian-and-ubuntu-based-distributions"
}

# Function to copy zsh configuration
copy_zsh_configuration() {
    # Install zsh
    sudo apt install zsh -y

    # Array of zsh configuration options
    SUBMENU_ZSH=(
        "zsh configuration - common.zsh-theme"
        "zsh configuration - simple"
        "Return to main menu"
    )

    # Prompt user to choose zsh configuration
    choice=$(printf "%s\n" "${SUBMENU_ZSH[@]}" | fzf --reverse)

    case $choice in
        "zsh configuration - common.zsh-theme")
            chsh -s $(which zsh) $USER
            curl -fsSL https://github.com/hecdelatorre/common/raw/master/common.zsh-theme > "$HOME/.zsh_prompt"
            curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/config-files/.zshrc > "$HOME/.zshrc"
            ;;
        "zsh configuration - simple")
            chsh -s $(which zsh) $USER
            echo "PROMPT=' %F{cyan}%1/%f %F{green}❯%f '" > "$HOME/.zsh_prompt"
            curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/config-files/.zshrc > "$HOME/.zshrc"
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
MENU=(
    "1 Change sources.list"
    "2 Install BSPWM"
    "3 Install Openbox"
    "4 Install General Apps"
    "5 Copy kitty terminal configuration"
    "6 Copy xterm terminal configuration"
    "7 Copy vim and neovim configuration"
    "8 Copy zsh configuration"
    "9 Exit"
)

while true; do
    # Prompt user to choose from the main menu
    choice=$(printf "%s\n" "${MENU[@]}" | fzf --reverse)

    case $choice in
        "1 Change sources.list")
            change_sources_list
            ;;
        "2 Install BSPWM")
            install_packages "${COMMON_PACKAGES[@]}" "${BSPWM_PACKAGES[@]}"
            copy_bspwm_configuration
            enter_continue
            ;;
        "3 Install Openbox")
            install_packages "${COMMON_PACKAGES[@]}" "${OPENBOX_PACKAGES[@]}"
            copy_openbox_configuration
            enter_continue
            ;;
        "4 Install General Apps")
            install_packages "${GENERAL_APPS[@]}"
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
        "8 Copy zsh configuration")
            copy_zsh_configuration
            ;;
        "9 Exit")
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a valid option."
            ;;
    esac
done
