bash_scripts
============

```
ln -sf ~/bash_scripts/irbrc ~/.irbrc

test -f $HOME/.zshrc && ( readlink -f shellconf.sh >> $HOME/.zshrc )
test -f $HOME/.bashrc && ( readlink -f shellconf.sh >> $HOME/.bashrc )

```
