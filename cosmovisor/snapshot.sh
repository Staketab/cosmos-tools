#!/bin/bash

RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"
NORMAL="\033[0m"
SNAP_BINARIES="akash,sifnoded,sentinelhub,desmos,osmosisd,bcnad"

function line {
echo "-------------------------------------------------------------------"
}

function greeting {
line
echo -e "$YELLOW Using the Snapshot Service from$NORMAL$RED c29r3: $NORMAL"
echo -e "$GREEN Snapshot Github link:$NORMAL$RED https://github.com/c29r3/cosmos-snapshots $NORMAL"
echo -e "$GREEN Contact discord nickname:$NORMAL$RED @whataday2day#1271 $NORMAL"
line
sleep 3
}

function snapStart {
if [[ "${BIN_NAME}" == "akash" ]]; then
    cd $HOME/.${CONFIG_FOLDER}/data
    SNAP_NAME=$(curl -s http://135.181.60.250/akash/ | egrep -o ">akashnet-2.*tar" | tr -d ">")
    wget -O - http://135.181.60.250/akash/${SNAP_NAME} | tar xf -
elif [[ "${BIN_NAME}" == "sifnoded" ]]; then
    cd $HOME/.${CONFIG_FOLDER}/data
    SNAP_NAME=$(curl -s http://135.181.60.250:8081/sifchain/ | egrep -o ">sifchain.*tar" | tail -n 1 | tr -d '>')
    wget -O - http://135.181.60.250:8081/sifchain/${SNAP_NAME} | tar xf -
elif [[ "${BIN_NAME}" == "sentinelhub" ]]; then
    cd $HOME/.${CONFIG_FOLDER}/data
    SNAP_NAME=$(curl -s http://135.181.60.250:8083/sentinel/ | egrep -o ">sentinelhub-2.*tar" | tr -d ">")
    wget -O - http://135.181.60.250:8083/sentinel/${SNAP_NAME} | tar xf -
elif [[ "${BIN_NAME}" == "desmos" ]]; then
    cd $HOME/.${CONFIG_FOLDER}/data
    SNAP_NAME=$(curl -s http://135.181.60.250:8084/desmos/ | egrep -o ">desmos.*tar" | tr -d ">")
    wget -O - http://135.181.60.250:8084/desmos/${SNAP_NAME} | tar xf -
elif [[ "${BIN_NAME}" == "osmosisd" ]]; then
    cd $HOME/.${CONFIG_FOLDER}/data
    SNAP_NAME=$(curl -s http://135.181.60.250:8085/osmosis/ | egrep -o ">osmosis.*tar" | tr -d ">")
    wget -O - http://135.181.60.250:8085/osmosis/${SNAP_NAME} | tar xf -
elif [[ "${BIN_NAME}" == "bcnad" ]]; then
    cd $HOME/.${CONFIG_FOLDER}/data
    SNAP_NAME=$(curl -s http://135.181.60.250:8086/bitcanna/ | egrep -o ">bitcanna.*tar" | tr -d ">")
    wget -O - http://135.181.60.250:8086/bitcanna/${SNAP_NAME} | tar xf -
else
    line
    echo -e "$RED Something went wrong ... Snapshot not found ...$NORMAL"
    line
fi
line
echo -e "$GREEN Snapshot for ${BIN_NAME} installed.$NORMAL"
line
sleep 2
}

greeting
snapStart
