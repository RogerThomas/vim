#!/bin/bash
# ---------------------------------------------------------
# Check if script is running with sudo privileges
# ---------------------------------------------------------
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi
# ---------------------------------------------------------
rm -rf bundle
rm -rf ftplugin
rm -rf vim-pyunit

mkdir bundle
mkdir ftplugin

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle

sudo apt-get install mercurial
sudo apt-get install python-pip

pip install nose
pip install flake8
pip install -e "hg+https://code.google.com/p/nose-machineout/#egg=nose-machineout"
pip install vim_bridge

git clone git://github.com/nvie/vim-pyunit.git

cp vim-pyunit/ftplugin/python_pyunit.vim ~/.vim/ftplugin
cp vimrc ~/.vimrc
vim +PluginInstall +qall
