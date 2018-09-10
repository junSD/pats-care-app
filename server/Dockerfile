FROM node:8.9.4-alpine as builder

WORKDIR /elephant-build

RUN set -x && \
    apk add --update --nocache expect && \
    apk add coreutils python automake autoconf alpine-sdk

COPY package.json ./package.json
RUN npm install
COPY src/ ./src

COPY gruntfile.js ./gruntfile.js
COPY gulpfile.js ./gulpfile.js
COPY tsconfig.json ./tsconfig.json
COPY tslint.json ./tslint.json
COPY tslint-sonarts.json ./tslint-sonarts.json

RUN set -x && \
    npm run build

FROM node:8.9.4-alpine

COPY --from=builder /elephant-build/dist /dist
COPY --from=builder /elephant-build/node_modules /node_modules
COPY public/ ./public
COPY views/ ./views
COPY bin/ ./bin
COPY package.json ./package.json

COPY ./wait-for-postgres.sh /wait-for-postgres.sh
RUN chmod +x /wait-for-postgres.sh

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

#ENTRYPOINT ["/entrypoint.sh"]
