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

## Setup script

The `setup.sh` script performs the Arch Linux installation and also sets up my dotfiles
for the installed applications.

To use it, boot into the Arch Linux installation image,
[make sure you're connected to the internet](https://wiki.archlinux.org/title/installation_guide#Connect_to_the_internet)
and then execute the following command:

```
curl https://raw.githubusercontent.com/melosomelo/dotfiles/main/setup.sh > setup.sh && chmod +x ./setup.sh && ./setup.sh
```

The script will prompt you for some information, such as the path
of the disk you want to partition, the hostname, the name of the new user other than sudo, the
password for that new user, etc.

Beware the this script **is currently not resilient against
faulty user input**. This means that if
you provide a wrong path to a disk or make a mistake when specifying the
password and thus cause an error,
the script will simply halt and will start from the beginning if you execute it
again. Since some commands here are not idempotent, my guess is that you may end up with an invalid
installation. But I don't know, I haven't tested such scenarios. In any case, if you make some mistakes,
just restart the installation from scratch. I'll eventually improve this script to deal with
such scenarios.
