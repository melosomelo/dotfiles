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
sudo sed -i "s/#ParallelDownloads = 5/ParallelDownloads = 5/g" /etc/pacman.conf

username="mateus"
HOMEDIR="/home/${username}"

message "Installing additional official packages"
curl https://raw.githubusercontent.com/melosomelo/dotfiles/main/packages/official.txt > /home/$username/official.txt
sudo pacman -S $(cat home/$username/official.txt) --noconfirm && rm /home/$username/official.txt

message "Downloading and installing yay"
mkdir -p $HOMEDIR/.aur/yay
git clone https://aur.archlinux.org/yay.git $HOMEDIR/.aur/yay
cd $HOMEDIR/.aur/yay
makepkg -sirc --noconfirm

message "Downloading AUR packages with yay"
sudo curl https://raw.githubusercontent.com/melosomelo/dotfiles/main/packages/aur.txt > $HOMEDIR/aur.txt
yay -S $(cat $HOMEDIR/aur.txt) --noconfirm && rm $HOMEDIR/aur.txt

message "Setting new user's shell to fish"
chsh -s /usr/bin/fish

message "Installing Oh My Fish"
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > $HOMEDIR/omf_install && \
  /usr/bin/fish $HOMEDIR/omf_install --noninteractive --path=$HOMEDIR/.local/opt/omf --config=$HOMEDIR/.config/omf && \
  rm $HOMEDIR/omf_install

message "Setting Oh My Fish theme"
/usr/bin/fish -l -c "omf install l && omf theme l"

DOTFILES_DIR="${HOMEDIR}/dotfiles"
message "Downloading dotfiles"
git clone https://github.com/melosomelo/dotfiles $DOTFILES_DIR && cd $DOTFILES_DIR && git submodule init && git submodule update

message "Setting up symbolic links"
mkdir -p $HOMEDIR/.config && \
  ln -s $DOTFILES_DIR/X11/.xinitrc $HOMEDIR/.xinitrc && \
  ln -s $DOTFILES_DIR/alacritty $HOMEDIR/.config/alacritty && \
  ln -s $DOTFILES_DIR/nvim $HOMEDIR/.config/nvim && \
  ln -s $DOTFILES_DIR/i3 $HOMEDIR/.config/i3 && \
  mkdir -p $HOMEDIR/.config/fish && ln -s ${DOTFILES_DIR}/fish/config.fish $HOMEDIR/.config/fish/config.fish && \
    ln -s ${DOTFILES_DIR}/fish/functions $HOMEDIR/.config/fish/functions && \
  sudo mkdir -p /etc/pacman.d/hooks && \
    sudo ln -s ${DOTFILES_DIR}/pacman/hooks/save_package_list.hook /etc/pacman.d/hooks/save_package_list.hook

message "Setting up XDG user directories"
cp ${DOTFILES_DIR}/misc/user-dirs.dirs $HOMEDIR/.config

message "Setting the wallpaper"
feh --bg-scale $DOTFILES_DIR/wallpapers/purple_sky.png

echo -e "${BOLD}> Setup is complete! Reboot your system and enjoy!${RESET}"
rm -- "$0"
