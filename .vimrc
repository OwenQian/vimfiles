set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'

" CtrlP
Plugin 'ctrlpvim/ctrlp.vim'
"set ctrlp starting directory to current file
let g:ctrlp_working_path_mode = 0
let g:ctrlp_switch_buffer = 0

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-rails'

" Note Taking
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'

Plugin 'valloric/YouCompleteMe'
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

call vundle#end()
filetype plugin indent on

"####################### Remappings ###################
"use ctrl-j, etc. to navigate instead of ctrl-w then j
:let mapleader = "["

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"open new tab
nnoremap <leader>t :tabnew <CR>

"NERDTree
nnoremap <leader>NN :NERDTree <CR>

"unhighlight text
nnoremap <leader>n :noh <CR>

"YouCompleteMe leaders
nnoremap <leader>jd :YcmCompleter GoTo <CR>
nnoremap <leader>jt :YcmCompleter GetType <CR>
nnoremap <leader>jf :YcmCompleter FixIt <CR>

"toggle fold opening
nnoremap <ENTER> za
"############################### UI/UX ########################
colo solarized
set bg=dark

set relativenumber
set number
set ruler

set mouse=a

syntax on
set guifont=Menlo\ Regular:h13

set wildmenu "better command line completion
set showcmd "show partial cmds
set confirm "ask for confirmation instead of failing cmd
set visualbell

set hidden "allow hidden buffers

" Search Options
set incsearch
set hlsearch
set ignorecase
set smartcase

" Typing Options
set backspace=indent,eol,start " Allow backspacing

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set autoindent
set smartindent

" Different settings by file type
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype eruby setlocal ts=2 sw=2 expandtab

" Word Processing mode (WP)
func! WordProcessorMode() 
  setlocal formatoptions=1 
  setlocal noexpandtab 
  map j gj 
  map k gk
  setlocal spell spelllang=en_us 
  set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
  set complete+=s
  set formatprg=par
  setlocal wrap 
  setlocal linebreak 
endfu 
com! WP call WordProcessorMode()