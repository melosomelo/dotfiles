# dotfiles

My personal configuration files and scripts for a Arch Linux + KDE environment.

## Setup

Steps that need to be taken in order to setup the environment. This is not aimed at being customizable.
It's just a list for my personal use so that I have something to follow when I need to setup a new environment.
Will likely turn into a script in the future.

1. Follow the [Arch Linux installation guide](https://wiki.archlinux.org/title/Installation_guide).
   In the "Install essencial packages" section, make sure to also install `networkmanager`, `neovim`, `sudo` and `git`
2. Login with root
3. `systemctl enable NetworkManager.service && systemctl start NetworkManager.service`
4. Connect to the Internet with `nmtui`
5. `useradd -m mateus`
6. `passwd mateus`
7. `EDITOR=neovim visudo` and uncomment line for the `wheel` group
8. `usermod -aG wheel mateus`
9. Logout and login as `mateus`
10. `cd`
11. `git clone https://github.com/melosomelo/dotfiles`
12. `sudo pacman -S $(cat dotfiles/packages/official.txt)`
13. [Install `yay`](https://github.com/Jguer/yay?tab=readme-ov-file#installation)
14. `yay -S $(cat dotfiles/packages/aur.txt)`
15. `mkdir -p ~/.config/alacritty`
16. `ln -s  ~/dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml`
17. run `fish` and then `exit`
18. `rm .config/fish/config.fish`
19. `rm -rf .config/fish/functions`
20. `chsh -s /usr/bin/fish`
21. `curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish`
22. `omf install l`
23.

```
for ext in $(cat dotfiles/code/extensions.txt)
        code --install-extension $ext
end
```

24. `ln -s  ~/dotfiles/code/settings.json ~/.config/Code/User/settings.json`
25. `ln -s  ~/dotfiles/code/keybindings.json ~/.config/Code/User/keybindings.json`
26. `mkdir -p ~/.ssh`
27. `touch ~/.ssh/config`
28. Configure `ssh` for GitHub authentication via the `config` file
29. Run `gh auth login`
30. `sudo mkdir -p /etc/pacman.d/hooks`
31. `sudo ln -s ~/dotfiles/pacman/hooks/save_package_list.hook /etc/pacman.d/hooks`
32. Reboot
