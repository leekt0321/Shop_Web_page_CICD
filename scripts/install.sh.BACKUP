#!/bin/bash
sudo yum -y install npm
sudo yum -y install httpd
sudo cat << EOF >> /etc/httpd/conf/httpd.conf
DocumentRoot "/home/ec2-user/startbootstrap-shop-homepage/dist"
<Directory "/home/ec2-user/startbootstrap-shop-homepage/dist">
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>
EOF
