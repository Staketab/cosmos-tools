# AUTOVISOR
Cosmos multi-network automation script for Cosmovisor - STARGAZE TESTNET.

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
`BIN_VER = v0.10.1`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh v0.42.7 public-awesome stargaze starsd starsd v0.10.1
```

## 3. Data for start the chain. 
Chain-id - `cygnusx-1`  
Genesis file - [Link](https://github.com/public-awesome/networks/releases/download/cygnusx-1-final/genesis.json)  
Peers - `20c363b38c52edd09d16ee63b44ff79f752ab855@144.217.252.197:26669,9f7f4c5a0ab8021e1b5c00b44605054680ba893c@14.52.147.51:30626,9ec309c3151c3eb09fbf76de32e49d9210a3eeaf@162.55.60.249:26656,4475c871a43faa9775dae81f9e5f0855fa8a05c9@172.31.15.156:26656,d81edf338d1f2b30ef126c22f0191b3e3bd1cb59@3.96.128.109:26656,1919ee8480b62856deb5ae89661460849feaf2a8@51.210.217.96:26656,1ff88514bfc749cfc5607e62e41d2b5c2541c59c@157.230.249.138:26656,e6b371a1461156e2665ae4c7fda2f841a0ff2e25@46.4.54.229:26656,0e4f9c7e1602cf32a0699155c0c05cca2cd39b59@46.105.92.97:26656,e7c3d120dfc8b784d17097415c3c21cb74ba1e43@159.69.126.56:26656,bee3f15177e32abf9797fbfee5a53477d9721101@143.110.186.44:26656,84694f369f3a8af9806ba7e3c5537611f519b65d@79.143.179.196:26656`  
Seed - `b5c81e417113e283288c48a34f1d57c73a0c6682@seed.cygnusx-1.publicawesome.dev:36657`  
minimum-gas-prices - ``  

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart starsd.service`  
Cosmovisor service logs - `journalctl -u starsd.service -f`  
Stop Cosmovisor service - `systemctl stop starsd.service`  

## DONE
