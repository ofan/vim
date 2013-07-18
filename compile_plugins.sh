#!/bin/sh
# Here's a list of all plugins that need to compile before use.
# youcompleteme
echo Compiling YouCompleteMe...
cd ~/.vim/bundle/YouCompleteMe
./install.sh
cd -
# vimproc
echo Compiling vimproc...
cd ~/.vim/bundle/vimproc
make -f make_mac.mak
cd -
