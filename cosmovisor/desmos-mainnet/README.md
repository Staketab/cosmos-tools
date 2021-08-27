# COSMOVISOR
Setup COSMOVISOR for DESMOS MAINNET.

## 1. Install GOLANG.
Install custom version of Golang #GO. 
Specify version in this line `./install.sh -v VERSION`
Example `./install.sh -v 1.16.5`

Or you can install GO from [official website](https://golang.org/doc/install).
```
wget https://raw.githubusercontent.com/Staketab/node-tools/main/components/golang/install.sh \
&& chmod +x install.sh \
&& ./install.sh -v 1.16.5
```
Reboot your terminal after installing.

## 2. Run COSMOVISOR setup and build.
Enter Enviroments on the example of the Desmos project:  
`COSMOVISOR_VER = v0.42.9`  
`GIT_NAME = desmos-labs`  
`GIT_FOLDER = desmos`  
`BIN_NAME = desmos`  
`CONFIG_FOLDER = desmos`  
`BIN_VER = v1.0.1`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh v0.42.9 desmos-labs desmos desmos desmos v1.0.1
```

## 3. Data for start the chain. 
https://github.com/desmos-labs/desmos/releases/tag/v1.0.1  
Binary link:
```
none
```
Chain-id:
```
desmos-mainnet-1
```  
Genesis file:
```
https://raw.githubusercontent.com/desmos-labs/mainnet/main/genesis.json
```
Peers:
```
none
```
Seed:
```
9bde6ab4e0e00f721cc3f5b4b35f3a0e8979fab5@seed1.mainnet.desmos.network,5c86915026093f9a2f81e5910107cf14676b48fc@seed2.mainnet.desmos.network,45105c7241068904bdf5a32c86ee45979794637f@seed3.mainnet.desmos.network
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
