#!/usr/bin/env bash

gem install wirble

ln -sf $HOME/bash_scripts/irbrc $HOME/.irbrc

test -f $HOME/.zshrc && ( echo ". $(readlink -f shellinit.sh)" >> $HOME/.zshrc )
test -f $HOME/.bashrc && ( echo ". $(readlink -f shellinit.sh)" >> $HOME/.bashrc )

