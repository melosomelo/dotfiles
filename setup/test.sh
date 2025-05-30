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

log INFO "Downloading Arch Linux ISO from $arch_iso_download_url"
aria2c --seed-time=0 --out=archlinux.iso $arch_iso_download_url

log INFO "Creating virtual machine from ISO"