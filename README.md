bash_scripts
============

```
ln -sf ~/bash_scripts/irbrc ~/.irbrc
gem install wirble

test -f $HOME/.zshrc && ( echo ". $(readlink -f shellconf.sh)" >> $HOME/.zshrc )
test -f $HOME/.bashrc && ( echo ". $(readlink -f shellconf.sh)" >> $HOME/.bashrc )

```
