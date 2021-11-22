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
&& ./go.sh -v 1.17.2 -p /root/go \
&& rm -rf go.sh
```
Now apply the changes with the command below or reboot your terminal.  
```
. /etc/profile && . $HOME/.bashrc
```

### 2. Run Node setup:
Enter Enviroments `-g GIT_NAME -f GIT_FOLDER -b BIN_NAME -c CONFIG_FOLDER -v BIN_VER` and run this script to setup and build.  
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g GIT_NAME -f GIT_FOLDER -b BIN_NAME -c CONFIG_FOLDER -v BIN_VER
```
`GIT_NAME = Sifchain`  
`GIT_FOLDER = sifnode`  
`BIN_NAME = sifnoded`  
`CONFIG_FOLDER = sifnoded`  
`BIN_VER = mainnet-genesis`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g Sifchain -f sifnode -b sifnoded -c sifnoded -v mainnet-genesis \
&& rm -rf install.sh && . $HOME/.profile
```
## 3. Data for start the chain. 
Binary link:
```
none
```
Chain-id:
```
sifchain
```  
Genesis file:
```
https://raw.githubusercontent.com/Staketab/cosmos-tools/main/cosmovisor/sifchain/genesis.json
```
Peers:
```
8c240f71f9e060277ce18dc09d82d3bbb05d1972@13.211.43.177:26656,0120f0a48e7e81cc98829ef4f5b39480f11ecd5a@52.76.185.17:26656,bcc2d07a14a8a0b3aa202e9ac106dec0bef91fda@13.55.247.60:26656,8c240f71f9e060277ce18dc09d82d3bbb05d1972@13.211.43.177:26656
```
Seed:
```
none
```
minimum-gas-prices:
```
0.025rowan
```

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart sifnoded.service`  
Cosmovisor service logs - `journalctl -u sifnoded.service -f`  
Stop Cosmovisor service - `systemctl stop sifnoded.service`  

## DONE