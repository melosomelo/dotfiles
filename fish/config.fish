# global variables 
set -gx DOTFILES $HOME/dotfiles

# start X at login
if status is-login
  if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
    exec startx -- -keeptty
  end
end