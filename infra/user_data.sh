#!/bin/bash
set -eux
apt-get update -y
apt-get install -y ca-certificates curl git gnupg

# Install Docker
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" > /etc/apt/sources.list.d/docker.list
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

usermod -aG docker ubuntu

# Clone repo and start services (replace with your GitHub username)
su - ubuntu -c "git clone https://github.com/sa1if3/sre-reliability-lab.git"
cd /home/ubuntu/sre-reliability-lab
docker compose build
docker compose up -d