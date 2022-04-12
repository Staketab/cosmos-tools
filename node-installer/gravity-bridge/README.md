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
Example `./go.sh -v 1.18.1`  

### You can use all the variables or not use them at all and then the GO_VERSION and GO_PATH will be used by default as (-v 1.17.1 -p /usr/local/go)  

```
wget https://raw.githubusercontent.com/Staketab/node-tools/main/components/golang/go.sh \
&& chmod +x go.sh && ./go.sh -v 1.18.1 \
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
&& ./install.sh -g Gravity-Bridge -f Gravity-Bridge -b gravity -c gravity -v v1.4.0 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain.  
Binary link:
```
https://github.com/Gravity-Bridge/Gravity-Bridge/releases/download/v1.4.0/gravity-linux-amd64
```
Chain-id:
```
gravity-bridge-3
```  
Genesis file:
```
https://raw.githubusercontent.com/Gravity-Bridge/gravity-docs/main/genesis.json
```
Peers:
```
none        
```
Seed:
```
2b089bfb4c7366efb402b48376a7209632380c9c@65.19.136.133:26656,63e662f5e048d4902c7c7126291cf1fc17687e3c@95.211.103.175:26656
```
minimum-gas-prices:
```
0.000ugraviton
```

## 4. Service commands.
Reload configuration change - `sudo systemctl daemon-reload`  
Restart Cosmovisor service - `sudo systemctl restart gravity.service`  
Cosmovisor service logs - `sudo journalctl -u gravity.service -f`  
Stop Cosmovisor service - `sudo systemctl stop gravity.service`  

## DONE
