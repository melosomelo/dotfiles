#!/bin/bash

# Took a lot of things here from
# https://github.com/Ruturajn/Dotfiles/blob/main/Arch-Setup-Scripts/Arch_Install.sh

# Text modifiers
BOLD='\033[0;1m'
RED="\033[1;31m"
YELLOW="\033[1;93m"
CYAN="\033[1;36m"
RESET='\033[0;0m'

message(){
  echo -e "${BOLD}> $1${RESET}..."
}

# Start of the script

echo -e "${BOLD}> ${CYAN}Arch Linux${RESET}${BOLD} setup script"
echo -e "${BOLD}> Written by ${CYAN}Mateus Nascimento${RESET}${BOLD} (https://mateusm.dev)"

for i in 3 2 1
do
	echo -ne "${BOLD}> Setup will start in $i\r${RESET}"
	sleep 1
done

message "Setting up the system clock"
timedatectl set-ntp true

message "Enabling parallel downloads for pacstrap"
sed -i "s/#ParallelDownloads = 5/ParallelDownloads = 5/g" /etc/pacman.conf

echo -en "${BOLD}> Enter the path to the disk that needs to be partitioned: ${RESET}"
read disk_name
if [[ -z ${disk_name} ]]; then
	echo -e "${RED}> FATAL: No disk provided to be partitioned, cannot proceed!${RESET}"
	exit
fi

message "Partitioning the disk"
echo -en "${BOLD}> How much swap memory (in GB) do you want?${RESET}"
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
pacman-key --init
pacstrap -K /mnt base linux linux-firmware grub efibootmgr networkmanager

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
curl https://raw.githubusercontent.com/melosomelo/dotfiles/main/packages.txt > packages.txt
arch-chroot /mnt pacman -S $(cat ./packages.txt) --noconfirm
rm packages.txt

message "Configuring GRUB bootloader"
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

message "Enabling services"
arch-chroot /mnt systemctl enable NetworkManager

message "Adding new user"
echo -ne "${BOLD}> Choose your username: ${RESET}"
read username
arch-chroot /mnt useradd -m "${username}" && arch-chroot /mnt passwd "${username}"

message "Giving new user sudo privileges"
arch-chroot /mnt sed -i "s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/" /etc/sudoers \
	&& arch-chroot /mnt usermod -aG wheel "${username}"

message "Setting new user's shell to fish"
arch-chroot /mnt chsh -s /usr/bin/fish "${username}"

message "Installing Oh My Fish"
arch-chroot /mnt curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > omf_install \
	&& arhc-chroot /mnt fish omf_install --path=/mnt/home/mateus/.local/opt/omf --config=/mnt/home/mateus/.config/omf \

message "Downloading dotfiles"
arch-chroot /mnt git clone https://github.com/melosomelo/dotfiles /mnt/home/mateus/dotfiles

message "Setting up symbolic links"

echo -e "${BOLD}Setup done! Reboot your machine!${RESET}"