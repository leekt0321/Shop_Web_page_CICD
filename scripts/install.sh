#!/bin/bash

sudo yum -y install npm
sudo yum -y install httpd
sudo yum -y install php php-cli php-common php-fpm php-xml php-mysqlnd php-gd php-curl php-json php-mbstring php-zip php-intl

CONFIG_FILE="/etc/httpd/conf/httpd.conf"
BLOCK='<VirtualHost *:80>
    # Proxy 설정
    ProxyRequests Off
    ProxyPreserveHost On
    <Proxy *>
        Order deny,allow
        Allow from all
    </Proxy>
    RedirectMatch 301 ^/user$ /user/
    ProxyPass /user/ http://internal-Project-WAS-LB-1758617147.ap-northeast-2.elb.amazonaws.com:8080/ disablereuse=on
    ProxyPassReverse /user/ http://internal-Project-WAS-LB-1758617147.ap-northeast-2.elb.amazonaws.com:8080/

    RedirectMatch 301 ^/login$ /login/
    ProxyPass /login/ http://internal-Project-WAS-LB-1758617147.ap-northeast-2.elb.amazonaws.com:8080/ disablereuse=on
    ProxyPassReverse /login/ http://internal-Project-WAS-LB-1758617147.ap-northeast-2.elb.amazonaws.com:8080/

    # Static 파일 설정
    DocumentRoot "/home/ec2-user/startbootstrap-shop-homepage/dist"
    <Directory "/home/ec2-user/startbootstrap-shop-homepage/dist">
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>
</VirtualHost>'

if grep -q "<VirtualHost \*:80>" "$CONFIG_FILE"; then
    # 기존 <VirtualHost *:80> 블록 찾기 및 대체
    sudo sed -i "/<VirtualHost \*:80>/,/<\/VirtualHost>/c\\$BLOCK" "$CONFIG_FILE"
    echo "Existing <VirtualHost *:80> block replaced in $CONFIG_FILE"
else
    echo "$BLOCK" | sudo tee -a "$CONFIG_FILE" > /dev/null
    echo "Configuration block added to $CONFIG_FILE"
fi
