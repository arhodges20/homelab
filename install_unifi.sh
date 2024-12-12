#!/bin/bash

# Update package list
sudo apt update

# Install required packages
sudo apt install -y curl haveged gpg openjdk-8-jre-headless

# Add the UniFi repository GPG key
curl https://dl.ui.com/unifi/unifi-repo.gpg | sudo tee /usr/share/keyrings/ubiquiti-archive-keyring.gpg >/dev/null

# Add the UniFi repository to the sources list
echo 'deb [signed-by=/usr/share/keyrings/ubiquiti-archive-keyring.gpg] https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list >/dev/null

# Download and install the required version of libssl1.1
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb -O libssl1.1.deb
sudo dpkg -i libssl1.1.deb
rm libssl1.1.deb

# Add the MongoDB repository GPG key
curl https://pgp.mongodb.com/server-4.4.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/mongodb-org-server-4.4-archive-keyring.gpg >/dev/null

# Add the MongoDB repository to the sources list
echo 'deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-org-server-4.4-archive-keyring.gpg] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list >/dev/null

# Update package list again to include new repositories
sudo apt update

# Install MongoDB
sudo apt install -y mongodb-org-server

# Enable and start the MongoDB service
sudo systemctl enable mongod
sudo systemctl start mongod

# Install UniFi
sudo apt install -y unifi

# Display the server's IP address
echo "UniFi Controller installation is complete."
echo "You can access the UniFi Controller at: https://$(hostname -I | awk '{print $1}'):8443"
