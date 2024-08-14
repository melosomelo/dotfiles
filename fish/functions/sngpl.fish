# Save Node Global Packages List
function sngpl
  nvm use system -s
  set -l result $(node -v | grep -oE 'v[0-9]+\\.[0-9]+\\.[0-9]+')
  set -l non_system_node_versions $(nvm ls | grep -oE 'v[0-9]+\\.[0-9]+\\.[0-9]+')
  for node_version in $non_system_node_versions
    echo oi $node_version
    set -l result "$result\n$node_version"
  end
  echo wooooooooooooooo $result
end