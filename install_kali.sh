#!/bin/sh

# #############################################################################
## Set Colors for echo messages
# #############################################################################
red=$(tput setaf 1)
green=$(tput setaf 2)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
reset=$(tput sgr0)

# #############################################################################
## Global Variables
# #############################################################################
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# #############################################################################
# ## Functions Declarations
# #############################################################################

# #############################################################################
# error codes
# 0 - exited without problems
# 1 - parameters not supported were used or some unexpected error occurred
# 2 - OS not supported by this script
# 3 - installed version of rclone is up to date
# 4 - supported unzip tools are not available
# #############################################################################

set -e

# #############################################################################
#detect the platform
# #############################################################################
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

# #############################################################################
# Commands based on platform 
# #############################################################################
case "$OS" in
  'linux')
    #For Linux Systems
    echo "##################################################################"
    echo " This is a linux"
    echo "##################################################################"
    sudo apt install openssh-server -y

    echo "##################################################################"
    echo " Upgrading"
    echo "##################################################################"    
    sudo apt upgrade
    sudo apt dist-upgrade -y
    sudo apt-get full-upgrade -y
    sudo apt autoremove -y
    sudo apt install -y linux-headers-$(uname -r)

    echo "##################################################################"
    echo " Installing basic packages"
    echo "##################################################################"
    sudo apt install firmware-linux bmon htop iperf3 kitty speedtest-cli -y 
    sudo apt install wireshark git tmux guake python3 python3-pip tlp -y

    echo "##################################################################"
    echo " Installing Security Packages"
    echo "##################################################################"
    sudo apt install tilix maltego metasploit-framework burpsuite aircrack-ng -y 
    sudo apt install hydra nmap beef-xss nikto wavemon -y

    echo "##################################################################"
    echo " Installing dependencies for kismet"
    echo "##################################################################"
    sudo apt install build-essential git libwebsockets-dev pkg-config zlib1g-dev -y
    sudo apt install libnl-3-dev libnl-genl-3-dev libcap-dev libpcap-dev libnm-dev -y 
    sudo apt install libdw-dev libsqlite3-dev libprotobuf-dev libprotobuf-c-dev -y 
    sudo apt install protobuf-compiler protobuf-c-compiler -y 
    sudo apt install libusb-1.0-0-dev -y

    echo "##################################################################"
    echo " Installing pytho3 packages"
    echo "##################################################################"
    sudo apt install python3 python3-setuptools python3-protobuf python3-requests -y
    sudo apt install python3-numpy python3-serial python3-usb python3-dev -y 
    sudo apt install python3-websockets librtlsdr0 libubertooth-dev libbtbb-dev -y
    sudo apt-get install python3-setuptools python3-protobuf python3-requests -y
    sudo apt-get install librtlsdr0 python3-usb python3-paho-mqtt -y

    echo "##################################################################"
    echo " Installing libusb"
    echo "##################################################################"
    sudo apt-get install libusb-1.0-0-dev

    echo "##################################################################"
    echo "Installing GQRX"
    echo "##################################################################"
    sudo apt update
    sudo apt-get install software-properties-common
    sudo apt-get install python3-launchpadlib
    sudo apt update
    sudo apt-get update
    sudo apt-get install gqrx-sdr -y

    echo "##################################################################"
    echo " Compiling kismet"
    echo "##################################################################"
    sudo apt -y install kismet

    echo "##################################################################"
    echo " Installing yubi authenticator"
    echo "##################################################################"
    sudo apt-get update
    sudo apt install yubioath-desktop -y

    echo "##################################################################"
    echo " Installing Netbird client"
    echo "##################################################################"
    sudo apt-get update
    sudo apt-get install ca-certificates curl gnupg -y
    curl -sSL https://pkgs.netbird.io/debian/public.key 
    sudo gpg --dearmor --output /usr/share/keyrings/netbird-archive-keyring.gpg
    echo 'deb [signed-by=/usr/share/keyrings/netbird-archive-keyring.gpg] https://pkgs.netbird.io/debian stable main'
    sudo tee /etc/apt/sources.list.d/netbird.list
    sudo apt-get update -y
    sudo apt-get install netbird -y
    sudo apt-get install netbird-ui -y

    echo "##################################################################"
    echo " Installing GPS tools"
    echo "##################################################################"
    sudo apt install gpsd gpsd-clients libgps-dev libgps -y

    echo "##################################################################"
    echo " Installing RTL8812AU/21AU and RTL8814AU Wireless drivers"
    echo "##################################################################"
    sudo apt update
    sudo apt upgrade -y
    sudo apt install linux-headers-generic build-essential git -y
    sudo apt install dkms -y
    cd $HOME
    git clone https://github.com/lwfinger/rtw88
    cd rtw88
    make
    sudo make install
    sudo make install_fw
    sudo cp rtw88.conf /etc/modprobe.d/

    echo "##################################################################"
    echo " Installing brave"
    echo "##################################################################"
    sudo curl -fsS https://dl.brave.com/install.sh | sh

    echo "##################################################################"
    echo " Installing OMZ"
    echo "##################################################################"
    sudo apt-get install -y zsh zsh-syntax-highlighting zsh-autosuggestions -y
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    cp /etc/skel/.zshrc ~/.zshrc
    chsh -s $(which zsh)

    echo "##################################################################"
    echo " Installing Powerlevel10k"
    echo "##################################################################"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

    ;;
  'freebsd'|'openbsd'|'netbsd')
    #For bsd Systems
    echo " This is a bsd"
    ;;
  'osx')
    #For MacOS systems
    echo " This is a MacOS: "
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
