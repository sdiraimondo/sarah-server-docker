FROM node:alpine

RUN apk update && apk upgrade && \
    apk --no-cache add build-base git python sudo && \
    git config --system http.sslverify false && \
    mkdir /home/pi && \
    cd /home/pi && \
    git clone https://github.com/JpEncausse/SARAH-Server-NodeJS.git sarah-server && \
    cd sarah-server/server/app && \
    npm install && \
    sed 's/app.js &/app.js/' -i /home/pi/sarah-server/sarah-server.sh && \
    chmod +x /home/pi/sarah-server/sarah-server.sh && \
    apk del git build-base python

EXPOSE 8080 8888
VOLUME /home/pi/sarah-server
CMD ["/home/pi/sarah-server/sarah-server.sh", "start"]
