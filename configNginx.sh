#!/bin/bash
apt-get update -y
apt-get install nginx -y

echo "server {
    listen 80;

    location / {
        proxy_pass http://s3-website-itt.s3-website.us-east-1.amazonaws.com
    }
}" > /etc/nginx/sites-available/default

nginx -s reload