# dotfiles

## Todo

- [ ] Add git authentication into `setup.sh` script.
- [ ] Add `xdg-user-dirs` configuration into `setup.sh` script.
- [ ] Create fish function to update mirror list with `reflector` and also
      enable its service to periodically run.
- [ ] Define pacman cache cleaning strategy.
- [ ] Define backup strategy.
- [ ] Configure clipboard

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
