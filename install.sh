#!/bin/sh

# error codes
# 0 - exited without problems
# 1 - parameters not supported were used or some unexpected error occurred
# 2 - OS not supported by this script
# 3 - installed version of rclone is up to date
# 4 - supported unzip tools are not available

set -e

#detect the platform
OS="$(uname)"
case $OS in
  Linux)
    OS='linux'
    ;;
  FreeBSD)
    OS='freebsd'
    ;;
  NetBSD)
    OS='netbsd'
    ;;
  OpenBSD)
    OS='openbsd'
    ;;
  Darwin)
    OS='osx'
    ;;
  SunOS)
    OS='solaris'
    echo 'OS not supported'
    exit 2
    ;;
  *)
    echo 'OS not supported'
    exit 2
    ;;
esac

OS_type="$(uname -m)"
case "$OS_type" in
  x86_64|amd64)
    OS_type='amd64'
    ;;
  i?86|x86)
    OS_type='386'
    ;;
  aarch64|arm64)
    OS_type='arm64'
    ;;
  armv7*)
    OS_type='arm-v7'
    ;;
  armv6*)
    OS_type='arm-v6'
    ;;
  arm*)
    OS_type='arm'
    ;;
  *)
    echo 'OS type not supported'
    exit 2
    ;;
esac


case "$OS" in
  'linux')
    #For Linux Systems
    printf "\n This is a linux"
    ;;
  'freebsd'|'openbsd'|'netbsd')
    #For bsd Systems
    printf "\n This is a bsd"
    ;;
  'osx')
    #For MacOS systems
    printf "\n This is a MacOS: "
    echo "Setting up your Mac..."

    # Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
    #rm -rf $HOME/.zshrc
    #ln -s $HOME/dotfiles/zshrc/.zshrc $HOME/.zshrc

    # Update Homebrew recipes
    brew update

    # Install all our dependencies with bundle (See Brewfile)
    brew tap homebrew/bundle
    brew bundle --file $HOME/dotfiles/brew/Brewfile

    # for kitty config
    #rm -rf $HOME/.config/kitty/kitty.conf
    #mkdir -p $HOME/.config/kitty
    #ln -s $HOME/dotfiles/kitty/kitty.conf $HOME/.config/kitty/kitty.conf
    ;;
  *)
    echo 'OS not supported'
    exit 2
esac

# for vim
rm -rf $HOME/.vimrc
ln -s $HOME/dotfiles/vim/vimrc $HOME/.vimrc

# for tmux
rm -rf $HOME/.tmux.conf
ln -s $HOME/dotfiles/tmux/tmux.conf $HOME/.tmux.conf

# Plugin Manager - https://github.com/tmux-plugins/tpm
# If you didn't use my dotfiles install script you'll need to:
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# for git config
rm -rf $HOME/.gitconfig
ln -s $HOME/dotfiles/git/gitconfig $HOME/.gitconfig

# Installing VIM pluggins for HCL (hcl.vim)
mkdir -p ~/.vim/pack/jvirtanen/start
cd ~/.vim/pack/jvirtanen/start
git clone https://github.com/jvirtanen/vim-hcl.git

read -r -p "Want to restore powerleve 10k config file from this repo? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    # for power level 10k
    rm -rf $HOME/.p10k.zsh
    ln -s $HOME/dotfiles/p10k/p10k.zsh $HOME/.p10k.zsh
fi

exit 0
