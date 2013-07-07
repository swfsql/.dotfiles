

[[ $- != *i* ]] && return

# http://ruderich.org/simon/config/zshrc
umask 007
setopt autocd
autoload -Uz zmv
setopt histignoredups
setopt histignorespace
autoload -Uz colors && colors

# Alias

alias fl='ranger'
alias k='clear && mathomatic -q'
alias wf='sudo wifi-menu'
alias pl='mplayer '
alias hora='feh ~/faku/hora.png'
alias ariad='aria2c --conf-path=/home/thi/.aria2/aria2d.conf'

alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -a'
alias ..='cd .. && ls'
alias ...='cd ../.. && ls'
alias lk='cd'
alias grep='grep --color=auto'

alias shut='sudo shutdown -h now'
alias shutdown='sudo shutdown -h now'
alias reboot='sudo reboot'



function cv() {
 if [[ $1 == *\.c ]]; then
  gcc $1 `pkg-config --libs --cflags opencv`
 elif [[ $1  == *\.cpp ]]; then
  g++ $1 `pkg-config --libs --cflags opencv`
 else
  echo "extensao invalida"
  return
 fi
 ./a.out
}

## ex - archive extractor
# usage: ex <file>
function ex() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2|*.tbz2) tar xjf $1 ;;
      *.tar.gz)         tar xzf $1   ;;
      *.bz2)            bunzip2 $1   ;;
      *.rar)            unrar e $1   ;;
      *.gz)             gunzip $1    ;;
      *.tar)            tar xf $1    ;;
      *.tgz)            tar xzf $1   ;;
      *.zip)            unzip $1     ;;
      *.Z)              uncompress $1;;
      *.7z)             7z x $1      ;;
      *)                echo "'$1' cannot be extracted via ex" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# PROXY

 function proxy(){

    if [[ $1 == "thi" ]] ; then

     unset HTTP_PROXY
     unset http_proxy
     unset HTTPS_PROXY
     unset https_proxy
     unset FTP_PROXY
     unset ftp_proxy
     echo -e "\nProxy environment variable removed."

    elif [[ $1 == "uni" ]]; then 

     export http_proxy="http://172.16.1.1:3128/"
     export https_proxy="http://172.16.1.1:3128/"
     export ftp_proxy="http://172.16.1.1:3128/"
     export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
     echo -e "\nProxy environment variable set."

    elif [[ $1 == "uni2" ]]; then 

     export http_proxy="http://172.16.1.1:3128/"
     export https_proxy="http://172.16.1.1:3128/"
     export ftp_proxy="http://172.16.1.1:3128/"
     export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
     echo -e "\nProxy environment variable set."

    fi
 }

# CONEXÃO

# funcion net(){
#   if [[ $# == "1" ]] ; then
#     proxy $1
#     sudo netcfg $1
#   else
#     dwb &! exit
#   fi
# }
# alias bro='net bro'
# alias uni='net uni'
# alias uni2='net uni2'
# alias net2='chromium &! exit'


# TEMA

sublrc=$HOME/.config/sublime-text-2/Packages/User/Preferences.sublime-settings
conkyrc=$HOME/.conkyrc
dwbrc=$HOME/.config/dwb/settings
tmprc=$HOME/.tmprc
function light() {
  xrdb -load $HOME/.Xresources
  xrdb -merge $HOME/.Xresources_light
  
  echo $(cat $sublrc| sed -r "s/\(Dark\)\.tmTheme/(Light).tmTheme/") > $sublrc
  
  cat $conkyrc| sed -r "s/own_window_colour 002b36/own_window_colour fdf6e3/" > $conkyrc.tmp
  cat $conkyrc.tmp > $conkyrc
  cat $conkyrc | sed -r "s/color #839496/color #657b83/" > $conkyrc.tmp
  cat $conkyrc.tmp > $conkyrc
  cat $conkyrc | sed -r "s/default_shade_color 073642/default_shade_color eee8d5/" > $conkyrc.tmp
  cat $conkyrc.tmp > $conkyrc
  rm $conkyrc.tmp

  cat $dwbrc| sed -r "s/002b36/fdf6e3/" > $tmprc.tmp
  cat $tmprc.tmp > $dwbrc
  cat $dwbrc | sed -r "s/073642/eee8d5/" > $tmprc.tmp
  cat $tmprc.tmp > $dwbrc
  cat $dwbrc | sed -r "s/586e75/93a1a1/" > $tmprc.tmp
  cat $tmprc.tmp > $dwbrc
  cat $dwbrc | sed -r "s/657b83/839496/" > $tmprc.tmp
  cat $tmprc.tmp > $dwbrc
  rm $tmprc.tmp

  xmonad --restart
  urxvt &! exit
}


function dark() {
  xrdb -load $HOME/.Xresources
  xrdb -merge $HOME/.Xresources_dark
  
  echo $(cat $sublrc | sed -r "s/\(Light\)\.tmTheme/(Dark).tmTheme/") > $sublrc

  cat $conkyrc| sed -r "s/own_window_colour fdf6e3/own_window_colour 002b36/" > $conkyrc.tmp
  cat $conkyrc.tmp > $conkyrc
  cat $conkyrc | sed -r "s/color #657b83/color #839496/" > $conkyrc.tmp
  cat $conkyrc.tmp > $conkyrc
  cat $conkyrc | sed -r "s/default_shade_color eee8d5/default_shade_color 073642/" > $conkyrc.tmp
  cat $conkyrc.tmp > $conkyrc
  rm $conkyrc.tmp
  
  cat $dwbrc| sed -r "s/fdf6e3/002b36/" > $tmprc.tmp
  cat $tmprc.tmp > $dwbrc
  cat $dwbrc | sed -r "s/eee8d5/073642/" > $tmprc.tmp
  cat $tmprc.tmp > $dwbrc
  cat $dwbrc | sed -r "s/93a1a1/586e75/" > $tmprc.tmp
  cat $tmprc.tmp > $dwbrc
  cat $dwbrc | sed -r "s/839496/657b83/" > $tmprc.tmp
  cat $tmprc.tmp > $dwbrc
  rm $tmprc.tmp

  xmonad --restart
  urxvt &! exit
}


# SE SAIR, VOLTAR AO LOGIN DO THI


# if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
#   startx
#   logout
# fi


# Converte um video para mp3
function mp3 () {
  ffmpeg -i "$1" -q:a 0 -map a "${1}.mp3"
}


# Usado no Conky
function disk () {
  while read data
  do
    echo $data | sed -r "s/0B/0.0/g" | sed -r "s/([0-9])[0-9]{2,2}\.{0,1}[0-9]*K/0.\1/g" | sed -r "s/.*[BK]/0.1/g" | sed -r "s/\.([0-9])[0-9]/.\1/g" | sed -r "s/M//g"
  done
}


# PROMPT

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code=" %(?. .%{$fg[red]%} %? %{$reset_color%})"

local THI_COL=$(( COLUMNS / 2 ))
if [[ $COLUMNS < 46 ]] ; then
  THI_COL=$(( ( COLUMNS - 12 ) / 2 ))
fi

PROMPT='%{$FG[105]%}%(!.#.»)%{$reset_color%} '
RPROMPT='$(git_prompt_info)${return_code}$FG[032]%$THI_COL<..<${PWD/#$HOME/~}%<<%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
