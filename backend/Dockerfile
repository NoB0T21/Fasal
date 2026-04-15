FROM node:20-alpine

RUN apk add --no-cache redis

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

RUN npm run build

EXPOSE 5000

CMD redis-server --daemonize yes && npm run start