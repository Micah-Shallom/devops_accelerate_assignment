FROM node:16-alpine3.15

RUN mkdir /app

COPY . /app

WORKDIR /app

EXPOSE 5000

RUN ["npm", "install"]

CMD ["node" , "app.js"]