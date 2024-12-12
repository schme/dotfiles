#!/usr/bin/env bash

# Some good to remember commands
#
# sudo cryptsetup openLuks /dev/sdb4 whatever-name-i-use-x
# sudo lsblkid
# sudo ubuntu-drivers list
# sudo ubuntu-drivers install nvidia:535

sudo add-apt-repository universe
sudo add-apt-repository multiverse

echo "deb http://archive.canonical.com/ubuntu jammy partner" | sudo tee -a /etc/apt/sources.list

sudo apt update && sudo apt upgrade

sudo apt install ubuntu-restricted-extras
## Various
sudo apt install xclip ntp

## Set ntp on
sudo timedatectl set-ntp on


## Regolith (Ubuntu 22.04 specific)
wget https://regolith-desktop.com/install-release-ubuntu-22.04-amd64.txt
source install-release-ubuntu-22.04-amd64.txt
sudo apt install regolith-desktop regolith-session-flashback regolith-look-*
rm install-release-ubuntu-22.04-amd64.txt

## oh-my-zsh
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## a good editor
sudo add-apt-repository ppa:maveonair/helix-editor
sudo apt update
sudo apt install helix

## other development
sudo apt install clangd clang-tidy clang-format

## firefox (apt will install from snap)
snap install firefox

## brave, unfortunately often needed as well
snap install brave


sudo apt install python3-dropbox nautilus-dropbox

## flatpak so we can install from there
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install md.obsidian.Obsidian

# Steam
curl -s http://repo.steampowered.com/steam/archive/stable/steam.gpg | sudo gpg --dearmor -o /usr/share/keyrings/steam.gpg > /dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/steam.gpg] http://repo.steampowered.com/steam/ stable steam" | sudo tee /etc/apt/sources.list.d/steam.list

