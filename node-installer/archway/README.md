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
Example `./go.sh -v 1.17.5`  

### You can use all the variables or not use them at all and then the GO_VERSION and GO_PATH will be used by default as (-v 1.17.1 -p /usr/local/go)  

```
wget https://raw.githubusercontent.com/Staketab/node-tools/main/components/golang/go.sh \
&& chmod +x go.sh && ./go.sh -v 1.17.5 \
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
&& ./install.sh -g archway-network -f archway-cli -b archwayd -c archway -v v0.0.3 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain.  
Binary link:
```
https://github.com/Northa/archway_bin/releases/download/v0.0.3/archwayd
```
Chain-id:
```
augusta-1
```  
Genesis file:
```
https://raw.githubusercontent.com/archway-network/testnets/main/augusta-1/genesis.json
```
Peers:
```
1f6dd298271684729d0a88402b1265e2ae8b7e7b@162.55.172.244:26656
```
Seed:
```
2f234549828b18cf5e991cc884707eb65e503bb2@34.74.129.75:31076,c8890bcde31c2959a8aeda172189ec717fef0b2b@95.216.197.14:26656
```
minimum-gas-prices:
```
0.000uaugust
```

## 4. Service commands.
Reload configuration change - `sudo systemctl daemon-reload`  
Restart Cosmovisor service - `sudo systemctl restart archwayd.service`  
Cosmovisor service logs - `sudo journalctl -u archwayd.service -f`  
Stop Cosmovisor service - `sudo systemctl stop archwayd.service`  

## DONE
