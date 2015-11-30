#!/bin/sh

wmname LG3D # java fix
xset m 14/2 3 # mouse speed
xsetroot -cursor_name left_ptr # mouse cursor
setxkbmap -model pc104 -layout us,br -option ctrl:nocaps,grp:win_space_toggle # keyboard settings

# execute some scripts
$HOME/.script/xinitrc.default # the usual xinitrc
$HOME/.script/wallpaper & # random wallpaper 
$HOME/.script/statusbar & 

# start some programs
/usr/bin/xscreensaver -no-splash &
redshift -l -19.619898:-43.217412 &
dunst &
urxvtd -q -o -f
urxvtc &

exec dwm
