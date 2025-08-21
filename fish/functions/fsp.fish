# utility to free some space
function fsp
  # clearing yay and pacman cache
  yay -Scc --noconfirm
  yarn cache clean
  npm cache clean --force
end
