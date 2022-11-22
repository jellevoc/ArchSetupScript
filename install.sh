#!/bin/bash
#made in vim

RED='\033[1;31m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
YELLOW='\033[1;33m'
GREEN='\033[1;33'
ORANGE='\033[0;33'
NC='\033[0m'

echo -e -n "${PURPLE}have you enabled multilib yet?[Y/n]: ${NC}"
read answer
if [ "$answer" = 'n' ];
then
	echo -e "${RED}enable multilib and then run this script again${NC}"
	exit
fi

echo -e "${BLUE}updating packages and repos${NC}"
sudo pacman -Syu

echo -e  "${BLUE}installing some basic packages ${PURPLE}"
sudo pacman -S firefox code bashtop zip unrar vlc neofetch lolcat latte-dock mysql-workbench zsh wget openssh git php pulseaudio-bluetooth bluez bluez-utils blueman discord thunderbird libreoffice-fresh vivaldi kvantum --needed --noconfirm

sudo pacman -R kmix
echo -e "${NC}"
sudo systemctl enable --now bluetooth


echo -e "${BLUE}installing code extensions${YELLOW}"
code --install-extension coenraads.bracket-pair-colorizer-2
code --install-extension equinusocio.vsc-community-material-theme
code --install-extension pranaygp.vscode-css-peek
code --install-extension dsznajder.es7-react-js-snippets
code --install-extension abusaidm.html-snippets
code --install-extension qufiwefefwoyn.inline-sql-syntax
code --install-extension onecentlin.laravel-blade
code --install-extension shufo.vscode-blade-formatter
code --install-extension amiralizadeh9480.laravel-extra-intellisense
code --install-extension codingyu.laravel-goto-view
code --install-extension mohamedbenhida.laravel-intellisense
code --install-extension onecentlin.laravel5-snippets
code --install-extension yandeu.five-server
code --install-extension magicstack.magicpython
code --install-extension pkief.material-icon-theme
code --install-extension bmewburn.vscode-intelephense-client
code --install-extension esbenp.prettier-vscode
code --install-extension tomi.xasnippets
code --install-extension msjsdiag.vscode-react-native
code --install-extension bradlc.vscode-tailwindcss
code --install-extension robole.snippets-ranger

echo "setting zsh as default shell"
#changing shell to zsh
chsh -s /bin/zsh

echo -e "${BLUE}installing ohmyzsh${NC}"
sudo sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo -e "${BLUE}installing yay${NC}"
sudo git clone https://aur.archlinux.org/yay.git
sudo chown 777 yay/
cd yay/
makepkg -si --noconfirm

cd ..
rm -rf /yay-git

echo -e "${BLUE}installing packages with yay${NC}"
yay -S nextcloud-client rider pycharm-community-edition jetbrains-fleet bitwarden figma-linux-bin phpstorm --noconfirm

echo -e "${GREEN}Script is finished!${NC}"

neofetch | lolcat
