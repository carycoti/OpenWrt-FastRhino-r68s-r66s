#!/bin/bash

# 配置bash
mkdir -p files/etc
pushd files
git clone --depth=1 https://github.com/jaivardhankapoor/bestbash root/.bash
ln -s ./.bash/init ./.bashrc
ln -s root/.bash/init etc/bash.bashrc
popd