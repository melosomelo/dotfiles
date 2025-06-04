#!/usr/bin/bash

set -e

arch_iso_download_url="$(curl --fail --silent --show-error 'https://archlinux.org/feeds/releases/' | xml sel -t -v '//channel/item[1]/link')torrent"

if [ "$SKIP_ISO_DOWNLOAD" != 1 ]; then
  echo "Downloading Arch Linux ISO from $arch_iso_download_url"
  aria2c --seed-time=0 $arch_iso_download_url
  mv $(ls | grep -E ".*\.iso\$") archlinux.iso
fi

# Commenting this out for now because it was just not working :(
# We remaster the ISO file to add some behaviors that are required to properly run the scripts in a CI environment
# if [ "$SKIP_ISO_REMASTER" != 1 ]; then
#   log INFO "Remastering ISO file"
# 
#   # Mounting the ISO locally so we can edit it
#   mkdir -p archiso/iso archiso/work
#   mount -o loop archlinux.iso archiso/iso
#   cp -rT archiso/iso archiso/work
#   umount archiso/iso
# 
#   # Send all output to the serial device ttyS0. Required to connect to the VM via virsh without any GUI
#   sed -i 's/\(APPEND.*\)$/\1 console=ttyS0/' archiso/work/boot/syslinux/archiso_sys-linux.cfg
# 
#   # Enabling autologin on ttyS0
#   unsquashfs -d archiso/airootfs archiso/work/arch/x86_64/airootfs.sfs
#   mkdir -p archiso/airootfs/etc/systemd/system/serial-getty@ttyS0.service.d
#   cat <<EOF > archiso/airootfs/etc/systemd/system/serial-getty@ttyS0.service.d/autologin.conf
# [Service]
# ExecStart=
# ExecStart=-/sbin/agetty --autologin root --noclear %I \$TERM
# EOF
#   rm archiso/work/arch/x86_64/airootfs.sfs
#   mksquashfs archiso/airootfs archiso/work/arch/x86_64/airootfs.sfs -comp zstd -noappend
# 
#   # Rebuilding the ISO file
#   cd archiso/work
#   xorriso -as mkisofs \
#   -iso-level 3 \
#   -full-iso9660-filenames \
#   -volid "ARCH_$(date +%Y%m)" \
#   -output "$(pwd)/archlinux-custom.iso" \
#   -eltorito-boot boot/syslinux/isolinux.bin \
#       -eltorito-catalog boot/syslinux/boot.cat \
#       -no-emul-boot -boot-load-size 4 -boot-info-table \
#   -isohybrid-mbr boot/syslinux/isohdpfx.bin \
#   -eltorito-alt-boot \
#       -e EFI/BOOT/BOOTx64.EFI \
#       -no-emul-boot \
#   -efi-boot-part --efi-boot-image --protective-msdos-label \
#   -m "arch/x86_64/airootfs.sfs.cms.sig" \
#   -graft-points .
#   mv archlinux-custom.iso ../
#   cd ..
#   rm -rf archiso/
#   mv archlinux-custom.iso archlinux.iso
# fi

echo "Creating virtual machine from ISO"
virt-install \
  --name archlinux-test \
  --memory 2048 \
  --vcpus 2 \
  --cdrom archlinux.iso \
  --os-variant archlinux \
  --disk size=20 \
  --transient \
  --boot uefi
  # --console pty,target_type=serial \
  # --graphics none \