FROM node:alpine

ENV _WORKDIR_ /home/pi/sarah-server
ENV _WORKSPACE_ /home/pi
ENV TZ Europe/Paris

RUN apk update && apk upgrade && \
    apk --no-cache add build-base git python sudo && \
    git config --system http.sslverify false && \
    mkdir ${_WORKSPACE_} && \
    cd ${_WORKSPACE_} && \
    git clone https://github.com/JpEncausse/SARAH-Server-NodeJS.git sarah-server && \
    cd sarah-server/server/app && \
    npm install && \
    sed 's/app.js &/app.js/' -i ${_WORKDIR_}/sarah-server.sh && \
    chmod +x ${_WORKDIR_}/sarah-server.sh && \
    apk del git build-base python

COPY ./docker-entrypoint.sh /

EXPOSE 8080 8888
WORKDIR ${_WORKDIR_}
VOLUME _WORKDIR_

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sarah-server.sh", "start"]
