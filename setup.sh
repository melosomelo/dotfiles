#!/bin/bash

# Took a lot of things here from
# https://github.com/Ruturajn/Dotfiles/blob/main/Arch-Setup-Scripts/Arch_Install.sh

# Text modifiers
BOLD='\033[0;1m'
RED="\e[1;31m"
RESET='\033[0;0m'

message(){
  echo -e "${BOLD}> $1${RESET}..."
}

# Start of the script
# This initial part merely automates the Arch Linux installation guide.
message "Setting up the system clock"
timedatectl set-npt true

message "Enabling parallel downloads for pacstrap"
sed -i "s/#ParallelDownloads = 5/ParallelDownloads = 5/g" /etc/pacman.conf

read -rp "${BOLD}> Enter the path to the disk that needs to be partitioned: ${RESET}" disk_name
if [[ -z ${disk_name} ]]; then
	echo -e "${RED}> FATAL: No disk provided to be partitioned, cannot proceed!${RESET}"
	exit
fi

message "Partitioning the disk"
read -rp "${BOLD}> How much swap memory (in GB) do you want?${RESET}" amount_swap
sgdisk -n 1::+512M -t 1:ef00 "${disk_name}"
sgdisk -n 2::+"${amount_swap}"G -t 2:8200 "${disk_name}"
sgdisk -n 3:: -t 3:8300 "${disk_name}"

message "Formatting the partitions"
mkfs.ext4 "${disk_name}3"
mkswap "${disk_name}2"
mkfs.fat -F 32 "${disk_name}1"

message "Mounting the partitions"
mount "${disk_name}3" /mnt
mount --mkdir "${disk_name}1" /mnt/boot
swapon "${disk_name}2"

message "Generating fstab file"
genfstab -U /mnt >> /mnt/etc/fstab

message "Setting the timezone"
arch-chroot /mnt ln -sf /usr/share/zoneinfo/America/Fortaleza /etc/localtime
arch-chroot /mnt hwclock --systohc

message "Configuring locale"
arch-chroot /mnt sed -i '/^#en_US.UTF-8 UTF-8/s/^#//' /etc/locale.gen
arch-chroot /mnt locale-gen
arch-chroot /mnt echo "LANG=en_US.UTF-8" | tee -a /mnt/etc/locale.conf

message "Setting the hostname"
echo -n "Please, specify a hostname: "
read hostname
arch-chroot /mnt touch /etc/hostname
arch-chroot /mnt echo "${hostname}" | tee -a /mnt/etc/hostname

message "Setting the new root password"
arch-chroot /mnt passwd

message "Enabling parallel downloads for pacman"
arch-chroot /mnt sed -i "s/#ParallelDownloads = 5/ParallelDownloads = 5/g" /etc/pacman.conf

message "Installing additional packages"
arch-chroot /mnt pacman -S grub efibootmgr --noconfirm

message "Installing GRUB bootloader"
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

echo -e "${BOLD}Setup done! Reboot your machine!${RESET}"