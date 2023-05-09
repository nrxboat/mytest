FROM devisty/xssh:v2
EXPOSE 80

CMD ["apt update && apt upgrade -y"]
COPY . /app
RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]
