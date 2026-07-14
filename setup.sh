#!/bin/bash
# after installing or updating yadr, point the .vimrc simlink to the .vimrc in this directory
# ln -s vimfiles/.vimrc .vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

VIMFILES="${VIMFILES:-$HOME/vimfiles}"
CURSOR_USER_DIR="$HOME/Library/Application Support/Cursor/User"

mkdir -p "$CURSOR_USER_DIR"
ln -sfn "$VIMFILES/cursor/settings.json" "$CURSOR_USER_DIR/settings.json"
