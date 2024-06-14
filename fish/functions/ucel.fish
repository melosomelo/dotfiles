# Update Code Extension List
function ucel
  cd $DOTFILES
  git stash clear && git add . && git stash && git pull && git stash pop
  code --list-extensions > $HOME/dotfiles/code/extensions.txt
  git add .
  git commit -m "[$(date +%Y-%m-%d_%H:%M)] updating vscode extensions list"
  git push origin main
end