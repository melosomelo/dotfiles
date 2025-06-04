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

pacstrap -K /mnt base linux linux-firmware
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
  read -rsp "Enter the root password for the system: " PASSWORD
fi
arch-chroot /mnt /bin/bash -c "echo \"$ROOT_PASSWORD\" | passwd --stdin"
echo
echo "✓ Root password set successfully"