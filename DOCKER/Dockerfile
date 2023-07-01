FROM node:lts-alpine3.18
WORKDIR /usr/src/app
COPY test-nodeapp-1-task /usr/src/app
RUN npm install express
EXPOSE 8081
CMD [ "node", "server.js" ]