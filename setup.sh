#!/bin/bash

echo "\n--- ETH1 [Installing node.js & npm] ---\n"

sudo apt install curl -y
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.bashrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install --lts

echo -e "\n--- ETH2 [Installing Apache2 & additional deps] ---\n"

sudo apt update
sudo apt install apache2
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod ssl
sudo systemctl restart apache2

echo -e "\n--- ETH3 [Setting up client & server] ---\n"

mkdir client 
mkdir server

git clone https://github.com/pauf419/rentry.git ./client -b client
npm --prefix ./client i && npm --prefix ./client run build

echo -e "\n--- INFO: client node_modules installed and builded. ---\n"

git clone https://github.com/pauf419/rentry.git ./server -b server
npm --prefix ./server i

echo -e "\n---INFO: server node_modules installed and ready to start(WARNING: .prod.env edit and database transfer required) ---\n"


