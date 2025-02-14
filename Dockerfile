FROM node:10-alpine

LABEL maintainer Vincenzo Chianese, vincenzo@express-gateway.io

ARG EG_VERSION
ENV NODE_ENV production
ENV NODE_PATH /usr/local/share/.config/yarn/global/node_modules/
ENV EG_CONFIG_DIR /var/lib/eg
# Enable chokidar polling so hot-reload mechanism can work on docker or network volumes
ENV CHOKIDAR_USEPOLLING true

VOLUME /var/lib/eg

COPY ./.npmrc /root/.npmrc

RUN cat ~/.npmrc

RUN yarn global add @veeklabs/express-gateway

COPY ./bin/generators/gateway/templates/basic/config /var/lib/eg



COPY ./lib/config/models /var/lib/eg/models

EXPOSE 8080 9876

CMD ["node", "-e", "require('@veeklabs/express-gateway')().run();"]
