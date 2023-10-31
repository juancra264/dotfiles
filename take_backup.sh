#!/bin/sh
local_path="$HOME"/dotfiles/apps
mdfind kMDItemKind="Application" > "$local_path"/apps_all.txt
mdfind -onlyin /Applications -onlyin ~/Applications kMDItemKind="Application" > "$local_path"/apps.txt
brew bundle dump --force --file="$local_path"/Brewfile
brew list  > "$local_path"/brew_list.txt 
brew list --cask > "$local_path"/brew_listCask.txt 
brew deps --tree --installed  > "$local_path"/brew_depsTree.txt
printenv > "$local_path"/env.txt
