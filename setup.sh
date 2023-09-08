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
archroot /mnt ln -sf /usr/share/zoneinfo/America/Fortaleza /etc/localtime
archroot /mnt hwclock --systohc

message "Setting the locale"
archroot /mnt sed -i '/^#en_US.UTF-8 UTF-8/s/^#//' /etc/locale.gen
archroot /mnt echo "LANG=en_US.UTF-8" >> /etc/locale.conf

message "Setting the hostname"
archroot /mnt read hostname
archroot /mnt echo "${hostname}" >> /etc/hostname

message "Setting the root password"
archroot /mnt passwd

message "UEFI installing GRUB"
archroot /mnt pacman -S grub efibootmgr
archroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
archroot /mnt grub-mkconfig -o /boot/grub/grub.cfg


