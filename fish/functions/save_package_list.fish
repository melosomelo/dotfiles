# doesn't deal with AUR packages yet
function save_package_list
  cd $DOTFILES
  # save any unstaged/uncomitted changes and pull any new changes
  git stash clear && git add . && git stash && git pull && git stash pop
  # Update the list of additional (not base system) packages
  pacman -Qqen | grep -v -E -e "base|base-devel|linux|linux-firmware|grub|efibootmgr|networkmanager" > packages/official.txt
  # AUR packages
  pacman -Qqem > packages/aur.txt
  git add .
  git commit -m "[$(date +%Y-%m-%d_%H:%M)] pacman install/remove hook"
  git push origin main
end
