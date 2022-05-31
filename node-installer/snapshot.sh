#!/bin/bash

set -e

RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"
NORMAL="\033[0m"
SNAP_BINARIES="akashnet-2,sifchain-1,sentinelhub-2,desmos-mainnet,osmosis-1,bitcanna-1,oasis-2,impacthub-3,juno-1,kichain-2,stargaze-1,axelar-dojo-1,axelar-testnet-lisbon-3,umee-1,evmos_9001-2,omniflixhub-1,axelar-testnet-casablanca-1,gravity-bridge-3"
# panacea-3

function line {
echo "-------------------------------------------------------------------"
}

function unpack {
cd $HOME/.${CONFIG_FOLDER}/data
aria2c -x2 ${SNAP_LINK}${SNAP_NAME}
line
echo -e "$GREEN Unpacking SNAP...$NORMAL"
line
tar -xf ${SNAP_NAME}
rm -rf ${SNAP_NAME}
rm -rf $HOME/.${CONFIG_FOLDER}/data/upgrade-info.json
}
function unpackStaketab {
cd $HOME/.${CONFIG_FOLDER}/data
aria2c -x2 ${SNAP_LINK}
line
echo -e "$GREEN Unpacking SNAP...$NORMAL"
line
tar -xf *.tar
rm -rf *.tar
rm -rf $HOME/.${CONFIG_FOLDER}/data/upgrade-info.json
}
function unpackWasmStaketab {
rm -rf $HOME/.${CONFIG_FOLDER}/wasm && mkdir -p $HOME/.${CONFIG_FOLDER}/wasm
cd $HOME/.${CONFIG_FOLDER}/wasm
aria2c -x2 ${WASM_LINK}
line
echo -e "$GREEN Unpacking WASM...$NORMAL"
line
tar -xf *.tar
rm -rf *.tar
}

function greeting {
line
echo -e "$YELLOW Using the Snapshot Services from:$NORMAL"
echo -e "$GREEN c29r3:$NORMAL$RED https://github.com/c29r3/cosmos-snapshots$NORMAL"
line
echo -e "$GREEN Bambarello:$NORMAL$RED http://snapshots.alexvalidator.com/$NORMAL"
line
echo -e "$GREEN Staketab:$NORMAL$RED https://github.com/Staketab/nginx-cosmos-snap$NORMAL"
line
echo -e "$GREEN Alex Novy:$NORMAL$RED https://snapshots.stakecraft.com/$NORMAL"
line
}

function snapStart {
if [[ "${CHAIN}" == "akashnet-2" ]]; then
    SNAP_LINK="http://135.181.60.250/akash/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">akashnet-2.*tar" | tr -d ">")
    unpack
elif [[ "${CHAIN}" == "sifchain-1" ]]; then
    SNAP_LINK=$(curl -s https://services.staketab.com/backend/sifchain/ | jq -r .snap_link)
    unpackStaketab
elif [[ "${CHAIN}" == "sentinelhub-2" ]]; then
    SNAP_LINK="http://135.181.60.250:8083/sentinel/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">sentinelhub-2.*tar" | tr -d ">")
    unpack
elif [[ "${CHAIN}" == "desmos-mainnet" ]]; then
    SNAP_LINK=$(curl -s https://services.staketab.com/backend/desmos/ | jq -r .snap_link)
    unpackStaketab
elif [[ "${CHAIN}" == "osmosis-1" ]]; then
    SNAP_LINK=$(curl -s https://services.staketab.com/backend/osmosis/ | jq -r .snap_link)
    WASM_LINK=$(curl -s https://services.staketab.com/backend/osmosis/ | jq -r .wasm_link)
    unpackStaketab
    unpackWasmStaketab
elif [[ "${CHAIN}" == "bitcanna-1" ]]; then
    SNAP_LINK="http://135.181.60.250:8086/bitcanna/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">bitcanna.*tar" | tr -d ">")
    unpack
elif [[ "${CHAIN}" == "oasis-2" ]]; then
    SNAP_LINK="http://snapshots.alexvalidator.com/oasis/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">oasis.*tar" | tr -d ">")
    unpack
elif [[ "${CHAIN}" == "juno-1" ]]; then
    SNAP_LINK="https://snapshots.stakecraft.com/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">juno-1.*tar" | tr -d ">")
    unpack
elif [[ "${CHAIN}" == "kichain-2" ]]; then
    SNAP_LINK="https://mercury-nodes.net/kichain-snaps/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">kichain-2.*tar" | tr -d ">")
    unpack
elif [[ "${CHAIN}" == "stargaze-1" ]]; then
    SNAP_LINK=$(curl -s https://services.staketab.com/backend/stargaze/ | jq -r .snap_link)
    WASM_LINK=$(curl -s https://services.staketab.com/backend/stargaze/ | jq -r .wasm_link)
    unpackStaketab
    unpackWasmStaketab
elif [[ "${CHAIN}" == "axelar-dojo-1" ]]; then
    SNAP_LINK=$(curl -s https://services.staketab.com/backend/axelar/ | jq -r .snap_link)
    unpackStaketab
elif [[ "${CHAIN}" == "umee-1" ]]; then
    SNAP_LINK=$(curl -s https://services.staketab.com/backend/umee/ | jq -r .snap_link)
    unpackStaketab
elif [[ "${CHAIN}" == "evmos_9001-2" ]]; then
    SNAP_LINK=$(curl -s https://services.staketab.com/backend/evmos/ | jq -r .snap_link)
    unpackStaketab
elif [[ "${CHAIN}" == "omniflixhub-1" ]]; then
    SNAP_LINK=$(curl -s https://services.staketab.com/backend/omniflix/ | jq -r .snap_link)
    unpackStaketab
elif [[ "${CHAIN}" == "axelar-testnet-lisbon-3" ]]; then
    SNAP_LINK=$(curl -s https://services.staketab.com/backend/axelar-testnet-lisbon/ | jq -r .snap_link)
    unpackStaketab
elif [[ "${CHAIN}" == "axelar-testnet-casablanca-1" ]]; then
    SNAP_LINK=$(curl -s https://services.staketab.com/backend/axelar-testnet-casablanca/ | jq -r .snap_link)
    unpackStaketab
elif [[ "${CHAIN}" == "gravity-bridge-3" ]]; then
    SNAP_LINK=$(curl -s https://services.staketab.com/backend/gravity/ | jq -r .snap_link)
    unpackStaketab
else
    line
    echo -e "$RED Something went wrong ... Snapshot not found ...$NORMAL"
    line
fi
line
echo -e "$GREEN Snapshot for ${CHAIN} installed.$NORMAL"
line
sleep 2
}

greeting
snapStart
