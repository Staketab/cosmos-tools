#!/bin/bash

echo ""
echo "░██████╗████████╗░█████╗░██╗░░██╗███████╗████████╗░█████╗░██████╗░░░░░█████╗░░█████╗░███╗░░░███╗"
echo "██╔════╝╚══██╔══╝██╔══██╗██║░██╔╝██╔════╝╚══██╔══╝██╔══██╗██╔══██╗░░░██╔══██╗██╔══██╗████╗░████║"
echo "╚█████╗░░░░██║░░░███████║█████═╝░█████╗░░░░░██║░░░███████║██████╦╝░░░██║░░╚═╝██║░░██║██╔████╔██║"
echo "░╚═══██╗░░░██║░░░██╔══██║██╔═██╗░██╔══╝░░░░░██║░░░██╔══██║██╔══██╗░░░██║░░██╗██║░░██║██║╚██╔╝██║"
echo "██████╔╝░░░██║░░░██║░░██║██║░╚██╗███████╗░░░██║░░░██║░░██║██████╦╝██╗╚█████╔╝╚█████╔╝██║░╚═╝░██║"
echo "╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝╚═════╝░╚═╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝"
echo ""

sleep 1

RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"

COSMOVISOR=$1
GIT_NAME=$2
GIT_FOLDER=$3
BIN_NAME=$4
BIN_FOLDER=$5
BIN_VER=$6

if [ "$COSMOVISOR" == "" ]; then
    exit
fi

if [ "$GIT_NAME" == "" ]; then
    exit
fi

if [ "$GIT_FOLDER" == "" ]; then
    exit
fi

if [ "$BIN_NAME" == "" ]; then
    exit
fi

if [ "$BIN_FOLDER" == "" ]; then
    exit
fi

if [ "$BIN_VER" == "" ]; then
    exit
fi

function service {
echo "[Unit]
Description=${BIN_NAME} Node Service
After=network-online.target
[Service]
User=${USER}
Environment=DAEMON_NAME=${BIN_NAME}
Environment=DAEMON_ALLOW_DOWNLOAD_BINARIES=true
Environment=DAEMON_RESTART_AFTER_UPGRADE=true
Environment=DAEMON_HOME=${HOME}/.${BIN_FOLDER}
ExecStart=$(which cosmovisor) start
Restart=always
RestartSec=3
LimitNOFILE=4096
[Install]
WantedBy=multi-user.target
" >/etc/systemd/system/cosmovisor.service

sudo systemctl daemon-reload && sudo systemctl enable cosmovisor.service

echo "---------------"
echo -e "$YELLOW cosmovisor.service installed.\033[0m"
echo "---------------"
}

function genesis {
echo -e "$GREEN Enter RAW link to Genesis file (Example: https://raw.githubusercontent.com/desmos-labs/morpheus/master/morpheus-apollo-1/genesis.json)\033[0m"
read -p "Genesis link: " GENESIS
curl $GENESIS > ~/.${BIN_FOLDER}/config/genesis.json
}
function seeds {
echo -e "$GREEN Enter Seeds (Example: be3db0fe5ee7f764902dbcc75126a2e082cbf00c@seed-1.morpheus.desmos.network:26656)\033[0m"
read -p "Seed: " SEED
sed -i.bak -E 's#^(seeds[[:space:]]+=[[:space:]]+).*$#\1"'$SEED'"#' ~/.${BIN_FOLDER}/config/config.toml
}
function peers {
echo -e "$GREEN Enter Peers (Validator or Sentry PEER) (Example: 728d59298dce64c72f13001f67a5b3e7fc080f91@135.181.201.2:26656)\033[0m"
read -p "Persistent_peers: " PEERS
sed -i.bak -E 's#^(persistent_peers[[:space:]]+=[[:space:]]+).*$#\1"'$PEERS'"#' ~/.${BIN_FOLDER}/config/config.toml
}
function gas {
echo -e "$GREEN Enter minimum-gas-prices (Example: 0.025udaric)\033[0m"
read -p "minimum-gas-prices: " GAS_PRICE
sed -i.bak -E 's#^(minimum-gas-prices[[:space:]]+=[[:space:]]+).*$#\1"'$GAS_PRICE'"#' ~/.${BIN_FOLDER}/config/app.toml
}

function sentry {

echo -e "$YELLOW SENRTY CONFIGURING.\033[0m"
echo -e "$YELLOW Next you need to provide CHAIN data.\033[0m"
echo -e "$YELLOW If some data is not needed, just press ENTER to go next.\033[0m"
echo "---------------"

sleep 3

echo -e "$GREEN Enter CHAIN-ID\033[0m"
read -p "Chain-id: " CHAIN

echo -e "$GREEN Enter your Sentry Moniker\033[0m"
read -p "Moniker: " MONIKER
if [ "$CHAIN" == "" ]; then
    ${BIN_NAME} init $MONIKER
else
    ${BIN_NAME} init $MONIKER --chain-id $CHAIN
fi

echo "---------------"
echo -e "$YELLOW Your SENTRY Moniker: ${MONIKER}, initialised.\033[0m"
echo -e "$YELLOW Your SENTRY NODE-ID: \033[0m"
${BIN_NAME} tendermint show-node-id
echo "---------------"

sleep 5

genesis
seeds
peers
gas

sed -i.bak -E 's#^(pex[[:space:]]+=[[:space:]]+).*$#\1'true'#' ~/.${BIN_FOLDER}/config/config.toml
sed -i.bak -E 's#^(addr_book_strict[[:space:]]+=[[:space:]]+).*$#\1'false'#' ~/.${BIN_FOLDER}/config/config.toml

echo "---------------"
echo -e "$YELLOW ${BIN_NAME} Configured and waiting to start.\033[0m"
echo "---------------"
echo -e "$YELLOW Installation of ${BIN_NAME}, and cosmovisor complete.\033[0m"
echo "---------------"
echo -e "$YELLOW Waiting for start the chain!\033[0m"
echo "---------------"
}

