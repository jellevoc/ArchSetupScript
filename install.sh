#!/bin/bash
#made in vim

sudo pacman -Syu --noconfirm
sudo pacman -S git base-devel --noconfirm

git clone https://aur.archlinux.org/paru.git
chmod 777 paru/
cd paru/
makepkg -si --noconfirm

#You will need to create a free account
#https://my.nextdns.io/signup
sh -c "$(curl -sL https://nextdns.io/install)"
nextdns start

paru -S firefox firefox-developer-edition firefox-nightly-bin --noconfirm

#Firefox stable will be used as daily default hardenend browser
#Firefox dev will be strictly hardenend for sensitive tasks
#Firefox nightly will not be hardenend 

sudo cp /etc/pacman.conf /etc/pacman.conf.backup
mline=$(grep -n "\\[multilib\\]" /etc/pacman.conf | cut -d: -f1)
rline=$(($mline + 1))
sudo sed -i ''$mline's|#\[multilib\]|\[multilib\]|g' /etc/pacman.conf
sudo sed -i ''$rline's|#Include = /etc/pacman.d/mirrorlist|Include = /etc/pacman.d/mirrorlist|g' /etc/pacman.conf

sudo cp /etc/paru.conf /etc/paru.conf.backup
mline=$(grep -n "\\[BottomUp\\]" /etc/paru.conf | cut -d: -f1)
rline=$(($mline + 1))
sudo sed -i ''$mline's|#\[BottomUp\]|\[BottomUp\]|g' /etc/paru.conf
sudo sed -i ''$rline's|#RemoveMake|SkipView' /etc/paru.conf
paru -Sy

paru -S atom-editor-beta-bin bleachbit calibre deja-dup electrum element-desktop balena-etcher freefilesync-bin gimp handbrake keepassxc mailspring newsflash onlyoffice-bin protonmail-bridge-nokeychain protonvpn signal-desktop standardnotes-bin torbrowser-launcher transmission-qt veracrypt virtualbox-host-modules-arch virtualbox vlc wire-desktop telegram-desktop discord_arch_electron spotify code unrar zip zsh --noconfirm
sudo modprobe vboxdrv
sudo pacman -R kmix --noconfirm

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo cp ~/.zshrc ~/.zshrc.backup
sudo mv ~/ArchSetupScript/.zshrc ~/.zshrc

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
source ~/.zshrc

timedatectl set-timezone Europe/Amsterdam
cd ..
rm -rf /yay-git

echo -e "${BLUE}installing packages with yay${NC}"
yay -S nextcloud-client rider pycharm-community-edition jetbrains-fleet bitwarden figma-linux-bin phpstorm --noconfirm

echo -e "${GREEN}Script is finished!${NC}"

neofetch | lolcat
