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
set -e
echo -e "${BOLD}> ${CYAN}Arch Linux${RESET}${BOLD} setup script"
echo -e "${BOLD}> Written by ${CYAN}Mateus Nascimento${RESET}${BOLD} (https://mateusm.dev)"

for i in 3 2 1
do
	echo -ne "${BOLD}> Setup will start in $i\r${RESET}"
	sleep 1
done

username="mateus"

message "Reading user input data"
echo -en "${BOLD}> Enter the path to the disk that needs to be partitioned: ${RESET}"
read disk_name
echo -en "${BOLD}> Enter the amount of swap memory (in GB) you want: ${RESET} "
read amount_swap
echo -en "${BOLD}> Specify a hostname for your machine: ${RESET} "
read hostname
echo -en "${BOLD}> Choose your root password: ${RESET} "
read -s root_password
echo -en "${BOLD}> Choose the password for the main user ${username}: ${RESET} "
read -s main_user_password

message "Setting up the system clock"
timedatectl set-ntp true

message "Enabling parallel downloads for pacstrap"
sed -i "s/#ParallelDownloads = 5/ParallelDownloads = 5/g" /etc/pacman.conf


message "Partitioning the disk"
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
pacman-key --init && pacstrap -K /mnt base base-devel linux linux-firmware grub efibootmgr networkmanager

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
arch-chroot /mnt touch /etc/hostname
arch-chroot /mnt echo "${hostname}" | tee -a /mnt/etc/hostname

message "Setting the new root password"
arch-chroot /mnt echo "root:${root_password}" | arch-chroot /mnt chpasswd

message "Enabling parallel downloads for pacman"
arch-chroot /mnt sed -i "s/#ParallelDownloads = 5/ParallelDownloads = 5/g" /etc/pacman.conf

message "Installing additional official packages"
curl https://raw.githubusercontent.com/melosomelo/dotfiles/main/packages/official.txt > official.txt \
	&& arch-chroot /mnt pacman -S $(cat ./official.txt) --noconfirm && rm official.txt

message "Configuring GRUB bootloader"
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

message "Enabling services"
arch-chroot /mnt systemctl enable NetworkManager

message "Adding new user ${username}"
arch-chroot /mnt useradd -m "${username}" && \
  arch-chroot echo "${username}:${main_user_password}" | arch-chroot /mnt chpasswd

message "Giving new user sudo privileges"
arch-chroot /mnt sed -i "s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/" /etc/sudoers \
	&& arch-chroot /mnt usermod -aG wheel "${username}"

message "Setting new user's shell to fish"
arch-chroot /mnt chsh -s /usr/bin/fish "${username}"

message "Downloading and installing yay"
arch-chroot /mnt runuser -l -u $username mkdir -p ~/.aur/yay
arch-chroot /mnt runuser -l "${username}" -c "git clone https://aur.archlinux.org/yay.git ~/.aur/yay && cd ~/.aur/yay && makepkg -src && echo ${main_user_password} | sudo -S pacman -U $(*.pkg.tar.zst)"

message "Installing AUR packages with yay"
arch-chroot /mnt runuser -l "${username}" -c "curl https://raw.githubusercontent.com/melosomelo/dotfiles/main/packages/aur.txt > aur.txt && yay -S $(cat ./aur.txt) --noconfirm && rm aur.txt"

DOTFILES_DIR="/home/${username}/dotfiles"
message "Downloading dotfiles"
arch-chroot /mnt runuser -l "${username}" -c "git clone https://github.com/melosomelo/dotfiles && cd ${DOTFILES_DIR} && git submodule init && git submodule update"

message "Setting up symbolic links"
arch-chroot /mnt runuser -l "${username}" -c "mkdir -p .config"
arch-chroot /mnt runuser -l "${username}" -c "ln -s ${DOTFILES_DIR}/X11/.xinitrc .xinitrc"
arch-chroot /mnt runuser -l "${username}" -c "ln -s ${DOTFILES_DIR}/alacritty .config/alacritty"
arch-chroot /mnt runuser -l "${username}" -c "ln -s ${DOTFILES_DIR}/nvim .config/nvim"
arch-chroot /mnt runuser -l "${username}" -c "mkdir -p .config/fish && ln -s ${DOTFILES_DIR}/fish/config.fish .config/fish/config.fish && ln -s ${DOTFILES_DIR}/fish/functions .config/fish/functions"
arch-chroot /mnt runuser -l "${username}" -c "sudo -S mkdir -p /etc/pacman.d/hooks && sudo ln -s ${DOTFILES_DIR}/pacman/hooks/save_package_list.hook /etc/pacman.d/hooks/save_package_list.hook"

message "Installing Oh My Fish"
arch-chroot /mnt runuser -l "${username}" -c 'curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > omf_install && fish omf_install --noninteractive --path=~/.local/opt/omf --config=~/.config/omf && rm omf_install'

message "Setting Oh My Fish theme"
arch-chroot /mnt runuser -l "${username}" -c 'omf install l && omf theme l'

message "Setting up XDG user directories"
arch-chroot /mnt runuser -l "${username}" -c "cp ${DOTFILES_DIR}/misc/user-dirs.dirs .config && xdg-user-dirs-update"

echo -e "${BOLD}Setup done! Reboot your machine!${RESET}"
