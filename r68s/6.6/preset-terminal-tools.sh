#!/bin/bash

# 配置bash
mkdir -p files
pushd files
git clone --depth=1 https://github.com/jaivardhankapoor/bestbash root/.bash
# rm -f etc/bash.bashrc
mkdir etc
ln -s root/.bash/init etc/bash.bashrc
popd