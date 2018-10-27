""Save
"" This doesn't work in nix because Ctrl-S sends a stty stop sig
"nnoremap <C-S> :w<CR>
"
""Copy and Paste
"" copy and cut are mapped in visual mode (selected text)
"vnoremap <C-C> "*y
"vnoremap <C-X> "*x
"" paste has to work in cmds and in general
"cmap <C-V> <C-R>*
"imap <C-V> <C-R>*
