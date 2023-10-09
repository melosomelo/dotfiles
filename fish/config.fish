# abbreviations
abbr -a gs git status
abbr -a ga git add
abbr -a gp git push
abbr -a gpo git push origin
abbr -a gpom git push origin main
abbr -a gc git commit
abbr -a gcm git commit -m \"

# aliases
alias v nvim

# global variables
set -g fish_greeting
set -gx DOTFILES $HOME/dotfiles
set -gx BSPWM_SPLIT_AREA_DIR west

# start X at login
if status is-login
  if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
    exec startx -- -keeptty
  end
end

if status is-interactive
  # applying selected wal theme to new terminals
  cat ~/.cache/wal/sequences
end
