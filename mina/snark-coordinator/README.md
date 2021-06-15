# SNARK-COORDINATOR SETUP
First server setup.

## 1. Installing components
```
curl -s https://raw.githubusercontent.com/Staketab/tools/main/mina/libs-20.04/install.sh | bash
```
## 2. Ports
Need to open 8301 and 8302 ports.  
```
sudo iptables -A INPUT -p tcp --dport 8301:8302 -j ACCEPT
```
## 3. Setup .ENV file
```
echo "TAG=mina-daemon-baked:1.1.5-a42bdee
PEER_LIST=https://storage.googleapis.com/mina-seed-lists/mainnet_seeds.txt
WORKER_FEE=0.0025
WORKER_SEL=rand
MINA_PUBLIC_KEY=B62qmw8X...
" > ~/.env
```
Need to specify:  
`TAG` - docker image version.  
`PEER_LIST` - Link to the peer list file.  
`WORKER_FEE` - Snark worker Fee.  
`WORKER_SEL` - By default, the `-work-selection` for a snark worker is random `rand`. You can change this by adding `seq` to the ENV, which will work on jobs in the order required to be included from the scan state and will likely result in your snarks being included without a potentially lengthy delay.  
`MINA_PUBLIC_KEY` - Mina wallet address.  

## 4. Download docker-compose.yml
```
wget https://raw.githubusercontent.com/Staketab/tools/main/mina/snark-coordinator/docker-compose.yml
```
## 5. Start the Node
Run the command `docker-compose up -d` to start the node.

Other commands:
1. Check status
```
docker exec -it root_coordinator_1 mina client status
```
2. Stop docker-compose
```
docker-compose down
```
3. Docker-compose logs
```
docker-compose logs -f
```

## 6. Add Workers servers to the Trust-list.
Start new TMUX session `tmux new -s trust`.  
And then run the command with your workers IP:
```
curl -s https://raw.githubusercontent.com/Staketab/tools/main/mina/snark-coordinator/trust.sh | bash -s - IP1 IP2 IP3 IP4
```
Example:
```
curl -s https://raw.githubusercontent.com/Staketab/tools/main/mina/snark-coordinator/trust.sh | bash -s - 1.1.1.1 2.2.2.2 3.3.3.3 4.4.4.4
```
You can specify one or more IPs. MAX four in script.

### COORDINATOR CONFIGURED

# SNARK-WORKER SETUP
Second server setup.

## 1. Install Mina package
```
echo "deb [trusted=yes] http://packages.o1test.net release main" | sudo tee /etc/apt/sources.list.d/mina.list
sudo apt-get update
sudo apt-get install -y curl unzip mina-mainnet=1.1.5-a42bdee
```
## 2. Start Worker
Start new TMUX session `tmux new -s work-1`.  
And then run the Worker by command:  
```
mina internal snark-worker -daemon-address $COORDINATOR_IP:8301 -proof-level full -shutdown-on-disconnect false
```

### You may setup 1 or more workers on one server. It all depends on the power of the server. 
### For example on server 8 cores/16 threads you can run 3 workers.

### If the Worker was able to connect to the coordinator correctly, then he will begin to produce works.
