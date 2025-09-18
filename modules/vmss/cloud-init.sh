#!/bin/bash
set -e

# Update system
apt-get update -y
apt-get upgrade -y

# Install dependencies
apt-get install -y curl jq

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Login with Managed Identity (no creds needed)
az login --identity --allow-no-subscriptions

# Variables (injected by Terraform via custom_data if needed)
VAULT_NAME="${vault_name}"
SECRET_NAME="db-password"

# Fetch secret value
SECRET_VALUE=$(az keyvault secret show \
  --vault-name "$VAULT_NAME" \
  --name "$SECRET_NAME" \
  --query value -o tsv)

# Store secret in environment for apps
echo "DB_PASSWORD=${SECRET_VALUE}" >> /etc/environment

# Optionally write to a config file for services
mkdir -p /etc/myapp
echo "db_password=${SECRET_VALUE}" > /etc/myapp/config.ini

# Example: Install Nginx as placeholder web app
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx

# Drop a simple page showing secret was retrieved (for demo only!)
echo "<h1>VMSS Node Running</h1><p>Fetched secret from Key Vault ✅</p>" > /var/www/html/index.html
