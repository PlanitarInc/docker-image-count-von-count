#!/bin/sh

set -ex

cd /build

sudo apt-get update
sudo apt-get install -y wget

./build-openresty.sh
./build-redis.sh
