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
&& ./install.sh -g axelarnetwork -f axelar-core -b axelard -c axelar -v v0.17.3 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain. 
https://github.com/axelarnetwork/axelar-core/releases/tag/v0.17.3

Binary link:
```
https://github.com/axelarnetwork/axelar-core/releases/download/v0.17.3/axelard-linux-amd64-v0.17.3
```
Chain-id:
```
axelar-testnet-casablanca-1
```  
Genesis file:
```
https://axelar-testnet.s3.us-east-2.amazonaws.com/axelar-testnet-casablanca-1/genesis.json
```
Peers:
```
0d9aab72b613119d3bf6ebb5aed510fb7eb5421c@65.108.195.29:26656
```
Seed:
```
95c90e528c54e2ebaa0427e034c8facc75e6da3f@aa96e735f68464b09955026986b15632-1865235038.us-east-2.elb.amazonaws.com:26656
```
minimum-gas-prices:
```
0uaxl
```

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart service - `systemctl restart axelard.service`  
Service logs - `journalctl -u axelard.service -f`  
Stop service - `systemctl stop axelard.service`  

## DONE
