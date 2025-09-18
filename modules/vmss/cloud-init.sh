#!/bin/bash
# Update system
apt-get update -y

# Install nginx and Azure CLI
apt-get install -y nginx curl
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Start nginx
systemctl enable nginx
systemctl start nginx

# Web page with hostname
echo "<h1>Hello from Terraform VMSS in $(hostname)</h1>" > /var/www/html/index.html

# Login with Managed Identity
az login --identity

# Fetch secret from Key Vault (provided by Terraform template)
APP_SECRET=$(az keyvault secret show \
  --name app-password \
  --vault-name ${vault_name} \
  --query value -o tsv)

# Write secret to env for app (mock example)
echo "APP_SECRET=${APP_SECRET}" >> /etc/environment
