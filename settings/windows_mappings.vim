"" This mapping doesn't work in *nix environments because it sends a stty start
"" signal
"nnoremap <silent> <C-Q> :bd<CR>
"" pneumonic: T for terminate
"nnoremap <silent> <C-T> :bd<CR>
"
""Save
"nnoremap <C-S> :w<CR>
"
""Copy and Paste
"" copy and cut are mapped in visual mode (selected text)
"vnoremap <C-C> "*y
"vnoremap <C-X> "*x
"" paste has to work in cmds and in general
"cmap <C-V> <C-R>*
"imap <C-V> <C-R>*
