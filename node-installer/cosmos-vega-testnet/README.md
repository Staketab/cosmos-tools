# Auto-node-installer
Cosmos SDK multi-network automation script for node setup.  
### Features:  
- Node installer
- Cosmovisor installer
- Snapshots
- State-sync
- No need to edit config

### 1. Install GOLANG:
Install custom version of Golang #GO.  
Or you can install GO from [official website](https://golang.org/doc/install).  

Specify version and GO path in this line `./go.sh -v GO_VERSION -p GO_PATH`  
Example `./go.sh -v 1.17.2 -p /root/go`  

### You can use all the variables or not use them at all and then the GO_VERSION and GO_PATH will be used by default as (-v 1.17.1 -p /usr/local/go)  

```
wget https://raw.githubusercontent.com/Staketab/node-tools/main/components/golang/go.sh \
&& chmod +x go.sh && ./go.sh -v 1.17.2 \
&& rm -rf go.sh
```
Now apply the changes with the command below or reboot your terminal.  
```
. /etc/profile && . $HOME/.bashrc
```

### 2. Run Node setup:
The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g cosmos -f gaia -b gaiad -c gaia -v v5.0.8 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain. 
https://github.com/cosmos/gaia/releases  
Binary link:
```
https://github.com/cosmos/gaia/releases/download/v5.0.8/gaiad-v5.0.8-linux-amd64
```
Chain-id:
```
vega-testnet
```  
Genesis file:
```
https://github.com/cosmos/vega-test/raw/master/public-testnet/modified_genesis_public_testnet/genesis.json.gz
```
Peers:
```
99b04a4efd48846f654da25532c85bd1fa6a6a39@198.50.215.1:46656,1edc806e29bfb380dc0298ce4fded8e3e8554e2a@198.50.215.1:36656,66a9e52e207c8257b791ff714d29100813e2fa00@143.244.151.9:26656
```
Seed:
```
none
```
minimum-gas-prices:
```
0.001uatom
```

## 4. Service commands.
Reload configuration change - `sudo systemctl daemon-reload`  
Restart Cosmovisor service - `sudo systemctl restart gaiad.service`  
Cosmovisor service logs - `sudo journalctl -u gaiad.service -f`  
Stop Cosmovisor service - `sudo systemctl stop gaiad.service`  

## DONE
