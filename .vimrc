set autoindent
set tabstop=2
set expandtab
set shiftwidth=2
set shiftround
set hlsearch
set lazyredraw
set linebreak
set encoding=utf-8
set title
set number
set relativenumber
set noerrorbells
set visualbell
set mouse=a


syntax enable
set background=dark
set title

" Plugins
call plug#begin('~/.vim/plugged')

" JSX highlighting
Plug 'maxmellon/vim-jsx-pretty'

" material color theme
Plug 'kaicataldo/material.vim'

call plug#end()

" auto pair closing characters
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

