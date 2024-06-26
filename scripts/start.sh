#!/bin/bash
npm install
sudo systemctl enable --now httpd
sudo chmod 755 /home/ec2-user
