#!/usr/bin/bash

set -e

echo -e "\033[1mArch Linux installation script\033[0m. Written by \033[1;36mMateus Nascimento\033[0m (\033[4;36m@melosomelo\033[0m)"

pacman -S --noconfirm --quiet gum

echo
echo -e "\033[1mThis script can automatically partition a disk of your choosing.\033[0m"
echo
echo "It will create a layout with:"
echo "  - One boot partition"
echo "  - One swap partition"
echo "  - One root partition"
echo
echo -e "\033[33mYou can specify the starting sector and desired size for each.\033[0m"
echo
echo "This setup works well for most cases, but may not suit more complex partitioning needs."
echo
echo "If you'd rather format your disk manually, go do that and then simply rerun this script like so:"
echo -e "  \033[1;3;36msudo SKIP_DISK_PARTITIONING=1 ./install.sh\033[0m"


gum confirm \
  --default "Would you like to continue with the automatic partitioning?" \
  --affirmative "Yes, let's do it" \
  --negative "No, I want to do it myself" || exit 0


if [ -z "$TARGET_DISK" ]; then
  echo
  TARGET_DISK=$(gum input \
    --header "Provide the path for the disk to be partitioned" \
    --placeholder "Something like /dev/sda")
else
  echo "Target disk path was passed as a variable. Using value '$TARGET_DISK'."
fi

if [ ! -f "$TARGET_DISK" ]; then
  gum log --level error "File $TARGET_DISK does not exist"
  exit 1
fi

