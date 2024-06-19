#!/bin/sh

echo "Setting up your Mac..."

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/dotfiles/zshrc/.zshrc $HOME/.zshrc

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file $HOME/dotfiles/brew/Brewfile

# for kitty config
#rm -rf $HOME/.config/kitty/kitty.conf
#mkdir -p $HOME/.config/kitty
#ln -s $HOME/dotfiles/kitty/kitty.conf $HOME/.config/kitty/kitty.conf

# for vim
rm -rf $HOME/.vimrc
ln -s $HOME/dotfiles/vim/vimrc $HOME/.vimrc

# for power level 10k
rm -rf $HOME/.p10k.zsh
ln -s $HOME/dotfiles/p10k/p10k.zsh $HOME/.p10k.zsh

# for git config
rm -rf $HOME/.gitconfig
ln -s $HOME/dotfiles/git/gitconfig $HOME/.gitconfig
