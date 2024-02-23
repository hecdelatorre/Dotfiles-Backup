# Dotfiles-Backup

Dotfiles-Backup is a project aimed at automating the setup and configuration of Debian-based systems, particularly for users who prefer a customizable Linux environment. This project provides scripts for adding a user to sudo and performing basic system installations, ensuring a smooth and efficient setup process.

## Prerequisites

Before running the scripts provided by Dotfiles-Backup, ensure that `curl` is installed on your system. You can install `curl` using the following command:

```bash
sudo apt install -y curl
```

## Adding User to sudo

To add a user to the sudo group, execute the following command as root:

```bash
bash -c "$(curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/add_user_sudo.sh)"
```

This command will prompt you to enter the username you wish to add to the sudo group. Ensure that you have root privileges to execute this command.

## Basic Installations

The basic-installations.sh script provided by Dotfiles-Backup automates the setup and installation of common packages and configurations for a Debian-based system. To run this script as a non-root user, execute the following command:

```bash
bash -c "$(curl -fsSL https://codeberg.org/hecdelatorre/Dotfiles-Backup/raw/branch/main/basic-installations.sh)"
```

This script installs essential packages, sets up configurations for various tools and applications, and provides options for customization based on user preferences.

## License

Dotfiles-Backup is licensed under the GNU General Public License v3.0 (GPL-3.0). Feel free to use, modify, and distribute the scripts according to the terms of the GPL v3 license.