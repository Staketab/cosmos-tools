# COSMOVISOR
Setup COSMOVISOR for MEDIBLOC TESTNET.

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
Enter Enviroments on the example of the Desmos project:  
`COSMOVISOR_VER = v0.42.4`  
`GIT_NAME = medibloc`  
`GIT_FOLDER = panacea-core`  
`BIN_NAME = panacead`  
`CONFIG_FOLDER = panacead`  
`BIN_VER = v1.3.3`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh v0.42.4 medibloc panacea-core panacead panacead v1.3.3
```

## 3. Data for start the chain. 
Chain-id - `opentestnet-1`  
Genesis file - [Link](https://raw.githubusercontent.com/medibloc/panacea-opentestnet/main/opentestnet-1/genesis.json)  
Peers - `6cbc8908891228a0a7747b92c3d96c2c39b81918@13.125.195.109:26656`  
Seed - `None`  
minimum-gas-prices - `0.025umed`  

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart cosmovisor.service`  
Cosmovisor service logs - `journalctl -u cosmovisor.service -f`  
Stop Cosmovisor service - `systemctl stop cosmovisor.service`  

## DONE
