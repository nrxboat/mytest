FROM debian:latest
EXPOSE 80

RUN apt update && apt install -y openssh-server curl wget unzip sudo apache2
RUN echo "PermitRootLogin Yes" >> /etc/ssh/sshd_config
RUN echo "root:password" | chpasswd
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | \
RUN  sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
RUN  echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | \
RUN  sudo tee /etc/apt/sources.list.d/ngrok.list && \
 RUN sudo apt update && sudo apt install ngrok
COPY . /app
RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]
