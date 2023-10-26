function node
  if not $NVM_INITIALIZED
    load_nvm
  end
  command node $argv
end