#!/bin/sh

set -ex

cd /tmp
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
#make test
make PREFIX=/opt/redis install -C src
