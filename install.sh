#!/bin/bash
git submodule add https://github.com/gmarik/vundle.git bundle/vundle
git submodule init
git submodule update
git submodule foreach git submodule init
git submodule foreach git submodule update
