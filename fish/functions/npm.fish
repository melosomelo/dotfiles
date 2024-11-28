function npm
  if test -f ./.nvmrc
    nvm -s use && command npm $argv
  else
    command npm $argv
  end
end