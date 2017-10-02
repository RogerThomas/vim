#!/bin/bash
# ---------------------------------------------------------
# Check if script is running with sudo privileges
# ---------------------------------------------------------
#if [ "$(id -u)" != "0" ]; then
#    echo "This script must be run as root" 1>&2
#    exit 1
#fi
# ---------------------------------------------------------
USER=`whoami`
chown -R $USER .
rm -rf bundle
rm -rf ftplugin

mkdir bundle
mkdir ftplugin

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle

brew install mercurial
brew install python-pip

pip3 install --upgrade nose
pip3 install --upgrade flake8
pip3 install -e "git+https://github.com/mcrute/nose-machineout#egg=nose_machineout"
pip3 install --upgrade vim_bridge
pip3 install --upgrade isort

# git clone git://github.com/nvie/vim-pyunit.git

# cp vim-pyunit/ftplugin/python_pyunit.vim ~/.vim/ftplugin
# sudo cp ftplugins/* ftplugin

rm -rf vim-pyunit
cp vimrc ~/.vimrc
cp flake8 ~/.config/flake8
chown $USER ../.vimrc

vim +PluginInstall +qall
