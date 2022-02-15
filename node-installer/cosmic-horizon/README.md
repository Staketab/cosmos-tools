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
Example `./go.sh -v 1.17.2`  

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
&& ./install.sh -g cosmic-horizon -f coho -b cohod -c coho -v v0.1 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain.  
Binary link:
```
https://github.com/cosmic-horizon/coho/releases/download/v0.1/cohod-v0.1-linux-amd64
```
Chain-id:
```
darkmatter-1
```  
Genesis file:
```
https://raw.githubusercontent.com/cosmic-horizon/testnets/main/darkmatter-1/genesis.json
```
Peers:
```
4338abf9fdbe143e59119d25310d8187e776df8a@89.58.6.243:26656,038e405c3bc3b7a72b2a8fe9759e4495ac9f7ab0@97.113.198.230:26656,20d436ab002bed85fbf0a1740cdf44d56594d62f@149.28.13.161:26656
```
Seed:
```
none
```
minimum-gas-prices:
```
0.001ucoho
```

## 4. Service commands.
Reload configuration change - `sudo systemctl daemon-reload`  
Restart Cosmovisor service - `sudo systemctl restart cohod.service`  
Cosmovisor service logs - `sudo journalctl -u cohod.service -f`  
Stop Cosmovisor service - `sudo systemctl stop cohod.service`  

## DONE
