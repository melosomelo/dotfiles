#!/bin/bash

# Text modifiers
BOLD='\033[0;1m'
RED="\033[1;31m"
YELLOW="\033[1;93m"
CYAN="\033[1;36m"
RESET='\033[0;0m'

message(){
  echo -e "${BOLD}> $1${RESET}..."
}

set -e

echo -e "${BOLD}> ${CYAN}Arch Linux${RESET}${BOLD} install script"
echo -e "${BOLD}> Written by ${CYAN}Mateus Nascimento${RESET}${BOLD} (https://mateusm.dev)"

for i in 3 2 1
do
	echo -ne "${BOLD}> Installation will begin in $i\r${RESET}"
	sleep 1
done

message "Setting up the system clock"
timedatectl set-ntp true

message "Enabling parallel downloads for pacstrap"
sed -i "s/#ParallelDownloads = 5/ParallelDownloads = 5/g" /etc/pacman.conf

message "Partitioning the disk"
echo -en "${BOLD}> Enter the path to the disk that needs to be partitioned: ${RESET}"
read disk_name
echo -en "${BOLD}> Enter the amount of swap memory (in GB) you want: ${RESET} "
read amount_swap
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

message "Installing base system"
pacstrap -K /mnt base base-devel linux linux-firmware grub efibootmgr networkmanager

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
echo -en "${BOLD}> Specify a hostname for your machine: ${RESET} "
read hostname
arch-chroot /mnt touch /etc/hostname
arch-chroot /mnt echo "${hostname}" | tee -a /mnt/etc/hostname

message "Setting the new root password"
arch-chroot /mnt passwd

message "Configuring GRUB bootloader"
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

# Values is fixed as of now due to the pacman hook that saves the list of installed packages.
# Will fix this later (maybe).
message "Enabling services"
arch-chroot /mnt systemctl enable NetworkManager

username="mateus"
message "Adding new user ${username}"
arch-chroot /mnt useradd -m "${username}"

message "Setting password for new user ${username}"
arch-chroot /mnt passwd ${username}

message "Giving new user sudo privileges"
arch-chroot /mnt sed -i "s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/" /etc/sudoers \
	&& arch-chroot /mnt usermod -aG wheel "${username}"

echo -en "${BOLD}Installation is done! Would you like to run the setup now? (Y/n)"
read install_setup
if [ install_setup = "Y" ]; then
  message "Downloading setup script"
  curl https://raw.githubusercontent.com/melosomelo/dotfiles/main/setup.sh > setup.sh && \
    chmod +x ./setup.sh
fi
