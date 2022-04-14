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
Example `./go.sh -v 1.18 -p /root/go`  

### You can use all the variables or not use them at all and then the GO_VERSION and GO_PATH will be used by default as (-v 1.17.1 -p /usr/local/go)  

```
wget https://raw.githubusercontent.com/Staketab/node-tools/main/components/golang/go.sh \
&& chmod +x go.sh && ./go.sh -v 1.18 \
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
&& ./install.sh -g cosmos -f gaia -b gaiad -c gaia -v v6.0.0 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain. 
https://github.com/cosmos/gaia/releases  
Binary link:
```
https://github.com/cosmos/gaia/releases/download/v6.0.0/gaiad-v6.0.0-linux-amd64
```
Chain-id:
```
vega-testnet
```  
Genesis file:
```
https://github.com/cosmos/testnets/raw/master/v7-theta/public-testnet/genesis.json.gz
```
Peers:
```
5c9850dc5ec603b0c97ffd8d67bde3221b877acf@p2p.sentry-01.theta-testnet.polypore.xyz:26656,208683ee734ba3cec1cfc0c8bcbc326969641952@p2p.sentry-02.theta-testnet.polypore.xyz:26656,58e9d022962a3875fa22d7146949d0dc34e51ba6@p2p.state-sync-01.theta-testnet.polypore.xyz:26656,6954e0479cd71fa01aeed15e1a3b87c06433d827@p2p.state-sync-02.theta-testnet.polypore.xyz:26656
```
Seed:
```
none
```
minimum-gas-prices:
```
0.000uatom
```

## 4. Service commands.
Reload configuration change - `sudo systemctl daemon-reload`  
Restart Cosmovisor service - `sudo systemctl restart gaiad.service`  
Cosmovisor service logs - `sudo journalctl -u gaiad.service -f`  
Stop Cosmovisor service - `sudo systemctl stop gaiad.service`  

## DONE
