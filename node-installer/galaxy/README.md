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
Example `./go.sh -v 1.18 -p /root/go`  

### You can use all the variables or not use them at all and then the GO_VERSION and GO_PATH will be used by default as (-v 1.17.1 -p /usr/local/go)  

```
wget https://raw.githubusercontent.com/Staketab/node-tools/main/components/golang/go.sh \
&& chmod +x go.sh && ./go.sh -v 1.18 \
&& rm -rf go.sh
```
Now apply the changes with the command below or reboot your terminal.  
```
. /etc/profile && . $HOME/.bashrc
```

### 2. Run Node setup:
The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g galaxies-labs -f galaxy -b galaxyd -c galaxy -v v1.0.0 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain. 
Binary link:
```
none
```
Chain-id:
```
galaxy-1
```  
Genesis file:
```
https://media.githubusercontent.com/media/galaxies-labs/networks/main/galaxy-1/genesis.json
```
Peers:
```
bf446887a7a00c8babfeba2f92ba569a206a3ea7@65.108.71.140:26676,1e9ee1911298a15128c8485ea47b18be08939e01@136.244.29.116:38656,a4bd8fed416aa29d9cc061e2b9dffa7f4b679c91@65.21.131.144:30656,801f4e17769bd2ee02b27720d901a42cb8d052ea@65.108.192.3:24656,cd8fd9e1677c701015b8909116f88974028cd0b4@203.135.141.28:26656,51b3263a333de94198fe4c4d819b48fbd107f93a@5.9.13.234:26356,e21bf32eaedee13d8dc240baacf23fee97a8edac@141.94.141.144:43656,8b447bd4fa1e56d8252538a6e23573e5e78924fa@161.97.155.94:26656
```
Seed:
```
574e8402e255f895680db2904168724258fd6ff8@13.125.60.249:26656
```
minimum-gas-prices:
```
0.000uglx
```

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart galaxyd.service`  
Cosmovisor service logs - `journalctl -u galaxyd.service -f`  
Stop Cosmovisor service - `systemctl stop galaxyd.service`  

## DONE
