# SPAM TX SCRIPT.
Install script for auto spamming tx.  
### Features:  
- You can specify a custom RPC port
- Custom FEES
- Custom Sleep Time in seconds(s), minutes(m), hours(h)  
- It is enough to enter in the variables only the password, binary and key name in the start command
- No need to edit config

Specify environments in this line `./send.sh -b BINARY -k KEY_NAME -s SLEEP_TIME -c TX_COUNT -p RPC_PORT`  
Example `./send.sh -b umeed -k staketab -s 1s -c 1000 -p 36657`  
`-s 1s` - value in seconds(s), minutes(m), hours(h)  
### You can use like all variables, some or set only `-b BINARY` and `-k KEY_NAME`.

Start new `TMUX` session:
```
tmux new -s unjail
```
And start this script:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/send-tx/send.sh \
&& chmod +x send.sh \
&& ./send.sh -b BINARY -k KEY_NAME -s SLEEP_TIME -c TX_COUNT -p RPC_PORT
```
# DONE
