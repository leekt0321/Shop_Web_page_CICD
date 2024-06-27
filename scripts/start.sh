#!/bin/bash
npm install
sudo systemctl enable --now httpd
sudo systemctl restart httpd
sudo chmod 755 /home/ec2-user
