#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

QT_QPA_PLATFORMTHEME="qt5ct"
xset r rate 200 20 #adjust key delay and repeat rate
xinput set-prop "DLL080D:01 06CB:7A13 Touchpad" "libinput Tapping Enabled" 1 #enable tapping on touchpad
setxkbmap -option caps:escape # map Caps Lock to ESC
wal -R # restore the last pywal colorscheme that was on use
/.fehbg & # set the background on startup
export DESKTOP_SESSION=plasma
export KDEWM=/usr/bin/i3
exec startplasma-x11
