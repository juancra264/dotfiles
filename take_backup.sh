#!/bin/sh
mdfind kMDItemKind="Application" > ~/dotfiles/apps/apps_all.txt
mdfind -onlyin /Applications -onlyin ~/Applications kMDItemKind="Application" > ~/dotfiles/apps/apps.txt
brew bundle dump --force --file=~/dotfiles/apps/Brewfile