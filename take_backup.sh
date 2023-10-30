#!/bin/sh
mdfind kMDItemKind="Application" > ~/dotfiles/apps/apps_all.txt
mdfind -onlyin /Applications -onlyin ~/Applications kMDItemKind="Application" > ~/dotfiles/apps/apps.txt
brew bundle dump --force --file=~/dotfiles/apps/Brewfile
brew list  > ~/dotfiles/apps/brew_list.txt 
brew list --cask > ~/dotfiles/apps/brew_listCask.txt 
brew deps --tree --installed  > ~/dotfiles/apps/brew_depsTree.txt