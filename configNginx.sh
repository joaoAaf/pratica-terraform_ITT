#!/bin/bash
apt-get update -y
apt-get install nginx -y

echo "server {
    listen 80;

    location / {
        proxy_pass http://.......
    }
}" > /etc/nginx/sites-available/default

nginx -s reload