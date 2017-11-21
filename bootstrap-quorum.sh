#!/bin/bash

set -euf -o pipefail

# install constellation build deps
add-apt-repository ppa:ethereum/ethereum -y
apt-get update
apt-get install -y build-essential unzip libdb-dev libleveldb-dev libsodium-dev zlib1g-dev libtinfo-dev solc sysvbanner wrk

# install constellation
wget -q https://github.com/jpmorganchase/constellation/releases/download/v0.2.0/constellation-0.2.0-ubuntu1604.tar.xz
tar xf constellation-0.2.0-ubuntu1604.tar.xz
cp constellation-0.2.0-ubuntu1604/constellation-node /usr/local/bin && chmod 0755 /usr/local/bin/constellation-node
rm -rf constellation-0.2.0-ubuntu1604.tar.xz constellation-0.2.0-ubuntu1604

# install golang
add-apt-repository ppa:gophers/archive
apt update
apt-get install golang-1.9-go
ln -f /usr/lib/go-1.9/bin/go /usr/bin/go

# make/install quorum
git clone https://github.com/jpmorganchase/quorum.git
pushd quorum >/dev/null
git checkout tags/v2.0.0
make all
cp build/bin/geth /usr/local/bin
cp build/bin/bootnode /usr/local/bin
popd >/dev/null

#mv quorum ../

cp -r quorum-vm-template/3nodes-quorum ../

# done!
banner "Quorum"

chown -R ubuntu:ubuntu /home/ubuntu/

