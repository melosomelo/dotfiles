#!/usr/bin/bash
set -e

echo -e "\033[1mArch Linux installation script\033[0m. Written by \033[1;36mMateus Nascimento\033[0m (\033[4;36m@melosomelo\033[0m)"

# Simple (and a bit crude) check to display help prompt. 
for arg in "$@"; do
  case "$arg" in
    -h|--help)
    echo
    echo "This script follows the steps from the Arch Linux installation guide and is meant to be run"
    echo "only in the Arch Linux installation image. Running it elsewhere may have drastic consequences."
    echo
    echo "It is interactive by default, but it can be made headless by passing required values via shell variables:"
    echo -e "  \033[1;3;36mVARIABLE=1 ./install.sh\033[0m"
    echo
    echo "Below are its capabilities and configuration options."
    echo
    echo "1. Disk partitioning"
    echo -e "This script uses the GNU parted tool to partition a \e[1msingle\e[0m disk of your choosing."
    echo "It creates three partitions:"
    echo "  - One EFI boot partition"
    echo "  - One swap partition"
    echo "  - One Ext4 root partition"
    echo
    echo "You can specify the start and end of each partition using the syntax accepted by parted (see its manpage)."
    echo "This setup suits most use cases, but may not be ideal for complex layouts."
    echo
    echo "If you'd rather format your disk manually, you can run script with SKIP_DISK_PARTITIONING set to 1."
    echo
    echo "Partitioning is configured using these variables:"
    echo "  - TARGET_DISK"
    echo "  - BOOT_PARTITION_START"
    echo "  - BOOT_PARTITION_END"
    echo "  - SWAP_PARTITION_START"
    echo "  - SWAP_PARTITION_END"
    echo "  - ROOT_PARTITION_START"
    echo "  - ROOT_PARTITION_END"
    echo
    echo "Example:"
    echo "  TARGET_DISK=/dev/sda BOOT_PARTITION_START=0MiB BOOT_PARTITION_END=512MiB ./install.sh"
    echo
    echo "Partitioning is an inherently dangerous operation, so always be careful when doing it (especially via automated scripts ;))."
    exit 0
  esac
done

for i in {5..1}; do
  echo -ne "Starting in $i\r"
  sleep 1
done
echo

pacman -Sy --noconfirm --quiet gum > /dev/null

if [ "$SKIP_DISK_PARTITIONING" != 1 ]; then
  if [ -z "$TARGET_DISK" ]; then
    TARGET_DISK=$(gum input \
      --header "Provide the path for the disk to be partitioned" \
      --placeholder "Something like /dev/sda")
  else
    gum log --level debug "Target disk was passed as a variable. Using value '$TARGET_DISK'."
  fi
  if [ ! -b "$TARGET_DISK" ]; then
    gum log --level error "Device $TARGET_DISK does not exist"
    exit 1
  fi

  if [ -z "$BOOT_PARTITION_START" ]; then
    BOOT_PARTITION_START=$(gum input \
      --header "Specify the start of the boot partition" \
      --placeholder "An offset from the beginning of the disk (e.g. 0%, 1MiB)"
    )
  else
    gum log --level debug "Boot partition start was passed as a variable. Using value '$BOOT_PARTITION_START'"
  fi

  if [ -z "$BOOT_PARTITION_END" ]; then
    BOOT_PARTITION_END=$(gum input \
      --header "Specify the end of the boot partition" \
      --placeholder "An offset from the beginning of the disk (e.g. 0%, 1MiB)"
    )
  else
    gum log --level debug "Boot partition end was passed as a variable. Using value '$BOOT_PARTITION_END'"
  fi

  if [ -z "$SWAP_PARTITION_START" ]; then
    SWAP_PARTITION_START=$(gum input \
      --header "Specify the start of the swap partition" \
      --placeholder "An offset from the beginning of the disk (e.g. 0%, 1MiB)"
    )
  else
    gum log --level debug "Swap partition start was passed as a variable. Using value '$SWAP_PARTITION_START'"
  fi

  if [ -z "$SWAP_PARTITION_END" ]; then
    SWAP_PARTITION_END=$(gum input \
      --header "Specify the end of the swap partition" \
      --placeholder "An offset from the beginning of the disk (e.g. 0%, 1MiB)"
    )
  else
    gum log --level debug "Swap partition end was passed as a variable. Using value '$SWAP_PARTITION_END'"
  fi

  if [ -z "$ROOT_PARTITION_START" ]; then
    ROOT_PARTITION_START=$(gum input \
      --header "Specify the start of the root partition" \
      --placeholder "An offset from the beginning of the disk (e.g. 0%, 1MiB)"
    )
  else
    gum log --level debug "Root partition start was passed as a variable. Using value '$ROOT_PARTITION_START'"
  fi

  if [ -z "$ROOT_PARTITION_END" ]; then
    ROOT_PARTITION_END=$(gum input \
      --header "Specify the end of the root partition" \
      --placeholder "An offset from the beginning of the disk (e.g. 0%, 1MiB)"
    )
  else
    gum log --level debug "Root partition end was passed as a variable. Using value '$ROOT_PARTITION_END'"
  fi

  if false
  then
    :
  else
    gum log --level error "PARTITIONING FAILED. At least one of the partitions was not successfully created."
    gum log --level error "The disk is most likely at an inconsistent state. You'll have to fix it manually."
  fi
fi