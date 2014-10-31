#!/bin/sh

set -ex

VERSION=1.7.4.1
OPTIONS="--with-pcre-jit --with-ipv6"

sudo apt-get update # XXX
sudo apt-get install -y libreadline-dev libncurses5-dev libpcre3-dev \
  libssl-dev perl make

cd /tmp
wget http://openresty.org/download/ngx_openresty-${VERSION}.tar.gz
tar xzvf ngx_openresty-${VERSION}.tar.gz
cd ngx_openresty-${VERSION}
./configure --prefix=/opt/openresty
make
make install
