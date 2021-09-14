# AUTOVISOR
Cosmos multi-network automation script for Cosmovisor - MEDIBLOC MAINNET.

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
`GIT_NAME = medibloc`  
`GIT_FOLDER = panacea-core`  
`BIN_NAME = panacead`  
`CONFIG_FOLDER = panacea`  
`BIN_VER = v2.0.1`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh v0.42.9 medibloc panacea-core panacead panacea v2.0.1
```

## 3. Data for start the chain. 
Chain-id - `panacea-3`  
Genesis file - [Link](https://github.com/medibloc/panacea-mainnet/raw/master/panacea-3/genesis.json.gz)  
Peers - `8c41cc8a6fc59f05138ae6c16a9eec05d601ef71@13.209.177.91:26656,cc0285c4d9cec8489f8bfed0a749dd8636406a0d@54.180.169.37:26656,1fc4a41660986ee22106445b67444ec094221e76@52.78.132.151:26656`  
Seed - `e93f5df69cc1b9bda230b3efcf162d4672293ded@3.35.82.40:26656,0e0db1c7ab1e37c76f2ceced0bb72e1c60ef17a6@13.124.96.254:26656,a83232db3a40e486b54b1463a43431e8490b808b@52.79.108.35:26656`  
minimum-gas-prices - `5umed`  

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart panacead.service`  
Cosmovisor service logs - `journalctl -u panacead.service -f`  
Stop Cosmovisor service - `systemctl stop panacead.service`  

## DONE
