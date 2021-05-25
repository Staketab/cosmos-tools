#!/bin/bash

echo "░██████╗████████╗░█████╗░██╗░░██╗███████╗████████╗░█████╗░██████╗░░░░░█████╗░░█████╗░███╗░░░███╗"
echo "██╔════╝╚══██╔══╝██╔══██╗██║░██╔╝██╔════╝╚══██╔══╝██╔══██╗██╔══██╗░░░██╔══██╗██╔══██╗████╗░████║"
echo "╚█████╗░░░░██║░░░███████║█████═╝░█████╗░░░░░██║░░░███████║██████╦╝░░░██║░░╚═╝██║░░██║██╔████╔██║"
echo "░╚═══██╗░░░██║░░░██╔══██║██╔═██╗░██╔══╝░░░░░██║░░░██╔══██║██╔══██╗░░░██║░░██╗██║░░██║██║╚██╔╝██║"
echo "██████╔╝░░░██║░░░██║░░██║██║░╚██╗███████╗░░░██║░░░██║░░██║██████╦╝██╗╚█████╔╝╚█████╔╝██║░╚═╝░██║"
echo "╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝╚═════╝░╚═╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝"
echo ""

sleep 1

set -e

YELLOW="\033[33m"
GREEN="\033[32m"
VERSION=$1
TAG=$2
SERVERIP="$(curl ifconfig.me)"

if [ "$VERSION" == "" ]; then
    VERSION="1.4.4"
fi

if [ "$TAG" == "" ]; then
    TAG="1.4.4"
fi

function service {
echo "[Unit]
Description=Avalanche Node
After=network.target
StartLimitIntervalSec=0
[Service]
Type=simple
WorkingDirectory=$HOME
Restart=on-failure
RestartSec=3
LimitNOFILE=4096
ExecStart=$HOME/ava-node/avalanchego --public-ip=${SERVERIP} --http-host=
[Install]
WantedBy=multi-user.target
" >/etc/systemd/system/avalanchego.service
}

function install {
cd \
&& export VERSION="$VERSION" && export TAG="$TAG"

if [ -e /etc/systemd/system/avalanchego.service ]; then
  echo "Service found."
  sudo systemctl stop avalanchego
  rm -rf /etc/systemd/system/avalanchego.service
  service
  sudo systemctl enable avalanchego.service
else
  service
  sudo systemctl enable avalanchego.service
fi

echo "---------------"
echo -e "$YELLOW Avalanche service installed.\033[0m"
echo "---------------"
}

function update {
if [ -e $HOME/avalanchego-linux-amd64-v$VERSION.tar.gz ]; then
  rm -rf $HOME/avalanchego-linux-amd64-v$VERSION.tar.gz
  wget https://github.com/ava-labs/avalanchego/releases/download/v$TAG/avalanchego-linux-amd64-v$VERSION.tar.gz
else
  wget https://github.com/ava-labs/avalanchego/releases/download/v$TAG/avalanchego-linux-amd64-v$VERSION.tar.gz
fi

mkdir -p $HOME/ava-node $HOME/ava-node/plugins

tar -C $HOME/ava-node -xvf avalanchego-linux-amd64-v$VERSION.tar.gz --strip-components 1 \
&& rm -rf $HOME/avalanchego-linux-amd64-v$VERSION.tar.gz

sudo systemctl daemon-reload && sudo systemctl restart avalanchego.service

echo "---------------"
echo -e "$GREEN --------AVALANCHE VERSION v$VERSION INSTALLED--------\033[0m"
echo "---------------"
}

install
update