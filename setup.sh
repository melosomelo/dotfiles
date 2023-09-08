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

message "Changing root into the new system"
arch-chroot /mnt

message "Setting the timezone"
ln -sf /usr/share/zoneinfo/America/Fortaleza /etc/localtime
hwclock --systohc

message "Setting the locale"
sed -i '/^#en_US.UTF-8 UTF-8/s/^#//' /etc/locale.gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

message "Setting the hostname"
read hostname
echo "${hostname}" >> /etc/hostname

message "Setting the root password"
passwd

message "UEFI installing GRUB"
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
