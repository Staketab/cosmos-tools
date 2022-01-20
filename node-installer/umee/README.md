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
`GIT_NAME = umee-network`  
`GIT_FOLDER = umee`  
`BIN_NAME = umeed`  
`CONFIG_FOLDER = umee`  
`BIN_VER = v0.5.0-rc3`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g umee-network -f umee -b umeed -c umee -v v0.5.0-rc3 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain. 
https://github.com/umee-network/umee/releases  
Binary link:
```
none
```
Chain-id:
```
umee-alpha-mainnet-3
```  
Genesis file:
```
https://raw.githubusercontent.com/umee-network/testnets/main/networks/umee-alpha-mainnet-3/genesis.json
```
Peers:
```
b2bf71f20584fa63dbb4ca66f0533a58a7a4dcea@65.108.178.116:26656,dcbb9502e059f40b18c8fac2837b712340ad4727@161.97.159.64:26656,b5e533e6df886eb34a9d8e348124f400a77a33b6@146.59.55.100:26656,04fa2806127d971f1d23b2f8d116e4a8ddefc191@159.89.144.87:26656,0f5245bf2a9029676052043efd82e814ec5aece1@89.163.164.209:26656,db6ef36604edca1cb93c9b4dc3fad47dc3aa8989@135.181.165.110:26656
```
Seed:
```
none
```
minimum-gas-prices:
```
0uumee
```

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart umeed.service`  
Cosmovisor service logs - `journalctl -u umeed.service -f`  
Stop Cosmovisor service - `systemctl stop umeed.service`  

## DONE
