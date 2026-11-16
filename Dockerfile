FROM eclipse-temurin:21-jre

RUN apt-get update \
 && apt-get install -y --no-install-recommends websockify ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY viaproxy /app/viaproxy
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

ENV PORT=10000
EXPOSE 10000

CMD ["/app/start.sh"]