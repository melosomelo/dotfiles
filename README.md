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
20. `ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish`
21. `ln -s ~/dotfiles/fish/functions ~/.config/fish`
22. `ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf`
23. `chsh -s /usr/bin/fish`
24. `curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish`
25. `omf install l`
26. `omf install https://github.com/jorgebucaran/nvm.fish`
27.

```
for ext in $(cat dotfiles/code/extensions.txt)
        code --install-extension $ext
end
```

28. `ln -s  ~/dotfiles/code/settings.json ~/.config/Code/User/settings.json`
29. `ln -s  ~/dotfiles/code/keybindings.json ~/.config/Code/User/keybindings.json`
30. `mkdir -p ~/.ssh`
31. `touch ~/.ssh/config`
32. Configure `ssh` for GitHub authentication via the `config` file
33. Run `gh auth login`
34. `sudo mkdir -p /etc/pacman.d/hooks`
35. `sudo ln -s ~/dotfiles/pacman/hooks/save_package_list.hook /etc/pacman.d/hooks`
36. `sudo systemctl enable docker.service`
37. `sudo systemctl start docker.service`
38. `sudo usermod -aG docker mateus`
39. `sudo systemctl enable cronie && sudo systemctl start cronie`
40. Reboot

## Wishlist

- [ ] Configure `tmux`
- [ ] Configure `qutebrowser`
- [ ] Save web bookmarks independently of web browser
- [ ] Implement a "work mode". This'd be a mode that can be toggled in order to use more work optimized software.
      For instance, use i3 + qutebrowser instead of Chrome + Kwin. It'd be cool for times when I want to use my computer more
      casually or for when other people need to use it for some reason.
- [ ] Add some cool themes with color schemes
