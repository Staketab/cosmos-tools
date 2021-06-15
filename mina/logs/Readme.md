# Mina logs downloader to GCP.

Install `gsutil` SDK:
```
curl https://sdk.cloud.google.com | bash
```
Download bash script:
```
wget https://raw.githubusercontent.com/Staketab/tools/main/mina/logs/mina-logs-gcp.sh
```
Edit path to `.mina-config/exported_logs` folder and link to `gs` on google cloud:
```
nano mina-logs-gcp.sh
```
Then run the script:
```
chmod +x mina-logs-gcp.sh
./mina-logs-gcp.sh
```
### jrwashburn#0765 Original version https://github.com/jrwashburn/mina-node-install/blob/main/scripts/mina-log-archive-gcs-upload.sh  
### Done
