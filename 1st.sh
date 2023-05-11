curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok

curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

filebrowser -d /root/data//filebrowser.db config init
filebrowser -d /root/data/filebrowser.db config set --address 0.0.0.0
filebrowser -d /root/data//filebrowser.db config set --port 8088
filebrowser -d /root/data/filebrowser.db config set --locale zh-cn
filebrowser -d /root/data/filebrowser.db config set --log /var/log/filebrowser.log
filebrowser -d /root/data/filebrowser.db users add root password --perm.admin

a2enmod proxy proxy_http proxy_balancer lbmethod_byrequests rewrite


wget https://github.com/alist-org/alist/releases/download/v3.16.3/alist-linux-amd64.tar.gz
tar -zxvf alist-*-*.tar.gz /root/data
chmod +x /root/data/alist