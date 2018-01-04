" ############# Vundle ###########
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Core
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'blueyed/vim-diminactive'

" Python
Plugin 'vim-scripts/indentpython.vim'

call vundle#end()
filetype plugin indent on

" ############# Ctrl-P ##############
let g:ctrlp_switch_buffer = 0
nnoremap <silent> ,t :CtrlP<CR>
nnoremap <silent> ,b :CtrlPBuffer<cr>
nnoremap <silent> <C-S-P> :ClearCtrlPCache<cr>
" ctrl-shift-m to jump to a method
nnoremap <silent> <C-S-M> :CtrlPBufTag<CR>

" ############# NERDTree ############
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30

" Use Ctrl-\ to open nerdtree
function! OpenNerdTree()
  if &modifiable && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
  else
    NERDTreeToggle
  endif
endfunction
nnoremap <silent> <C-\> :call OpenNerdTree()<CR>

" ############# Syntastic ############
" have syntastic be in passive mode by default
let g:syntastic_mode_map = { 'mode': 'passive' }

" ############# General Config ###########
set number			                "Line numbers
set relativenumber              "Show line numbers relative to current line
colo solarized
set bg=dark
set guifont=Consolas:h14
syntax on
set hidden                      "Allow buffers to exist in backgroun
set backspace=indent,eol,start  "Allow backspacing over eol in insert mode
set history=1000		            "Store long history
set showmode                    "Show mode at the bottom
set showcmd                     "Show incomplete cmds at bottom
set gcr=a:blinkon0 		          "Disable blinking cursor
set visualbell			            "No sounds
set autoread  			            "reload files that have changed outside vim
set wildmenu 			              "Better command line completion
set encoding=utf-8

set nowrap
set linebreak

" Search
set incsearch                   "Show results while typing
set hlsearch                    "Highlight search
set ignorecase
set smartcase                   "Ignore search case unless there's a capital

"Swap files
set noswapfile
set nobackup
set nowb

"Indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

"Scrolling
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

"Mark unnecessary whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" ############## Python settings ##############
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" ############# Remappings ###########
let mapleader = ","

nnoremap // :noh<CR>

"Movement
" go to last edit location
nnoremap ,. '.

"Splits
nnoremap <silent> ss :split<CR>
nnoremap <silent> vv :vsplit<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Buffers
nnoremap <silent> <leader>z :bp<CR>
nnoremap <silent> <leader>x :bn<CR>

"Save
nnoremap <C-S> :w<CR>

"Copy and Paste
" copy and cut are mapped in visual mode (selected text)
vnoremap <C-C> "*y
vnoremap <C-X> "*x
" paste has to work in cmds and in general
cmap <C-V> <C-R>*
imap <C-V> <C-R>*
" copy current filename into system clipboard
nnoremap <silent> ,cf :let @* = expand("%:~")<CR>

"Quickfix List
" remap ctrl-x and z to navigate quickfix error list
nnoremap <silent> <C-x> :cn<CR>
nnoremap <silent> <C-z> :cp<CR>
" open and close quickfix window
nmap <silent> <leader>qc :cclose<CR>
nmap <silent> <leader>qo :copen<CR>

" Make gf (go to file) create the file, if not existent
nnoremap <C-w>f :sp +e<cfile><CR>
nnoremap <C-w>gf :tabe<cfile><CR>

" ############### Scripts ############
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()
nmap ,w :StripTrailingWhitespaces<CR>
