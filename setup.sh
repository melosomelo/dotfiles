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
arch-chroot /mnt ln -sf /usr/share/zoneinfo/America/Fortaleza /etc/localtime
arch-chroot /mnt hwclock --systohc

message "Setting the locale"
arch-chroot /mnt sed -i '/^#en_US.UTF-8 UTF-8/s/^#//' /etc/locale.gen
arch-chroot /mnt echo "LANG=en_US.UTF-8" >> /etc/locale.conf

message "Setting the hostname"
arch-chroot /mnt read hostname
arch-chroot /mnt echo "${hostname}" >> /etc/hostname

message "Setting the root password"
arch-chroot /mnt passwd

message "UEFI installing GRUB"
arch-chroot /mnt pacman -S grub efibootmgr
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg


