" ############# CtrlP ##############
" Don't jump to a file if it's already open
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

" Mappings
"CtrlP
nnoremap <silent> <leader>t :CtrlP<CR>
" Buffer search
nnoremap <silent> <leader>b :CtrlPBuffer<CR>
" used to find functions
nnoremap <silent> <leader>f :CtrlPBufTag<CR>
