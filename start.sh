#!/bin/bash
source /app/config.sh
tar -zxvf /root/temp/alist-linux-amd64.tar.gz 
cd /root/data
cp /root/temp/alist /root/data -n
chmod +x alist


filebrowser -d /root/data/filebrowser.db config init
filebrowser -d /root/data/filebrowser.db config set --address 0.0.0.0
filebrowser -d /root/data//filebrowser.db config set --port 8088
filebrowser -d /root/data/filebrowser.db config set --locale zh-cn
filebrowser -d /root/data/filebrowser.db config set --log /var/log/filebrowser.log
filebrowser -d /root/data/filebrowser.db users add root password --perm.admin

a2enmod proxy proxy_http proxy_balancer lbmethod_byrequests rewrite

cp /app/alist.conf /etc/apache2/sites-enabled/ -n
cp /app/filebrowser.conf /etc/apache2/sites-enabled/ -n


nohup filebrowser -d /root/data/filebrowser.db >/dev/null 2>&1 &

./alist start

service ssh start
service apache2 start

echo "set ngrok token: $NGROK_TOKEN"
ngrok authtoken $NGROK_TOKEN
echo "start ngrok service"
ngrok tcp 22 --log=stdout > ngrok.log
