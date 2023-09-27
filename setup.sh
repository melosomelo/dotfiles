#!/bin/bash

# Text modifiers
BOLD='\033[0;1m'
RED="\033[1;31m"
YELLOW="\033[1;93m"
CYAN="\033[1;36m"
RESET='\033[0;0m'

message(){
  echo -e "${BOLD}> $1${RESET}..."
}

set -e
echo -e "${BOLD}> ${CYAN}Arch Linux${RESET}${BOLD} setup script"
echo -e "${BOLD}> Written by ${CYAN}Mateus Nascimento${RESET}${BOLD} (https://mateusm.dev)"

for i in 3 2 1
do
	echo -ne "${BOLD}> Setup will begin in $i\r${RESET}"
	sleep 1
done

message "Enabling parallel downloads for pacman"
sed -i "s/#ParallelDownloads = 5/ParallelDownloads = 5/g" /etc/pacman.conf

message "Installing additional official packages"
curl https://raw.githubusercontent.com/melosomelo/dotfiles/main/packages/official.txt > official.txt \
	&& sudo pacman -S $(cat ./official.txt) --noconfirm && rm official.txt

username="mateus"
message "Setting new user's shell to fish"
chsh -s /usr/bin/fish "${username}"

HOMEDIR="/home/${username}"
DOTFILES_DIR="${HOMEDIR}/dotfiles"
message "Downloading dotfiles"
git clone https://github.com/melosomelo/dotfiles && cd ${DOTFILES_DIR} && git submodule init && git submodule update

message "Setting up symbolic links"
mkdir -p .config && \
  ln -s ${DOTFILES_DIR}/X11/.xinitrc .xinitrc && \
  ln -s ${DOTFILES_DIR}/alacritty .config/alacritty && \
  ln -s ${DOTFILES_DIR}/nvim .config/nvim && \
  mkdir -p .config/fish && ln -s ${DOTFILES_DIR}/fish/config.fish .config/fish/config.fish && \
    ln -s ${DOTFILES_DIR}/fish/functions .config/fish/functions && \
  mkdir -p /etc/pacman.d/hooks && \
    ln -s ${DOTFILES_DIR}/pacman/hooks/save_package_list.hook /etc/pacman.d/hooks/save_package_list.hook

message "Installing Oh My Fish"
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > omf_install && \
  fish omf_install --noninteractive --path=~/.local/opt/omf --config=~/.config/omf && \
  rm omf_install

message "Setting Oh My Fish theme"
omf install l && omf theme l

message "Downloading and installing yay"
mkdir -p $HOMEDIR/.aur/yay
git clone https://aur.archlinux.org/yay.git $HOMEDIR/.aur/yay
cd $HOMEDIR/.aur/yay && makepkg -sirc
