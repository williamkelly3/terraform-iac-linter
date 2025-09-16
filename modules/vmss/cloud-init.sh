#!/bin/bash
apt-get update -y
apt-get install -y nginx
echo "Hello from VMSS $(hostname)" > /var/www/html/index.html
systemctl enable nginx
systemctl start nginx
