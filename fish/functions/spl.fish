# Save Package List
function spl
  cd $DOTFILES
  git stash clear && git add . && git stash && git pull && git stash pop
  pacman -Qqen > packages/official.txt
  pacman -Qqem > packages/aur.txt
  git add .
  git commit -m "[$(date +%Y-%m-%d_%H:%M)] updating packages list"
  git push origin
end
