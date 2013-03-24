

[[ $- != *i* ]] && return

# Alias

alias fl='ranger'
alias subl='subl'

alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -a'
alias ..='cd .. && ls'
alias ...='cd ../.. && ls'
alias lk='cd'

alias shutdown='sudo shutdown -h now'
alias reboot='sudo reboot'
alias lo='xscreensaver-command --lock &! exit'
alias lç='lo'

alias dsk='sudo fdisk -l'
alias w8='sudo mount /dev/sda2 /w8'

alias pl='lyvi'
alias p='mpc toggle'
alias pa='mpc clear && mpc load all && mpc shuffle && mpc volume 60 && mpc play'
alias load='mpc load'
alias shuf='mpc shuffle'
alias next='mpc next'
alias prev='mpc prev'
alias vol='mpc volume'
alias high='mpc volume 100'
alias low='mpc volume 60'

alias dj='mplayer -playlist http://www.bbc.co.uk/radio1/wm_asx/aod/radio1.asx'
alias folk='mplayer -playlist http://mms-live.online.no/p4_country.m3u'
alias folk2='mplayer -playlist http://server-10.stream-server.nl:8300/listen.pls'
alias rock='mplayer -playlist http://sc6.radiocaroline.net:8040/listen.pls'
alias chill='mplayer -playlist http://media-ice.musicradio.com/ChillMP3'


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

    fi
 }

# CONEXÃO

funcion net(){
  if [[ $# == "1" ]] ; then
    proxy $1
    sudo netcfg $1
  fi
  chromium &! exit
}


# SE SAIR, VOLTAR AO LOGIN DO THI


if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
  startx
  logout
fi


# PROMPT

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code=" %(?. .%{$fg[red]%}%?%{$reset_color%})"

PROMPT='%{$FG[105]%}%(!.#.»)%{$reset_color%} '
RPROMPT='$(git_prompt_info)$FG[032]%~%{$reset_color%}${return_code}'

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
