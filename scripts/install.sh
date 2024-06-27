#!/bin/bash

sudo yum -y install npm
sudo yum -y install httpd

CONFIG_FILE="/etc/httpd/conf/httpd.conf"
BLOCK='DocumentRoot "/home/ec2-user/startbootstrap-shop-homepage/dist"
<Directory "/home/ec2-user/startbootstrap-shop-homepage/dist">
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>'

# 블록이 이미 있는지 확인
if ! grep -q "$BLOCK" "$CONFIG_FILE"; then
    echo "$BLOCK" | sudo tee -a "$CONFIG_FILE" > /dev/null
    echo "Configuration block added to $CONFIG_FILE"
else
    echo "Configuration block already exists in $CONFIG_FILE"
fi

