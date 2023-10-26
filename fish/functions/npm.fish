function npm
  if not $NVM_INITIALIZED
    load_nvm
  end
  command npm $argv
end