function validator {

echo -e "$YELLOW VALIDATOR CONFIGURING.\033[0m"
echo -e "$YELLOW Next you need to provide CHAIN data.\033[0m"
echo -e "$YELLOW If some data is not needed, just press ENTER to go next.\033[0m"
echo "---------------"

sleep 3

echo -e "$GREEN Enter CHAIN-ID\033[0m"
read -p "Chain-id: " CHAIN

echo -e "$GREEN Enter your Moniker\033[0m"
read -p "Moniker: " MONIKER
if [ "$CHAIN" == "" ]; then
    ${BIN_NAME} init $MONIKER
else
    ${BIN_NAME} init $MONIKER --chain-id $CHAIN
fi

echo "---------------"
echo -e "$YELLOW Your Validator Moniker: ${MONIKER}, initialised.\033[0m"
echo -e "$YELLOW Your Validator NODE-ID: \033[0m"
${BIN_NAME} tendermint show-node-id
echo "---------------"

sleep 5

genesis
seeds
peers
gas

sed -i.bak -E 's#^(pex[[:space:]]+=[[:space:]]+).*$#\1'false'#' ~/.${BIN_FOLDER}/config/config.toml

echo "---------------"
echo -e "$YELLOW ${BIN_NAME} Configured and waiting to start.\033[0m"
echo "---------------"
echo -e "$YELLOW Installation of ${BIN_NAME}, and cosmovisor complete.\033[0m"
echo "---------------"
echo -e "$YELLOW Waiting for start the chain!\033[0m"
echo "---------------"
}

function configuring {

mkdir -p $GOBIN ${HOME}/.${BIN_FOLDER}/cosmovisor/genesis/bin ${HOME}/.${BIN_FOLDER}/cosmovisor/upgrades/Gir/bin

mkdir -p $GOPATH/src/github.com/cosmos && cd $GOPATH/src/github.com/cosmos && git clone https://github.com/cosmos/cosmos-sdk && cd cosmos-sdk/cosmovisor && git checkout ${COSMOVISOR} && make cosmovisor

mv cosmovisor $GOBIN

echo "---------------"
echo -e "$YELLOW Cosmovisor built and installed.\033[0m"
echo "---------------"

mkdir $GOPATH/src/github.com/${GIT_FOLDER} && cd $GOPATH/src/github.com/${GIT_FOLDER} && git clone https://github.com/${GIT_NAME}/${GIT_FOLDER} && cd ${GIT_FOLDER} && git fetch && git checkout tags/${BIN_VER} && make install && make build

echo "---------------"
echo -e "$YELLOW ${BIN_NAME} built and installed.\033[0m"
echo "---------------"

if [ -e $GOPATH/src/github.com/${GIT_FOLDER}/${GIT_FOLDER}/build/${BIN_NAME} ]; then
  cp build/${BIN_NAME} ${HOME}/.${BIN_FOLDER}/cosmovisor/genesis/bin
  cp build/${BIN_NAME} ${HOME}/.${BIN_FOLDER}/cosmovisor/upgrades/Gir/bin
else
  cd
  cp $GOBIN/${BIN_NAME} ${HOME}/.${BIN_FOLDER}/cosmovisor/genesis/bin
  cp $GOBIN/${BIN_NAME} ${HOME}/.${BIN_FOLDER}/cosmovisor/upgrades/Gir/bin
fi

ln -s -T ${HOME}/.${BIN_FOLDER}/cosmovisor/upgrades/Gir ${HOME}/.${BIN_FOLDER}/cosmovisor/current

cd
echo "export PATH=$HOME/.${BIN_NAME}/cosmovisor/current/bin:\$PATH" >> ~/.profile
echo "export BIN_NAME=${BIN_NAME}" >> ~/.profile
echo "export BIN_FOLDER=${BIN_FOLDER}" >> ~/.profile
echo "export DAEMON_NAME=${BIN_NAME}" >> ~/.profile
echo "export DAEMON_HOME=${HOME}/.${BIN_NAME}" >> ~/.profile
echo "export DAEMON_ALLOW_DOWNLOAD_BINARIES=true" >> ~/.profile
echo "export DAEMON_RESTART_AFTER_UPGRADE=true" >> ~/.profile
. ~/.profile

service
}

function initialising {

echo -e "$YELLOW Next, you need to choose which type of node to configure.\033[0m"
echo -e "$YELLOW If you have to configure SENTRY node type$RED yes\033[0m.\033[0m"
echo -e "$YELLOW If you have to configure VALIDATOR node type$RED no\033[0m.\033[0m"
read -p "Your answer: " ANSWER
if [ "$ANSWER" == "yes|YES|Yes" ]; then
    sentry
elif [ "$ANSWER" == "no|No" ]; then
    validator
else
    echo "$RED Answer wrong. Exited...\033[0m"
    exit 0
fi

}

function start {
sleep 2

sudo systemctl start cosmovisor.service

journalctl -u cosmovisor.service -f
}

configuring
initialising
start
