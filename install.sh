#!/bin/bash

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
f_linux_ssh_server() {
  echo "${blue}###############################################################################${reset}"
  echo "${blue} This is a linux${reset}"
  echo "${blue}###############################################################################${reset}"
  sudo apt install openssh-server -y
}

f_linux_upgrade() {
  echo "${blue}###############################################################################${reset}"
  echo "${blue} Upgrading${reset}"
  echo "${blue}###############################################################################${reset}"
  sudo apt upgrade
  sudo apt dist-upgrade -y
  sudo apt-get full-upgrade -y
  sudo apt autoremove -y
}

f_linux_basic_packages() {
  echo "${blue}###############################################################################${reset}"
  echo "${blue} Installing basic packages${reset}"
  echo "${blue}###############################################################################${reset}"
  sudo apt install glances bmon htop iperf3 kitty speedtest-cli mosh eza -y 
  sudo apt install wireshark git tmux guake python3 python3-pip tlp jq remmina -y
  sudo apt install zsh zsh-syntax-highlighting zsh-autosuggestions -y
}

f_linux_bluetoothManager() {
  echo "${blue}###############################################################################${reset}"
  echo "${blue} Installing bluetooth manager${reset}"
  echo "${blue}###############################################################################${reset}"
  sudo apt install blueman -y 
  sudo systemctl enable bluetooth.service
  sudo systemctl start bluetooth.service
}

f_linux_SecPackages() {
  echo "${blue}###############################################################################${reset}"
  echo "${blue} Installing Security Packages${reset}"
  echo "${blue}###############################################################################${reset}"
  sudo apt install tilix maltego metasploit-framework burpsuite aircrack-ng -y 
  sudo apt install hydra nmap beef-xss nikto wavemon -y
}

f_linux_kismet() {
  echo "${blue}###############################################################################${reset}"
  echo "${blue} Installing dependencies for kismet${reset}"
  echo "${blue}###############################################################################${reset}"
  sudo apt install build-essential git libwebsockets-dev pkg-config zlib1g-dev -y
  sudo apt install libnl-3-dev libnl-genl-3-dev libcap-dev libpcap-dev libnm-dev -y 
  sudo apt install libdw-dev libsqlite3-dev libprotobuf-dev libprotobuf-c-dev -y 
  sudo apt install protobuf-compiler protobuf-c-compiler -y 
  sudo apt install libusb-1.0-0-dev -y
  sudo apt install python3 python3-setuptools python3-protobuf python3-requests -y
  sudo apt install python3-numpy python3-serial python3-usb python3-dev -y 
  sudo apt install python3-websockets librtlsdr0 libubertooth-dev libbtbb-dev -y
  sudo apt-get install python3-setuptools python3-protobuf python3-requests -y
  sudo apt-get install librtlsdr0 python3-usb python3-paho-mqtt -y

  echo "${blue}###############################################################################${reset}"
  echo "${blue} Installing GQRX${reset}"
  echo "${blue}###############################################################################${reset}"
  sudo apt-get install software-properties-common
  sudo apt-get install python3-launchpadlib
  sudo apt update
  sudo apt-get update
  sudo apt-get install gqrx-sdr -y

  echo "${blue}###############################################################################${reset}"
  echo "${blue} Compiling kismet${reset}"
  echo "${blue}###############################################################################${reset}"
  sudo apt -y install kismet
}

f_linux_yubiauth() {
  echo "${blue}###############################################################################${reset}"
  echo "${blue} Installing yubi authenticator${reset}"
  echo "${blue}###############################################################################${reset}"
  sudo apt install yubioath-desktop -y
}

f_linux_netbird() {
  echo "${blue}###############################################################################${reset}"
  echo "${blue} Installing Netbird client${reset}"
  echo "${blue}###############################################################################${reset}"
  sudo apt-get install ca-certificates curl gnupg -y
  curl -sSL https://pkgs.netbird.io/debian/public.key | sudo gpg --dearmor --output /usr/share/keyrings/netbird-archive-keyring.gpg
  echo 'deb [signed-by=/usr/share/keyrings/netbird-archive-keyring.gpg] https://pkgs.netbird.io/debian stable main' | sudo tee /etc/apt/sources.list.d/netbird.list
  sudo apt-get update -y
  sudo apt-get install netbird -y
  sudo apt-get install netbird-ui -y
}

f_linux_gpstools() {
  echo "${blue}###############################################################################${reset}"
  echo "${blue} Installing GPS tools${reset}"
  echo "${blue}###############################################################################${reset}"
  sudo apt install gpsd gpsd-clients libgps-dev -y
}

