# dotfiles

## Todo

- [ ] VSCode
    - [ ] Configure VSCode
    - [ ] Add VSCode configuration to `setup.sh`
- [ ] Neovim
    - [ ] Review Neovim configuration (`packer` is no longer maintained)
    - [x] ~Add Neovim configuration to `setup.sh`~
- [ ] Pacman
    - [ ] Define cache cleaning strategy
    - [ ] Define backup strategy
- [ ] Picom
    - [ ] Configure `picom`
    - [ ] Add picom configuration to `setup.sh`
    - [ ] Find a way to add rounded borders with i3 or switch to another window manager
- [x] ~Add support for AUR packages~
  - [x] ~Create script to automatically download, build and install AUR packages~ (used `yay`)
  - [x] ~Add suport for installed AUR packages on the installed packages list~
  - [x] ~Add support for AUR packages on the `setup.sh`~
- [ ] Configure clibpoard with support for texts and images
- [ ] Configure screenshot and investigate integration with clipboard
- [ ] Add git authentication to `setup.sh` script.
- [x] ~Add `xdg-user-dirs` configuration to `setup.sh` script.~
- [x] ~Create fish function to update mirror list with `reflector` and also
      enable its service to periodically run.~
- [x] ~Install `yay` during `setup.sh`~

## Install and setup scripts

There are two main scripts to setup an Arch Linux instance based on this config: `install.sh`
and `setup.sh`. `install.sh` performs the basic system installation as per the
[Arch Linux installation guide](https://wiki.archlinux.org/title/installation_guide)
and creates a new sudo user named `mateus`, while `setup.sh` installs and configures the relevant
pieces of software.

Before installing, make sure that you're connected to the Internet, that you have a disk
attached that you to partition and that you know its path on the installation image
filesystem.

To actually perform the installation, execute the following command:

```
curl https://raw.githubusercontent.com/melosomelo/dotfiles/main/install.sh > install.sh && chmod +x ./install.sh && ./install.sh
```

After the installation is complete, the script will prompt you to check if you want to download
and execute the `setup.sh` script. If you want to perform the setup later, download the
script just as previously with `install.sh` and **make sure to execute the script as the newly
created user!**

