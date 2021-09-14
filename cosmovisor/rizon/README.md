# COSMOVISOR
Cosmos multi-network automation script for Cosmovisor - RIZON TESTNET.

## 1. Install GOLANG.
Install custom version of Golang #GO. 
Specify version in this line `./install.sh -v VERSION`
Example `./install.sh -v 1.15.7`

Or you can install GO from [official website](https://golang.org/doc/install).
```
wget https://raw.githubusercontent.com/Staketab/node-tools/main/components/golang/install.sh \
&& chmod +x install.sh \
&& ./install.sh -v 1.15.7
```
Reboot your terminal after installing.

## 2. Run COSMOVISOR setup and build.
Enter Enviroments on the example of the Osmosis project:  
`COSMOVISOR_VER = v0.42.6`  
`GIT_NAME = rizon-world`  
`GIT_FOLDER = rizon`  
`BIN_NAME = rizond`  
`CONFIG_FOLDER = rizon`  
`BIN_VER = v0.2.0`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh v0.42.6 rizon-world rizon rizond rizon v0.2.0
```

## 3. Data for start the chain. 
Chain-id - `groot-07`  
Genesis file - [Link](https://raw.githubusercontent.com/rizon-world/testnet/master/genesis.json)  
Peers - `fc40d080708997112f799afaac09c667a560131a@65.21.184.214:26656,b197e7a5c3a70d6e6d5d65a09d881fa4ff597201@65.21.106.221:26656,7216c0b7bd384036211946571d5fde3b63e71523@104.251.216.165:26656,4c255b376f2a5208f6a2aed641a50fadd81d318d@128.199.198.111:26656,a891d5b5f6e1b38e851e5e8162641b4c3e722698@95.111.240.161:26656,3b8bba36191286ea05d85d57eed035997da20c0a@3.210.29.92:26656`  
Seed - `08c0e4c197a0607a9832f9b365d07cef9b04a859@3.34.181.126:26656,34cec0c4ada4cd7f8ad26c457d604edc0eff3cb0@13.124.253.195:26656,72016f93daf677147c5d1d2625273dde61ae2d0a@3.34.5.208:26656`  
minimum-gas-prices - `0.025uatolo`  

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart rizond.service`  
Cosmovisor service logs - `journalctl -u rizond.service -f`  
Stop Cosmovisor service - `systemctl stop rizond.service`  

## DONE
