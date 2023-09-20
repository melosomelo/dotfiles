# update /etc/pacman.d/mirrorlist using the reflector package
function update_mirrorlist
  set countries BR,US
  if test $(count $argv) -ne 0
    set countries $argv
  end
  sudo reflector --latest 5 --sort rate --country $countries --save /etc/pacman.d/mirrorlist
end
