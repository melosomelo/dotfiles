#!/usr/bin/bash
set -e

echo -e "\033[1mArch Linux installation script\033[0m. Written by \033[1;36mMateus Nascimento\033[0m (\033[4;36m@melosomelo\033[0m)"

for i in {5..1}; do
  echo -ne "Starting in $i\r"
  sleep 1
done
echo

prompt_if_unset() {
  local var_name="$1"
  local prompt_text="$2"

  if [ -z "${!var_name}" ]; then
    read -rp "$prompt_text" "$var_name"
  fi
}


if [ "$SKIP_DISK_PARTITIONING" != 1 ]; then
  prompt_if_unset TARGET_DISK "Provide the path for the disk to be partitioned (e.g., /dev/sda): "
  if [ ! -b "$TARGET_DISK" ]; then
    echo -e "\033[1;31mDevice $TARGET_DISK does not exist\033[0m"
    exit 1
  fi

  # Creating a new partition table in the disk.
  parted --script "$TARGET_DISK" mklabel gpt

  # Creating partitions
  prompt_if_unset BOOT_PARTITION_START "Specify the start of the boot partition (e.g., 0%, 1MiB): "
  prompt_if_unset BOOT_PARTITION_END "Specify the end of the boot partition (e.g., 0%, 1MiB): "
  parted --script "$TARGET_DISK" mkpart efiboot fat32 "$BOOT_PARTITION_START" "$BOOT_PARTITION_END" \
    set 1 boot on \
    set 1 esp on
  prompt_if_unset SWAP_PARTITION_START "Specify the start of the swap partition (e.g., 0%, 1MiB): "
  prompt_if_unset SWAP_PARTITION_END "Specify the end of the swap partition (e.g., 0%, 1MiB): "
  parted --script "$TARGET_DISK" mkpart swap linux-swap "$SWAP_PARTITION_START" "$SWAP_PARTITION_END"
  prompt_if_unset ROOT_PARTITION_START "Specify the start of the root partition (e.g., 0%, 1MiB): "
  prompt_if_unset ROOT_PARTITION_END "Specify the end of the root partition (e.g., 0%, 1MiB): "
  parted --script "$TARGET_DISK" mkpart root ext4 "$ROOT_PARTITION_START" "$ROOT_PARTITION_END"
  echo "✓ Partitions created"

  # Formatting partitions
  mkfs.fat -F 32 "$TARGET_DISK"1
  mkswap "$TARGET_DISK"2
  mkfs.ext4 "$TARGET_DISK"3
  echo "✓ Partitions formatted"

  # Mounting file systems
  mount "$TARGET_DISK"3 /mnt
  mount --mkdir "$TARGET_DISK"1 /mnt/boot
  swapon "$TARGET_DISK"2
  echo "✓ File systems mounted"

  echo "Final layout of the target disk:"
  echo
  parted --script "$TARGET_DISK" print
  echo
fi

pacstrap -K /mnt base base-devel linux linux-firmware grub efibootmgr networkmanager
echo "✓ Installed base system"

genfstab -U /mnt >> /mnt/etc/fstab
echo "✓ fstab file created successfully"

arch-chroot /mnt ln -sf /usr/share/zoneinfo/America/Fortaleza /etc/localtime
arch-chroot /mnt hwclock --systohc
echo "✓ Time zone set to America/Fortaleza (UTC-3)"

arch-chroot /mnt sed -i '/^#en_US.UTF-8 UTF-8/s/^#//' /etc/locale.gen
arch-chroot /mnt locale-gen
arch-chroot /mnt /bin/bash -c 'echo "LANG=en_US.UTF-8" >> /etc/locale.conf'
echo "✓ Locale set to en_US.UTF-8"

prompt_if_unset _HOSTNAME "Specify your hostname: "
arch-chroot /mnt /bin/bash -c "echo \"$_HOSTNAME\" > /etc/hostname"
echo "✓ Hostname set to $_HOSTNAME"

if [ -z "$ROOT_PASSWORD" ]; then
  read -rsp "Enter the root password for the system: " ROOT_PASSWORD
fi
arch-chroot /mnt /bin/bash -c "echo \"$ROOT_PASSWORD\" | passwd --stdin"
echo
echo "✓ Root password set successfully"

arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
echo "✓ Bootloader (GRUB) configured"

arch-chroot /mnt systemctl enable NetworkManager
echo "✓ Required services enabled"

# Values is fixed as of now due to the pacman hook that saves the list of installed packages.
# Will fix this later (maybe).
USERNAME="mateus"
arch-chroot /mnt useradd -m "$USERNAME"
echo "✓ Created user $USERNAME"

if [ -z "$USER_PASSWORD" ]; then
  read -rsp "Enter the main user's password: " USER_PASSWORD
fi
arch-chroot /mnt /bin/bash -c "echo \"$USER_PASSWORD\" | passwd --stdin \"$USERNAME\""
echo
echo "✓ Password for $USERNAME set"

arch-chroot /mnt sed -i "s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/" /etc/sudoers && \
  arch-chroot /mnt usermod -aG wheel "$USERNAME"
echo "✓ $USERNAME now has sudo privileges"

read -rp "Installation is complete! Would you like to run the setup script now? (Y/n): " RUN_SETUP_SCRIPT
if [ "$RUN_SETUP_SCRIPT" == "Y" ]; then
  https://raw.githubusercontent.com/melosomelo/dotfiles/refs/heads/main/env-bootstrap/setup.sh > setup.sh
  chmod +x ./setup.sh
  mv ./setup.sh /mnt/home/$USERNAME
  arch-chroot /mnt runuser -u $USERNAME -- bash /home/$USERNAME/setup.sh
else
  echo "Skipping setup. Remember to execute it later as the newly added $USERNAME user!"
fi