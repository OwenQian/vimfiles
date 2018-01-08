" ############# Vundle ###########
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Core
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'morhetz/gruvbox'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'blueyed/vim-diminactive'

" code snippets
Plugin 'MarcWeber/vim-addon-mw-utils' " necessary for snipmate
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'           " snippets library

" make tab the universal code completer
Plugin 'ervandew/supertab'            

" code completion
Plugin 'maralla/completor.vim'

" Appearance
Plugin 'itchyny/lightline.vim'   "colorful bar at the bottom
Plugin 'xsunsmile/showmarks.git' "show position of marks

" Supplement to motion
Plugin 'justinmk/vim-sneak'
Plugin 'vim-scripts/camelcasemotion.git' "allow camelcase motion

" Silver searcher (faster than ctrlP search)
Plugin 'rking/ag.vim'

" Python
" Makes python indentation more consistent with PEP8
Plugin 'Vimjas/vim-python-pep8-indent'

call vundle#end()
filetype plugin indent on

" Use Ctrl-\ to open nerdtree
function! OpenNerdTree()
  if &modifiable && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
  else
    NERDTreeToggle
  endif
endfunction
nnoremap <silent> <C-\> :call OpenNerdTree()<CR>

" ############# General Config ###########
set number                      "Line numbers
set relativenumber              "Show line numbers relative to current line
colo gruvbox
set bg=dark
set guifont=Consolas:h14        "scotia
"set guifont=Inconsolata:h18    "use this at home
syntax on
set hidden                      "Allow buffers to exist in backgroun
set backspace=indent,eol,start  "Allow backspacing over eol in insert mode
set history=1000                "Store long history
set showmode                    "Show mode at the bottom
set showcmd                     "Show incomplete cmds at bottom
set gcr=a:blinkon0              "Disable blinking cursor
set visualbell                  "No sounds
set autoread                    "reload files that have changed outside vim
set wildmenu                    "Better command line completion
set encoding=utf-8

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
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

"Scrolling
set scrolloff=8      "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

"Mark unnecessary whitespace
"highlight BadWhitespace
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" ############## Python settings ##############
au BufNewFile,BufRead *.py
      \ set tabstop=4      |
      \ set softtabstop=4  |
      \ set shiftwidth=4   |
      \ set textwidth=79   |
      \ set expandtab      |
      \ set autoindent     |
      \ set fileformat=unix

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

"Buffers Navigation
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
nnoremap <silent> <leader>cf :let @* = expand("%:~")<CR>

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

"CtrlP
nnoremap <silent> <leader>t :CtrlP<CR>

" ctrl-m to jump to a method
nnoremap <silent> <C-M> :CtrlPBufTag<CR>

" ############# Ctrl-P ##############
let g:ctrlp_switch_buffer = 0

if exists("g:ctrlp_user_command")
  unlet g:ctrlp_user_command
endif
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command =
        \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" ############# NERDTree ############
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" ############# Syntastic ############
" have syntastic be in passive mode by default
let g:syntastic_mode_map = { 'mode': 'passive' }

" ############# Lightline ###########
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'filename': 'MyFilename',
      \ },
      \ }

set laststatus=2 " use status bar even with single buffer

" ############### Camelcase Motion ##########
map W <Plug>CamelCaseMotion_w
map B <Plug>CamelCaseMotion_b
map E <Plug>CamelCaseMotion_e

sunmap W
sunmap B
sunmap E

" ############## Showmarks #################
nmap <Space> <Plug>SneakForward

" ############## Showmarks #################
" Get rid of the weird brace symbols
let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXY"

" ############### SuperTab ############
let g:SuperTabDefaultCompletionType = "<c-n>"

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
nmap <leader>w :StripTrailingWhitespaces<CR>

" map F9 to run the python script
"autocmd FileType python nnoremap <buffer> <F9> :execute "!py" shellescape(@%, 1)<CR>
