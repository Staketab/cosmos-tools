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
&& chmod +x go.sh \
&& ./go.sh -v 1.17.2 \
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
&& ./install.sh -g IDEP-network -f incentivized-testnet -b iond -c ion -v none \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain. 
## IMPORTANT  
### Use Binary installation option  
Binary link:
```
https://raw.githubusercontent.com/IDEP-network/incentivized-testnet/main/binary/iond
```
Chain-id:
```
SanfordNetwork
```  
Genesis file:
```
https://raw.githubusercontent.com/IDEP-network/incentivized-testnet/main/binary/genesis.json
```
Peers:
```
4a22319cf53209fe8655f4aa7dd023a3822d4e3c@88.99.56.200:36656
```
Seed:
```
fb870b06d828a82a368f7a8e539edf76c3e7b420@159.89.84.111:26656
```
minimum-gas-prices:
```
0idep
```

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart iond.service`  
Cosmovisor service logs - `journalctl -u iond.service -f`  
Stop Cosmovisor service - `systemctl stop iond.service`  

## DONE
