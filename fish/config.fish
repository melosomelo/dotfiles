# abbreviations
abbr -a ga git add
abbr -a gp git push
abbr -a gpo git push origin
abbr -a gpom git push origin main

# global variables
set -g fish_greeting
set -gx DOTFILES $HOME/dotfiles

# start X at login
if status is-login
  if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
    exec startx -- -keeptty
  end
end
