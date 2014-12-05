set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'fatih/vim-go'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'


call vundle#end()            " required
filetype plugin indent on    " required  

" Configuration file for vim
set modelines=0		" CVE-2007-2438
set backspace=2		" more powerful backspacing

set number
syntax enable
set background=light
let g:solarized_termcolors = 256
colorscheme solarized
set incsearch
set spell
set spelllang=en_us
set tabstop=2
set shiftwidth=2
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set backspace=2
set cursorline
set colorcolumn=0

set grepprg=grep\ -nH\ $*
let g:text_flavor = "latex"

" airline plugin
set laststatus=2

imap jj <Esc>
