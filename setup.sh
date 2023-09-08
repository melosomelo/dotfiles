#!/bin/bash

# Text modifiers
BOLD='\033[0;1m'
RESET='\033[0;0m'

message(){
  echo -e "${BOLD}> $1${RESET}..."
}

# Start of the script
# This initial part merely automates the Arch Linux installation guide.
message "Generating fstab file"
genfstab -U /mnt >> /mnt/etc/fstab

message "Setting the timezone"
ln -sf /usr/share/zoneinfo/America/Fortaleza /mnt/etc/localtime
arch-chroot /mnt hwclock --systohc

message "Setting the locale"
sed -i '/^#en_US.UTF-8 UTF-8/s/^#//' /mnt/etc/locale.gen
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf

message "Setting the hostname"
echo -n "Please, specify a hostname: "
read hostname
echo "${hostname}" > /mnt/etc/hostname

message "Setting the new root password"
passwd

message "UEFI installing GRUB"
arch-chroot /mnt pacman -S grub efibootmgr --noconfirm
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/mnt/boot --bootloader-id=GRUB
arch-chroot /mnt grub-mkconfig -o /mnt/boot/grub/grub.cfg

echo -e "${BOLD}Setup done!${RESET}"