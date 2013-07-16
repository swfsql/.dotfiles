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
    xrdb -merge $HOME/.Xresources_light
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

#####

xset -b #fuck you beep

xsetroot -cursor_name left_ptr

./.scripts/ytold & # move videos antigos do youtube para old/

urxvtd -q -o -f 
urxvtc &

# BACKGROUND
cat ~/.bg | xargs -0 feh --bg-fill &
find ~/hd/img/wall/ -type f \( -name '*.jpg' -o -name '*.png' \) -print0 | shuf -n1 -z > ~/.bg
BGI=$(cat ~/.bg)
rm ~/.bgi
ln -s $BGI ~/.bgi

/usr/bin/xscreensaver -no-splash &
mpd &
aria2c --conf-path=$HOME/.aria2/aria2d.conf &
exec xmonad
