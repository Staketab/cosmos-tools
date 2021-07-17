# COSMOVISOR
Setup COSMOVISOR for STARGAZE TESTNET.

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
`COSMOVISOR_VER = v0.42.7`  
`GIT_NAME = public-awesome`  
`GIT_FOLDER = stargaze`  
`BIN_NAME = starsd`  
`CONFIG_FOLDER = starsd`  
`BIN_VER = v0.10.0`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh v0.42.7 public-awesome stargaze starsd starsd v0.10.0
```

## 3. Data for start the chain. 
Chain-id - `cygnusx-1`  
Genesis file - [Link](https://github.com/public-awesome/networks/releases/download/cygnusx-1-final/genesis.json)  
Peers - ``  
Seed - `b5c81e417113e283288c48a34f1d57c73a0c6682@seed.cygnusx-1.publicawesome.dev:36657`  
minimum-gas-prices - `0.025ustarx`  

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart starsd.service`  
Cosmovisor service logs - `journalctl -u starsd.service -f`  
Stop Cosmovisor service - `systemctl stop starsd.service`  

## DONE
