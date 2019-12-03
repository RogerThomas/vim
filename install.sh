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

rm /usr/local/bin/show_tests
ln show_tests.py /usr/local/bin/show_tests

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

pip install --upgrade nose
pip install --upgrade flake8
pip install -e "git+https://github.com/mcrute/nose-machineout#egg=nose_machineout"
pip install --upgrade vim_bridge
pip install --upgrade isort

rm -rf vim-pyunit
cp vimrc ~/.vimrc
cp vimrc ~/.config/nvim/init.vim
cp isort.cfg ~/.isort.cfg
cp flake8 ~/.config/flake8
chown $USER ../.vimrc

mkdir -p ~/.vim/syntax
cp syntax/python.vim ~/.vim/syntax

vim +PlugInstall +qall
