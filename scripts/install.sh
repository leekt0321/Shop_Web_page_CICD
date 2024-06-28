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

# 임시 파일 생성
TMP_FILE=$(mktemp)

# 기존 블록을 대체하거나 추가하는 awk 스크립트
awk -v block="$BLOCK" '
BEGIN { found = 0 }
/<VirtualHost \*:80>/ { found = 1 }
/<VirtualHost \*:80>/,/<\/VirtualHost>/ { next }
{ print }
/<\/VirtualHost>/ && found == 1 { print block; found = 2 }
END { if (found == 0) print block }
' "$CONFIG_FILE" > "$TMP_FILE"

# 변경 사항을 원본 파일에 적용
sudo mv "$TMP_FILE" "$CONFIG_FILE"

echo "Configuration updated in $CONFIG_FILE"

