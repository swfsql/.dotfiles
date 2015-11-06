

[[ $- != *i* ]] && return

# http://ruderich.org/simon/config/zshrc
umask 007
setopt autocd
autoload -Uz zmv
setopt histignorealldups
setopt histignorespace
autoload -Uz colors && colors
bindkey -v
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

# Alias

alias fl='ranger'
alias k='clear && mathomatic -q'
alias feh='feh -FdZ'

alias dir2tar='find . -type d -maxdepth 1 -mindepth 1 -exec tar cvf {}.tar {}  \;'
alias tar2pgp='find . -type f -name \*.tar -maxdepth 1 -exec gpg --encrypt -r Thiago -o {}.gpg {} \; -exec rm {} \;'
alias dec='gpg --decrypt -r Thiago -o'
alias enc='gpg --encrypt -r Thiago -o'
alias gpg2tar='find . -type f -name \*.gpg -maxdepth 1 -exec gpg --decrypt -r Thiago -o {}.tar {} \;'


alias ls='ls -hF --color=auto'
alias ll='ls -l'
alias la='ll -A'

alias ..='cd .. && ls'
alias ...='cd ../.. && ls'
alias lk='cd'
alias grep='grep --color=auto'
alias mkdir='mkdir -p -v'
alias ping='ping -c 3'
alias :q=' exit'
alias :Q=' exit'
alias :x=' exit'
alias cd..='cd ..'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias cls=' echo -ne "\033c"'

alias shut='systemctl poweroff'
alias shutdown='systemctl poweroff'
alias reboot='systemctl reboot'

alias fb="printf '\33]50;%s\007' 'xft:Inconsolata:pixelsize=26:antialias=true:hinting=true'"
alias fm="printf '\33]50;%s\007' 'xft:Inconsolata:pixelsize=12:antialias=true:hinting=true'"
alias fs="printf '\33]50;%s\007' 'xft:Inconsolata:pixelsize=8:antialias=true:hinting=true'"

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

# SE SAIR, VOLTAR AO LOGIN DO THI


# if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
#   startx
#   logout
# fi


# Converte um video para mp3
function mp3 () {
  ffmpeg -threads 8 -i "$1" -q:a 0 -map a "${1}.mp3"
}


# PROMPT

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code=" %(?. .%{$fg[red]%} %? %{$reset_color%})"

local THI_COL=$(( COLUMNS / 2 ))
if [[ $COLUMNS < 46 ]] ; then
  THI_COL=$(( ( COLUMNS - 12 ) / 2 ))
fi

PROMPT='%{$FG[105]%}%(!.#.>)%{$reset_color%} '
RPROMPT='$(git_prompt_info)${return_code}$FG[032]%$THI_COL<..<${PWD/#$HOME/~}%<<%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
