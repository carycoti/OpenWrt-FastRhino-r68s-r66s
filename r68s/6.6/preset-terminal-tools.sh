#!/bin/bash

# 配置bash
mkdir -p files/root
pushd files/root
git clone --depth=1 https://github.com/jaivardhankapoor/bestbash ./.bash
rm -f /etc/bash.bashrc
ln -s ./.bash/init /etc/bash.bashrc
popd