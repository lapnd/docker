#!/bin/bash
# Check if sudo is already installed
if command -v docker >/dev/null 2>&1; then
    echo "sudo is already installed."
    exit 0
fi
COMPOSE_VERSION=$(curl https://api.github.com/repos/docker/compose/releases/latest -s | jq .name -r)
sudo sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
sudo chmod +x /usr/local/bin/docker-compose

sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install --yes \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io --yes
sudo groupadd docker
sudo usermod -aG docker $(whoami)
newgrp docker