f_linux_brave() {
  echo "${blue}###############################################################################${reset}"
  echo "${blue} Installing brave${reset}"
  echo "${blue}###############################################################################${reset}"
  sudo curl -fsS https://dl.brave.com/install.sh | sh
}

f_linux_mullvad() {
  echo "${blue}###############################################################################${reset}"
  echo "${blue} Installing Mullvad browser${reset}"
  echo "${blue}###############################################################################${reset}"
  sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
  echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable stable main" | sudo tee /etc/apt/sources.list.d/mullvad.list
  sudo apt update
  sudo apt install mullvad-browser
}

f_linux_alphaDriver(){
  echo "${blue}###############################################################################${reset}"
  echo "${blue} Installing RTL8812AU/21AU and RTL8814AU Wireless drivers${reset}"
  echo "${blue}###############################################################################${reset}"
  read -r -p "Want install Wireless Drivers Alpha? [y/N]" -n 1
  echo # (optional) move to a new line
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    sudo apt update
    sudo apt upgrade -y
    #sudo apt install linux-headers-generic build-essential git -y
    sudo apt install dkms -y
    rm -rf $HOME/rtw88
    cd $HOME
    git clone https://github.com/lwfinger/rtw88
    cd $HOME/rtw88
    make
    sudo make install
    sudo make install_fw
    sudo cp rtw88.conf /etc/modprobe.d/
    cd $SCRIPT_DIR
	fi
}

f_linux_spotify() {
  echo "${blue}###############################################################################${reset}"
  echo "${blue} Installing Spotify${reset}"
  echo "${blue}###############################################################################${reset}"
  read -r -p "Want install spotify? [y/N]" -n 1
  echo # (optional) move to a new line
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
      # Spotify installation on Ubuntu
      curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
      echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
      sudo apt-get update 
      sudo apt-get install spotify-client -y
  fi
}

f_linux_install_app() {
  f_linux_ssh_server
  f_linux_upgrade
  f_linux_basic_packages
  f_linux_bluetoothManager
  f_linux_SecPackages
  f_linux_kismet
  f_linux_yubiauth
  f_linux_netbird
  f_linux_gpstools
  f_linux_brave
  f_linux_mullvad
  f_linux_alphaDriver
  f_linux_spotify
}

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
    f_linux_install_app
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
echo "${blue}###############################################################################${reset}"
echo "${blue} Configuring VIM${reset}"
echo "${blue}###############################################################################${reset}"
rm -rf $HOME/.vimrc
ln -s $HOME/dotfiles/vim/vimrc $HOME/.vimrc

# for tmux
echo "${blue}###############################################################################${reset}"
echo "${blue} Configuring TMUX${reset}"
echo "${blue}###############################################################################${reset}"
rm -rf $HOME/.tmux.conf
ln -s $HOME/dotfiles/tmux/tmux.conf $HOME/.tmux.conf

echo "${blue}###############################################################################${reset}"
echo "${blue} Installing TMUX pluggings${reset}"
echo "${blue}###############################################################################${reset}"
# Plugin Manager - https://github.com/tmux-plugins/tpm
# If you didn't use my dotfiles install script you'll need to:
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# for git config
echo "${blue}###############################################################################${reset}"
echo "${blue} Configuring TMUX${reset}"
echo "${blue}###############################################################################${reset}"
rm -rf $HOME/.gitconfig
ln -s $HOME/dotfiles/git/gitconfig $HOME/.gitconfig

echo "${cyan}###############################################################################${reset}"
echo "${cyan} Restoring Power Level 10K${reset}"
echo "${cyan}###############################################################################${reset}"
read -r -p "Want to restore powerleve 10k config file from this repo? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    # for power level 10k
    rm -rf $HOME/.p10k.zsh
    ln -s $HOME/dotfiles/p10k/p10k.zsh $HOME/.p10k.zsh
fi

echo " "
echo "${green}###############################################################################${reset}"
echo "${green} Installing and configuration complete !!!! ${reset}"
echo "${green}###############################################################################${reset}"

echo " "
echo "${cyan}###############################################################################${reset}"
echo "${cyan} Install Oh-my-zsh and power level${reset}"
echo "${cyan}###############################################################################${reset}"
echo "${cyan} Manual Installation:${reset}"
echo 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
echo 'git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions'
echo 'cp /etc/skel/.zshrc ~/.zshrc'
echo 'git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k'
echo 'echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc'

if [ -f /var/run/reboot-required ]; then
  echo "${red}###############################################################################${reset}"
  echo "${red} Please reboot the system${reset}"
  echo "${red}###############################################################################${reset}"
fi

exit 0
