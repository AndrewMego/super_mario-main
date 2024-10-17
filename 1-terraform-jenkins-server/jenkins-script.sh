#!/bin/bash

# Update system packages
sudo apt update -y

# Install Java (Jenkins requires Java)
sudo apt install openjdk-11-jdk -y

# Install Jenkins
sudo apt update
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Install Git
sudo apt install git -y

# Install Terraform
sudo apt install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
sudo apt-add-repository \
    "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update && sudo apt install terraform -y

# Install kubectl
curl -LO "https://dl.k8s.io/release/v1.23.6/bin/linux/amd64/kubectl"
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Confirm installations
java -version
jenkins --version
git --version
terraform -version
kubectl version --client

