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
&& ./install.sh -g ingenuity-build -f quicksilver -b quicksilverd -c quicksilverd -v v0.1.1 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain. 
https://github.com/ingenuity-build/quicksilver/releases/tag/v0.1.1  

Binary link:
```
none
```
Chain-id:
```
quicktest-1
```  
Genesis file:
```
https://raw.githubusercontent.com/ingenuity-build/testnets/main/rhapsody/genesis.json
```
Peers:
```
none
```
Seed:
```
dd3460ec11f78b4a7c4336f22a356fe00805ab64@seed.quicktest-1.quicksilver.zone:26656
```
minimum-gas-prices:
```
0uqck
```

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart service - `systemctl restart quicksilverd.service`  
Service logs - `journalctl -u quicksilverd.service -f`  
Stop service - `systemctl stop quicksilverd.service`  

## DONE
