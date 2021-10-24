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
Enter Enviroments on the example of the Desmos project:  
`GIT_NAME = desmos-labs`  
`GIT_FOLDER = desmos`  
`BIN_NAME = desmos`  
`CONFIG_FOLDER = desmos`  
`BIN_VER = v1.0.1`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g desmos-labs -f desmos -b desmos -c desmos -v v1.0.1
```

## 3. Data for start the chain. 
https://github.com/desmos-labs/desmos/releases/tag/v1.0.1  
Binary link:
```
none
```
Chain-id:
```
desmos-mainnet
```  
Genesis file:
```
https://raw.githubusercontent.com/desmos-labs/mainnet/main/genesis.json
```
Peers:
```
6af346f98a371c327afc078f45f401c7594bf4c7@95.216.42.177:26656,a2f741cfabd08d5393af119485202f5de8ccaaf8@136.243.5.13:26656,2cfcc59cc95139a35fe8afb6462af3d36e45c5ce@135.181.181.121:36656,fae2ffd80edc88ec47dac9346df53107ae1e4b7d@157.90.7.48:26656
```
Seed:
```
9bde6ab4e0e00f721cc3f5b4b35f3a0e8979fab5@seed-1.mainnet.desmos.network:26656,5c86915026093f9a2f81e5910107cf14676b48fc@seed-2.mainnet.desmos.network:26656,45105c7241068904bdf5a32c86ee45979794637f@seed-3.mainnet.desmos.network:26656
```
minimum-gas-prices:
```
0.001udsm
```

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart desmos.service`  
Cosmovisor service logs - `journalctl -u desmos.service -f`  
Stop Cosmovisor service - `systemctl stop desmos.service`  

## DONE
