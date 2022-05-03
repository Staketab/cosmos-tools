# Statesync auto setup

## Statesync start:
Specify HOST_PORT, CONFIG_FOLDER, SERVICE_NAME and BLOCKS in this line `./statesync.sh HOST_PORT CONFIG_FOLDER SERVICE_NAME BLOCKS`  
Example `./statesync.sh http://111.222.333.444:26657 .osmosisd osmosisd 2000`  
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/state-sync/statesync.sh \
&& chmod +x statesync.sh \
&& ./statesync.sh http://111.222.333.444:26657 .osmosisd osmosisd 2000
```

## ! Important
### Next steps only for Osmosis, Stargaze
After applying chunks and restoring state you need to change App version. (Example for Osmosis)
## Stop the service.
```
sudo systemctl stop osmosisd
```
## Set app version to 1.
```
git clone https://github.com/tendermint/tendermint
cd tendermint
git checkout remotes/origin/callum/app-version
go install ./...
tendermint set-app-version 1 --home $HOME/.osmosisd
```
## Restarting...
```
sudo systemctl restart osmosisd
```

### DONE
