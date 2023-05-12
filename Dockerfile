FROM debian:latest
EXPOSE 80

RUN apt update && apt install -y openssh-server curl wget unzip sudo apache2 screen tar
RUN echo "PermitRootLogin Yes" >> /etc/ssh/sshd_config
RUN echo "root:password" | chpasswd



COPY . /app

RUN chmod +x /app/1st.sh
RUN chmod +x /app/start.sh
CMD ["/app/1st.sh"]
CMD ["/app/start.sh"]
