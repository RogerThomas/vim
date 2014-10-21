#!/bin/bash
# ---------------------------------------------------------
# Check if script is running with sudo privileges
# ---------------------------------------------------------
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi
# ---------------------------------------------------------

rm -rf ~/.vim/bundle/vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle

sudo apt-get install mercurial
sudo apt-get install python-pip

pip install nose
pip install flake8
pip install -e "hg+https://code.google.com/p/nose-machineout/#egg=nose-machineout"
pip install vim_bridge

rm -rf vim-pyunit
git clone git://github.com/nvie/vim-pyunit.git

cp vim-pyunit/ftplugin/python_pyunit.vim ~/.vim/ftplugin

vim +PluginInstall +qall
