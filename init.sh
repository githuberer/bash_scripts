#!/usr/bin/env bash

set -e

gem install wirble

ln -sf $HOME/bash_scripts/irbrc $HOME/.irbrc

wget --no-check-certificate http://install.ohmyz.sh -O - | sh

test -f $HOME/.zshrc && ( echo ". $(readlink -f shellinit.sh)" >> $HOME/.zshrc )

