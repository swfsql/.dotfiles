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

# screensaver
/usr/bin/xscreensaver -no-splash &

# background
cat ~/.tmp/bg | xargs -0 feh --bg-fill &

#cursor speed & pic
xset m 6/1 1
xsetroot -cursor_name left_ptr

# music
mpd &

urxvtd -q -o -f 
urxvtc &

setxkbmap -model jp106 -layout jp -option ctrl:nocaps


#
#-------
#
while true; do

  # Power/Battery Status
  DWM_BATTERY=$(( `cat /sys/class/power_supply/BAT1/charge_now` * 100 / `cat /sys/class/power_supply/BAT1/charge_full` ));
  if [ "$( cat /sys/class/power_supply/ADP1/online )" -eq "1" ]; then
    DWM_BATTERY=${DWM_BATTERY}"Λ";
    DWM_RENEW_INT=3;
  else
    DWM_BATTERY=${DWM_BATTERY}"V";
    DWM_RENEW_INT=30;
  fi;

  # Volume Level
  DWM_VOL=$( amixer -c0 sget Master | awk -vS0=' ' '/Mono:/ {print substr($4, 2, length($4) - 3)}' );

  # Date and Time
  DWM_CLOCK=$( date '+%a %e %b %l:%M' );

  # RAM Memory usage
  DWM_RAM=$( free -m | awk -vS1=' ' '/Mem:/ {printf "%2.0f", 100 * $3 / $7}'  );

  # CPU Usage
  DWM_CPU_A=($(sed -n '2,9p' /proc/stat));
  DWM_CPU_B=(0 0 0 0 0 0 0 0);
  for ((i=0; i<8; i++)) ;
  do
    for ((j=0; j<4; j++)) ;
    do
      DWM_CPU_B[i]=$((${DWM_CPU_B[i]} + ${DWM_CPU_A[1 + i * 11 + j]}));
    done
  done
  sleep 1
  DWM_CPU_C=($(sed -n '2,9p' /proc/stat));
  DWM_CPU_D=(0 0 0 0 0 0 0 0);
  for ((i=0; i<8; i++)) ;
  do
    for ((j=0; j<4; j++)) ;
    do
      DWM_CPU_D[i]=$((${DWM_CPU_D[i]} + ${DWM_CPU_C[1 + i * 11 + j]}));
    done
  done
  DWM_CPU_E=(0 0 0 0 0 0 0 0);
  for ((i=0; i<8; i++)) ;
  do
    DWM_CPU_E[i]=$(((100 * (${DWM_CPU_B[i]} - ${DWM_CPU_D[i]} - ${DWM_CPU_A[4 + i * 11]} + ${DWM_CPU_C[4 + i * 11]})) / (${DWM_CPU_B[i]} - ${DWM_CPU_D[i]})));
  done
  OLDIFS=$IFS
  IFS=$'\n'
  DWM_CPU_MAX=$(echo "${DWM_CPU_E[*]}" | sort -nr | head -n1);
  IFS=$OLDIFS
  echo $DWM_CPU_MAX
  DWM_CPU_AVERAGE=0;
  for i in "${DWM_CPU_E[@]}"
  do
    DWM_CPU_AVERAGE=$((DWM_CPU_AVERAGE + i))
  done
  DWM_CPU_AVERAGE=$((DWM_CPU_AVERAGE/8))

  # Overall output command
  DWM_STATUS="${DWM_RAM}r ${DWM_CPU_AVERAGE}/${DWM_CPU_MAX}c ${DWM_CPUF}f ${DWM_VOL}v $DWM_BATTERY $DWM_CLOCK";
  xsetroot -name "$DWM_STATUS";
  sleep $DWM_RENEW_INT;

done &
#--------
#
#
#$cpu $memperc ${freq_g (1)} 
#---
#
#
#${hwmon temp 1} 
#---
#
#
#${diskio_read}   ${diskio_write} 
#---
#
#
#${upspeedf enp2s0f5}   ${downspeedf enp2s0f5} 
#---
#
#
#$if_mpd_playing
#$mpd_smart
#$endif 
#---
#
#









# change background for next session
find ~/hd/img/wall/ -type f \( -name '*.jpg' -o -name '*.png' \) -print0 | shuf -n1 -z > ~/.tmp/bg
BGI=$(cat ~/.tmp/bg)
rm ~/.tmp/bgi
ln -s $BGI ~/.tmp/bgi

exec dwm
