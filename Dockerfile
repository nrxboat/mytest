FROM debian:latest
EXPOSE 80

RUN apt update && apt install -y openssh-server curl wget unzip sudo apache2 screen tar
RUN echo "PermitRootLogin Yes" >> /etc/ssh/sshd_config
RUN echo "root:password" | chpasswd

RUN mkdir -p /root/temp && cd /root/temp
ADD https://github.com/alist-org/alist/releases/download/v3.16.3/alist-linux-amd64.tar.gz /root/temp
RUN tar -zxvf alist-linux-amd64.tar.gz

RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok

RUN curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

COPY . /app

RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]
