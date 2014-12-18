#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export EDITOR='vim'
autoload -Uz zmv
setopt histignorealldups
setopt histignorespace

bindkey -v

alias fl="ranger"
alias ur="urxvt &! exit"
export PATH="$HOME/Library/Haskell/bin:$PATH"
