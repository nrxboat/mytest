FROM debian:latest
EXPOSE 80

RUN apt update && apt install -y openssh-server curl wget unzip sudo apache2 screen tar
RUN echo "PermitRootLogin Yes" >> /etc/ssh/sshd_config
RUN echo "root:password" | chpasswd
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok

RUN curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

RUN filebrowser -d /root/data//filebrowser.db config init
RUN filebrowser -d /root/data/filebrowser.db config set --address 0.0.0.0
RUN filebrowser -d /root/data//filebrowser.db config set --port 8088
RUN filebrowser -d /root/data/filebrowser.db config set --locale zh-cn
RUN filebrowser -d /root/data/filebrowser.db config set --log /var/log/filebrowser.log
RUN filebrowser -d /root/data/filebrowser.db users add root password --perm.admin

RUN a2enmod proxy proxy_http proxy_balancer lbmethod_byrequests rewrite

RUN wget https://github.com/alist-org/alist/releases/download/v3.16.3/alist-linux-amd64.tar.gz
RUN tar -zxvf alist-*-*.tar.gz /root/data
RUN chmod +x /root/data

COPY . /app
RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]
