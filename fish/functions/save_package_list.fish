# doesn't deal with AUR packages yet
function save_package_list
  cd $DOTFILES
  pacman -Qqen | grep -v -E -e "base|linux|linux-firmware|grub|efibootmgr|networkmanager" - > wow.txt
end
