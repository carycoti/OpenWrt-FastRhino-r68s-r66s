#!/bin/bash

# 配置bash
mkdir -p files/etc
pushd files
git clone --depth=1 https://github.com/jaivardhankapoor/bestbash root/.bash
sed -i "s/alias grep='grep --color=tty -d skip'/alias grep='grep --color=tty'/" root/.bash/alias 
# ln -s root/.bash/init root/.bashrc
# ln -s root/.bash/init etc/bash.bashrc
echo "# GIT {{{
alias gs='git status -sb'
alias ga='git add .'
alias gb='git branch'
alias gc='git commit -am'
alias gd='git diff'
alias go='git checkout'
alias gl=\"git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit\"
alias gr='git remote'
alias gn='git clone -o'
alias gp='git pull'
alias gps='git push'
#}}}" >> root/.bash/alias 

echo "source ~/.bash/colors
source ~/.bash/settings
source ~/.bash/alias
source ~/.bash/functions" > etc/bash.bashrc
popd