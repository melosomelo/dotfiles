#!/usr/bin/bash

set -e

log() {
  local level="$1"; shift
  local timestamp
  timestamp="$(date '+%Y-%m-%d %H:%M:%S')"

  case "$level" in
    INFO)  color="\033[1;32m" ;;  # Green
    WARN)  color="\033[1;33m" ;;  # Yellow
    ERROR) color="\033[1;31m" ;;  # Red
    *)     color="\033[0m"    ;;  # Default
  esac

  printf "${color}[%s] [%s] %s\033[0m\n" "$timestamp" "$level" "$*"
}

arch_iso_download_url="$(curl --fail --silent --show-error 'https://archlinux.org/feeds/releases/' | xml sel -t -v '//channel/item[1]/link')torrent"

if [ "$SKIP_ISO_DOWNLOAD" != 1 ]; then
  log INFO "Downloading Arch Linux ISO from $arch_iso_download_url"
  aria2c --seed-time=0 $arch_iso_download_url
  mv $(ls | grep -E ".*\.iso\$") archlinux.iso
fi

if [ "$SKIP_ISO_REMASTER" != 1 ]; then
  log INFO "Remastering ISO file with modified boot parameters"
  mkdir -p ~/archiso/iso ~/archiso/work
  mount -o loop archlinux.iso ~/archiso/iso
  cp -rT ~/archiso/iso ~/archiso/work
  umount ~/archiso/iso
  sed -i 's/\(APPEND.*\)$/\1 autologin console=ttyS0/' ~/archiso/work/boot/syslinux/archiso_sys-linux.cfg
  script_dir=$(pwd)
  cd ~/archiso/work
  xorriso -as mkisofs \
    -iso-level 3 \
    -full-iso9660-filenames \
    -volid "ARCH_$(date +%Y%m)" \
    -output "$script_dir/archlinux-custom.iso" \
    -eltorito-boot boot/syslinux/isolinux.bin \
        -eltorito-catalog boot/syslinux/boot.cat \
        -no-emul-boot -boot-load-size 4 -boot-info-table \
    -isohybrid-mbr boot/syslinux/isohdpfx.bin \
    -eltorito-alt-boot \
        -e EFI/BOOT/BOOTx64.EFI \
        -no-emul-boot \
    -m "arch/x86_64/airootfs.sfs.cms.sig" \
    -graft-points . 
  rm -rf ~/archiso/iso ~/archiso/work
  cd $script_dir
  mv archlinux-custom.iso archlinux.iso
fi

log INFO "Creating virtual machine from ISO"
virt-install \
  --name archlinux-test \
  --memory 2048 \
  --vcpus 2 \
  --cdrom archlinux.iso \
  --os-variant archlinux \
  --disk size=2 \
  --transient \
  --graphics none \
  --noautoconsole