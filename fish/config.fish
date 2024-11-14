# abbreviations
abbr -a gs git status
abbr -a gd git diff
abbr -a ga git add
abbr -a gps git push
abbr -a gpso git push origin
abbr -a gpsom git push origin main
abbr -a gpl git pull
abbr -a gc git commit
abbr -a gcm git commit -m \"
abbr -a gco git checkout

abbr -a ngmo nest g mo
abbr -a ngco nest g co
abbr -a ngpr nest g pr

abbr -a lz lazydocker

abbr -a tls tmux ls
abbr -a ta tmux a

# aliases
alias v nvim

# global variables
set -g fish_greeting
set -gx DOTFILES $HOME/dotfiles
set -gx EDITOR nvim
set -gx NVM_INITIALIZED false
set -gx QT_STYLE_OVERRIDE breeze

# start X at login
if status is-login
  if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
	  #exec startx -- -keeptty
  end
end

if status is-interactive
  zoxide init fish | source
end
