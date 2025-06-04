#!/usr/bin/bash

set -e

echo -e "\033[1mArch Linux setup script\033[0m. Written by \033[1;36mMateus Nascimento\033[0m (\033[4;36m@melosomelo\033[0m)"

for i in {5..1}; do
  echo -ne "Starting in $i\r"
  sleep 1
done
echo

cd

echo "Cloning dotfiles repository"
git clone https://github.com/melosomelo/dotfiles

echo "Installing additional official packages"
pacman -S $(cat dotfiles/packages/official.txt)

echo "Installing yay"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd..

echo "Using yay to install AUR packages"
yay -S $(cat dotfiles/packages/aur.txt)