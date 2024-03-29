set fileformats=unix,dos
" ############# Vundle ###########
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Core
Plugin 'VundleVim/Vundle.vim'
"Plugin 'altercation/vim-colors-solarized'
Plugin 'morhetz/gruvbox'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'blueyed/vim-diminactive'
Plugin 'tpope/vim-surround'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'yegappan/taglist' " visual view of code structure

" make tab the universal code completer
Plugin 'ervandew/supertab'            

"" code completion
"Plugin 'davidhalter/jedi-vim'    " code completion and navigator for python

" Appearance
Plugin 'itchyny/lightline.vim'   "colorful bar at the bottom
Plugin 'xsunsmile/showmarks.git' "show position of marks

" Supplement to motion
Plugin 'justinmk/vim-sneak'
Plugin 'vim-scripts/camelcasemotion.git' "allow camelcase motion

" Silver searcher wrapper (faster than ctrlP search)
Plugin 'rking/ag.vim'

"" Python
"" Makes python indentation more consistent with PEP8
"Plugin 'Vimjas/vim-python-pep8-indent'

" Go
Plugin 'fatih/vim-go'

call vundle#end()
"filetype plugin indent on
filetype plugin indent on



" ############# General Config ###########
set number                      "Line numbers
set relativenumber              "Show line numbers relative to current line
colo gruvbox
set bg=dark
set guifont=Inconsolata-dzForPowerline:h14
syntax on
set hidden                      "Allow buffers to exist in background
set backspace=indent,eol,start  "Allow backspacing over eol in insert mode
set history=1000                "Store long history
set showmode                    "Show mode at the bottom
set showcmd                     "Show incomplete cmds at bottom
set gcr=a:blinkon0              "Disable blinking cursor
set visualbell                  "No sounds
set autoread                    "reload files that have changed outside vim
set wildmenu                    "Better command line completion
set encoding=utf-8
set mouse=a                     "Allow mouse clicking

set nowrap
set linebreak

" Search
set incsearch                   "Show results while typing
set hlsearch                    "Highlight search
"Ignore search case unless there's a capital
set ignorecase
set smartcase                   

"Swap files
set noswapfile
set nobackup
set nowb

"Indentation
set autoindent
set smartindent
" Use shiftwidth for number of spaces inserted by tab at the start of a line
" and when backspacing
set smarttab         
set shiftwidth=4     " The number of spaces to use when indenting e.g., >>
set softtabstop=4    " The number of spaces that a tab counts for when editing
set tabstop=4        " The number of spaces that a tab in the file counts for
set expandtab        " Expand tabs into the appropriate amount of spaces

"Scrolling
set scrolloff=8      "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ############# Remappings ###########
let mapleader = ","

" use // to unhighlight search
nnoremap // :noh<CR>

"Movement
" go to last edit location
nnoremap <leader>. '.
" switch the functions of 0 and ^
nnoremap 0 ^
nnoremap ^ 0

"Splits
nnoremap <silent> ss :split<CR>
nnoremap <silent> vv :vsplit<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Mappings to easily navigate the terminal
tnoremap <C-J> <C-W><C-J>
tnoremap <C-K> <C-W><C-K>
tnoremap <C-L> <C-W><C-L>
tnoremap <C-H> <C-W><C-H>

"Buffers Navigation
nnoremap <silent> <leader>z :bp<CR>
nnoremap <silent> <leader>x :bn<CR>
nnoremap <silent> <leader>a :b#<CR>
nnoremap <silent> Q :q<CR>
nnoremap <silent> <leader>q :b#<bar>bd#<CR>
nnoremap <silent> <C-T> :bd<CR>

" copy current filename into system clipboard
nnoremap <silent> <leader>cf :let @*=expand("%") . ':' . line(".")<CR>

" pretty format JSON file
nnoremap <silent> <leader>jj :%!jq .<CR>


"Quickfix List
" remap ctrl-x and z to navigate quickfix error list
"nnoremap <silent> <C-x> :cn<CR>
"nnoremap <silent> <C-z> :cp<CR>
"" open and close quickfix window
"nmap <silent> <leader>qc :cclose<CR>
"nmap <silent> <leader>qo :copen<CR>

" Search
" CtrlP
nnoremap <silent> <leader>t :CtrlP<CR>
"Buffer search
nnoremap <silent> <leader>b :CtrlPBuffer<CR>
"used to find functions
nnoremap <silent> <leader>f :CtrlPBufTag<CR>

" Silver Searcher
nnoremap <leader>gg :Ag ""<Left>

" ############# Taglist ############
nnoremap <silent> <C-S> :TlistToggle<CR>
let Tlist_File_Fold_Auto_Close = 1

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
let g:syntastic_cpp_check_header = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

" ############### Camelcase Motion ##########
map W <Plug>CamelCaseMotion_w
map B <Plug>CamelCaseMotion_b
map E <Plug>CamelCaseMotion_e

sunmap W
sunmap B
sunmap E

" ############### Tmux Navigator ##########
" Don't allow default mappings
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
" ############## Showmarks #################
nmap <Space> <Plug>SneakForward

" ############## Showmarks #################
" Get rid of the weird brace symbols
let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXY"

" ############### SuperTab ############
let g:SuperTabDefaultCompletionType = "<c-n>"

" ############### Settings Files ############
" Note: change this to the proper path for the given computer
let settings_dir = "~/vimfiles/settings"
"let settings_dir = "~/.yadr/owen_config/settings"

" source all .vim files in the settings_dir
" Note: globpath expands all the wildcards in a given dir
" Note: split turns the expanded strings into a List to be iterated over
for fpath in split(globpath(settings_dir, '*.vim'), '\n')
  execute "source" fpath
endfor
