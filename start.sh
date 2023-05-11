#!/bin/bash
source /app/config.sh

cp /app/alist.conf /etc/apache2/sites-enabled/
cp /app/filebrowser.conf /etc/apache2/sites-enabled/

service ssh start
service apache2 start

echo "set ngrok token: $NGROK_TOKEN"
ngrok authtoken $NGROK_TOKEN
echo "start ngrok service"
ngrok tcp 22 --log=stdout > ngrok.log
