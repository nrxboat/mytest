#!/bin/bash
source /app/config.sh



nohup filebrowser -d /root/data/filebrowser.db >/dev/null 2>&1 &

cd /root/data
./alist start

service ssh start
service apache2 start

echo "set ngrok token: $NGROK_TOKEN"
ngrok authtoken $NGROK_TOKEN
echo "start ngrok service"
ngrok tcp 22 --log=stdout > ngrok.log
