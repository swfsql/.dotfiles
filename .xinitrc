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

# font
#xset +fp /usr/share/fonts/local
#xset +fp /usr/share/fonts/TTF
#xset +fp /usr/share/fonts/100dpi
#xset +fp /usr/share/fonts/misc
#xset +fp /usr/share/fonts/truetype
#xset fp rehash

xsetroot -cursor_name left_ptr


#: "${wm:=$HOME/down/tar/monsterwm/monsterwm}"
#: "${ff:="/tmp/monsterwm.fifo"}"
#[[ -p $ff ]] || mkfifo -m 600 "$ff"


urxvt & 
find ~/files/img/wall/ -type f \( -name '*.jpg' -o -name '*.png' \) -print0 | shuf -n1 -z | xargs -0 feh --bg-fill &  # feh --bg-fill down/img/wall/fog-forest-tree-nature-1440x2560.jpg  & # nitrogen --restore & #bg
#conky &
#mpd &
#exec dwm

#fifo="/tmp/m"

#trap 'rm -f "${fifo}"' INT TERM EXIT
#[ -p "${fifo}" ] || { rm -f "${fifo}"; mkfifo -m 600 "${fifo}"; }
#conky < "${fifo}" | bar &

# bar
conky | dzen2 -e '' -h '12' &

/usr/bin/xscreensaver -no-splash &
exec xmonad

#exec monsterwm

#&
#bar
