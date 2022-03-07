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
Example `./go.sh -v 1.17.5`  

### You can use all the variables or not use them at all and then the GO_VERSION and GO_PATH will be used by default as (-v 1.17.1 -p /usr/local/go)  

```
wget https://raw.githubusercontent.com/Staketab/node-tools/main/components/golang/go.sh \
&& chmod +x go.sh && ./go.sh -v 1.17.5 \
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
&& ./install.sh -g OmniFlix -f omniflixhub -b omniflixhubd -c omniflixhub -v v0.4.0 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain.  
Binary link:
```
none
```
Chain-id:
```
omniflixhub-1
```  
Genesis file:
```
https://raw.githubusercontent.com/OmniFlix/mainnet/main/omniflixhub-1/genesis.json
```
Peers:
```
2df1f357f08049ba0c0dddfffe805f0e135e54ec@35.247.185.216:26656,6198ac4bc907f6d1a78309ef58491370afc49799@34.124.195.219:26656,574b37cc6e80663e70673cbe848147c2643ca48e@35.240.187.174:26656,8313c9d55006da030588f61806b3e056a113e6e8@34.87.18.204:26656
```
Seed:
```
9d75a06ebd3732a041df459849c21b87b2c55cde@35.187.240.195:26656,19feae28207474eb9f168fff9720fd4d418df1ed@35.240.196.102:26656
```
minimum-gas-prices:
```
0.001uflix
```

## 4. Service commands.
Reload configuration change - `sudo systemctl daemon-reload`  
Restart Cosmovisor service - `sudo systemctl restart omniflixhubd.service`  
Cosmovisor service logs - `sudo journalctl -u omniflixhubd.service -f`  
Stop Cosmovisor service - `sudo systemctl stop omniflixhubd.service`  

## DONE
