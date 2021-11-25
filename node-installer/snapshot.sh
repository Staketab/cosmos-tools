#!/bin/bash

set -e

RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"
NORMAL="\033[0m"
SNAP_BINARIES="akashnet-2,sifchain-1,sentinelhub-2,desmos-mainnet,osmosis-1,bitcanna-1,oasis-node,impacthub-3,panacea-3,juno-1,comdex-1,kichain-2,Test-Denali,SanfordNetwork"

function line {
echo "-------------------------------------------------------------------"
}

function unpack {
cd $HOME/.${CONFIG_FOLDER}/data
aria2c -x2 ${SNAP_LINK}${SNAP_NAME}
line
echo -e "$GREEN Unpacking...$NORMAL"
line
tar -xf ${SNAP_NAME}
rm -rf ${SNAP_NAME}
rm -rf $HOME/.${CONFIG_FOLDER}/data/upgrade-info.json
}

function greeting {
line
echo -e "$YELLOW Using the Snapshot Services from:$NORMAL"
echo -e "$GREEN c29r3:$NORMAL$RED https://github.com/c29r3/cosmos-snapshots$NORMAL"
line
echo -e "$GREEN Bambarello:$NORMAL$RED http://snapshots.alexvalidator.com:8081/$NORMAL"
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
    SNAP_LINK="http://135.181.60.250:8081/sifchain/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">sifchain.*tar" | tail -n 1 | tr -d '>')
    unpack
elif [[ "${CHAIN}" == "sentinelhub-2" ]]; then
    SNAP_LINK="http://135.181.60.250:8083/sentinel/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">sentinelhub-2.*tar" | tr -d ">")
    unpack
elif [[ "${CHAIN}" == "desmos-mainnet" ]]; then
    SNAP_LINK="http://135.181.60.250:8084/desmos/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">desmos.*tar" | tr -d ">")
    unpack
elif [[ "${CHAIN}" == "osmosis-1" ]]; then
    SNAP_LINK="http://135.181.60.250:8085/osmosis/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">osmosis.*tar" | tr -d ">")
    unpack
elif [[ "${CHAIN}" == "bitcanna-1" ]]; then
    SNAP_LINK="http://135.181.60.250:8086/bitcanna/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">bitcanna.*tar" | tr -d ">")
    unpack
elif [[ "${CHAIN}" == "oasis-node" ]]; then
    SNAP_LINK="http://95.216.45.250:8081/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">oasis.*tar" | tr -d ">")
    unpack
elif [[ "${CHAIN}" == "impacthub-3" ]]; then
    SNAP_LINK="http://cosmos-snap.staketab.com/ixo/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">impacthub-3.*tar" | tr -d ">")
    unpack
elif [[ "${CHAIN}" == "panacea-3" ]]; then
    SNAP_LINK="http://cosmos-snap.staketab.com/medibloc/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">panacea-3.*tar" | tr -d ">")
    unpack
elif [[ "${CHAIN}" == "juno-1" ]]; then
    SNAP_LINK="https://snapshots.stakecraft.com/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">juno-1.*tar" | tr -d ">")
    unpack
elif [[ "${CHAIN}" == "comdex-1" ]]; then
    SNAP_LINK="http://cosmos-snap.staketab.com/comdex/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">comdex-1.*tar" | tr -d ">")
    unpack
elif [[ "${CHAIN}" == "kichain-2" ]]; then
    SNAP_LINK="https://mercury-nodes.net/kichain-snaps/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">kichain-2.*tar" | tr -d ">")
    unpack
elif [[ "${CHAIN}" == "Test-Denali" ]]; then
    SNAP_LINK="http://cosmos-snap.staketab.com/idep/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">Test-Denali.*tar" | tr -d ">")
    unpack
elif [[ "${CHAIN}" == "SanfordNetwork" ]]; then
    SNAP_LINK="http://cosmos-snap.staketab.com/idep/"
    SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">SanfordNetwork.*tar" | tr -d ">")
    unpack
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
