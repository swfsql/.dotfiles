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
Plugin 'tpope/vim-surround'
Plugin 'Valloric/YouCompleteMe'
Plugin 'mhinz/vim-startify'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'




call vundle#end()            " required
filetype plugin indent on    " required  

" Configuration file for vim
set modelines=0		" CVE-2007-2438
set backspace=2		" more powerful backspacing

set number
syntax enable
colorscheme solarized
set background=light
set incsearch
set spell
set spelllang=en_us
set shiftwidth=2
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set backspace=2
set cursorline
set colorcolumn=0
set ts=2 sts=2 sw=2 expandtab
autocmd FileType make set ts=2
autocmd FileType mkd set sw=4
autocmd FileType mkd set sts=4

set noswapfile
set paste
set showcmd
set mouse-=a
set mousehide

set hidden
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
let mapleader = "\<Space>"
map <Leader>k :bprev<CR>
map <Leader>j :bnext<CR>
nnoremap <Leader>f :CtrlP<CR>
nnoremap <Leader>h :CtrlPBuffer<CR>
map <Leader>s gt
map <Leader>d gT

nnoremap <Leader>w :w<CR>
nmap <Leader>v V


set grepprg=grep\ -nH\ $*
let g:text_flavor = "latex"

" airline plugin
set laststatus=2

" snips
let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"

"imap jj <Esc>
