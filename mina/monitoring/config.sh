#!/bin/bash

RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"
NORMAL="\033[0m"
NODE_IP="$(curl ifconfig.me)"

curl -s https://raw.githubusercontent.com/Staketab/tools/main/components/install.sh | bash

echo -e "$YELLOW Components updated.$NORMAL"
echo "---------------"

sudo iptables -A INPUT -p tcp --dport 8302:8303 -j ACCEPT
chmod 700 $HOME/keys
chmod 600 $HOME/keys/my-wallet
sudo docker network create mina

echo -e "$YELLOW Mina docker network created.$NORMAL"
echo "---------------"

cd
mkdir $HOME/tmp

echo "MINA_TAG=mina-daemon-baked:1.1.5-a42bdee
SIDECAR_TAG=mina-bp-stats-sidecar:1.1.6-386c5ac
ARCHIVE_TAG=mina-archive:1.1.5-a42bdee
PEER_LIST=https://storage.googleapis.com/mina-seed-lists/mainnet_seeds.txt
WORKER_FEE=0.0025
WORKER_SEL=rand                                                               # rand or seq selection
KEYPATH='$HOME/keys/my-wallet'
MINA_PUBLIC_KEY=B62qqV16g8s7...
RECEIVER=B62qqV16g8s7...
PASS=''
GCLOUD_SET=true
GCLOUD_KEYFILE=''
NETWORK_NAME=''
GCLOUD_BLOCK_UPLOAD_BUCKET=''" > $HOME/tmp/.env

echo -e "$YELLOW ENV for docker-compose created.$NORMAL"
echo "---------------"

wget https://raw.githubusercontent.com/Staketab/tools/main/mina/monitoring/mina-sidecar.json -O $HOME/tmp/mina-sidecar.json

echo -e "$YELLOW SIDECAR json created.$NORMAL"
echo "---------------"

echo "global:
  scrape_interval: 15s # 15s will be enough, because block of time
  scrape_timeout: 15s
  evaluation_interval: 15s # Evaluate alerting
alerting:
  alertmanagers:
  - static_configs:
    - targets: []
    scheme: http
    timeout: 5s
scrape_configs:
  - job_name: 'mina-mainnet'
    metrics_path: /metrics
    scheme: http
    static_configs:
      - targets: ['${NODE_IP}:6060','${NODE_IP}:9100']
        labels:
          hostname: 'mina'
" > $HOME/tmp/prometheus-mina.yml

echo -e "$YELLOW Prometheus yml config created.$NORMAL"
echo "---------------"

echo "server:
  http_listen_address: 0.0.0.0
  http_listen_port: 9080

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://loki:3100/loki/api/v1/push

scrape_configs:

- job_name: system
  static_configs:
  - targets:
      - localhost
    labels:
      job: varlogs
      __path__: /var/log/*log

- job_name: containers
  entry_parser: raw

  static_configs:
  - targets:
      - localhost
    labels:
      job: containerlogs
      __path__: /var/lib/docker/containers/*/*log

  pipeline_stages:

  - json:
      expressions:
        stream: stream
        attrs: attrs
        tag: attrs.tag

  - regex:
      expression: (?P<image_name>(?:[^|]*[^|])).(?P<container_name>(?:[^|]*[^|])).(?P<image_id>(?:[^|]*[^|])).(?P<container_id>(?:[^|]*[^|]))
      source: tag

  - labels:
      tag:
      stream:
      image_name:
      container_name:
      image_id:
      container_id:
" > $HOME/tmp/docker.yml

echo -e "$YELLOW Protonmail yml config created.$NORMAL"
echo "---------------"

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
&& wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - \
&& sudo apt-get update \
&& sudo apt-get -y install postgresql

echo -e "$GREEN POSTGRESQL installed.$NORMAL"
echo "---------------"

echo -e "$GREEN ALL settings and configs created.$NORMAL"
echo "---------------"

cd
