#!/bin/bash

#######################
## Set up Linux Mint ##
#######################

add-apt-repository -y ppa:deadsnakes/ppa
apt-get update && apt-get -y dist-upgrade

# Install basic utilities
apt-get -y install git httpie neovim silversearcher-ag tldr tree zsh

# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git /tmp/fzf
/tmp/fzf/install --all

# Set up zsh
chsh -s /bin/zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Install Python related stuff
apt-get -y install build-essential libffi-dev libncurses-dev libreadline-dev \ 
	libsqlite-dev libssl-dev zlib1g-dev python-dev python3-pip python3-venv

pip3 install setuptools wheel

# Install i3 related stuff
apt-get -y install dunst feh i3lock i3blocks nitrogen rofi \
	rxvt-unicode-256color scrot xautolock

pip3 install pywal

# Configure virtualenvwrapper
pip3 install virtualenvwrapper
echo "
export PATH="${PATH}:${HOME}/.local/bin/"
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /home/thomas/.local/bin/virtualenvwrapper.sh" | tee -a ~/.bashrc ~/.zshrc

## Install i3 ##################################################################
## Install build dependencies
apt-get -y install autoconf automake libxcb1-dev libxcb-keysyms1-dev \
	libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
	libstartup-notification0-dev libxcb-randr0-dev libev-dev \
	libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev \
	libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake

git clone https://www.github.com/Airblader/i3 /tmp/i3-gaps
cd /tmp/i3-gaps

autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

## Disabling sanitizers is important for release versions!
## The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
make install

################################################################################
