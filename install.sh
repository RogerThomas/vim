#!/bin/bash
git submodule add https://github.com/gmarik/vundle.git bundle/vundle
git submodule init
git submodule update
git submodule foreach git submodule init
git submodule foreach git submodule update
sudo apt-get install python-pip
pip install nose
pip install flake8
pip install nose_machineout
pip install vim_bridge
git clone git://github.com/nvie/vim-pyunit.git
cp vim-pyunit/ftplugin/python_pyunit.vim ~/.vim/ftplugin
