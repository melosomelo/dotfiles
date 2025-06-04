#!/usr/bin/bash

set -e

echo -e "\033[1mArch Linux setup script\033[0m. Written by \033[1;36mMateus Nascimento\033[0m (\033[4;36m@melosomelo\033[0m)"

for i in {5..1}; do
  echo -ne "Starting in $i\r"
  sleep 1
done
echo

USERNAME="mateus"

cd /home/$USERNAME

echo "Cloning dotfiles repository"
[ -d dotfiles ] || runuser -u $USERNAME -- git clone https://github.com/melosomelo/dotfiles.git

echo "Adding custom pacman configuration file"
cp  dotfiles/pacman/pacman.conf /etc/pacman.conf

echo "Adding pritunl repositories and keys"
pacman-key --keyserver hkp://keyserver.ubuntu.com -r 7568D9BB55FF9E5287D586017AE645C0CF8E292A
pacman-key --lsign-key 7568D9BB55FF9E5287D586017AE645C0CF8E292A

echo "Installing additional official packages"
pacman -Sy --noconfirm $(cat dotfiles/packages/official.txt)

echo "Installing yay"
[-d yay] || runuser -u $USERNAME -- git clone https://aur.archlinux.org/yay.git
cd yay
runuser -u $USERNAME -- makepkg -si
cd..

echo "Using yay to install AUR packages"
yay -S $(cat dotfiles/packages/aur.txt)