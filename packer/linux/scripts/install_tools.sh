#!/bin/bash -eux

## install tools
echo "==> Installing docker and docker-compose"

sudo apt-get update -y
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common jq -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable'
sudo apt-get update -y
sudo apt-get install docker-ce docker-compose -y