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
`GIT_NAME = tharsis`  
`GIT_FOLDER = evmos`  
`BIN_NAME = evmosd`  
`CONFIG_FOLDER = evmosd`  
`BIN_VER = v0.3.0`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g tharsis -f evmos -b evmosd -c evmosd -v v0.3.0 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain. 
https://github.com/tharsis/evmos/releases  
Binary link:
```
none
```
Chain-id:
```
evmos_9000-2
```  
Genesis file:
```
https://raw.githubusercontent.com/tharsis/testnets/main/olympus_mons/genesis.json
```
Peers:
```
78605eed3018a74d9c8c3a912cd8e6d5c9a9ca4b@65.21.232.149:26726,3bd90caf48ddd2d6b290550ecccd63348fc51da0@95.217.107.96:26658,f8da50943569f160854ac21c9ffb46fb4ff7bc0d@144.217.252.197:26626,1c4c38243893889a17fd3e677999f896b2b18586@95.217.35.111:26666,0e4dec8dd2cb74277bae3a9e7f1816603e97ce60@161.97.178.48:26656,3e7b138c766dc6da32decca8665da1afb2b6bb88@207.244.249.17:26656,5502b008356087cb689211bb3c4285b7ce7f6571@95.217.154.12:26656,8227d17c3cf123108c69bf671295e5fb22d9beb3@161.97.115.68:26656,56de4d8fe7421f5a4fb6ba75b20d749be3eecf22@95.217.84.54:26656,06e3dfce2d729250e810bd5605ad7f05f3b1fc2c@75.119.155.119:26656,7cb1576a6ed3dbdc62bc30908ff7d7e910c5b08f@78.46.52.20:46656,5502b008356087cb689211bb3c4285b7ce7f6571@95.217.154.12:26656,5576b0160761fe81ccdf88e06031a01bc8643d51@195.201.108.97:24656,13e850d14610f966de38fc2f925f6dc35c7f4bf4@176.9.60.27:26656,38eb4984f89899a5d8d1f04a79b356f15681bb78@18.169.155.159:26656,59c4351009223b3652674bd5ee4324926a5a11aa@51.15.133.26:26656,3a5a9022c8aa2214a7af26ebbfac49b77e34e5c5@65.108.1.46:26656,6624238168de05893ca74c2b0270553189810aa7@95.216.100.80:26656
```
Seed:
```
c36cec90ded95d162b85f8ecd00ecd7c8849ca75@arsiamons.seed.evmos.org:26656,6f0bbcf559a3eab1c5594062d587ccec4b4bade2@evmos-seed.artifact-staking.io:26656,faa31510d9280e74e7f2e767a62023bd5c896c27@evmos-testnet.mercury-nodes.net:29447
```
minimum-gas-prices:
```
0aphoton
```

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart evmosd.service`  
Cosmovisor service logs - `journalctl -u evmosd.service -f`  
Stop Cosmovisor service - `systemctl stop evmosd.service`  

## DONE
