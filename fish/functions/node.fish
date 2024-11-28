function node
  if test -f ./.nvmrc
    nvm -s use && command node $argv
  else
    command node $argv
  end
end