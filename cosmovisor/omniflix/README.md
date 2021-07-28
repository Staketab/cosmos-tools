# COSMOVISOR
Setup COSMOVISOR for OMNIFLIX TESTNET.

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
Enter Enviroments on the example of the Osmosis project:  
`COSMOVISOR_VER = v0.42.6`  
`GIT_NAME = OmniFlix`  
`GIT_FOLDER = omniflixhub`  
`BIN_NAME = omniflixhubd`  
`CONFIG_FOLDER = omniflixhub`  
`BIN_VER = v0.1.0`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh v0.42.6 OmniFlix omniflixhub omniflixhubd omniflixhub v0.1.0
```

## 3. Data for start the chain. 
Chain-id - `flixnet-1`  
Genesis file - [Link](https://raw.githubusercontent.com/OmniFlix/testnets/main/flixnet-1/genesis.json)  
Peers - `449848dbf4c9efec273f9014b3e2ff7f2ca468e5@45.72.100.123:26656,086706a33dd2c511bf0162ee3583429a9e2ab1a5@45.72.100.124:26656`  
Seed - `af3b140b9283f568aa49097e9e7dba8a9f3498e3@45.72.100.122:26656`  
minimum-gas-prices - `-`  

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart omniflixhubd.service`  
Cosmovisor service logs - `journalctl -u omniflixhubd.service -f`  
Stop Cosmovisor service - `systemctl stop omniflixhubd.service`  

## DONE
