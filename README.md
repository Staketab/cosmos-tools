# Node Tools
List of tools for Node projects.

# GOLANG #GO
Install custom version of Golang #GO.  
Specify version in this line `./install.sh -v VERSION`  
Example `./install.sh -v 1.15.7`    

Or you can install GO from [official website](https://golang.org/doc/install).
```
wget https://raw.githubusercontent.com/Staketab/tools/main/golang/install.sh \
&& chmod +x install.sh \
&& ./install.sh -v 1.15.7
```
Reboot your terminal after installing.

# MINA
## 1. Installation guide for Mina Node. 
Link to the [Guide](https://icohigh.gitbook.io/mina-node-testnet/).  

## 2. Install libraries for Ubuntu 20.04

```
wget https://raw.githubusercontent.com/Staketab/tools/main/mina/libs-20.04/install.sh \
&& chmod +x install.sh \
&& ./install.sh \
&& rm -rf install.sh
```

# AVALANCHE
Script for installing and updating Avalanche node from binary.  
Specify TAG and VERSION in this line `./install-upd.sh TAG VERSION`  
Example `./install-upd.sh 1.4.4 1.4.4`  
```
wget https://raw.githubusercontent.com/Staketab/tools/main/avalanche/install-upd.sh \
&& chmod +x install-upd.sh \
&& ./install-upd.sh 1.4.4 1.4.4 \
&& rm -rf install-upd.sh
```

# COSMOVISOR
Setup COSMOVISOR for all Cosmos projects.  

### 1. Install GOLANG.

### 2. Run COSMOVISOR setup and build.
Enter Enviroments `COSMOVISOR_VER GIT_NAME GIT_FOLDER BIN_NAME BIN_VER` and run this script to setup and build.  
```
wget https://raw.githubusercontent.com/Staketab/tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh COSMOVISOR_VER GIT_NAME GIT_FOLDER BIN_NAME BIN_VER
```
#### On the example of the Desmos project:
`COSMOVISOR_VER = v0.42.4`  
`GIT_NAME = desmos-labs`  
`GIT_FOLDER = desmos`  
`BIN_NAME = desmos`  
`BIN_VER = v0.16.0`

The run command should look like this:  
```
wget https://raw.githubusercontent.com/Staketab/tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh v0.42.4 desmos-labs desmos desmos v0.16.0
```
### DONE
