#!/bin/bash

sudo yum -y install npm
sudo yum -y install httpd

CONFIG_FILE="/etc/httpd/conf/httpd.conf"
BLOCK='<VirtualHost *:80>
    # Proxy 설정
    ProxyRequests Off
    ProxyPreserveHost On
    <Proxy *>
        Order deny,allow
        Allow from all
    </Proxy>
    RedirectMatch 301 ^/app$ /app/
    ProxyPass /app/ http://internal-Project-WAS-LB-1758617147.ap-northeast-2.elb.amazonaws.com:8080/ disablereuse=on
    ProxyPassReverse /app/ http://internal-Project-WAS-LB-1758617147.ap-northeast-2.elb.amazonaws.com:8080/

    # Static 파일 설정
    DocumentRoot "/home/ec2-user/startbootstrap-shop-homepage/dist"
    <Directory "/home/ec2-user/startbootstrap-shop-homepage/dist">
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>

</VirtualHost>'

# 블록이 이미 있는지 확인
if ! grep -q "<VirtualHost *:80>" "$CONFIG_FILE"; then
    echo "$BLOCK" | sudo tee -a "$CONFIG_FILE" > /dev/null
    echo "Configuration block added to $CONFIG_FILE"
else
    echo "Configuration block already exists in $CONFIG_FILE"
fi

