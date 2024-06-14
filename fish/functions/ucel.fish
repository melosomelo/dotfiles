# Update Code Extension List
function ucel
  code --list-extensions > $HOME/dotfiles/code/extensions.txt
  echo "Extension list was updated. Please, commit your changes."
end